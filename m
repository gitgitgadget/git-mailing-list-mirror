From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 15/41] check-racy.c: use error_errno()
Date: Tue,  3 May 2016 19:03:48 +0700
Message-ID: <1462277054-5943-16-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 14:07:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ7N-0000Cn-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbcECMHr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:07:47 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35829 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932610AbcECMHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:07:46 -0400
Received: by mail-pf0-f170.google.com with SMTP id 77so9226882pfv.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=yP7ApkWtUY1H6BcifbnsU459CgHMJHJdOeq/PmwVyBJsyJ9xi9u58GPZ8/qNSuCqN9
         4Ny/8lM4vucpjQ0SJVH336aalSTjbCP8VwF6BGKvDFzdZaw5BBgEN1XjKwwfuLQ8gbKc
         BLiQ2FvBZXF8sfioTAUixjk3eoBLdCsm2AtqZFhuxkQXCa1+gyn3EXk18qqpwv7kJojV
         I0xsWPNl22SAovscTiEtW5LJVLOcFt/W2E1JhBkSOlq3ALs6L1jbd4QoVjJ91xqGNo12
         F7RL4LL7+1Q064eUxkb87C2Zc6xhOEbo+hZXgkMlb1TRJb3+XTFTIfvy09GkOSazE/m3
         0HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=C0y5kM5KIl0a9KcGMKDmWMMQL3aRgAab5U3LTOj6oqRnETVJg5pG+FTnxCq5IOTlcO
         aiJbuxIELYAgd+bNLkzAcqvii3pEZn9nPyPRhnRijIIH1FCfd6A6dn/spLBDxCe/T/LB
         YOxxQSWK/mEpg3cyWeM0XxRufr3aqzNaA0+9xztf5Yd3DoFz5UGytHliyxZ5TktbKMkK
         WMT9QZrV6Z0wu9vBT9EIVaOMBdP22x9gobxB+oh8UKSyJfoWYTaTj9eqZvIrPEApX3lO
         vSIbB/bq9HpBl+2RpDKy7mKw5SiQ/TA5/ttOf61OQXqZDJlt5Z0tFcf8Hslxn6UVe2sF
         pTOA==
X-Gm-Message-State: AOPr4FXUs9YfGNhVaV0aiyT27/cFul9MQU+DIhra/tnnmR6vi+cmLktmFGeNJViRqugr7A==
X-Received: by 10.98.15.142 with SMTP id 14mr2971107pfp.6.1462277265318;
        Tue, 03 May 2016 05:07:45 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id v185sm5485878pfb.72.2016.05.03.05.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:07:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:07:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293366>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 check-racy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check-racy.c b/check-racy.c
index 00d92a1..24b6542 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -12,7 +12,7 @@ int main(int ac, char **av)
 		struct stat st;
=20
 		if (lstat(ce->name, &st)) {
-			error("lstat(%s): %s", ce->name, strerror(errno));
+			error_errno("lstat(%s)", ce->name);
 			continue;
 		}
=20
--=20
2.8.0.rc0.210.gd302cd2
