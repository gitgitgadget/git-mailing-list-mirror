From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/4] submodule--helper clone: remove double path checking
Date: Wed, 30 Mar 2016 17:17:36 -0700
Message-ID: <1459383457-6848-4-git-send-email-sbeller@google.com>
References: <1459383457-6848-1-git-send-email-sbeller@google.com>
Cc: norio.nomura@gmail.com, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 02:17:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alQJD-00054y-3M
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 02:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbcCaARu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 20:17:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34503 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbcCaARs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 20:17:48 -0400
Received: by mail-pa0-f49.google.com with SMTP id fe3so52556125pab.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1PeHX7SBCnyoOmR4qAN7YKFIZ08mfaZ8gm6AbCb5sA=;
        b=giA4+qIML2VCXtrsLf4u8R+QclVVmtRbURxEXY2oQIFrkts8E5qs7T8WOtBCP08blD
         kUVdIhoUOpXZuybtRWe8OZ8q8i4r19mB2tn+4PLUDBHmE68hIlFTtqrn76gPHRNLwYhG
         WB0wR57AXX0y+tHvk1vBYfAm1J+64n/jDV9PkELs2sQiDzHxqI/zCm+BByKhb+eUixEV
         YLzwB9DWeLlBp7MXbQf2SHGO7fn7z36Of2BcIDnA5AwW7jCDt+IEuxaOL4lsp6c56y7K
         DEfjnZKch1Yg5Nqua2lTIRevvt0RGqeO5b/F7+hFml3/BffKTjOIBtR8ILeRMkBC4Agb
         qAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1PeHX7SBCnyoOmR4qAN7YKFIZ08mfaZ8gm6AbCb5sA=;
        b=ZFZ7mkdATBg6syEw3FFiIt7rwb8r5TEBP2Q9sxBsw+nDdzXUb2YxjDFovMScVMra6Y
         aSn4Hdkh5hTHFI7DxHi7eaeuNfvfdeRZRdeYf8ROif/Tpyx3JqSVCtvNEeLLGRw+EIqS
         2Gd9FPWV37SoKgR5TxzI2lXcb9Se+YjddKgpRsoajwJ6JY3nQR9L6av709vRP4vXDpQv
         uuZ7tj6TBuxkL7dr2cHGgPdfHfEiBzWQFKJaasHvEVvbRppdW1KkGwa7oSClFyRQ4tH+
         Y3HmJO4KcDfYBwrpD6ObbMXZB97jlG/1nce+t4VIuU45Iy3p9ZS2x7CIC4hJ6+H47Urd
         Ct8A==
X-Gm-Message-State: AD7BkJIjo1kwIeSDnrLC5RrOYijwoc0ze4r6kP/rL+qx0dEbcgxx5W3/hoAj05GDHFdUKYPT
X-Received: by 10.66.155.232 with SMTP id vz8mr17447204pab.53.1459383467790;
        Wed, 30 Mar 2016 17:17:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:30b6:9b24:6e56:d07e])
        by smtp.gmail.com with ESMTPSA id n74sm8508671pfa.45.2016.03.30.17.17.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 17:17:47 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g4004fdc.dirty
In-Reply-To: <1459383457-6848-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290361>

Just a few lines after the deleted code we call

  safe_create_leading_directories_const(path + "/.git")

so the check is done twice without action in between.
Remove the first check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 88002ca..914e561 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -212,11 +212,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Write a .git file in the submodule to redirect to the superproject. */
-	if (safe_create_leading_directories_const(path) < 0)
-		die(_("could not create directory '%s'"), path);
-
 	strbuf_addf(&sb, "%s/.git", path);
-
 	if (safe_create_leading_directories_const(sb.buf) < 0)
 		die(_("could not create leading directories of '%s'"), sb.buf);
 	submodule_dot_git = fopen(sb.buf, "w");
-- 
2.5.0.264.g4004fdc.dirty
