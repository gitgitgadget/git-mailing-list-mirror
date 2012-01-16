From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] diff: do not duplicate shortstat with "git diff --stat --shortstat"
Date: Mon, 16 Jan 2012 11:47:58 +0700
Message-ID: <1326689281-23788-3-git-send-email-pclouds@gmail.com>
References: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 05:49:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmeVK-0002eA-US
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 05:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab2APEse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 23:48:34 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34863 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2APEsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 23:48:32 -0500
Received: by mail-iy0-f174.google.com with SMTP id f6so1947623iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 20:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hbCvrHS/6bgkNzaX0AToZGhIj/QaU/SWKILFo7uNisM=;
        b=bwrdeGtsOZ02QAIsspPEe7s5gQaKET481Ek16er8zkTN68jpkHYGejuZ7Uw0CHMmkh
         gL916rHvOYbKJPJS0IQcdUoPUDJzxR2VYEZQ3FPSgeYtYUkdY81NUG05KIz5BWzVMgHk
         zFj/usmPDMbcS04nl2bLMcPVBQqbKR0TQTkK4=
Received: by 10.42.19.69 with SMTP id a5mr6904758icb.35.1326689312408;
        Sun, 15 Jan 2012 20:48:32 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id uz5sm5903064igc.0.2012.01.15.20.48.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 20:48:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Jan 2012 11:48:22 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1326689281-23788-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188612>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index d4223e2..203b054 100644
--- a/diff.c
+++ b/diff.c
@@ -1465,10 +1465,6 @@ static void show_stats(struct diffstat_t *data, =
struct diff_options *options)
 			fprintf(options->file, "%s ...\n", line_prefix);
 		extra_shown =3D 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	fprintf(options->file,
-	       " %d files changed, %d insertions(+), %d deletions(-)\n",
-	       total_files, adds, dels);
 }
=20
 static void show_shortstats(struct diffstat_t *data, struct diff_optio=
ns *options)
@@ -4218,6 +4214,9 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_DIRSTAT && DIFF_OPT_TST(options, DIRS=
TAT_BY_LINE))
 		dirstat_by_line =3D 1;
=20
+	if (output_format & DIFF_FORMAT_DIFFSTAT)
+		output_format |=3D DIFF_FORMAT_SHORTSTAT;
+
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_=
=46ORMAT_NUMSTAT) ||
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
--=20
1.7.3.1.256.g2539c.dirty
