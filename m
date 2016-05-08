From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/41] check-racy.c: use error_errno()
Date: Sun,  8 May 2016 16:47:35 +0700
Message-ID: <1462700881-25108-16-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:51:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLLm-0000pT-Ld
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbcEHJuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:50:05 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36264 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcEHJuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:50:02 -0400
Received: by mail-pa0-f66.google.com with SMTP id i5so13722235pag.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=dbz+OCJlYeohkYV0aoBr3orp7tGfIG4aBjUrfXk6UGUbZK6TQcUa8kVw3215JcnlGH
         B39v5ly1i343r2T1ImXnFaVZfkz/tRQpYUkjLYYmq6QBxX5iXx3mwiAqMHsu21DJsE6i
         OlkMYUihcuL802EoB2UrUALj6knf6jJYg+ZAoxZqyijDTjrWFSMxXOVCQcTh/hO+MbCW
         SdVMKeNvSjtawFYqrNIZlHpNwH4P8XssFc78Ajoqfog40vCqkOouNzxhf1YR33ILteWz
         6+R/7/ZbyPxlHwBx/31HebhGD51hsEOVrX2qvcQ3LH/xwSO9Kc5dUWA2MDyRMpA/eUPX
         Dw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DfWrWJ5ZGArRqWu2+m5QsYuoP4vyioNntB5jJS7CwU=;
        b=FN6KuR3rZ4Gicte08V20S+3q9yBUziay63kRsJE9k8qQ8JNfuTVI4HOFdOaYT2t3N3
         6Uc5Ugab8sutDR57/27+Y8ftVYM1Uq5p5SWB2kXmlO9gyhUPbLxd810ey0NjOA0KoVzG
         hHktRlyFi2LeATpyL8ZwczwALVn65ohCE4bw0Twz3McQry+tlF3rZF8swRHpBZ95yz7G
         t4Ur9CVbCa6jbSREdMEzjcWx9O+IReJmLFLYaF3exnHIUwrzj9hEeQY/FPGuEr8a+YXI
         y+rGnMrzIWobfNTb1BMep5gdNypzDH1WNL1+HxS5073gz6/qnwd6VxjWQhmpZPRQ1u7B
         94Ww==
X-Gm-Message-State: AOPr4FW8WqHX4HX4EoTcmx7RQKbDrYwn1lb9/anV+7O9Yduad62/WSh+dxOkQwMoT70CUQ==
X-Received: by 10.66.82.166 with SMTP id j6mr41436787pay.140.1462701002177;
        Sun, 08 May 2016 02:50:02 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id h1sm32709296pfh.49.2016.05.08.02.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:50:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:50:01 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293929>

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
