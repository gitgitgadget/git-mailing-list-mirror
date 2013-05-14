From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 30/47] remote-hg: add test to push new bookmark
Date: Mon, 13 May 2013 23:36:53 -0500
Message-ID: <1368506230-19614-31-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72h-0004oJ-QL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab3ENEkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:19 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:50109 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755842Ab3ENEkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:18 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so104369oag.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+rJsFCYiz0s8ewef4tJIDnSJu9kmO5z0Xz1LpfnrDKA=;
        b=Q2j0GezpEainwl+Nd++SrBCxBdaqguCrGJs++uCSWQir5JJ8mI/wOsK5hbJME90+tC
         weWbK7YLrifzeM87x4OnpTUa7yfuzWgJno/5gZwEApzf/2fY1fw/jXpB4lfNYWjZzhlZ
         Kcza5FhlLVy+qZX+d7Y5w3aAqmWZnWKdRFNSpCIGi4E7aYrVEo/mdMCeIUkZ906ftmk/
         T7RRyF4TwWp9lb66jJv6SXuV7rdfMMTCZVGFIHFw7gPXa2IAzPGy/OTGOxLJ6tLdhccJ
         O/HJLG+36KhKavgdOA0yDrEJjgS5DHDF13vt8Fm1le5iXuNCLlOULj4EEoA99sxbYWIu
         KZyg==
X-Received: by 10.60.93.37 with SMTP id cr5mr15455980oeb.112.1368506417656;
        Mon, 13 May 2013 21:40:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n6sm20472321oel.8.2013.05.13.21.40.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224262>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 44764a0..5e4f53f 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -107,6 +107,21 @@ test_expect_success 'update bookmark' '
 	check_bookmark hgrepo devel devel
 '
 
+test_expect_success 'new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
 # cleanup previous stuff
 rm -rf hgrepo
 
@@ -222,4 +237,19 @@ test_expect_success 'remote update bookmark' '
 	check_bookmark hgrepo devel devel
 '
 
+test_expect_success 'remote new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
 test_done
-- 
1.8.3.rc1.579.g184e698
