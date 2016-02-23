From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 08/25] upload-pack: tighten number parsing at "deepen" lines
Date: Tue, 23 Feb 2016 20:44:46 +0700
Message-ID: <1456235103-26317-9-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDHf-00009w-OD
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbcBWNpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:39 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34542 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcBWNpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:38 -0500
Received: by mail-pf0-f173.google.com with SMTP id x65so112627552pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=reksN2BETIpFsQv1AQCNAtV7kkXj6menuxSC6yOo2Bo=;
        b=Lp2eb6GBSu+pMNMYCfbps3QcG+j0MxrXMG3wZOB9djyUhjymfyq35rXcgsJOhzajR+
         BVIp4thCxc4cNT1XRLJpASKckCIvtV70L9w8osDUnxLY5HMvaR/80tzAMP9zndRUlfLr
         SOcYBsxFUBwmw6qK7SpHDV92obmtADa94EoHPMJa2/QaEGmLpyEEGpEoW7UgXyduelZM
         yKN69TjCWraxY5jyR8yR4XtLQGv/dmVLp0qGC2CXTmlaxKUATD8/ECKFc2rFkA4PiUa7
         4XGFmlQ6DGcFsUXkK8AMqq/tYMCxzijUACTTfkYHd76Nngt7/GXlBHScLgB/mCMRLZFp
         00qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=reksN2BETIpFsQv1AQCNAtV7kkXj6menuxSC6yOo2Bo=;
        b=eJl1MBZL7Ydba/n0uslU3zqQdRlxk7Dx3pQCKdWp029uNNfcDhEHjuLSxDvi3gNezt
         6RBuOzyUWPV0WBX20989iY2t/Lr9EsNCQ+o9rrsh2ZPvTAvaTmtV0FfC4h5dgBpwiSgq
         +2oBz1brfptL2k4KNKFEFeSN6YoJoHxSAhc/AVbk0EK0tSkUJtBsIJix+SSTg8u6gTnj
         GfMZbZ10465Wpev3GXZPR1lmW9gdlbu3xNXyU4SZz1Xw/R6J3MVMmzbvoZwwZ4dK5cve
         tPJQtLayKz84kHX9Q3G4pQRFjmK/BADEM70A1Fremh95CcPASwrcICNbQpxqI/qjOUlt
         z62A==
X-Gm-Message-State: AG10YOSyRnRNb+2s8AZj4R7r62zuSRPGnrG30mK3k0Ok1g30z9O8vyJECtT9G8iH7nqhHA==
X-Received: by 10.98.14.146 with SMTP id 18mr46402871pfo.35.1456235137940;
        Tue, 23 Feb 2016 05:45:37 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id qh8sm6020976pac.40.2016.02.23.05.45.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:46:07 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287058>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 257ad48..9f14933 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -641,9 +641,9 @@ static void receive_needs(void)
 			continue;
 		}
 		if (skip_prefix(line, "deepen ", &arg)) {
-			char *end;
+			char *end =3D NULL;
 			depth =3D strtol(arg, &end, 0);
-			if (end =3D=3D arg || depth <=3D 0)
+			if (!end || *end || depth <=3D 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
--=20
2.7.1.532.gd9e3aaa
