Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990A120248
	for <e@80x24.org>; Tue, 26 Feb 2019 23:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfBZXee (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 18:34:34 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36318 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfBZXee (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 18:34:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id c2so8056071qkb.3
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 15:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9UXN+BYlZC24Jn6tGeUJvZYS7nxCI7g7PNjuYp7KjU=;
        b=PKuPx+eADSkDfZrPL67cKH1YnwOzXOpTv5KhGXgdaveqW5PAMHCrTNr07819bIKH4h
         Ma0rLPXM04p6QVb0HmICPAGx9H+pDOlIccCUaOYto/9eojq/p9hINd1MBVhmCs1n7Nr/
         L9A230QSoY5QdItLx+92GrW2r1Wv3Oe/pTkVPHcZdPqLGl5HV4/vTzv7OE75iqGd2zU4
         d7fTDPkQ7w6oOqONmWhGQE/P4w2u8RPv0EOlQ36RXRnE+Ek7dktDoJc2p34sgqgG8W/6
         kFcl9d2xtJDt2Wou1PLCrg9Hg24ZXZRW+gGcY+ZrHTPwytUZg8RfXa6uqClIYZaUQh8o
         0zeA==
X-Gm-Message-State: AHQUAuab94t8+R97n2StwyvtML0dlxIw48VhDAYveDT048Ro+O+qsQiX
        g9vOb6yXKtX33u/xH22ZeHqvjBAWzntTbRriq86bCUNG
X-Google-Smtp-Source: AHgI3IaOykSrT10vKxblAIRrOha2HJNO0xin+6IAy7IHfpeHV4w19YPFrALKhZqrc6Gg4D0IA9lQE0XH8vS32lS9Wdo=
X-Received: by 2002:a37:c313:: with SMTP id a19mr57748qkj.220.1551224073637;
 Tue, 26 Feb 2019 15:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20190226215348.5119-1-jacob.e.keller@intel.com>
In-Reply-To: <20190226215348.5119-1-jacob.e.keller@intel.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Feb 2019 18:34:23 -0500
Message-ID: <CAPig+cR8n05zvzxFnbyGm08hEHTTTozzGY1DTE1SvDxsuPPTfw@mail.gmail.com>
Subject: Re: [PATCH] describe: bail of --contains --all is used with --exclude
 or --match
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 4:54 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
> describe: bail of --contains --all is used with --exclude or --match

s/of/if/

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/builtin/describe.c b/builtin/describe.c
> @@ -589,6 +589,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>                         for_each_string_list_item(item, &exclude_patterns)
>                                 argv_array_pushf(&args, "--exclude=refs/tags/%s", item->string);
> +               } else {
> +                       if (patterns.nr || exclude_patterns.nr)
> +                               die(_("--contains with --all does not support --match or --exclude"));
>                 }

Could be folded into an 'else if':

    } else if (patterns.nr || exclude_patterns.nr) {
        die(...);
    }

but not worth a re-roll.
