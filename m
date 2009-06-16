From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3 0/4] Teach shell scripts to be quiet
Date: Mon, 15 Jun 2009 19:05:01 -0700
Message-ID: <1245117905-19351-1-git-send-email-bebarino@gmail.com>
Cc: Thomas Adam <thomas.adam22@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 04:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGO39-0000Fy-Dj
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZFPCFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZFPCFI
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:05:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:29984 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbZFPCFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:05:07 -0400
Received: by wa-out-1112.google.com with SMTP id j5so837169wah.21
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=UcjEJaYt608uRlX7n+qxWX+lnDXlaPVrTdC2+iF1Nfc=;
        b=GVX7XxyIEFOA2xEVWY5/wU3vC9YRP8bjEpRrgP9IpRVlNN4LOZ9pokeZCJlw94A77k
         mMvntUXOfJ5JafM+UB99yDmMzcwM1bk2UeqrNhWLXmCptDseH3sSpK1l5FJLLvaL0Nfx
         W4Cc1+0hHa6fxV7MhY5nVo9EFbmf8elxxKZ54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=acw8y4etum36f0rO1qsosL77T4oF3bwtW4eDE9o7o9ZzA1d8MgFkgczplbaETggpbU
         w6c56DDO8XYZRFEYWmQ/Kmp2N/8TKTxyDt9FaDs9Mhxf6NVRxLmwJeitBWoyclzSYvhw
         0FtCH782aSkGLmlVWFYVFRY+RF8JoXGa/3MFo=
Received: by 10.114.202.15 with SMTP id z15mr12728366waf.67.1245117909027;
        Mon, 15 Jun 2009 19:05:09 -0700 (PDT)
Received: from earth (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id v9sm7290245wah.36.2009.06.15.19.05.06
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Jun 2009 19:05:08 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 15 Jun 2009 19:05:05 -0700
X-Mailer: git-send-email 1.6.3.2.306.g4f4fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121646>

The main goal of this series is to teach git-am and git-rebase to be
quiet.

I was tempted to do a more clever say() which could take arbitrary
printf arguments. I've decided it's not worth it, as just doing
what Junio suggested and then adding an echo works well for most
users of say().

stash is still left out, and I've noticed that rerere could probably
be made quiet too, but that's for a later day.

I've included a test for the newline bug. If it's not wanted
it can just be dropped.

Changes since v2:
    - say uses printf instead of echo
    - suppressing errors from git-apply under am -3 -q
    - added a test for am -3 -q
    - added a test for am where subjects have a literal newline
    - am,rebase tests check both stdout and stderr
    - rebase.sh::continue_merge() suppress the output of git rev-list

Changes since v1:
    - introduction of say()
    - migration of submodule and repack

Stephen Boyd (4):
  t4150: test applying with a newline in subject
  git-sh-setup: introduce say() for quiet options
  submodule, repack: migrate to git-sh-setup's say()
  am, rebase: teach quiet option

 Documentation/git-am.txt     |    6 +++++-
 Documentation/git-rebase.txt |    4 ++++
 git-am.sh                    |   26 ++++++++++++++++++++------
 git-rebase.sh                |   39 +++++++++++++++++++++++++++------------
 git-repack.sh                |   12 +++++-------
 git-sh-setup.sh              |   10 ++++++++++
 git-submodule.sh             |   24 ++++++------------------
 t/t3400-rebase.sh            |    7 +++++++
 t/t4150-am.sh                |   26 ++++++++++++++++++++++++++
 9 files changed, 110 insertions(+), 44 deletions(-)
