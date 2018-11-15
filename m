Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF271F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbeKPGDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 01:03:32 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:33421 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGDc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 01:03:32 -0500
Received: by mail-pl1-f202.google.com with SMTP id o23so3902482pll.0
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MUxbrow166DmrESAAkcVMkeyPctA//y3MQo+cgdcmms=;
        b=dzTRJmFi64TB2BVe3p10Z3vk7Fxz2hddKVj4zLJVLknvd3kbRshQMeIwqz74SNckPu
         u75lFA/xfdebwU5iIaUyup52KhkNhTOqa9zfMdTZjN4Gtcy/vErFW5zmva1QWqzR/Hnw
         YaMmYHCwENuq/eTOdDXvKWqezmC2V4wR3a+EFumBDyFEFym0Sdqpsar/nfTwmNvR+E2A
         23capEuf+DsnoAu4K1MAGgiUBvEls2XWu40MSDTwZ2WO6OwImJMB3uTvADeO+uddNc7G
         6nTjKhiu78LuKbZWrhD+Hmpnh7Uq8nVpY2EbyxNL4veXZf5G+fe6JPbBaYtTIv2L6XCa
         3SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MUxbrow166DmrESAAkcVMkeyPctA//y3MQo+cgdcmms=;
        b=PFjAxh2dZFD+oqdL5l5Tb8K8rJFNxVYIXGBfWjvK2y7hZv4kMSGgtVQOztoHy96CHy
         vlEHKL9CgaJF9dHMOJlVMsc0H8x2fDFouj4zbI+zpL5Uk3BcKiRuRZ3VQ13d+SmoBTpk
         AgPFCHHBQOLwXzmoyVL1onME96Qo08WnExazMfwSz1dASika4rNsqEHxn1LN+wggDnJt
         DrSNHQ7LGWF5W1Jz3Wx61qV6L2ePJWxmXGVegfxtEdQmpHQZF+wQzQIZVlX7/jBxF2j1
         gN+m/2EpWv7M1vowgc5sVyjya1G52pJZ/DND2m9Z3gc7z0rlxTMSaGdo6dArZiEZhv8s
         RNPA==
X-Gm-Message-State: AGRZ1gIkmMvXgZvnU6PVjns/k90BWbvabKm6W26PNYBuMA/N1hYNaqj2
        m+dsoqJxbJLZOgI5JTGXGrPYrny/Cy+LDDu1aXDf
X-Google-Smtp-Source: AJdET5fkQf5G1u/jN+O1F5FROJESx8Zg/3+e8hVWL3vgtUzisDbXqXK2UKmVFxRCh9eV5dT/DhxNIgf01djUeHtdS804
X-Received: by 2002:a17:902:76c2:: with SMTP id j2-v6mr759716plt.62.1542311659825;
 Thu, 15 Nov 2018 11:54:19 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:54:16 -0800
In-Reply-To: <20181114001306.138053-19-sbeller@google.com>
Message-Id: <20181115195416.21890-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-19-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 18/23] submodule: use submodule repos for object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +/*
> + * Initialize 'out' based on the provided submodule path.
> + *
> + * Unlike repo_submodule_init, this tolerates submodules not present
> + * in .gitmodules. This function exists only to preserve historical behavior,
> + *
> + * Returns 0 on success, -1 when the submodule is not present.
>   */
> -static void show_submodule_header(struct diff_options *o, const char *path,
> +static struct repository *open_submodule(const char *path)

The function documentation needs to be reworded - there's no "out", and
the return value is now a possibly NULL pointer to struct repository.

> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct repository *out = xmalloc(sizeof(*out));
> +
> +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> +		strbuf_release(&sb);
> +		free(out);
> +		return NULL;
> +	}
> +
> +	out->submodule_prefix = xstrdup(path);

I've discussed this submodule_prefix line before [1] - do we really need
this? Tests pass even if I remove this line.

Other than that, this patch looks good.

[1] https://public-inbox.org/git/20181019203750.110741-1-jonathantanmy@google.com/
