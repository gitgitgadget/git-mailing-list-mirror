Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780AFECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 08:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiIAIFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIAIFb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 04:05:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6407B40E22
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 01:05:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c2so16387501plo.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QUhg2aZrHhPdc2pFn+oaWCkktjzpMnZ4lWP3Kb91zfg=;
        b=LCrk5zfwPgomcB/ikwDNtkqvrXwMjuZrhIgvxQRwTxtClM5APJQIZVGCsq4jU538lh
         1zTVvfE+AMriWgj5OVc4TC3vv3wb8WZUZA1ncfaV4cIZcdo+fWyAv1udrnCQA4nrGly+
         /34E7k7bb0bRuKLHJp89RMCF9J/cph20qWTGFc5lsHqzGj4GYWCKJKXNcbsKy4qn+sOV
         8HvMYY2vsnKR5zgWZMLf2Ch8SER0Qwd7lncz20wQt93lsOax6yjwVhB1rmDIRDxEwsSj
         xG/V8IsmAqi7dTYd5UTf6DcB68I7iXHgp13ucM13/YnR/gm8p53byp9ZS/1nusMpUCeO
         ssRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QUhg2aZrHhPdc2pFn+oaWCkktjzpMnZ4lWP3Kb91zfg=;
        b=70rbN0/kpNiW1UL+iBxDrds5/9ORcgZTyRzEXeX1Yujzwaa8KUliJ85CXEt6tYqOTd
         bIXKrsZm9iFDDERlPi+KWz2ja98NkLU5aHK4LHTiP3Y5mDnrW0ow1u0orF4KMAmO4K6g
         dg5ZnCeEz2Gx6M5XEqB163yDYKOm8Cyj8Ym2CMsgCTOhztNPF/iV6c0K1Z1wmsH4qyiZ
         rA/nvF2lXgMcZ3JjcWB27jYVVeygiCcIqRMU0EzJBqyU3/49zWS8ZZXvHBgAxgJ8Zpi3
         AFO4vUlT3MwUaJlfJ1v6d1epI31tDYgSPSYMtGdruuK1+kVyE2I7fV2JcTfsKtwxoYhz
         VsmA==
X-Gm-Message-State: ACgBeo1hFBlloZWCg4amDVd2Rzjcu41mCXHn5+E/H6WpZ5fl7uLBWf4F
        STgcLl8uizTzu5n3K4V26qQ=
X-Google-Smtp-Source: AA6agR4vTrLWiTMmaNBCCWzfv5Wk5OmD/poctTueNMjcXaJiNuAsLK/pSGcdjSp0ig60lsFUz2X0kQ==
X-Received: by 2002:a17:902:f641:b0:172:e2f8:7efb with SMTP id m1-20020a170902f64100b00172e2f87efbmr28688328plg.140.1662019516667;
        Thu, 01 Sep 2022 01:05:16 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b00536f0370db8sm12314397pfv.212.2022.09.01.01.05.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 01:05:15 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, mjcheetham@outlook.com,
        newren@gmail.com, steadmon@google.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH 5/7] bundle-uri: parse bundle list in config format
Date:   Thu,  1 Sep 2022 16:05:09 +0800
Message-Id: <20220901080509.35003-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.232.g7580e1f09af
In-Reply-To: <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
References: <1d1bd9c710327b4d705cfede017771da7fb6ec52.1661181174.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> diff --git a/bundle-uri.h b/bundle-uri.h
> index 41a1510a4ac..294ac804140 100644
> --- a/bundle-uri.h
> +++ b/bundle-uri.h
> @@ -71,6 +71,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
>  struct FILE;
>  void print_bundle_list(FILE *fp, struct bundle_list *list);
>
> +/**
> + * A bundle URI may point to a bundle list where the key=value
> + * pairs are provided in config file format. This method is
> + * exposed publicly for testing purposes.
> + */
> +
> +int parse_bundle_list_in_config_format(const char *uri,
> +				       const char *filename,
> +				       struct bundle_list *list);
> +

Although the comment clarifies the purpose of why to introduce
"parse_bundle_list_in_config_format", but I think this API is useful if finally
config format is supported. So far, we have a API names "bundle_uri_parse_line"
which is used to parsing key-value pairs and package into bundle list, I think
maybe we should rename the API name from "parse_bundle_list_in_config_format" to
"bundle_uri_parse_config_format", maybe better in my opinion for more consistent
naming. I think it doesnt break anything, feel free to accept or remain.

Thanks.
