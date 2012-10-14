From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 09/12] wildmatch: fix case-insensitive matching
Date: Sun, 14 Oct 2012 09:35:07 +0700
Message-ID: <1350182110-25936-10-git-send-email-pclouds@gmail.com>
References: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 04:36:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNE4E-0005qc-P3
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 04:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab2JNCg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2012 22:36:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37467 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2JNCg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 22:36:27 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3964144pbb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5dlN8DxEQTTqYmnkVgooFyAKa001vvZB5goN3L5mx/0=;
        b=RaQ2VsVAaZ/OL4BjvJMdmcgpMOv1jINm96FXUg/sDdZprW8aqSxdUJ6tM2sL1LZUJz
         uNB+czYurAJZwMamI2hhbBy5V4kAIcmyklgLopVOha9RbwrYOklUhhPhrWJ3ffsLspM4
         7rCFdHNpqZxHu9D8SsyJxYFOzJs+vHXA0qpF9eTweum/vNhmyl0hAvONdQ39YWeji+8y
         MzhcpZAX88HGS5y5Hrtqi6F+Ts3qCYPn3ZFlKHXkivcFFyYbk8uIgk/AQsDmcM49JC8Z
         WOl72oHD9AqnlDGP5XiwQhfyWFAE2TCB1sKiioYHrjP8hh4o5KAQkB5GFJMc1ZLPD4RD
         Dp7Q==
Received: by 10.68.247.196 with SMTP id yg4mr26257738pbc.167.1350182187181;
        Sat, 13 Oct 2012 19:36:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id x8sm6783211paw.16.2012.10.13.19.36.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 19:36:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Oct 2012 09:36:12 +0700
X-Mailer: git-send-email 1.8.0.rc2.11.g2b79d01
In-Reply-To: <1350182110-25936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207600>

dowild() does case insensitive matching by lower-casing the text. That
means lower case letters in patterns imply case-insensitive matching,
but upper case means exact matching.

We do not want that subtlety. Lower case pattern too so iwildmatch()
always does what we expect it to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index 20c5ef6..6542524 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -71,6 +71,8 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		return ABORT_ALL;
 	if (force_lower_case && ISUPPER(t_ch))
 	    t_ch =3D tolower(t_ch);
+	if (force_lower_case && ISUPPER(p_ch))
+	    p_ch =3D tolower(p_ch);
 	switch (p_ch) {
 	  case '\\':
 	    /* Literal match with following character.  Note that the test
--=20
1.8.0.rc2.11.g2b79d01
