Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF8C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31594610F7
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhHMReO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhHMReN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 13:34:13 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2FC0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:33:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u10so17000691oiw.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=z3RnzKYM8P5Cq8aHhe6LBGdycIMjo4ER7JCKfP1N2CM=;
        b=um6tPQxjWr2ZpudqlGAztSQv+xgWbWyBsUjGz1IBPT8QdPWNGUzOQ5RZ83uzN8XfGA
         Oh+oE+NLNsCuRqUztidq5k6XOUJS8c6rTdT05BhuAJnC/NkKxS/opooOs7EI5UvRY7mp
         VaQiWKpc1sGRv3LdngncZIv7KTvl+8LYiLHa/8RZiDK1yiAYbmOUXjFL/LYTDaK0gzKG
         ofN0y0jwUHEThpR5UWIJn1jTmJc9hWh0l+5oOzCFcn424quafEgzdm0xArE9WyGWV3ux
         KXrV7O+fOMCfJuhugMPEHMz2tac14l87tjPr1HtxN6XMmR7jm3EfECQbSketcUjgY5U9
         5jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=z3RnzKYM8P5Cq8aHhe6LBGdycIMjo4ER7JCKfP1N2CM=;
        b=WkpAjvAonM0Kz1uocqKAh077KJr84ceifXFGaBCbJZrdSI0LctKeswaWmBkSkFyLZQ
         Ak7M/J0sr3jdCAXrnGrpV/X7UDTWjRrBpASPqqXamtWtb9lprpbF/Y6MDsam7coA+njU
         mHEYLBBPfyMyqTBIiB/pqvakAqWdUHkgKjzUDuHg8WyFZB/pqrqjhaFulPAxLWgGYm7Q
         /sK8dJZCkkTuGEGZQc4cGZarCm3aLgP8SLZ9H0w3Wbtfde/hJSfiq6s5wdjyo4ZxnCeu
         swDheD9Cf2aSzFshsBhIERnfntkpg05Ne5xu3XGxbt7xbEPL7fhfPTr1NUS1/UtYztQ6
         gOPg==
X-Gm-Message-State: AOAM530wa/6mNcDhbJ3BuQ0aNmKLZbuBHrchtR24Lusty0F2mSdJ0jLa
        r966vFXCHsyiBGY8VpgTdBk=
X-Google-Smtp-Source: ABdhPJzs8M2x/fqIpwRbxbo1pvP3gxci2DqWAnrvKNa1x1iJfDUfrjFIC2xKF9AsCUzpipNw5qHg8Q==
X-Received: by 2002:aca:a8c8:: with SMTP id r191mr1023347oie.144.1628876025572;
        Fri, 13 Aug 2021 10:33:45 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id m15sm451684oiw.18.2021.08.13.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 10:33:45 -0700 (PDT)
Date:   Fri, 13 Aug 2021 12:33:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>,
        Mahi Kolla <mahikolla@google.com>
Message-ID: <6116acf7a96f9_dde02087e@natae.notmuch>
In-Reply-To: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
 <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
Subject: RE: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahi Kolla via GitGitGadget wrote:
> From: Mahi Kolla <mahikolla@google.com>

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -986,6 +986,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct remote *remote;
>  	int err = 0, complete_refs_before_fetch = 1;
>  	int submodule_progress;
> +	int experimental_flag;
>  
>  	struct transport_ls_refs_options transport_ls_refs_options =
>  		TRANSPORT_LS_REFS_OPTIONS_INIT;
> @@ -1130,6 +1131,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  					   strbuf_detach(&sb, NULL));
>  		}
>  
> +		if(!git_config_get_bool("feature.experimental", &experimental_flag) &&

You are missing a space after the 'if'.

> +		    experimental_flag) {
> +		    string_list_append(&option_config, "submodule.recurse=true");
> +		}
> +

-- 
Felipe Contreras
