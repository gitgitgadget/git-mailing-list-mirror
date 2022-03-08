Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27309C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbiCHWb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbiCHWb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:31:27 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5E59A42
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:30:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id eq14so632218qvb.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xLIu6cyObcJZe/w0+F0u4VnaNi8rNegrOPjnGYZdVEs=;
        b=tWKBuIzI2wkR3xwOjFVt4GmATu5220p4mDelUheEP4DoM0mh8VDZVymPsgoLNmidPa
         v8Um3Cy3+S4UeIV6LPn/Q+6Pn56LeXom/0PgCzI3brNXLBmv48Gt1m411kKc8ZvPEILW
         rS5mwlGZqjWVJQG0MHnYL4JFFY4n2nk+0XQ6LV1xG1JJu1PWAnz1jB6jjayvZoPsVwB8
         ceC+n4T8zKhPCrxaWef7OrPhqYUB3llovLC16jbqJnjgBbgEQodyMsy70bvqYwK8+EiU
         pfdU0HoVs2pX7YbHFoFw+vAiMUiE07U7VY97PnCljCNF/I9Si4Mk2UtNjsvhMCv0DUcK
         g5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xLIu6cyObcJZe/w0+F0u4VnaNi8rNegrOPjnGYZdVEs=;
        b=0lwj6iVyae8EPds3ibYTf3jYzvf8J+UwuxprZG7r08CIZh5hJShyvAF4vod2ZvXpG9
         58uVtni8EWUUeXSsF7P/LeOVfxKEOr1J0ev3Q5ZDVY48smiZqvZujMuinfwxZrbVCB2r
         XAd8KLo9xftftT8kGyEjax1d+nkx1RYhNbUHbOjzuF1+ScZjO1HCZlenVtpyGJQil4pj
         miZ1gQwByhe6d73GXxYf1NEAYbIb+Gl8yzFUaILA878vMMHkzAmFVRoWGKmz1TC79wsP
         zW9rJHOahO4UM5fMvJsqbTyN2B6Q7LCR8HN9RrcpGNWG55oiq3lYukd3+iyyrOZ4LEqq
         Rdhw==
X-Gm-Message-State: AOAM5311rcf8QT7kkWOK9zzzYfJwlPnaQBM274PpPkd88A6w6yHk/nf4
        BWOcdkR3YLBBEZSr8y41d7lxMZzo67DiNU+E
X-Google-Smtp-Source: ABdhPJyE0m1sSS5gmgqMyqcHhSAPdRbQ3p5+KsjS1PkNOpTXnZktYaGRT+FUI1yGKZP6rGYXicPWiQ==
X-Received: by 2002:a05:6214:212f:b0:435:1b10:c858 with SMTP id r15-20020a056214212f00b004351b10c858mr14520949qvc.86.1646778629742;
        Tue, 08 Mar 2022 14:30:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v13-20020ac8578d000000b002de94b94741sm180060qta.22.2022.03.08.14.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:30:29 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:30:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] cat-file: skip expanding default format
Message-ID: <YifZBEAEqUvFwiEV@nand.local>
References: <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1221.v3.git.git.1646777327043.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 08, 2022 at 10:08:46PM +0000, John Cai via GitGitGadget wrote:
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950ec..e2edba70b41 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -351,6 +351,13 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  	}
>  }
>
> +static int print_default_format(char *buf, int len, struct expand_data *data)
> +{
> +	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
> +			 type_name(data->type),
> +			 (uintmax_t)*data->info.sizep);
> +}

Two small nits here. It looks like the indentation on the second and
third lines is off a little bit, since we'd typically expect those to be
indented to the same margin as the first argument to xsnprintf().

The other is that you're reading data->info.sizep by dereferencing it,
but we know that it points to data->size. So I think there it makes
sense to just read the value directly out of data->size, though note
that you'll still need the cast to uintmax_t since you're formatting it
with PRIuMAX.

> +
>  /*
>   * If "pack" is non-NULL, then "offset" is the byte offset within the pack from
>   * which the object may be accessed (though note that we may also rely on
> @@ -381,10 +388,16 @@ static void batch_object_write(const char *obj_name,
>  		}
>  	}
>
> -	strbuf_reset(scratch);
> -	strbuf_expand(scratch, opt->format, expand_format, data);
> -	strbuf_addch(scratch, '\n');
> -	batch_write(opt, scratch->buf, scratch->len);
> +	if (!opt->format) {
> +		char buf[1024];
> +		int len = print_default_format(buf, 1024, data);
> +		batch_write(opt, buf, len);

Just curious (and apologies if this was discussed earlier and I missed
it), but: is there a reason that we have to use a scratch buffer here
that is separate from the strbuf we already have allocated?

That would avoid a large-ish stack variable, but it means that the two
paths are a little more similar, and can share the batch_write call
outside of the if/else statement.

The rest of the changes in this file all look good to me.

> diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
> new file mode 100755
> index 00000000000..e463623f5a3
> --- /dev/null
> +++ b/t/perf/p1006-cat-file.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +test_description='Basic sort performance tests'

Is this description a hold-over from p0071? If so, it may be worth
updating here.

> +test_expect_success 'setup' '
> +	git rev-list --all >rla
> +'
> +
> +test_perf 'cat-file --batch-check' '
> +	git cat-file --batch-check <rla
> +'

We could probably get away with dropping the setup test and using
`--batch-all-objects` here. Note that right now you're only printing
commit objects, so there would be a slight behavior change from the way
the patch is currently written, but it should demonstrate the same
performance improvement.

Thanks,
Taylor
