Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00474C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52436145E
	for <git@archiver.kernel.org>; Fri,  7 May 2021 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhEGRLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhEGRLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 13:11:04 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B2C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 10:10:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so5685181pjb.2
        for <git@vger.kernel.org>; Fri, 07 May 2021 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y07rRZ1FIEXPcbAZBFrHJO6CVzO1qNg1EI1UBKGceQM=;
        b=EgJdUJ/Wp69ZMMlXMqTo8m4Ib6elikRuGL00oodcf4oHqT32RWVrHm5Cz5b9/2Bcym
         rNgTP0z2PqgXyhFh2ZQyQuphkV0yUSP6RnQI/h1RXKlthK/A6Q02N0WJgh1up9izJGIu
         PaJSkDhFcgH2WgtypTyNXMMobHgz1MB7kvwoFrraz6cXpoWZT8xHKZw2qVLr/gUOOSqq
         1Z7ZeucdiDRTauM7uAYFLSqBon6PmN/KRQAxZs8lNLzs+Bv974tHUGwknLq8xFXLVzbk
         xt7eR8E2GcYGK3Ydp+pZa/uVtSsObVcFijj6SRs4aEePTAABsLbQvre/C5seXoHMcXeF
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y07rRZ1FIEXPcbAZBFrHJO6CVzO1qNg1EI1UBKGceQM=;
        b=OkMABwtVow4a8siGEu+xkCVYudnkieqqralquieY68lbOIsESXx09tlsEoQ3AuMggH
         VvJM75RuET+rcMtZc0xOjq82hwHfKgruEK+PBlOI9pFHnqcTExkcFRWEsWsCusbDwAjT
         US8XKmrkWxfFTjJIHIyQ7TMVJwdwO0g/vE33MkwLkuTH9c2iojVZZjQ+McfEfZjAS/59
         7HyD2ClQe104V4AeEq1aYiT90H4FXSvwXEfnjNMJfitvhuSaI7AByoyJGnbl9wStKO7r
         zcDoQg4bhEBisrJGDWEE8y/P+a5fjaEK5+Ccx+dunynEZFKxbQPEvXsgICKieGPr1+Mb
         AmVQ==
X-Gm-Message-State: AOAM532552mZGhsv4zx/UVOsVVRi0eovhbB50cGW6lZD2Vdz/kNOf6n0
        /glJV6P8VxJduixcmqbvxR83N54nlk5CrQ==
X-Google-Smtp-Source: ABdhPJwvuhoy0OOBeQAj0MwqoSlwLL+la5PLRgFAPXUeRYAgLiMkEsdGJWOIUUt8oQC6GvJie3VFqw==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr24624338pjb.202.1620407401648;
        Fri, 07 May 2021 10:10:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d0e9:239c:84a2:f593])
        by smtp.gmail.com with ESMTPSA id b65sm5073730pga.83.2021.05.07.10.10.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:10:00 -0700 (PDT)
Date:   Fri, 7 May 2021 10:09:54 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
Message-ID: <YJV0YibkFYUe2UcA@google.com>
References: <20210507002908.1495061-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507002908.1495061-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 05:29:08PM -0700, Emily Shaffer wrote:
> 
> It can be useful to tell who invoked Git - was it invoked manually by a
> user via CLI or script? By an IDE? Knowing where the Git invocation came
> from can help with debugging to isolate where the problem came from.
> 
> Unfortunately, there's no cross-platform reliable way to gather the name
> of the parent process. If procfs is present, we can use that; otherwise
> we will need to discover the name another way. However, the process ID
> should be sufficient regardless of platform.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> We briefly discussed hiding this behind a config, internally. However, I
> wanted to include the parent name alongside the cmd_start event, which
> happens very early (maybe before config gathering?).
> 
> Maybe it's better to log the parent_name as its own event, since it
> shouldn't change over the lifetime of the process?
> 
> procfs is very non-portable, though - I think this won't even work on
> MacOS. So I'm curious if anybody has better suggestions for how to do
> this.

I wrote this and then I wrote nonportable tests anyways, bah. Working on
a fix now - the tests break for MacOS and Windows.

The parent_name needs to be set conditionally below.

> diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
> index 1529155cf0..3a2a8a5b5f 100755
> --- a/t/t0212-trace2-event.sh
> +++ b/t/t0212-trace2-event.sh
> @@ -61,6 +61,7 @@ test_expect_success JSON_PP 'event stream, error event' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  }
>  	|};
> @@ -115,6 +116,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  },
>  	|  "_SID0_/_SID1_":{
> @@ -143,6 +145,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2/trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"test-tool",
>  	|    "version":"$V"
>  	|  },
>  	|  "_SID0_/_SID1_/_SID2_":{
> @@ -155,6 +158,7 @@ test_expect_success JSON_PP 'event stream, return code 0' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2/trace2/trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"$TEST_DIRECTORY/../t/helper//test-tool",
>  	|    "version":"$V"
>  	|  }
>  	|};
> @@ -192,6 +196,7 @@ test_expect_success JSON_PP 'event stream, list config' '
>  	|        "value":"hello world"
>  	|      }
>  	|    ],
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  }
>  	|};
> @@ -229,6 +234,7 @@ test_expect_success JSON_PP 'event stream, list env vars' '
>  	|        "value":"hello world"
>  	|      }
>  	|    ],
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  }
>  	|};
> @@ -263,6 +269,7 @@ test_expect_success JSON_PP 'basic trace2_data' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  }
>  	|};
> @@ -295,6 +302,7 @@ test_expect_success JSON_PP 'using global config, event stream, error event' '
>  	|    "exit_code":0,
>  	|    "hierarchy":"trace2",
>  	|    "name":"trace2",
> +	|    "parent_name":"/bin/sh",
>  	|    "version":"$V"
>  	|  }
>  	|};


 - Emily
