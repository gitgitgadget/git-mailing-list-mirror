Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774AC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2DD611EF
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 08:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhHUILW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 04:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUILW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 04:11:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AB6C061575
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:10:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bt14so25011688ejb.3
        for <git@vger.kernel.org>; Sat, 21 Aug 2021 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PsH9FQ5MT4QC/PgJZLXg1X8RV0EHWk2Iv7IOZ5sW5H4=;
        b=UcEJNKTB4cDaQRoZR7PKtmml4YayVPVlVLFg7AZ6Ac7EXw4xsQN8jrj1zIafxiVcT3
         CQMbsECOwT8gsSzh+1jVAFJfeST1f7EzhPATMaq6PaM5ZsBFIYKtd5+pQ+Ghccirbb0O
         wHMPXnjMyCZbHujjl99YFZDkjBIZR8zeF4btZywnEIb5PrD/2VxSCyGXUY7dMKPdsvb3
         2ROdwDTrcGg7V5WiAxVuSzrlVOAszqKrLAkfq7TWfEiEQO6Lo0Cb+BEDNzqX12MsgUIK
         FPptW3AuCBogBLTJ+gkbXRATELmUyS4EOkPRvXJUxEotjYD9SGx8zFbFp8qKhESGptnF
         irrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PsH9FQ5MT4QC/PgJZLXg1X8RV0EHWk2Iv7IOZ5sW5H4=;
        b=QqEFVhD2wvIqG2iAxnxaia9uTbhXj1xcT67Hjs6aP4MShgTtDIdN64z8OQT0Hoqt6i
         nNmJNtQxr4GWxJlKmyBmJW6gqR6lUFp0UbPEYjW3sbGa3K+IBZPwQluzPU5EMmhK7onl
         4QcKrZx0M5AtD6mB46HR6Ad/KGCPkzywWg7XrP9fnheza/BfkZltHavi+QjUyewtwoiy
         qzDxzkkTxLVGzT36DKiOTTWwK3O7ub2up6d3EUePLqor6n780NA6eNlhfC/2UmWSNeuv
         YcmjxERZHBo41Z56a8F7TVsXnJ8RBC2bxP7+wdwScVg11zjhVAjV6Pk9mI/vx/yPNby3
         auCQ==
X-Gm-Message-State: AOAM532dCmEKYTOVNrKWRsXAGIjcWtDyzYDND/Zn427QtwlscI2H48HD
        F5jUDPvytc8tYm5ttIeZv+M=
X-Google-Smtp-Source: ABdhPJypHIAEJRh/bxMP6KVjE1Eqt/PzHRvquu3rze1RqEMqNTampQQidh8jTSXbEqJmu+qLY/24AA==
X-Received: by 2002:a17:907:98b2:: with SMTP id ju18mr25744954ejc.15.1629533441512;
        Sat, 21 Aug 2021 01:10:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f8sm5052574edy.57.2021.08.21.01.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 01:10:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCH v1 1/3] packfile-uri: http and https as default value of
 `--uri-protocol`
Date:   Sat, 21 Aug 2021 10:08:33 +0200
References: <cover.1628845748.git.dyroneteng@gmail.com>
 <0754ea6472f2665a5fe77de080434d3734c67259.1628845748.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <0754ea6472f2665a5fe77de080434d3734c67259.1628845748.git.dyroneteng@gmail.com>
Message-ID: <87fsv3gqv3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 13 2021, Teng Long wrote:

> HTTP(S) is usually one of the most common protocols, using "http" and
> "https" as the default parameter values of `--uri-protocol`, which can
> simplify the use of packfile-uri feature on client side when run a
> git-clone or git-fetch.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/pack-objects.c | 18 +++++++++++++++---
>  fetch-pack.c           | 13 ++++++++-----
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index de00adbb9e..5f6db92a4c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3892,6 +3892,18 @@ static int option_parse_unpack_unreachable(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_parse_uri_protocol(const struct option *opt,
> +				      const char *arg, int unset)
> +{
> +	if (!arg) {
> +		string_list_append(&uri_protocols, "http");
> +		string_list_append(&uri_protocols, "https");
> +	} else {
> +		string_list_append(&uri_protocols, arg);
> +	}
> +	return 0;
> +}
> +
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  {
>  	int use_internal_rev_list = 0;
> @@ -3995,9 +4007,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			 N_("do not pack objects in promisor packfiles")),
>  		OPT_BOOL(0, "delta-islands", &use_delta_islands,
>  			 N_("respect islands during delta compression")),
> -		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
> -				N_("protocol"),
> -				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
> +		OPT_CALLBACK_F(0, "uri-protocol", NULL, N_("protocol"),
> +			       N_("exclude any configured uploadpack.blobpackfileuri with this protocol"),
> +			       PARSE_OPT_OPTARG, option_parse_uri_protocol),
>  		OPT_END(),
>  	};
>  
> diff --git a/fetch-pack.c b/fetch-pack.c
> index c135635e34..511a892d4c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1755,11 +1755,14 @@ static void fetch_pack_config(void)
>  	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
>  	git_config_get_bool("transfer.advertisesid", &advertise_sid);
>  	if (!uri_protocols.nr) {
> -		char *str;
> -
> -		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
> -			string_list_split(&uri_protocols, str, ',', -1);
> -			free(str);
> +		const char *value;
> +
> +		if (!git_config_get_value("fetch.uriprotocols", &value)) {
> +			if (!value || !strcmp(value, "")) {
> +				string_list_append(&uri_protocols, "http");
> +				string_list_append(&uri_protocols, "https");
> +			} else
> +				string_list_split(&uri_protocols, value, ',', -1);
>  		}
>  	}

Isn't this adding support for:

    [fetch]
    uriProtocols

I.e. the case where it's an existing key that we'll get a NULL from,
ditto the ="" case.

Partially this issue pre-dates your series, but I think code here is
rather unclear because we keep using the same comma-delimited
representation we want in the protocol for too long in fetch-pack.c et
al.

But also, if we're going to make http/https the default, wouldn't
parsing config/options it, and then interpreting the empty list as that
default, as opposed to injecting it? Or have I misunderstood the intent
here...?

