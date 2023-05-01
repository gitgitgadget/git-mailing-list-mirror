Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24884C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 11:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjEALJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 07:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEALJc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 07:09:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BB1BD
        for <git@vger.kernel.org>; Mon,  1 May 2023 04:09:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so2868888a12.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 04:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682939370; x=1685531370;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFDyDtoSX/0WveXTvCOblBd9qSy/4Gyd96bISneGDqU=;
        b=FNeWkPBjd0BWoL6Y0eUYfUK1C7aCQ228r1xvGY+oSbaIKmchRJ9IO5RLE9/v0mP2FV
         5S3//Ax4ZskGVcfT7LZwquxasIrJg/5HZnoy2kFv0EGIubnpAM1rDk1MdBfL2Li8mBFa
         kWhXGB4pK9MfCnjYinLW4htcd5phfWSjGspwMduDQs9Z/L394FwXfz9cxkRBZRnzT10V
         ufYK+8klHdaEDgPwADWR+JPuQckjUhq0f1XPzc2G61G3gnLVKKIwZ/ZXtmp/hzmR1C+h
         jdp+NflS7c+ljLsNh4IzZiZF8q/arVyS/07XiVOeMmeRi76qyfrTS//O4xe8Org0eJ48
         t5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682939370; x=1685531370;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFDyDtoSX/0WveXTvCOblBd9qSy/4Gyd96bISneGDqU=;
        b=LV121/NsItMCd+Tu2KAaAUGlVkBYlPEAl64N7G/nm+umu/F7V9gnK3P+/RXDxK3grj
         XR2P8r0COTzTt84ZlMEtaIFkjCHyafK6OaE6tTdAp51AI4bVYTALNZaCTye6zNVDYw3g
         I2IPwgmAP6uVX9piEYB33tbHeLSlwd2zbV7SSNguhglUazl5KfMBurv9mS9shznNAJug
         YrH64OO0mr2CaZgAatFwuPaKDKItIL8ZWPnoRwY1uCt4tiAxLsLJyEYuYwjj+I+3OXyt
         wrGvT4gWuPZW+FfQir2dMkY3ekGAaQhk6EgdiXbTnkLBTCYPxZKN99cJqgaEF4GCYbD8
         lH1A==
X-Gm-Message-State: AC+VfDzB811bddbCstPiqoj2Lp5HrJaFeMA+a+zc+jlLOTbGTp+rpVa2
        fcQMHAycyGyMYl5nbNcQGDA=
X-Google-Smtp-Source: ACHHUZ4REsks21K37WMmfHd3o5tmZQqXUbxl/zl1cclOadCUZYJ+b0cDt6USLVz2o9x2BVwO1EgeOA==
X-Received: by 2002:a05:6402:47:b0:506:fcd5:6159 with SMTP id f7-20020a056402004700b00506fcd56159mr5910412edu.21.1682939369596;
        Mon, 01 May 2023 04:09:29 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm12050867edo.31.2023.05.01.04.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 04:09:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ptRPM-0003HM-2W;
        Mon, 01 May 2023 13:09:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 02/14] config.c: use kvi for CLI config
Date:   Mon, 01 May 2023 13:06:33 +0200
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <a682612cff23449e682023303f17a8be1d73fc31.1682104398.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 12 (bookworm); Emacs 28.2; mu4e 1.9.0
In-reply-to: <a682612cff23449e682023303f17a8be1d73fc31.1682104398.git.gitgitgadget@gmail.com>
Message-ID: <230501.86cz3kjok7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 21 2023, Glen Choo via GitGitGadget wrote:

> @@ -682,17 +677,30 @@ static int config_parse_pair(const char *key, const char *value,
>  	if (git_config_parse_key(key, &canonical_name, NULL))
>  		return -1;
>  
> -	ret = (fn(canonical_name, value, data) < 0) ? -1 : 0;
> +	ret = (kvi_fn(fn, canonical_name, value, kvi, data) < 0) ? -1 : 0;
>  	free(canonical_name);
>  	return ret;
>  }

This is pre-existing, but I'd much prefer as we're doing more
formalization of this interface if this were just:

	ret = kvi_fn(...);
	...;
	return ret;

I.e. a look at the current code shows us that the API users of
git_config_parse_parameter() are already doing this coercion themselves,
i.e. they only care about "ret < 0".

So let's just hand them the actual return value, rather than doing the
needless coercion.

> @@ -2423,19 +2429,13 @@ static int configset_add_value(struct config_reader *reader,
>  	l_item->e = e;
>  	l_item->value_index = e->value_list.nr - 1;
>  
> -	if (!reader->source)
> -		BUG("configset_add_value has no source");
> -	if (reader->source->name) {
> +	if (reader->source && reader->source->name) {
>  		kv_info->filename = strintern(reader->source->name);
>  		kv_info->linenr = reader->source->linenr;
>  		kv_info->origin_type = reader->source->origin_type;
> -	} else {
> -		/* for values read from `git_config_from_parameters()` */
> -		kv_info->filename = NULL;
> -		kv_info->linenr = -1;
> -		kv_info->origin_type = CONFIG_ORIGIN_CMDLINE;
> -	}
> -	kv_info->scope = reader->parsing_scope;
> +		kv_info->scope = reader->parsing_scope;
> +	} else
> +		kvi_from_param(kv_info);

Missing a {} here.
