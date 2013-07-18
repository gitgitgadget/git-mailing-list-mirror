From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] git add -e: Explicitly specify that patch should have no color
Date: Thu, 18 Jul 2013 18:58:04 -0400
Message-ID: <1374188284-27638-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Matthieu.Moy@imag.fr, Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 00:58:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzx9M-0002if-0i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 00:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab3GRW6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 18:58:12 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60647 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758908Ab3GRW6L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 18:58:11 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so8347458ief.12
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=U0h0kDb9o3eMdOCy/ZWMPjqsYeY+fXxZ5QJnLOE3FIo=;
        b=ZOGf+vz9BvS1m4lv4chS8/waZIfswyPv6QVBRcEide4L+NNWeH4AtXuDznl22AHPDJ
         8Bi2VfnYuB6q8gnXnj4OetpAovTk2KKb41L81Eg4rloRw1j0RXlrPJ0cAiiUjParpnj8
         PqmOEIQxhlhtbuRvU4PALxJTMII9OQm+AOHVOAD/uWSARvuTXgufwEw1qsXz0THWa5GA
         rOhajHwo5LKcfzfNS+rnZMvrvUc/Cckz1OIUGVj9Apa11k1NtLye9+aL5sQ+uApKQkvw
         qVEtqXuIK1cEOjW0Xz2TPNfLqQEIwqBHwYh47+xUtrL6ve03I3GnmuJL36c3nwSrFFrN
         dJ4w==
X-Received: by 10.42.237.204 with SMTP id kp12mr7569604icb.18.1374188290983;
        Thu, 18 Jul 2013 15:58:10 -0700 (PDT)
Received: from alabama.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id d14sm35266038igz.6.2013.07.18.15.58.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 15:58:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.755.gbf91598
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230762>

After this commit:
    4c7f1819b3c142ace98269a556bc929c80e7c9fd make color.ui default to 'auto'
the patch file for 'git add -e' receives all the color codes.  This is because
diffopt.use_color defaults to -1, which causes want_color to now return 'auto'.

By explicitly setting use_color to 0, we can ensure the diff output has no
color codes in it.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 builtin/add.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/add.c b/builtin/add.c
index f45d9d4..8266a9c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -343,6 +343,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev.diffopt.use_color = 0;
 	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
 	out = open(file, O_CREAT | O_WRONLY, 0666);
 	if (out < 0)
-- 
1.8.3.3.755.gbf91598
