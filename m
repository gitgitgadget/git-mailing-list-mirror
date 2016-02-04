From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/25] upload-pack: tighten number parsing at "deepen" lines
Date: Thu,  4 Feb 2016 16:03:45 +0700
Message-ID: <1454576641-29615-10-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFrF-00063F-DB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965436AbcBDJFK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:05:10 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32928 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbcBDJFE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:05:04 -0500
Received: by mail-pf0-f178.google.com with SMTP id w123so38611894pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=73nAhb//ZLwSW8hhjDBXX3M/E93ePJgeaeeGkNe76ek=;
        b=NVb4T0QkG/RbdpFqYt4N9PRmX//kdn1j00hRXFPCR69m1jw0uCeJPHTNNUEOFbv3EL
         wJsfkQJKK3ANi2pw92YaCaNP/xPd2a8OvxX0uV1mo4PvmdA4BWCnpXJmp/IwQB1pFseY
         dsdnCeU0PdTEjCLXZUPKJX3AVMosdohnVdctYCbmAOzE0oM2ziHlw7J2SXIL9/Gu++Il
         FdcLf0of4TO0vOrlwipLlzqEkCKi80cDSiXYMDSi1W60N+LXB1wsQdSjDczZ3RNlq057
         UzEm0NQYab81udVJnZcwwOK1hhsThVEbue176fhMHmTw8TEbbmQqEgJc3G/kaXCPEgfj
         4sQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=73nAhb//ZLwSW8hhjDBXX3M/E93ePJgeaeeGkNe76ek=;
        b=WIa3T2kSRsObOZeD4piCoJcB4ep9egVDKjdECPnCXE5EDN9jj9Fd4hiNAmC1M9PA7S
         ALclK66QdRAQsp44U8ny8i+yLWszHdtPKBvu5M24sq0bdJc4hoatQzhaLulKyoKkAIIY
         EYJaCGgM2MjBdnkmEr04Un260dSJPvBsmDhyc+IDSkMcaRYtup1IsEoutdObtrfXN2Ji
         YTDnPPE4hHbugFzZ7hsKU9xrlVXApn+FIoGA+JtuacBh1JB/rLylE8BhzEUXjmgw6Z9w
         RatTJm7CCxgEyB4FHMaMZfQL3YCHqoaqtunPgnTHthmSlPssA+88OCwLREBJAODmFPEI
         gVMQ==
X-Gm-Message-State: AG10YOQqv87+eyrZ1GVFOhFRypTxwR6QR+XHDtvAZl9yn21G8WIf4npqTascN9hdj0915A==
X-Received: by 10.98.69.155 with SMTP id n27mr9349645pfi.68.1454576704389;
        Thu, 04 Feb 2016 01:05:04 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id v86sm15323904pfa.83.2016.02.04.01.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:05:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:05:17 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285425>

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
2.7.0.377.g4cd97dd
