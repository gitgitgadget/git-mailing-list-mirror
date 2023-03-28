Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BADC77B6D
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjC1Rjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjC1Rjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 13:39:45 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9AED520
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:44 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-177b78067ffso13521862fac.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 10:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680025183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+08Tpkctwr4bpbEB1IHkRHbkiumXQdJpIwPg/a4nIJA=;
        b=FFaA3JA4rHvN45YkV3jv80IXHpgNoRNmeJCi9hZ6HvVPuOeMm4LvlhCAuebCO0Rwpp
         WSgjcsR+J6x7yZR1+IDnFrR7EUgSUhCYqaJuatMAg0YU5AdOqwGAtCZMWYSY2LxdfxVz
         5KTp3TRr1tU+0VAu/l3u9Y2c7Vduwh7FgImzWccYd4X96kjiFClOX88CpBHY3ECYhoDl
         4EuvDyWajVMFheDXCRsRFWm144N+dNqa/H79G5Xqicvm5M3YcYC2smq/9rfkFPgkUZdW
         GzxFN+gSHj3rz6Bq73UBL2Y1JUyYe43W+Jjy/OVqhRlN9BJCfJlFsmVG1WdVQRcRQMaD
         1ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+08Tpkctwr4bpbEB1IHkRHbkiumXQdJpIwPg/a4nIJA=;
        b=FtdR/i4q/PeseadWppy5xIRuBHqQfB6AH8K5qXplO8k4Q9CQVqvXLJ5QmwDMT8IG92
         HJT2EHdQsTMeYMpVf1uhjUD96cc4icj16R1H6E6TVGEdLhiIPVRRcruJzFN5GgDnYseA
         LE6at6blki+rCGlg4KqRxrZWxkV43mXIhOPK5DmGQsqtxBHvZ20wg8Mon43vszWaONp8
         465ALztpgaIAm3CetNn3tkj7EEcbQ6IPll9UkYH30gQjXuJwOel2KXKpXNEir08Xy9BK
         6hSajUzXxFFJ86kncuSpzhAuTT9twAy3nR7r4YEJwLXFp8BR5qW+H4ueCKYlISDlW3XM
         6VaA==
X-Gm-Message-State: AAQBX9e9XUubBAln275vomxEWTyMeWpHDWkUfE2S29taPmYVgVB8FRx4
        HhEvnkETL/H8p0sKn8EouOXBvpdL4cs=
X-Google-Smtp-Source: AKy350afxCK9DBW9LvO+qT9bp3EBMJ8UwKfzQNpThJMIF0bOCHqM/UZ1u6cAoTCBjNXqmL72XKoItg==
X-Received: by 2002:a05:6870:8a22:b0:177:ab68:aa9a with SMTP id p34-20020a0568708a2200b00177ab68aa9amr11701341oaq.1.1680025183680;
        Tue, 28 Mar 2023 10:39:43 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id u6-20020a056870b0c600b00172289de1besm10532671oag.18.2023.03.28.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:39:43 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] test: hack for zsh
Date:   Tue, 28 Mar 2023 11:39:31 -0600
Message-Id: <20230328173932.3614601-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.39.2.13.g1fb56cf030
In-Reply-To: <20230328173932.3614601-1-felipe.contreras@gmail.com>
References: <20230328173932.3614601-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See: https://www.zsh.org/mla/workers/2023/msg00336.html

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4046-diff-unmerged.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index 4998a1ce27..ca31771070 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -21,7 +21,8 @@ test_expect_success setup '
 			do
 				fpath="$b$o$t" &&
 				case "$fpath" in ooo) continue ;; esac &&
-				paths="$paths$fpath " &&
+				: hack for zsh &&
+				{ paths="$paths$fpath "; } &&
 				p="	$fpath" &&
 				case "$b" in x) echo "$m1$p" ;; esac &&
 				case "$o" in x) echo "$m2$p" ;; esac &&
-- 
2.39.2.13.g1fb56cf030

