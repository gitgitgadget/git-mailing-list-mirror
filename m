Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51968C28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHUN7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiHUN6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:55 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69121818
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so9798847wri.13
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=aIBTj9MYFsAY2N/IG3ERGESFbx4oxG5dO/qioT6/u/I=;
        b=PBg09TaOk4tyv3OO2tmKLPB5183VClOoX8T2LpUHAILshC+zso9kb//cqGxmUDzdqZ
         0N1Pq11rxuBtf2mFQyiJ/MSWulSX3236NFe7IMHqn9bBJEl9ke0H9jPbCfuUTtOe3GuG
         YeGxaUyozD4fI1BJixiAoLsnfI+hHLMU1trNgreuluO0Gl2qrGAEvauSmM2s3Yi2GxB2
         vM78aCVLFZjeiZQFG0qJChmZOgkPL4OnLstRLNchWyPNf7M+kBaWN01+pUO+P939t6/k
         C3jcNnmi9jQKGQo/EIigBOB0yKvfn0ZixcfEHlcFEvpBtKmLWswRCX0Z/VZh4/OaI6r+
         EBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=aIBTj9MYFsAY2N/IG3ERGESFbx4oxG5dO/qioT6/u/I=;
        b=G/8euXBgUI44wxqMzo8XyP19YmykyZusEha7co96tmwmjBFbjd2BnJKzJk+iQlEAev
         y8/pyOIE8PQ+NGo1Emf2u2CJrFxKBn31KwH2RP5KEeuNiCHiMUhYArOhB9tONDo33oYx
         JVx6B2cI9WbjGAeOY5kpytBfoBqCVwff4L2T74bBXttySojziv086ZtyeMVgIzxoQPUz
         +Y3EESisaQAmAkVXtkn4ZpLgXdUQch1g4S6mJgL1nzHqC0HB2En0k2+iP1KQVw7Q4/6f
         QnIX6SomKNQ4IWtbIYIdH68E06EVCe6jc4rgClscOW4XTXj4jZ4YrdkYFg7CV9gfpbIN
         mXhw==
X-Gm-Message-State: ACgBeo0CB7Wv9ptAcevGuG0i+XI6j6Lz4Gb2vLbL76z7ZCjrUGCrNnw4
        Z/OsL/JCJLZpucSGSXOnB16Ort92Pood54wu
X-Google-Smtp-Source: AA6agR7VpBLcNt8jJTluAxCh72/vugdJuX+SFvd7xDYnuphR8gT9VwinhlR59eoiPQzggMP5lQE0KQ==
X-Received: by 2002:a05:6000:178c:b0:223:141:8a14 with SMTP id e12-20020a056000178c00b0022301418a14mr8724124wrg.629.1661090320938;
        Sun, 21 Aug 2022 06:58:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 15/32] submodule--helper: add "const" to copy of "update_data"
Date:   Sun, 21 Aug 2022 15:57:24 +0200
Message-Id: <patch-v3-15.32-ab283479b92-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a "const" to the copy of "struct update_data" that's tracked by
the "struct submodule_update_clone", as it neither owns nor modifies
it.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d243c3ddfd3..829a57ce8a9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1780,7 +1780,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1865,7 +1865,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.2.1279.g64dec4e13cf

