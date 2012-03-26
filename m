From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/4] add tests for grep --heading with context
Date: Sun, 25 Mar 2012 22:41:43 -0400
Message-ID: <1332729705-9283-3-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBztX-0000gP-5j
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 04:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572Ab2CZCmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 22:42:37 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56519 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2CZCmA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 22:42:00 -0400
Received: by qaeb19 with SMTP id b19so1918880qae.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 19:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pJOY+J2t/3J+pquqzwSTGo7ZRkDd7JQjwaBPe7+wD8M=;
        b=NyjH65UzwvOqtf4v4oKOSa4TbXoHT6nGna9MKSMk1h0PyqZnpcQKVJCl/x5MrP6nHj
         hl5x7XACF19R56fDRK4s2u3G8O5gWRkM7rQxYFt5ibI7F1LyilsW18B8R1edTi4MYzRC
         xL/x0NTzwlvzmI3zhKvwaKG1SC/D+piF/X3COA8eXEMi3wSYQouRjah2Du0MUt6ExBE/
         CPEsU9kw44plZNpo4TRJaLi8NHZXkWh11k2NyD9oLFUYy244breYlgBFL28xdjeQGSBV
         p5xEawdWcTwm1F6BoWgoXkhxUwZ1Fy/lb3cfP/Ixd4Tq5RUlw5GYHc6m/hZERvcqim/P
         WEcw==
Received: by 10.224.101.69 with SMTP id b5mr25704028qao.25.1332729719754;
        Sun, 25 Mar 2012 19:41:59 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fq1sm27711867qab.10.2012.03.25.19.41.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 19:41:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193893>

It is easy to make a mistake in the logic that conditionally prints out
hunk separators in the various combinations of --heading, --break,
and --context.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 t/t7810-grep.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index d9ad633..58c0821 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -901,6 +901,43 @@ test_expect_success 'mimic ack-grep --group' '
 '
 
 cat >expected <<EOF
+hello.c
+int main(int argc, const char **argv)
+{
+--
+	/* char ?? */
+}
+--
+hello_world
+Hello_world
+HeLLo_world
+EOF
+
+test_expect_success 'grep --heading with context' '
+	git grep --heading -A1 -e char -e lo_w hello.c hello_world >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c
+int main(int argc, const char **argv)
+{
+--
+	/* char ?? */
+}
+
+hello_world
+Hello_world
+HeLLo_world
+EOF
+
+test_expect_success 'grep --break --heading with context' '
+	git grep --break --heading -A1 \
+		-e char -e lo_w hello.c hello_world >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 space: line with leading space1
 space: line with leading space2
 space: line with leading space3
-- 
1.7.9.2
