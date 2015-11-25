From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/5] Submodule Groups
Date: Tue, 24 Nov 2015 17:32:14 -0800
Message-ID: <1448415139-23675-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:32:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Owb-0005XK-NO
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbbKYBcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:32:23 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34718 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362AbbKYBcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:32:22 -0500
Received: by padhx2 with SMTP id hx2so39693441pad.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nEKQh0FAl9R5/f4S0R+id06a/EMBh0szwip8haokiiE=;
        b=PzC9rSczn/ygnxs1ZD6XpefuWbo3cKEsyNEDWMPZSwvf+tcF+9TB0nmpv3jlvSJ7qa
         1bUF1KOUqFAV2AzCTmA6w71SCGtpgsx8SfoTpB6xU01ktztUWJHkwB9j/jomA05NZT+J
         2tY6q2n48rMd5klGJ8METs0yu4s8LWem0tB9AmTmI/lxqo/jZ4UL0L9aD8grXJDhwo/L
         OG00XtszpliVfBcgutBp8eFJ+lXUL66Omzk6WuNiOyCqT7OmU7gRXqpXc92Hd5EDFJB2
         oXB0EJvyNUcDzTMANHzgQ3begsIwhekfW07EVf7xSwBTx4rUw6fnBFadC6qWSO3Sfd8X
         o+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nEKQh0FAl9R5/f4S0R+id06a/EMBh0szwip8haokiiE=;
        b=ETR3pp3PXPc9+cWwhSU60XalAqoExtimZTzp8a77DXUEamk/kMdBaRI6L4VItlUTwO
         ejWi8qfQFOAqAmhjAaUmREm6w0/Z5HrBGKe3Ya7jL5inJBF23y4xaZhcHQKlHAesIcE/
         Qa2/XWCQgN0GbWWv5ickvTbG1g21VZVeHQwAJ4YD1frVEUT8eoqqdeGudY6jar2WDkyO
         T05YXQH6Ddhw1mjRuzNmLVfaMGLtbOBRXU513as6KmPS3d+rh6/u1wjSN+m8Oj5noB9v
         5QNTBco6H7DdAyZBProtxorHcfuLtsSkL3FcHM1OpwdMMjGlhuTOvZfzM8wFqe9X4zsN
         6usg==
X-Gm-Message-State: ALoCoQmoWYZ16zVzMfZcpYQlVP7OQT9BqqFzPfKg1wQ9Q2yBEnDN95xUDUzP+B1THURQb9+vb5j7
X-Received: by 10.98.69.197 with SMTP id n66mr27282969pfi.42.1448415141559;
        Tue, 24 Nov 2015 17:32:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:38f7:d727:e789:685b])
        by smtp.gmail.com with ESMTPSA id v80sm16822162pfa.92.2015.11.24.17.32.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:32:21 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281670>

This is also available at https://github.com/stefanbeller/git/tree/submodule-groups
It applies on top of the submodule-parallel-patch series I sent a few minutes ago.

Consider having a real large software project in Git with each component
in a submodule (such as an operating system, Android, Debian, Fedora,
no toy OS such as https://github.com/gittup/gittup as that doesn't quite
demonstrate the scale of the problem).

If you have lots of submodules, you probably don't need all of them at once,
but you have functional units. Some submodules are absolutely required,
some are optional and only for very specific purposes.

This patch series adds meaning to a "groups" field in the .gitmodules file.

So you could have a .gitmodules file such as:

[submodule "gcc"]
        path = gcc
        url = git://...
        groups = default,devel
[submodule "linux"]
        path = linux
        url = git://...
        groups = default
[submodule "nethack"]
        path = nethack
        url = git://...
        groups = optional,games

and by this series you can work on an arbitrary subgroup of these submodules such
using these commands:

    git clone --group default --group devel git://...
    # will clone the superproject and recursively
    # checkout any submodule being in at least one of the groups.

    git submodule add --group default --group devel git://... ..
    # will add a submodule, adding 2 submodule
    # groups to its entry in .gitmodule
    
    # as support for clone we want to have:
    git config submodule.groups default
    git submodule init --groups
    # will init all submodules from the default group
    
    # as support for clone we want to have:
    git config submodule.groups default
    git submodule update --groups
    # will update all submodules from the default group

Any feedback welcome, specially on the design level!
(Do we want to have it stored in the .gitmodules file? Do we want to have
the groups configured in .git/config as "submodule.groups", any other way
to make it future proof and extend the groups syntax?)

Thanks,
Stefan

Stefan Beller (5):
  submodule-config: keep submodule groups around
  git submodule add can add a submodule with groups
  git submodule init to pass on groups
  submodule--helper: module_list and update-clone have --groups option
  builtin/clone: support submodule groups

 Documentation/git-clone.txt     |  11 ++++
 Documentation/git-submodule.txt |   8 ++-
 builtin/clone.c                 |  33 ++++++++++-
 builtin/submodule--helper.c     |  68 ++++++++++++++++++++++-
 git-submodule.sh                |  20 ++++++-
 submodule-config.c              |  14 +++++
 submodule-config.h              |   2 +
 t/t7400-submodule-basic.sh      | 118 ++++++++++++++++++++++++++++++++++++++++
 t/t7406-submodule-update.sh     |  32 +++++++++++
 9 files changed, 299 insertions(+), 7 deletions(-)

-- 
2.6.1.261.g0d9c4c1
