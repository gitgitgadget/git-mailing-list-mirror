Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E12C19F2C
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiHBM6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiHBM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBC12616
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l4so17812377wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HqO61h7mveACM6Jd2OCinin3ipsmHcU1AFh3ugoxELY=;
        b=YcalFBNwVT8i/e4/WOg3XR05u4TPUjLMjCkYPmTNLO/CRpQrnL1UDF05LWV2+Fd3CI
         ZceAWZUP73vJ7/xL5z7uYoQR3SjJhHErsylTTotUhB3XTVchoSFI5VFe6yrU8s70nVQG
         9EMij9YTQCQMW+hlHNzKIfWlBpb8uoxS9KHm9y+2CFVT/KzUJ4FUumJZ3D7IxkGOcIP8
         llPRPrT2BOtPXfzZeCsjoHBx0J3B0rx6FTRUL+A1+gvqfc2B9xAZyGpe+JU96kqv1tN4
         rug90oGGVmyDhPdmbpObYzi6wZBN9aWtvQn9VrQfEtiWe9Bm2oGbqgOxPfOyS42Ggdlb
         IzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HqO61h7mveACM6Jd2OCinin3ipsmHcU1AFh3ugoxELY=;
        b=tGArhy49LYd3+EuYflNUXAUpq4KhuAyUjKSI9su44JqXfKf3JKu2afrQwX9yuBo8eB
         R79OBfkcwXt/x70srTrtKfsB2xLwUl0EWduk9WrvYNKJ8bFz1AJWdDdagF6MKGUJhmOT
         3bIWEZzN1i74h683FFLk+TCBwYe4TqFI6rIibukfNnt0gs9uGI5VudDskvDeWINemRNd
         OYlrMQXM8Q9zZqukrm3xyvFwtssWWI7I3tFS0MerdvYNZPEP+DnCEi3i5Y4bA7oYyinf
         3kTXBDtvEh8R8H+tB00uIPmxDd7y85GOYDOucFj4+YDu818NQ/aKRokwcGnc8+t0BdEo
         8lhw==
X-Gm-Message-State: ACgBeo1v9WNUZ4flbbQb7rKpPH9ApaMjey+Ig6lkAtUQXcAHs1BYmASl
        xXwVhqQwpsjUIbgDgGiFg56lGBNdoR1Xfg==
X-Google-Smtp-Source: AA6agR4srcDhTVcGha/D0fuEy5yN3Of4U7cCiqViFMVA4PFgDziT7k+x55blY8k0AbQCwk21MYOuow==
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id r18-20020a5d4e52000000b0021f15aa1174mr11387501wrt.106.1659445079623;
        Tue, 02 Aug 2022 05:57:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:57:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 01/10] help.c: refactor drop_prefix() to use a "switch" statement"
Date:   Tue,  2 Aug 2022 14:56:50 +0200
Message-Id: <patch-v7-01.10-2665148f45b-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the drop_prefix() function in in help.c to make it easier to
strip prefixes from categories that aren't "CAT_guide". There are no
functional changes here, by doing this we make a subsequent functional
change's diff smaller.

As before we first try to strip "git-" unconditionally, if that works
we'll return the stripped string. Then we'll strip "git" if the
command is in "CAT_guide".

This means that we'd in principle strip "git-gitfoo" down to "foo" if
it's in CAT_guide. That doesn't make much sense, and we don't have
such an entry in command-list.txt, but let's preserve that behavior
for now.

While we're at it remove a stray newline that had been added after the
"return name;" statement.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 41c41c2aa11..7e594d291b0 100644
--- a/help.c
+++ b/help.c
@@ -44,13 +44,19 @@ static struct category_description main_categories[] = {
 static const char *drop_prefix(const char *name, uint32_t category)
 {
 	const char *new_name;
+	const char *prefix = NULL;
 
 	if (skip_prefix(name, "git-", &new_name))
 		return new_name;
-	if (category == CAT_guide && skip_prefix(name, "git", &new_name))
+	switch (category) {
+	case CAT_guide:
+		prefix = "git";
+		break;
+	}
+	if (prefix && skip_prefix(name, prefix, &new_name))
 		return new_name;
-	return name;
 
+	return name;
 }
 
 static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
-- 
2.37.1.1232.gc0cde427aa7

