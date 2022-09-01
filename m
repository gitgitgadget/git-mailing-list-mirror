Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84EECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 02:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIAC4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 22:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIAC43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 22:56:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2074BBD76C
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 19:56:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jm11so15835464plb.13
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 19:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rYXSM92F/+sENorwxmoUlHx+udhdFlcdD9alULu7nTA=;
        b=Q7e/rUd9RPMp6qjXmOA4RWhFTkFuJ47x3pySjyUwVu3wmAOS3t82A/kIPlNaWFO14m
         aq49CfhfFvttPxKodNIoI2uUjdwGzzgW2QD2A5nZ56bjOY08QUhLNYrjWo/01IvtQabC
         mudcZNVvuEsHQLx9oRCN0bvfzS3hyCaD+1Th/F3jbJcYeW6nkLukoWvVtqxg1ErPGEvx
         knhYemT7mZFcfHK/HMlmR9DmunPJyV3nMJm3vuYGefKzwYP568cYoh2otNiPEhIKIj1N
         i+TLy2jhFHdmYWVjbt+sRZ7nQc6E/AtS0BaScOPUyY+PGSLStpD6VYHPdJlwHVCtqsPe
         T0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rYXSM92F/+sENorwxmoUlHx+udhdFlcdD9alULu7nTA=;
        b=Um3WmLGV2RwKM2cVM8kRdOlsXsL4LVneOwa4dH7M93NhT35RQXEZ3O26X+TSc6TS/r
         wtYsdZbtXXqpH/Cz4NOVPtjg2Ho/9b/ic3mSHCn1loIVAYIr8ZAk7ty0B0K+D4ywy1kJ
         ucXysdp+IGjDe0CTIrh4k5OCYbrToii0OcdFY7qxQy2C43VpqOcrMDn767XvYDNyeRpW
         VFE41ok7lBUOv0tpTCM6UxJIIwvpSsEh/SVssDSRmL+P5U4wMcPjaY5lKqixgJmAcu0J
         eT5HMK415k06U9OVY/tZ0rh+KobhICon5ZsEk9B/aSEsJ6ChfA5k0AsKlW7WKxq/FIkb
         ginQ==
X-Gm-Message-State: ACgBeo2Lg0AsKKm0yhJn9pWTeyxO/2tv+vDsKyvZODiLGfFYm+XIS6O7
        5SsdzDW8vLQrJvpz1YFOPWA=
X-Google-Smtp-Source: AA6agR5BWU/NIf9Vfw1og4dun46YpQt44cilCygc8a0X2HIcJzRrhMVNKB/TsAz/zKTv3RI8cnnYQg==
X-Received: by 2002:a17:902:ce11:b0:172:6f2c:a910 with SMTP id k17-20020a170902ce1100b001726f2ca910mr29256251plg.156.1662000988640;
        Wed, 31 Aug 2022 19:56:28 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id z15-20020a170902cccf00b0016c0eb202a5sm12433849ple.225.2022.08.31.19.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2022 19:56:28 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 4/7] bundle-uri: unit test "key=value" parsing
Date:   Thu,  1 Sep 2022 10:56:22 +0800
Message-Id: <20220901025622.19901-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.229.g42ab0356e5e.dirty
In-Reply-To: <7580e1f09aff2acdf7a7cb86bf8dc7e294cffd33.1661181174.git.gitgitgadget@gmail.com>
References: <7580e1f09aff2acdf7a7cb86bf8dc7e294cffd33.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes
> +void print_bundle_list(FILE *fp, struct bundle_list *list)
> +{
> +	const char *mode;
> +
> +	switch (list->mode) {
> +	case BUNDLE_MODE_ALL:
> +		mode = "all";
> +		break;
> +
> +	case BUNDLE_MODE_ANY:
> +		mode = "any";
> +		break;
> +
> +	case BUNDLE_MODE_NONE:
> +	default:
> +		mode = "<unknown>";
> +	}
> +
> +	printf("[bundle]\n");
> +	printf("\tversion = %d\n", list->version);
> +	printf("\tmode = %s\n", mode);
> +
> +	for_all_bundles_in_list(list, summarize_bundle, fp);
> +}

"print_bundle_list" use to print the git config formatting lines of
"bundle_list", it's supported to use a "FILE *fp" as it's output. The
"for_all_bundles_in_list" use it, but other places seems not, I'm not
sure, maybe we should change to:

  fprintf(fp, "[bundle]\n");
  fprintf(fp, "\tversion = %d\n", list->version);
  fprintf(fp, "\tmode = %s\n", mode);

here?

Thanks.
