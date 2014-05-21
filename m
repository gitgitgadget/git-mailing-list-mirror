From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v4 1/5] t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
Date: Wed, 21 May 2014 17:20:03 +0400
Message-ID: <69a0e0d286e3c2999e47e9591a91901baaa52327.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400678003.git.Alex.Crezoff@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 15:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn6Ri-0001wM-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 15:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaEUNUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 09:20:32 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:64584 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbaEUNUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 09:20:31 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so1589486lab.17
        for <git@vger.kernel.org>; Wed, 21 May 2014 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=uZxoyyMvM0lDVQusVtXKvUZqCQQIpIeVwz0gUM3J+CM=;
        b=ctFmZfkFH5iF5tsJdqO5M5/7EIxZBaSJ9/VEvn9brYGgkFj5zXBtwNXVqWiI1Gq/ft
         lt0K9z7oZ95OYw8mP73IDtCc8WhwL9Ufu7GrLSnBKXXS2sXx8LYElzLP2rPJN3W9HPze
         RyQS4Cwqh+KX5ScdVw0r9l/NUHw+4ith69QkkJ+xoJ3IsJA65CPDquStZQj5NQo3+FG2
         kXXxjjzGQiVaDjb5jhAWY0QUmZ7vY1OD6Z9FkXrv86WBdFvs40wEEnUHOk2vNsisMT9d
         DNLUfdc5Ecvl0ANp2Ed/dtvZ++A209jchYMwS5IkC7w9JR4emp/NRLuzof/2nxBl3G6t
         QOHw==
X-Received: by 10.112.135.106 with SMTP id pr10mr35749454lbb.24.1400678429643;
        Wed, 21 May 2014 06:20:29 -0700 (PDT)
Received: from localhost (ppp91-77-196-183.pppoe.mtu-net.ru. [91.77.196.183])
        by mx.google.com with ESMTPSA id dl4sm1804657lbc.4.2014.05.21.06.20.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 May 2014 06:20:29 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-15
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400678003.git.Alex.Crezoff@gmail.com>
References: <cover.1400513063.git.Alex.Crezoff@gmail.com> <cover.1400678003.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249795>

The expected SHA-1 digests are always available in variables. Use
them instead of hardcoding.

That was introduced in a742f2a (t4205 (log-pretty-formats): don't
hardcode SHA-1 in expected outputs, 2013-06-26) but unfortunately was
not followed in 5e1361c (log: properly handle decorations with chained
tags, 2013-12-17)

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2a6278b..f9f33ae 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -296,6 +296,10 @@ EOF
 	test_cmp expected actual
 '
 
+# save HEAD's SHA-1 digest (with no abbreviations) to use it below
+# as far as the next test amends HEAD
+old_head1=$(git rev-parse --verify HEAD~0)
+
 test_expect_success 'left/right alignment formatting with stealing' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
@@ -310,6 +314,10 @@ EOF
 	test_cmp expected actual
 '
 
+# get new digests (with no abbreviations)
+head1=$(git rev-parse --verify HEAD~0) &&
+head2=$(git rev-parse --verify HEAD~1) &&
+
 test_expect_success 'log decoration properly follows tag chain' '
 	git tag -a tag1 -m tag1 &&
 	git tag -a tag2 -m tag2 tag1 &&
@@ -317,9 +325,9 @@ test_expect_success 'log decoration properly follows tag chain' '
 	git commit --amend -m shorter &&
 	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
 	cat <<EOF >expected &&
-6a908c10688b2503073c39c9ba26322c73902bb5  (tag: refs/tags/tag2)
-9f716384d92283fb915a4eee5073f030638e05f9  (tag: refs/tags/message-one)
-b87e4cccdb77336ea79d89224737be7ea8e95367  (tag: refs/tags/message-two)
+$head1  (tag: refs/tags/tag2)
+$head2  (tag: refs/tags/message-one)
+$old_head1  (tag: refs/tags/message-two)
 EOF
 	sort actual >actual1 &&
 	test_cmp expected actual1
-- 
1.9.2-15
