From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] parse-options-cb.c: use string_list_append_nodup in OPT_STRING_LIST()
Date: Fri, 10 Jun 2016 18:57:26 +0700
Message-ID: <20160610115726.4805-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 13:58:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBL4r-0000kG-4l
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 13:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcFJL6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 07:58:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35870 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcFJL6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 07:58:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id 62so5036810pfd.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0wOvycSOm/101+3Kw4ee4rwnCRzHe2HrkYnler7YTI=;
        b=FusyG86DOmHi2bHprfswPkz6P6e9lMUef7fHgzW2B56lz0qeQzYE+wotAc2gPUXYDo
         daZWxe0I2z/n5wkBeYk3VnYJQQU/pIf+asuG8kmPTTDtklnOHp+IoyuKFEHqNxyL2nmp
         /PiN2UqEQQKv4iva7lFcCSVC+lMjaWa9MRNoFI3MfRs8RxcxRWAKEz0xX60LvMMj0Cvv
         ZPSNOAK1WN215XoDgwYB9RHMdJHK4++Z/knBDVmC7knlZ1rU4hqQzfH33alNIzo1ZCk2
         bP56hngWOhG2zbC8CMJWVacD2aP/uWr1hNtaUsIKUAr7iFOuXyi/Sa+wre4csvzoQ5kM
         R+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0wOvycSOm/101+3Kw4ee4rwnCRzHe2HrkYnler7YTI=;
        b=jQnGFg/jaRAB4tWMDMxdJeC662waK1q8AqZnwupo9hhFPMlupiuE7MADQz3ssz876I
         TSOolKq1eR6GirfIwcbMZx36KlMIMPiAXGUdkqiIqFGvfechnR/hnKHJYZ3urzaK14nw
         oI93biEjEbX0R9KTPCdbvLPDbWdJ6Z2pOa807Cl7gahtF6tujkxCLmQ9ZOsjC6uWfsbp
         s5UlGBNAsnVl3Afnc9xg3TB0u8kv+uSB1lz42/bbY4mLe98Il6Ctnxlb5shMiNYZFCFM
         VMocg0zJOgJwVU9ujAhqmsOuRila6aMDXBv9tRKteAByO0avpdviOxwieBrrYRRusHrX
         cnYg==
X-Gm-Message-State: ALyK8tJggUmiJySH0fW7r6Wh031E+P6d41rPha7QxtajAaVXK7ZkchWbtprsZG8HWxb61g==
X-Received: by 10.98.82.194 with SMTP id g185mr1855952pfb.157.1465559882612;
        Fri, 10 Jun 2016 04:58:02 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id y2sm17302221pfi.39.2016.06.10.04.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 04:58:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 18:57:57 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296970>

If the given string list has strdup_strings set (*), the string will be
duplicated again. Pointless and leak memory. Ignore that flag.

(*) only interpret-trailers.c does it at the moment

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options-cb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 239898d..8a1b6e6 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -144,7 +144,7 @@ int parse_opt_string_list(const struct option *opt,=
 const char *arg, int unset)
 	if (!arg)
 		return -1;
=20
-	string_list_append(v, xstrdup(arg));
+	string_list_append_nodup(v, xstrdup(arg));
 	return 0;
 }
=20
--=20
2.8.2.524.g6ff3d78
