From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/2] git-p4: failing test case for skipping changes with multiple depots
Date: Sun, 13 Dec 2015 20:07:13 +0000
Message-ID: <1450037234-15344-2-git-send-email-luke@diamand.org>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 13 21:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CvX-0006zO-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 21:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbbLMUHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 15:07:23 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36757 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbLMUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 15:07:21 -0500
Received: by mail-wm0-f45.google.com with SMTP id n186so93172962wmn.1
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FytS4OvCj7zQpR2lZIf3riG80KVz8lDSC0hz8B6N7Bk=;
        b=TQ/FJweOukaGzacv4vWqNcAHs1LTwvZF8/HGG/1XmdoBvL9dMVBqo5GyV6t/gbSwvm
         wUEUtpsNR1GJ1OnI7ntYCTQTqrJEhUTXLn/osLv8KnhSU+tHYpWSG6PE0uCn55zdp6et
         mEhvORCjUR0vdGUhctsbgldKN+hM92MYqzVRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FytS4OvCj7zQpR2lZIf3riG80KVz8lDSC0hz8B6N7Bk=;
        b=QWPMPLPRS4XNIjOdgFVq2Inx/Uc2l2PsqCNjs4fNPGNlGHSKZ6Agt60gL0/Mx/d47z
         succjTrR0yS7vRNyMdKmvmHHwxJtwD5w3EyGWC3waFRV2cfowQLnHcS9jyflkuIUKQsp
         rer24nq8W3ksywaE2SZO5ku8MyZfA3v/JhzQ1OXLDHsx37q4SgMzMIW9MvgX9RGY0EIK
         xihGWFZZojpqXJT3CG6a9DndCbO440gO7S7ES6rvgohnat2BGz+tCFt6GGg+E89/lI1U
         cwGsKbboI45bumzg+hFrWmwQhVFQZIEjThuHjgAU0W9uno2twQj3JzkT9E3n/KoXxZRJ
         K6TA==
X-Gm-Message-State: ALoCoQl+87D1j/nBB/Zdc3R9D0XsfXJ2L2C81H8umT3R7pV9/f+LUAMLS3RW4SG5aE1gjQlBhD8FYicjfoM2ld73gumPTtnxGg==
X-Received: by 10.194.79.227 with SMTP id m3mr33399125wjx.123.1450037240251;
        Sun, 13 Dec 2015 12:07:20 -0800 (PST)
Received: from ethel.local.diamand.org (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id e136sm7404804wma.23.2015.12.13.12.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Dec 2015 12:07:19 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
In-Reply-To: <1450037234-15344-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282349>

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
