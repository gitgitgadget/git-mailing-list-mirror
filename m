From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 39/41] upload-pack.c: use error_errno()
Date: Tue,  3 May 2016 19:04:12 +0700
Message-ID: <1462277054-5943-40-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:10:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ9j-0001Wo-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206AbcECMKQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:10:16 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34201 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930AbcECMKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:10:14 -0400
Received: by mail-pf0-f181.google.com with SMTP id y69so9217482pfb.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=KgmjQkA1dDKfeEymv82LgM6p+FJtsZaS5rrXa2mLDGfqW0Y9vtn0PLyKxi3OPrh+uC
         BPOSL2S1Sf6d6oBEULf5RfcGCMentWHWlDnH2wwiU3mziGo8h6Mo6LQINaFgGvNCYvoP
         HUxIWuk0Wo8oBLCgxKQviB50IKeTfdEpA7zU8MeHft+BUjYRmHWyJBcO4a62a8zIrux+
         IEdYHyZGe+KE93y8Q3d8HKpP/DOyAJZpWpXkr0B5LpsOc2+fiOpJqAzwGNXO9uNq673c
         SMzqBEY/Y6wSEr7UtSr0E5aGZhRJU5EMG0LuFCRPijxtsxB9cRjBZcwn3L2w2ZxXsG+U
         sVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrMpYL76dCsegoGZnSvjOxowW8myTE9oSuxMkZa2abU=;
        b=hrKz+Mn+pajRoMhDO9dSQ+haWOp4oN4xKvgfsgKhwonmMWVgVdCcbUKrlFlxPzqGv2
         q4efk7lsEH9g2k0UFtcizJqOdETOx1hPFDkAvGiG023BU0e1GWIPud4HYv+h5cfP9WcO
         AJtQRyxJWd52ZetSYlasD+kmhXz72mfVDKeG0TOrGojhYclfvsDRVVIrpNior780q9re
         7Gb/hF/MI6yBAApb8T9KiZuZ5N4lNboRluh2Gy4lkBBLMflCUEZ6xcJXvQYAK2e6W520
         EXRBq1F4odsDs4wSz+Y+rldgsNKARfR/xUQSSJrBL/q6KE5y17j0aisY0RmMRh94fXlM
         95Xg==
X-Gm-Message-State: AOPr4FW/+eJ72zw/u0OE5gqGkjCIrr0ra0FL1Ny9SX7mggWftLKIRZfEJRfqdoe7qnV0jg==
X-Received: by 10.98.28.65 with SMTP id c62mr2900686pfc.61.1462277414359;
        Tue, 03 May 2016 05:10:14 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id ba9sm5518995pab.24.2016.05.03.05.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:10:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:10:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293390>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..f19444d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -174,8 +174,7 @@ static void create_pack_file(void)
=20
 		if (ret < 0) {
 			if (errno !=3D EINTR) {
-				error("poll failed, resuming: %s",
-				      strerror(errno));
+				error_errno("poll failed, resuming");
 				sleep(1);
 			}
 			continue;
--=20
2.8.0.rc0.210.gd302cd2
