From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 00/10] Log mailmap optimization
Date: Sat,  5 Jan 2013 22:26:36 +0100
Message-ID: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:27:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHA-0000L4-Kd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab3AEV1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:13 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:64125 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab3AEV1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:12 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so8250370wgb.26
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=asHy+0WNFCHYwa5KOsOYYlIGBleZhEdsL4bBs1/gMug=;
        b=dVCwqwKcpp9wAm8c89iqOaQOyzm96CzsNK0qyvDfwj9J38WmlNcBoAApd2dGWKLWlM
         /1ngRzuQWxEcSJOMxRvU25Y3oMa583CXsW5hrSkqqgmXvGOClRDgtiKkPcvHqhhDc37/
         G05kZZp9c73bky94UTFSQYJZH1vMzBXGnfdJXb71mJE5/jo/a3Mxr8/wkUsNkc/0p1D2
         8UwU6eNqHZIgCD4dAcOkGhSjWXVep0thz9t90s2GIWjJQKwEMTRYgqYmlwRGY1ZsRh78
         wyad/8FncJC/nq0qCQ1TUusuhD+LVZc8OyHtJ4bcTl+2bEqcSrPhgtnU1d2fvLRxkWiW
         IgrA==
X-Received: by 10.180.84.131 with SMTP id z3mr3147447wiy.25.1357421231327;
        Sat, 05 Jan 2013 13:27:11 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:10 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212717>

Hi,

Here is a reroll of ap/log-mailmap.
The idea is to use another preparatory step:
Allow case-insensitive and length search in list_lookup

We can now search for mapping name and email without any copy.
Of course a copy is then necessary to store the info, but we no
longer need any copy to look-up the mapping (useful for replacing or not
before grep).

Thanks,

Antoine Pelisse (10):
  list_lookup: create case and length search
  Use split_ident_line to parse author and committer
  mailmap: remove email copy and length limitation
  mailmap: simplify map_user() interface
  mailmap: add mailmap structure to rev_info and pp
  pretty: use mailmap to display username and email
  log: add --use-mailmap option
  test: add test for --use-mailmap option
  log: grep author/committer using mailmap
  log: add log.mailmap configuration option

 Documentation/config.txt  |   4 +
 Documentation/git-log.txt |   5 ++
 builtin/blame.c           | 183 ++++++++++++++++++++++------------------------
 builtin/log.c             |  16 +++-
 builtin/shortlog.c        |  54 ++++----------
 commit.h                  |   1 +
 log-tree.c                |   1 +
 mailmap.c                 |  55 +++++---------
 mailmap.h                 |   4 +-
 pretty.c                  | 114 ++++++++++++++++-------------
 revision.c                |  54 ++++++++++++++
 revision.h                |   1 +
 string-list.c             |  30 ++++++--
 string-list.h             |   2 +
 t/t4203-mailmap.sh        |  56 ++++++++++++++
 15 files changed, 349 insertions(+), 231 deletions(-)

--
1.7.12.4.3.g2036a08.dirty
