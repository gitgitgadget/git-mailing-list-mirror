Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3B9C77B60
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDAV3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 17:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjDAV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 17:29:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52993CA
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 14:29:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so15881846wms.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680384541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on65t8rikSv4AVit8DthFs5uOleH1rA8ap6xeK+pqxY=;
        b=N6+J8SQY6JM2i958nLqwn5BGIUgrT00sUaokrBpeOQ2WeYHVGV2oPvFSSxpLeGKMr4
         0iwmwDR99xCZBpL4scD288ix+XzU3Y3AWcKJDX5IbrBcdt5p8jOQiZHeJtB90qoD8K/D
         isDg/ONO3eBVzTHvjve7DFhK1KqToQLO9VsuCXrL4inZ9WRI2LyimvmjQVIi3uA+WV75
         R8RRl67TDImI7tlm4bOOwo7J2hLenMVhSOsTgzOMqOirIY+LlM+DHpHdobqDNz9Ah9g3
         TGYQw2V5MgAp790H/9itaKq0K324LXmKQ1IMX8oszkDPBQwe9KaECsV1Fbk1459kwify
         /ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680384541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=on65t8rikSv4AVit8DthFs5uOleH1rA8ap6xeK+pqxY=;
        b=l9EPSXgxzXXmgrXrbftshQmCL4muPN5hBIK/ZjIvo5jkxflRTUSMG7kExoTkRwavC3
         fSCz9kKEPuFQJ4Et/rmDP8YmJGaoQKE5FJRt5BE5V8dNT9Kg48UeV95CHt+lwBGbOc8v
         5AFcxVC/xPR/g53gtQnv4AH/+/mAiWZS67fkKTOo7ZeCDoRsVSZp4WAsihHvWhFqVbEa
         pfPngQ8e24WmJBIwxDdGw07DyFpYaxlNyLVaBi/MYj75jkY+rMqyHGRwLOZwfacQyv0n
         zlsIX9tjE6T98LzyxYvUQ+z7SiwogQemMl4k3HltoAkzaDF0k8Kiv7PHpQoyX45PsAa4
         eqTw==
X-Gm-Message-State: AAQBX9cfSplX+5WyGbQu4bab6icGtcMlUY6CJHblKoY7LOhqrsrdl08J
        ovaGykodPfbVEwz6aOP1BeBa4sOSDUAu0Alz
X-Google-Smtp-Source: AKy350buy6HE1SZCOyQCLLey56Kx075ANPpDSaRKO5Yd4GUgveky9crw9eGuUynIgiWGOx7zuwyutg==
X-Received: by 2002:a7b:c009:0:b0:3ef:62c6:9930 with SMTP id c9-20020a7bc009000000b003ef62c69930mr21127398wmb.3.1680384541437;
        Sat, 01 Apr 2023 14:29:01 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm5738364wrw.90.2023.04.01.14.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 14:29:01 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin Stenberg <martin@gnutiken.se>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 1/6] t0300: don't create unused file
Date:   Sat,  1 Apr 2023 23:28:53 +0200
Message-Id: <20230401212858.266508-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401212858.266508-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 'credential config with partial URLs' in t0300-credentials.sh
contaisn three "git credential fill" invocations.  For two of the
invocations, the test asserts presence or absence of string "yep" in the
standard output.  For the third test it checks for an error message in
standard error.

Don't redirect standard output of "git credential" to file "stdout" in
t0300-credentials.sh to avoid creating an unnecessary file when only
standard error is checked.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t0300-credentials.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index c66d91e82d..b8612ede95 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -808,7 +808,7 @@ test_expect_success 'credential config with partial URLs' '
 
 	git -c credential.$partial.helper=yep \
 		-c credential.with%0anewline.username=uh-oh \
-		credential fill <stdin >stdout 2>stderr &&
+		credential fill <stdin 2>stderr &&
 	test_i18ngrep "skipping credential lookup for key" stderr
 '
 
-- 
2.40.0

