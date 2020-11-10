Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CDC56202
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102BF20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDO4fPbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgKJVWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbgKJVV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:58 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8270C0613D3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:57 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n11so142729ota.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzJCSLWW82V5OOHIX+VN205dxl4K03BLnTUqqJG+yrk=;
        b=gDO4fPbYJ1pGX6GVxcWnTqdPBY+jyTwqiDzzg2KVSlPA9LrL1Yc/hpNo8wp66fWIW1
         CeMygdHJlQbmyD00MKSQ9zCxajbft3smDCJ9Mlv9N6TdHmGhii3YX314mcnDVkY4t77O
         wldLcHOG+GOTzd2nBekI0MqdtLJ+cP8YjM6lu6C7yLqJcX/l4GuWzftX0pyJpgm6BFYu
         yffWYS7tLweR81v9VepbaX5//vkxKpisbhyw1Kqu2bUaUGVZri1ykLjGaJusSlrcbz+q
         ywmxb86UDtcmCv7+yMQsZpPZhc+GzdCIzw5dgbAOLhqQUYazMYbOR8TXV5W6MTzH8POp
         9bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzJCSLWW82V5OOHIX+VN205dxl4K03BLnTUqqJG+yrk=;
        b=RyQulWVJHZf3bEL1KSLKkeJ2FRssNZcWPAy56VTOcGhmm98ndRx/ifOI36Afzy6Ujz
         KLBm6Bx36CeRWvIGuyje1o6GRF5KmE/l2recbKhSfLLiU5zXJ1hvPsXJYurxI7oZdg6B
         yyz+5AqmbfJ6gEFmV3hNhxTst2m00CjBHuglzlfW6270xaKlVHHO62ZMl65lbQToRytC
         ZT893/cWEbNerBcypBnqpRgd9jdglJQb24RXFjKU44zY1YSVDIBchjzEKlTUkx/yo6kb
         iLIUA/fHtf/9CWwg+kCSgy2ZecxQL1BiBLVPUTZWO/a8ScbezDUaZloAbLdKWV7kvJPc
         ZmVA==
X-Gm-Message-State: AOAM531qrDTMLXLPPFiUDKbPZLW17VQ9+8V1BB01MmRDs7guPacx+eID
        E0nrYvgGtknjw94NVpqNh189kDayd1++eA==
X-Google-Smtp-Source: ABdhPJy7F5cxsNSC2zFjFurhYIxZC0j2XQmIH8dA3IwVcne9nUcWnhm1XWeoyES7FqsQ3JhOcoFd2A==
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr16025014otb.300.1605043317011;
        Tue, 10 Nov 2020 13:21:57 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 66sm26257otp.33.2020.11.10.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:56 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/26] completion: bash: get rid of any non-append code
Date:   Tue, 10 Nov 2020 15:21:19 -0600
Message-Id: <20201110212136.870769-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7ecec00624..15d7490cfd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -300,7 +300,7 @@ __gitcomp_direct ()
 	COMPREPLY+=($1)
 }
 
-__gitcompappend ()
+__gitcompadd ()
 {
 	local x i=${#COMPREPLY[@]}
 	for x in $1; do
@@ -310,12 +310,6 @@ __gitcompappend ()
 	done
 }
 
-__gitcompadd ()
-{
-	COMPREPLY=()
-	__gitcompappend "$@"
-}
-
 # Generates completion reply, appending a space to possible completion words,
 # if necessary.
 # It accepts 1 to 4 arguments:
@@ -429,7 +423,7 @@ __gitcomp_builtin ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	__gitcompappend "$1" "${2-}" "${3-$cur}" "${4- }"
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Fills the COMPREPLY array with prefiltered paths without any additional
@@ -442,7 +436,7 @@ __gitcomp_file_direct ()
 {
 	local IFS=$'\n'
 
-	COMPREPLY=($1)
+	COMPREPLY+=($1)
 
 	# use a hack to enable file mode in bash < 4
 	compopt -o filenames +o nospace 2>/dev/null ||
-- 
2.29.2

