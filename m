From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] revision: make --grep search in notes too if shown
Date: Sat, 29 Sep 2012 11:41:29 +0700
Message-ID: <1348893689-20240-4-git-send-email-pclouds@gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 06:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THozS-0007bo-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 06:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab2I2EtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Sep 2012 00:49:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38637 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab2I2Esh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 00:48:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so5926981pbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 21:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CfZJ0+qHvuKbS0hSA96Px1gvJ9wwsCHjFbh+M6NmXA4=;
        b=tlirxU7TyTxTU5kQwELaaNJGx7vHk4Q0+R8q2Qn7EBCn5ciP2igRlxqhNg1hiv4iqn
         2LC9drCA9aFcUH2VRZjp060Ci4bAikahnPwKTtD37Kdcmfk1+0OoGeLBosh+XvxRfpps
         YzH4HMP1QNPjXaGwBzF6OS8+c3zZXunCZZy+NL+nbu/smuOYpEok8Gwtacc7Q3bGBUZn
         QG92oIjEduJIAPUA7kKE5O3NHoHkxfIlnHLcirJj1mFa5rD3AFWNys3kA4t26xjWEZ5C
         KSKno4maEemyTKLafo5E0ODKp4emB/w8MRTmAMr4cqLTOJEWSi9ICGZ+6mzRa+PPN+De
         OnnQ==
Received: by 10.66.74.196 with SMTP id w4mr22185397pav.32.1348894117519;
        Fri, 28 Sep 2012 21:48:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id j10sm6623656pax.4.2012.09.28.21.48.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 21:48:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 29 Sep 2012 11:41:49 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206621>

Notes are shown after commit body. From user perspective it looks
pretty much like commit body and they may assume --grep would search
in that part too. Make it so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 revision.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index 109bec1..dff6fb7 100644
--- a/revision.c
+++ b/revision.c
@@ -2223,6 +2223,12 @@ static int commit_match(struct commit *commit, s=
truct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 		strbuf_addstr(&buf, commit->buffer);
 	}
+	if (opt->show_notes) {
+		if (!buf.len)
+			strbuf_addstr(&buf, commit->buffer);
+		format_display_notes(commit->object.sha1, &buf,
+				     get_log_output_encoding(), 0);
+	}
 	if (buf.len)
 		retval =3D grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
--=20
1.7.12.1.406.g6ab07c4
