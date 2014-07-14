From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v1 2/3] dir.h: move struct exclude declaration to top level
Date: Mon, 14 Jul 2014 11:48:03 +0200
Message-ID: <53C3A753.5090700@gmail.com>
References: <53C3A71F.1020101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6crl-0008PH-AU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 11:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbaGNJsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2014 05:48:09 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:48793 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaGNJsG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 05:48:06 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so2189649wiv.15
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=puU3KWnT9zf5sFFJdaeq4kOyQ94jNNalxRX6x52jJ7w=;
        b=nRe+y6BKl6YoA2yjUCgcdfi78JGuSapL7cBMFGZaqTqMiGPTG3CvMpC3bj0WpEUxAF
         bgrhzJmSXPgRp899KBhZAzwTN92nH410F2yAluKxekUaiLZbhfrJb+g3XySX6beE11JJ
         QiFNUmAKeFs566nJimk14a2zfWsxbbW4phYhfjP9v9B7bd0wHImMg2MvGuuVln19UyNP
         IkKm3k/PO7PAhxIw8RnjHNx8Fu1YNkZGziiOoVhLRw69t206MFYJdFfhxoDZX8uA+oEo
         YRgepQp7PMbmAItBGPgL+JK8az1vJgMilF/xlC7u8EXV0928eodui8kKq9jzx8Z/yHB2
         wfHA==
X-Received: by 10.194.237.135 with SMTP id vc7mr18477294wjc.86.1405331284599;
        Mon, 14 Jul 2014 02:48:04 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id d4sm29187269wiy.13.2014.07.14.02.48.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 02:48:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C3A71F.1020101@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253481>

=46rom: =3D?UTF-8?q?Nguy=3DE1=3DBB=3D85n=3D20Th=3DC3=3DA1i=3D20Ng=3DE1=3D=
BB=3D8Dc=3D20Duy?=3D
 <pclouds@gmail.com>

There is no actual nested struct here. Move it out for clarity.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.h | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/dir.h b/dir.h
index 55e5345..02e3710 100644
--- a/dir.h
+++ b/dir.h
@@ -15,6 +15,27 @@ struct dir_entry {
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
=20
+struct exclude {
+	/*
+	 * This allows callers of last_exclude_matching() etc.
+	 * to determine the origin of the matching pattern.
+	 */
+	struct exclude_list *el;
+
+	const char *pattern;
+	int patternlen;
+	int nowildcardlen;
+	const char *base;
+	int baselen;
+	int flags;
+
+	/*
+	 * Counting starts from 1 for line numbers in ignore files,
+	 * and from -1 decrementing for patterns from CLI args.
+	 */
+	int srcpos;
+};
+
 /*
  * Each excludes file will be parsed into a fresh exclude_list which
  * is appended to the relevant exclude_list_group (either EXC_DIRS or
@@ -32,26 +53,7 @@ struct exclude_list {
 	/* origin of list, e.g. path to filename, or descriptive string */
 	const char *src;
=20
-	struct exclude {
-		/*
-		 * This allows callers of last_exclude_matching() etc.
-		 * to determine the origin of the matching pattern.
-		 */
-		struct exclude_list *el;
-
-		const char *pattern;
-		int patternlen;
-		int nowildcardlen;
-		const char *base;
-		int baselen;
-		int flags;
-
-		/*
-		 * Counting starts from 1 for line numbers in ignore files,
-		 * and from -1 decrementing for patterns from CLI args.
-		 */
-		int srcpos;
-	} **excludes;
+	struct exclude **excludes;
 };
=20
 /*
--=20
2.0.0.9646.g840d1f9.dirty
