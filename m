Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D61C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKHNjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiKHNjV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:39:21 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1968E0
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:39:19 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id f5so38687935ejc.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Y4qmGGGm2l3U27RKl8apwEdSQYV+/ISrleZjg8iNA=;
        b=DdXWiS0TigcbD8qeAXcT6T5FvcbmHQ0W95eYwwMdRzs4WOcG7bcwOZD+k+pBXZJQBa
         ikBWfck+DPWpq9glxkfB9pyNoFHI0Q+9rFvCYcBpexG/Fs+gs9DG230tYh03lelC7xyI
         fWmL4uEFaMslYNTgeMysihjjBUrbyLZJxGnIidkWeqXpNuaSkmpIorjK1vvNUimrh/9V
         BCTbR1xyrO7xHU5VByOyxCc2KxWsU6RN/YGyS5yV+M6kPwqUE5JR9ugcPqBRCtY6Ec+p
         I8nLAPmkrJgqihf950PJPRcy78lmhhYG+BDh/aiYTCmQZM56+oYOuyn3Y07h7ed7SlxV
         lLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/Y4qmGGGm2l3U27RKl8apwEdSQYV+/ISrleZjg8iNA=;
        b=EnB9+jEIoOxv/38b8JhAbxkhH08ONWgJsV8TpGx6BsGR2DAIAHxnntDhHVoEgeT1uj
         BrPU7Ek/2S7jmhjbKkuGqZDGZSD/uoSi/CyvCteA/p1XfDbRThzpr0C5Yi4I9IHiNFcd
         teTjPsYQTpUQ1MUFXDIBmPWGNOkK2JbvP64r2TajL/nfZFkexb7xoKEbjoNd3ueT26TW
         2JBxN+lqKNu0No2UiJzGyQgZ9AIQM7F26c4gQXjudPkgVCTpkifzAXbicVgFezleGd2n
         RWzebjlF79aWrOnmcZUwVKuozrcwXMVe5mluSZ/mM+5pw8Z69AAaKVPHM0paoFnxwioT
         w7CQ==
X-Gm-Message-State: ACrzQf3FbdB58Ut6zrEMyXhgfbbsoAyC34Sbu+2pWnB6y6si3kp5nb6z
        SASMbd4DfKpuikOJwilmAa8=
X-Google-Smtp-Source: AMsMyM7MKbhFeTCRudm1ACAR42pr1/5/w4jvNq6IKxVZ572sybAyQPJk+RGXa8zZzlLTHMPSfZEkEA==
X-Received: by 2002:a17:907:6d9d:b0:7ad:f514:794e with SMTP id sb29-20020a1709076d9d00b007adf514794emr36475553ejc.602.1667914758313;
        Tue, 08 Nov 2022 05:39:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id eh9-20020a0564020f8900b004587f9d3ce8sm5525188edb.56.2022.11.08.05.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 05:39:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osOov-000YVD-09;
        Tue, 08 Nov 2022 14:39:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/6] refs: get rid of global list of hidden refs
Date:   Tue, 08 Nov 2022 14:36:04 +0100
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <34afe30d60e4dbc7e50a590541440c20c27507a6.1667901510.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <34afe30d60e4dbc7e50a590541440c20c27507a6.1667901510.git.ps@pks.im>
Message-ID: <221108.86leolsgze.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, Patrick Steinhardt wrote:

> @@ -2591,6 +2592,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		packet_flush(1);
>  	oid_array_clear(&shallow);
>  	oid_array_clear(&ref);
> +	string_list_clear(&hidden_refs, 1);

In the v4 re-roll you got rid of the "1" for some other string_lists,
but is this one still needed, i.e. does it use "util"? At a glance it
doesn't seem so. There's another "hidden_refs" (maybe just semi-related)
in 4/6 that doesn't use it when clearing.

> diff --git a/refs.c b/refs.c
> index 1491ae937e..2c7e88b190 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1414,9 +1414,8 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
>  					    refname, strict);
>  }
>  
> -static struct string_list *hide_refs;
> -
> -int parse_hide_refs_config(const char *var, const char *value, const char *section)
> +int parse_hide_refs_config(const char *var, const char *value, const char *section,
> +			   struct string_list *hide_refs)
>  {
>  	const char *key;
>  	if (!strcmp("transfer.hiderefs", var) ||
> @@ -1431,21 +1430,16 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
>  		len = strlen(ref);
>  		while (len && ref[len - 1] == '/')
>  			ref[--len] = '\0';
> -		if (!hide_refs) {
> -			CALLOC_ARRAY(hide_refs, 1);
> -			hide_refs->strdup_strings = 1;
> -		}
> -		string_list_append(hide_refs, ref);
> +		string_list_append_nodup(hide_refs, ref);
>  	}
>  	return 0;
>  }
>  

As before, this is all much nicer, thanks.
