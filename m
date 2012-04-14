From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/5] completion: avoid trailing space for --exec-path
Date: Sun, 15 Apr 2012 00:43:03 +0300
Message-ID: <1334439784-6460-5-git-send-email-felipe.contreras@gmail.com>
References: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 23:44:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAlu-0002Pq-Tz
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321Ab2DNVoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:44:38 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56990 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab2DNVoh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:44:37 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so3144617lah.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ql7InykSgbzbB84IvHsUFE3l7Tdoyf+Zc4M+4KNcIdY=;
        b=hYCb2wkIvKxhBsWUP2IQJC2SBVX87LpsU4huE9k3dvOzOqQ1cRqkWuzmeQJTX9rY1R
         gRmNieQKhDoOiXz4ChUQPS5oXKrgNvahX6OHUE16g/aW6d6DR8baqG8HfUQ7kNKI2IB/
         f+JhUzFSBLwGdyFFCNg2jjmbS8E4vGRJs//0CiMueK97OfFDSvJgkh1w6TaodnvepIKe
         6+9P4Ct19D4J5j+xgn0Htln1HjPrrubMuz7HueQvhyeUZC2vBnhdopyWmlYrMNrqaNV5
         04bwk7tmRejLA/E89mLcm5GjIGNf0/YM8vCDq4+AUQ0AdM72ENLmKBnkmtWTS9Z73vAh
         09tw==
Received: by 10.112.26.1 with SMTP id h1mr2851650lbg.32.1334439876669;
        Sat, 14 Apr 2012 14:44:36 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id p2sm17707072lbj.0.2012.04.14.14.44.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 14:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334439784-6460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195522>

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
index 6a8cf9f..647ee77 100755
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
