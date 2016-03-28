From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/7] submodule status: test path handling in recursive submodules
Date: Mon, 28 Mar 2016 16:28:22 -0700
Message-ID: <1459207703-1635-7-git-send-email-sbeller@google.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 29 01:28:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akgaT-0004wc-US
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 01:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527AbcC1X2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 19:28:36 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36534 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbcC1X2e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 19:28:34 -0400
Received: by mail-pf0-f178.google.com with SMTP id u190so148959912pfb.3
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=whPg/5kzHhTEM5xmThuGTApSQtyHUbFCjaLS1sYmHXI=;
        b=nAR4Gz7m5kaJXbEotFl0n76/iX4tidAfmEgBjto4KCUb3WN5sFj85Nov9sbUPDbYv4
         NP+NRFPpRVWMV4A4Hv/s/S3/7JNgKEu+mAEf78uk+NHQX2H4PYUrkxrLv8J+dU/5cumU
         Z2tJMzYR3xRSXlHRgAhrc7iVAAQDHtB0XfAAlvf4bsYzf5wCSh8qc6/yT3xPXvXg5ArF
         KsGzsOhmBNIl2UomGruTshlJvAg1tovqRdBBt+1k+py759eQ2QRz1x9OUG2i4yKoK4BF
         wERemsmT6+PB+RlOp59cFFd6CmQKYnT02SHUaNF+xhJM+Yvs3sgwKdRvr2dwzqqjBdHo
         XjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=whPg/5kzHhTEM5xmThuGTApSQtyHUbFCjaLS1sYmHXI=;
        b=F7gww7dyO6fUxq7goyl5d8xuGbGCHqkHL/K4PmDqfF1ZaL5W8qmkqBUCrVsfvj8cdB
         yQW8uUxIHKWS5QouKIBoVcLPWTxwFEm9EpQGAhldiR6HzeKA77y26A/y8KuKUdlLSO42
         8u2zGYIDjm3CMq0O7cbVLGd8tUkVq6BjIbyvrV/G0vUjAxFMoSxXbklHEAe2apM8SS+3
         U+wqM3U5A8CTcEPUhzxFjarLTMJaGz8VB6WAH4Dh26u1zVQlwQw50blRg03zKibMM3Vg
         z4OzRnKot1bHF5UH1kmlpHA3Rkr4GQI7jc2j3DqSA7vs8spUqr8CKA9Q1IIItHO0x9bJ
         t1GQ==
X-Gm-Message-State: AD7BkJLmuLWYsfazqm3SeQNJepVh0fG3UTTvfjq/+QzKfRRUZCa/AWCdBMIFaRfxg4ykGgZ3
X-Received: by 10.98.68.145 with SMTP id m17mr46537052pfi.65.1459207713110;
        Mon, 28 Mar 2016 16:28:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e99f:70e4:359b:ad6b])
        by smtp.gmail.com with ESMTPSA id p79sm38143927pfi.61.2016.03.28.16.28.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 28 Mar 2016 16:28:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.23.gd22361a.dirty
In-Reply-To: <1459207703-1635-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290089>

This replicates the previous test except that it executes from a sub
directory. Document the expected outcome, which currently fails
by having too many '../' prefixed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7407-submodule-foreach.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 808c6c6..5c57151 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -263,6 +263,25 @@ test_expect_success 'test "status --recursive"' '
 '
 
 cat > expect <<EOF
+ $nested1sha1 ../nested1 (heads/master)
+ $nested2sha1 ../nested1/nested2 (heads/master)
+ $nested3sha1 ../nested1/nested2/nested3 (heads/master)
+ $submodulesha1 ../nested1/nested2/nested3/submodule (heads/master)
+ $sub1sha1 ../sub1 ($sub1sha1_short)
+ $sub2sha1 ../sub2 ($sub2sha1_short)
+ $sub3sha1 ../sub3 (heads/master)
+EOF
+
+test_expect_failure 'test "status --recursive" from sub directory' '
+	(
+		cd clone3 &&
+		mkdir tmp && cd tmp &&
+		git submodule status --recursive > ../../actual
+	) &&
+	test_cmp expect actual
+'
+
+cat > expect <<EOF
  $nested1sha1 nested1 (heads/master)
 +$nested2sha1 nested1/nested2 (file2~1)
  $nested3sha1 nested1/nested2/nested3 (heads/master)
-- 
2.8.0.rc4.23.gd22361a.dirty
