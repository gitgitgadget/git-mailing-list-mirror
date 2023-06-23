Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9660DEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjFWUg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjFWUgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 16:36:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5A02738
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:35:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc7267224adso2856141276.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687552546; x=1690144546;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vW7Xt8F/0k7DC+5uQVfTuk3zLfVjikQuUQqOJyDYbLA=;
        b=dbM0fzbnMgNzN9MPQgHSvy+G+L+Qz7fPY3qh9BQUnLFq19IqJLN35D3EeQJQapt0sR
         YuAxdwdnPPQO3+tcVEVWmSQvFLZ/o6KmECGNhkxdG+bYwrD45mUgsSSrEc5AjpVVb5+p
         7VvPrNFGo2WOtmjgSBm+I8wO/rMsc2V2iLpg9RlMpDawOG6TOSkn1OKRY7/4EHDozdz1
         njvBq2aanMCB9boE4ypLLYIB8ZArnMPC/aMaKoW3idwW7sdMzfU8OpusX3mhT70OKWuV
         uCcyzJ7famf6O5uFJnVMkd7ZsTpWysqrtDx5DWY1w2VJdv9HOOgxuV+IhaJihVMz/BcB
         v2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687552546; x=1690144546;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW7Xt8F/0k7DC+5uQVfTuk3zLfVjikQuUQqOJyDYbLA=;
        b=V9Zchg+Q+5Z8GYkaFqe51EaQPYrHZtMGB6ANCfpKlmxUTwEAzTFtL0h/W8vg3+bA+9
         jKOJIHTY6W7OePOe806mgknFq/Qis1evbTrMHNFT9WdlKJTlpjpNFqELeDjJdctRHraT
         TlgMthtnKjPLHL+K7z39/OOw+fs8I1g2K2yRREjZg4erMPxj/WOf7j62yUY7k26Atoq6
         eZ/hHD54HZyYKMdINN5Qru8ro0YHEkCwPuHMk9q+jThDDx0dQpOR7RLc0QWEworHfqao
         wcUrzIKbVosJNBAmf9I9t1nrWN7dhAG26bEIk4ozEo5HDWA4OkNXJ4Y0afIW+7xVS9g/
         2MJQ==
X-Gm-Message-State: AC+VfDxcWPf+FHbOCcK4JAy1/C7e0jD1pngf4mRZdMQOTXGbgjeNlqMk
        xgWc6fzrk7NauxDP7zqp57tPgl6HfX/+CH3wX2ye
X-Google-Smtp-Source: ACHHUZ5mqyg3nkhPDLvWEbP/zRjYuHj1U2HDc07w2RyAc/Xeuhg+oj73Tmd7MYwiYQhfIaWdJi60m1vRaeL7spUdVXtx
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7ab2:ee09:eab1:38cc])
 (user=jonathantanmy job=sendgmr) by 2002:a25:417:0:b0:c10:cb30:cd8b with SMTP
 id 23-20020a250417000000b00c10cb30cd8bmr41877ybe.4.1687552546700; Fri, 23 Jun
 2023 13:35:46 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:35:44 -0700
In-Reply-To: <1fb1708bbd967ed841fcb3d96ea0d1f6b880c60e.1687290233.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623203544.3255750-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 07/12] config.c: pass ctx with CLI config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -2465,16 +2488,10 @@ static int configset_add_value(struct config_reader *reader,
>  	l_item->e = e;
>  	l_item->value_index = e->value_list.nr - 1;
>  
> -	if (!reader->source)
> -		BUG("configset_add_value has no source");
>  	if (reader->source->name) {
> -		kvi_from_source(reader->source, current_config_scope(), kv_info);
> +		kvi_from_source(reader->source, kvi_p->scope, kv_info);
>  	} else {
> -		/* for values read from `git_config_from_parameters()` */
> -		kv_info->filename = NULL;
> -		kv_info->linenr = -1;
> -		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
> -		kv_info->scope = reader->parsing_scope;
> +		kvi_from_param(kv_info);
>  	}
>  	si->util = kv_info;
>  

Any reason to remove the "if (!reader->source)" guard? I don't think
this patch does anything to ensure that reader is present. We can
probably remove this once "reader" is removed.

The rest of the patch looks fine (and all patches prior look fine too.
 
