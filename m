From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 4/5] completion: avoid trailing space for --exec-path
Date: Sun, 15 Apr 2012 22:44:19 +0300
Message-ID: <1334519060-2348-5-git-send-email-felipe.contreras@gmail.com>
References: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVNZ-0002Nm-Bf
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab2DOToz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:44:55 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53524 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab2DOToy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:44:54 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so3492422lah.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nz0Ci7MO/0VTS60t5L2t741r6LwBQJiFB3532KDyGeY=;
        b=w05ZMw68ZPQk9kAombzWiGX3PPGhLz6Rd1wHe6dSJuf7PXrnRnCXpWO6pyoh6reqr6
         hF9j0/cxLyQnZ89NXBnCPlyE080Ysi5pDgaitKX297jKviqhkZ1473rbny4h21eERm5p
         +BxXihl4cMhNa1g1xAKy9osOg79KZzQey+yIDqHx7WZkV9gRZ0NWnK4TBlcpr95/LWLh
         bofwE0/vaaN5RcY1HEiRwHPXne4MGzIzEYmeBjlC029DUwtY4SCFV3VYeEwuwXYuTAfE
         2WBElnx5+dr88einv1XaBH7Nu63J9ZBfu1uIYWWcvq5vv42bEQiV0Ic025acVUv4vetG
         7U4Q==
Received: by 10.152.132.166 with SMTP id ov6mr8785387lab.35.1334519093820;
        Sun, 15 Apr 2012 12:44:53 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id u4sm16931216lad.5.2012.04.15.12.44.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195581>

From: Jonathan Nieder <jrnieder@gmail.com>

--exec-path looks to the completion script like an unambiguous
successful completion, but it is wrong; the user could be trying to
do

	git --exec-path; # print name of helper directory

or

	git --exec-path=/path/to/alternative/helper/dir <subcommand>

so the most helpful thing to do is to leave out the trailing space and
leave it to the operator to type an equal sign or carriage return
according to the situation.

Cc: Andreas Schwab <schwab@linux-m68k.org>
Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
[added tests]
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    1 +
 t/t9902-completion.sh                  |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b837704..6486a09 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2639,6 +2639,7 @@ _git ()
 			--bare
 			--version
 			--exec-path
+			--exec-path=
 			--html-path
 			--info-path
 			--work-tree=
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f24c968..dfef809 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -94,6 +94,7 @@ test_expect_success 'double dash "git" itself' '
 	--bare Z
 	--version Z
 	--exec-path Z
+	--exec-path=
 	--html-path Z
 	--info-path Z
 	--work-tree=
@@ -122,7 +123,11 @@ test_expect_success 'double dash "git checkout"' '
 test_expect_success 'general options' '
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
-	test_completion "git --exe" "--exec-path " &&
+	sed -e "s/Z$//" >expected <<-\EOF &&
+	--exec-path Z
+	--exec-path=
+	EOF
+	test_completion "git --exe" &&
 	test_completion "git --htm" "--html-path " &&
 	test_completion "git --pag" "--paginate " &&
 	test_completion "git --no-p" "--no-pager " &&
-- 
1.7.10.1.g1f19b8.dirty
