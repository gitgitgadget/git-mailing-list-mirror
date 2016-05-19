From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 01/20] read-cache.c: fix constness of verify_hdr()
Date: Thu, 19 May 2016 17:45:38 -0400
Message-ID: <1463694357-6503-2-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:46:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmG-0006Um-3M
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279AbcESVqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:40 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33734 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcESVqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:39 -0400
Received: by mail-qk0-f181.google.com with SMTP id n63so56492385qkf.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=2S5M3o9cRn3EKz2HKM2zau8M3eblcuOEcT3qNPmALAzHZqyzQSdIX2Vjteb0TiYKT5
         DQRRVcnAclQ5YXByPqbOmIipDd+8JLEgY2oEX9wk/ACYTAF6sW6eW1KwhGhZAGc9xAfo
         x9s4IhVctBiVs4UiKk08365VwV6LOK4LsbIH75BG/i96vrhuPoJ7vINZwREx9txVLP6h
         P2z6RlOGFLnXow6k2bk5/n7aZpP8RSU+oVxpwOWwtbznkyaDGM+SoRj6U1dBSRLAbTsn
         4iABSzsEHOcspeukoHcz7M1O11QGrTMZt1wQTR7j+KdKMuwDEJSrY8zZS+U7Mmv1v3Mb
         nLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uewEGQ0wF/3DxfN+baDwQCJkdkBanU90hVkFsq63qvw=;
        b=GZTo4SxMs/QZiSB/dhwTcHNP5ts8wDmu3hyndzcDmHrpVDMYXxTweu4G07RuukkARZ
         3JHdAHublFQTAM4ck6omHhL+mSREOMzMtZFop7VpPBjymrShpqT15GIFY10GKkJ6UAu2
         nGYDEyDnrSghbqmTtxCXha3qrmvMXFNm3NG6X5+fWIe/wclVEjtvFbBBbGfizmCyVLCO
         GwJJ7qo8bmsHkFmQMd80IrjS4VWgQ2iFf/fOQG4wIZVs9WA38VmUrOX/QFdbL2arheC1
         Qj0uxWXivFp/URBfnpfu7WiKY9JDiZ12KELKuq5n/1vd/I7dEP9TUZX66M2G/UxU2WU6
         Usyg==
X-Gm-Message-State: AOPr4FVALvuuHA9rN6SY4m5lULIl5W7gF9qpXYtUeXJQRX/U4vrdxZJOk09/snCkVODeyQ==
X-Received: by 10.233.221.66 with SMTP id r63mr16828237qkf.87.1463694398370;
        Thu, 19 May 2016 14:46:38 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295108>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index d9fb78b..16cc487 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1345,7 +1345,7 @@ struct ondisk_cache_entry_extended {
 			    ondisk_cache_entry_extended_size(ce_namelen(ce)) : \
 			    ondisk_cache_entry_size(ce_namelen(ce)))
=20
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long si=
ze)
 {
 	git_SHA_CTX c;
 	unsigned char sha1[20];
--=20
2.4.2.767.g62658d5-twtrsrc
