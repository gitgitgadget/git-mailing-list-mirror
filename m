Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD43C433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347028AbiDRR0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiDRR0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:26:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98E33A1B
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p189so9106802wmp.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJgDStJvgiYf4gGWMDLPAgohW7yIHzEQcjvn+eDquoM=;
        b=lSZrAX5V0tW7BDABaVGuOI4Y9c2uS80MstifkR0D9K9L5bWu6F6ZV/u+4DIegW08uE
         Q5JT0JxRMKMtvdLEhHUJBWK2ERWwDgjD5GEIujHjUgqeAykwUppHvlFiclmqmvBdVejx
         8n+PoXaIs/ECS9BTADHA3jzpuJXB7DONUg/s/+7vb3tIpN9i/0pohQWgRa/YcTZhUaxi
         s2TLcKG3EIFPKInZ51qjWefhWb7joou3G62p/FQMCTRnT9ffAhgbIguuCwbBswh1MOPy
         sGum+2ch0QiIX4v95piFobvQtP5G9Qn/rwqB/oqt3gwaILQWelxs4m+xBIjJGgaefPx+
         RAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJgDStJvgiYf4gGWMDLPAgohW7yIHzEQcjvn+eDquoM=;
        b=BGWgDio23AeRMWqmJ6eqWpvaMaRGkOvFN/gEZn+mxCWQjVB5a+7mOw7ACrW4lJdrkc
         hW1YO38aACZ8zecnA454RK7BcIYNnPp8DbtNntVK0UKCm2LbpDxaXIRlxUnSpUFZO5tK
         hslaF6L4z+kKSAGYqdM6WU4wBvvCSEe/439KUbBB7zWoYjMeVxKIs/iebxZYXA5ioPcd
         whEXgqW1AirOXmSQkQmmud8BjyzO4ajIZxYHD7fwmWT1SxqhR4ZhknERpSqChi7Qqp8Y
         XnbeVucg/e/rwV12RgD2DXrgdcqG2XMwxj+7rrzf9OAG0IXX5mr89TYb0Qa6xwWN/QVE
         EsJg==
X-Gm-Message-State: AOAM532toZty6RQmv/JW+zuYCEwVKQEgwfPRDThvc7IVOCPX36dP92uI
        1XB7uDFjA3Otbvskgdxr3xDNOsxzCIlxEg==
X-Google-Smtp-Source: ABdhPJz+cDDhlx9ElrkWN/APGB4wOmbxlk8khes6M0JSJbipzOvLt34GoCWyYBXB64MdIDQEReQfwQ==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr16101259wmq.166.1650302644846;
        Mon, 18 Apr 2022 10:24:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 04/36] fetch-pack: move --keep=* option filling to a function
Date:   Mon, 18 Apr 2022 19:23:21 +0200
Message-Id: <RFC-patch-v2-04.36-0315bda0dac-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the populating of the --keep=* option argument to "index-pack" to
a static function, a subsequent commit will make use of it in another
function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index d0aa3a5c229..b1d90d1914f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -847,6 +847,16 @@ static void parse_gitmodules_oids(int fd, struct oidset *gitmodules_oids)
 	} while (1);
 }
 
+static void add_index_pack_keep_option(struct strvec *args)
+{
+	char hostname[HOST_NAME_MAX + 1];
+
+	if (xgethostname(hostname, sizeof(hostname)))
+		xsnprintf(hostname, sizeof(hostname), "localhost");
+	strvec_pushf(args, "--keep=fetch-pack %"PRIuMAX " on %s",
+		     (uintmax_t)getpid(), hostname);
+}
+
 /*
  * If packfile URIs were provided, pass a non-NULL pointer to index_pack_args.
  * The strings to pass as the --index-pack-arg arguments to http-fetch will be
@@ -916,14 +926,8 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "-v");
 		if (args->use_thin_pack)
 			strvec_push(&cmd.args, "--fix-thin");
-		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
-			char hostname[HOST_NAME_MAX + 1];
-			if (xgethostname(hostname, sizeof(hostname)))
-				xsnprintf(hostname, sizeof(hostname), "localhost");
-			strvec_pushf(&cmd.args,
-				     "--keep=fetch-pack %"PRIuMAX " on %s",
-				     (uintmax_t)getpid(), hostname);
-		}
+		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit))
+			add_index_pack_keep_option(&cmd.args);
 		if (!index_pack_args && args->check_self_contained_and_connected)
 			strvec_push(&cmd.args, "--check-self-contained-and-connected");
 		else
-- 
2.36.0.rc2.902.g60576bbc845

