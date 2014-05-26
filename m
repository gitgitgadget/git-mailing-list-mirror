From: Caleb Thompson <cjaysson@gmail.com>
Subject: [PATCH v3 3/5] commit test: Use write_script
Date: Mon, 26 May 2014 13:56:24 -0500
Message-ID: <1401130586-93105-4-git-send-email-caleb@calebthompson.io>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 20:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp04x-0001UC-P6
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 20:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaEZS4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 14:56:54 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50516 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbaEZS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 14:56:43 -0400
Received: by mail-ie0-f180.google.com with SMTP id tp5so7924244ieb.39
        for <git@vger.kernel.org>; Mon, 26 May 2014 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KpprIvgxHkZwNZnqeuwdYLGC3Y4OxAQm5W0KO2pBGiw=;
        b=wwqrgWzBzxlPN1JRSqu7ZsON8wQoKLuZjgt0kCNYkOO4wSjSJGMDZo0THTMc5OI15Q
         yomB7OQnLnGJFBvWi0sR2LcffGtpZ/A5I/MWcop+8kdoReE6hYj2S+ihBjaeYf8DKL4B
         RY12qaE4A8VImmEEcrBoyVMoxbrxfhZHfkbB5Y2tsaFBdzqls6KWj2Z9R7fBJlD/zKyI
         dgjhZqDO808z/oSLICFYxv1nqiAioTbeUAKQTuU9gBvVzxtCYjWSRFQNn+s6REsQdHA2
         zyOy1Uw/7Gc19Uls4QMXJz7ZTRSBEGrzJj1GHCJrvP05G6nurFraMp9243CwIa3Gk6HC
         ENcg==
X-Received: by 10.42.99.138 with SMTP id w10mr24874234icn.42.1401130603111;
        Mon, 26 May 2014 11:56:43 -0700 (PDT)
Received: from sirius.att.net (107-216-44-113.lightspeed.austtx.sbcglobal.net. [107.216.44.113])
        by mx.google.com with ESMTPSA id ql7sm1708857igc.19.2014.05.26.11.56.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 11:56:42 -0700 (PDT)
X-Google-Original-From: Caleb Thompson <caleb@calebthompson.io>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250115>

Use write_script from t/test-lib-functions instead of cat, shebang, and
chmod.

Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
---
 t/t7507-commit-verbose.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 3b06d73..e62d921 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -3,11 +3,9 @@
 test_description='verbose commit template'
 . ./test-lib.sh
 
-cat >check-for-diff <<EOF
-#!$SHELL_PATH
-exec grep '^diff --git' "\$1"
+write_script check-for-diff <<-EOF
+	exec grep '^diff --git' "\$1"
 EOF
-chmod +x check-for-diff
 test_set_editor "$(pwd)/check-for-diff"
 
 cat >message <<'EOF'
-- 
1.9.3
