Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D920C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJDNYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJDNYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:24:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6BE52FCD
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:24:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a10so8965402wrm.12
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMI4Tzs1eOf8I3AzqyCeCNihJIdohR8xEaGJ686i+OY=;
        b=O4sUpalhO1nAWct9Zq4iYh67xlv0WfT0X62i1UOyukjVMTEdnCIbkfZs3HSOtQzsX8
         xTuRNl8a2K55MtGj7JiSAODaRHL9i5SZkPabCgWmfQVG4Aydj0RzZQ4RLqMmsgF3v70P
         NAEbgEZz62iZhHi5rk5cWpmPMKqAopt1pY6Kbm9Tk8MK5F5Upb0IBfnfDi9Yk7ZN5A8r
         iPr48kRdzEhgweoAZzwrohXPiZgJNoeumuvbrgLnN481qpFcUXMZlQd3IFrAhdX/+YYe
         3eR7ygegVUwURmHNo81PQLE/6B4XjwvvYX6RthBiJBt41MU1hSX4Xbr/0CFNXY+mahQw
         4afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMI4Tzs1eOf8I3AzqyCeCNihJIdohR8xEaGJ686i+OY=;
        b=gctj4Imud59cUz7XvbYGrxiLRgXoMe4LrSwAqkZzwBpyj/5qwCRQEPmAxVt5xN7K6a
         I73sOUxzpnp5mKygzdMAmVn+nvVxaxg2oOsUEByox4Nlc1ZK0GWx2DAN50guBgkfuPGT
         HOZvwz0TopDnYy4s2YbJQ+z09uvhXVU1/j+KsjAPu1cy6FjOw1YX6rgYmJKxP518tX9E
         f8wVF3wBiILSf+i1UC4LogE76pkAxBMg0SDcpdT28YO3onrNIfuyN0xwJdGGysA941e+
         vPtCz3IjhvowEihE9Pu5fAGgyjKVg+43Q8QKg8eVlSRurta7zMQ0rmm3+p/DTSZxUdS3
         W/2w==
X-Gm-Message-State: ACrzQf2Vlob0CJ/AOIPf9Old3maWt5dHQsA1VBiGgrzo+im77UnWH7P2
        qwTW9fy3NHrT5pPBD9YesSRb0wEAswtvZg==
X-Google-Smtp-Source: AMsMyM6jRkoKrcgs+s2Sdi+/sgX8rWpWxYrWpyEJhWjxpJp06lJX0TuykR0LjnHddgwZbIAiMzEQoA==
X-Received: by 2002:a05:6000:781:b0:22a:f30a:721f with SMTP id bu1-20020a056000078100b0022af30a721fmr16768362wrb.676.1664889845300;
        Tue, 04 Oct 2022 06:24:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:24:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 11/34] doc txt & -h consistency: balance unbalanced "[" and "]"
Date:   Tue,  4 Oct 2022 15:23:25 +0200
Message-Id: <patch-v4-11.34-aa2f9325839-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a "-h" output syntax issue introduced when "--diagnose" was added
in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
2022-08-12): We need to close the "[" we opened. The
corresponding *.txt change did not have the same issue.

The "help -h" output then had one "]" too many, which is an issue
introduced in b40845293b5 (help: correct the usage string in -h and
documentation, 2021-09-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 builtin/help.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 23170113cc8..bb138161943 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -61,7 +61,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
-	   "              [--diagnose[=<mode>]"),
+	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
 
diff --git a/builtin/help.c b/builtin/help.c
index 6f2796f211e..53f2812dfb1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -88,7 +88,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]",
+	"git help [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]",
 	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>|<doc>]"),
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
-- 
2.38.0.rc2.935.g6b421ae1592

