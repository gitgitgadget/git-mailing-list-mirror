From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/3] git-p4: failing test case for skipping changes with multiple depots
Date: Sat, 19 Dec 2015 09:39:38 +0000
Message-ID: <1450517980-1744-2-git-send-email-luke@diamand.org>
References: <1450517980-1744-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Hocevar <sam@hocevar.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 10:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAE0D-0001Gi-HU
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 10:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbbLSJjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 04:39:41 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36935 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbbLSJji (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 04:39:38 -0500
Received: by mail-wm0-f42.google.com with SMTP id p187so13341521wmp.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FytS4OvCj7zQpR2lZIf3riG80KVz8lDSC0hz8B6N7Bk=;
        b=fB5+EO1v8GnvuZ7JsBLqo8OfhCkXkeynSZmIejVeicUHPeXWtFOKAKP3czwCLsfqSf
         PtKN+pNfw53IjFaByuuj1w6Uy7wOgM110DH9ReheX0zaPrCFHbUnlezdkZu7R3WRYsyQ
         LT/SQz9taItdmJDS1vPWMBFIBhhEN3birp/hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FytS4OvCj7zQpR2lZIf3riG80KVz8lDSC0hz8B6N7Bk=;
        b=LqdEomrsbMED3Fj5hS8nAgzkJuQMnW5p0D1mmXckgVJBvP0ddjveF19ezy2PvoIOUN
         +vKOP7OeljAdaTCQIqVDs3FvYPrRqMewetZgVxj3IuvrEzA7nkngD/hvYoOKHMigeyzu
         1m1y9znh5YU9YdGpKsX4FIfAx8+h6eoR7IT1nwN3iS3iT1nyzMy5MC37DWw0Pf5QouZO
         VdSzNy+aP1dBwiHh7EBqGLNQx+PLacsFbbfc06Ee9JIYRq1QdIn3i8SaJMkaWEPUuk5J
         ppZ/Awy/11nCW4c+W75TqQCqP4Jh+UEURGyjrgPgZnBQeciNnz3s/LV38dX6c1vGRt73
         YZog==
X-Gm-Message-State: ALoCoQkuM/6JHCUgb99uRw14HCJtnIQC6UpNIpJqXwKl3gOuXxNWrze6yX8cqGKv7JHq6kEur/qcKY50uEawcn52dYpiU38wOA==
X-Received: by 10.28.24.200 with SMTP id 191mr7603475wmy.99.1450517977190;
        Sat, 19 Dec 2015 01:39:37 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id b84sm10211547wmh.15.2015.12.19.01.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 01:39:36 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
In-Reply-To: <1450517980-1744-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282740>

James Farwell reported that with multiple depots git-p4 would
skip changes.

http://article.gmane.org/gmane.comp.version-control.git/282297

Add a failing test case demonstrating the problem.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9818-git-p4-block.sh | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 3b3ae1f..64510b7 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -84,7 +84,7 @@ p4_add_file() {
 	(cd "$cli" &&
 		>$1 &&
 		p4 add $1 &&
-		p4 submit -d "Added a file" $1
+		p4 submit -d "Added file $1" $1
 	)
 }
 
@@ -112,6 +112,32 @@ test_expect_success 'Syncing files' '
 	)
 '
 
+# Handling of multiple depot paths:
+#    git p4 clone //depot/pathA //depot/pathB
+#
+test_expect_success 'Create a repo with multiple depot paths' '
+	client_view "//depot/pathA/... //client/pathA/..." \
+		    "//depot/pathB/... //client/pathB/..." &&
+	mkdir -p "$cli/pathA" "$cli/pathB" &&
+	for p in pathA pathB
+	do
+		for i in $(test_seq 1 10)
+		do
+			p4_add_file "$p/file$p$i"
+		done
+	done
+'
+
+test_expect_failure 'Clone repo with multiple depot paths' '
+	(
+		cd "$git" &&
+		git p4 clone --changes-block-size=4 //depot/pathA@all //depot/pathB@all \
+			--destination=dest &&
+		ls -1 dest >log &&
+		test_line_count = 20 log
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.6.2.474.g3eb3291
