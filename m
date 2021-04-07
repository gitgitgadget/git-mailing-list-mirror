Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13096C43462
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB65661154
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 08:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349667AbhDGIrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349623AbhDGIqo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 04:46:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00673C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 01:46:05 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n2so20071538ejy.7
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DMbygNF5G6tVhETg6D011+Pb+7YULcU+DnSgHjzg2XE=;
        b=Q4vxAzKWmyL9CNpjYMq84MvRu464976mshaxP/3IByRXD+vdQOnJXVm1Mbl3eoyQTo
         78Yc9lc4jKA5areluCCZoxcmg15eMgGwY0ViWW/PycYzPVZX+/EhuVYxVeoCSNgFqulf
         e103z5IYikNtoxyS+3cPKW9wsy+QYEussF5hJIuNW9lklMWGLOBY8E2PYucUg3jNqYxJ
         zn1mgPP9GrRx70+Y0Sb+4jMynDBZGEbd1Nxp6+NL/Oc1fVAeaMi7Z+MdFFOj7eX9Q1rc
         y2SrRDkT7qBqYeQt6Cuu60ICoAD5G8gK/cXbWrFDmim+xHYC7TG9OHpgeAANBU1+YEVV
         89SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DMbygNF5G6tVhETg6D011+Pb+7YULcU+DnSgHjzg2XE=;
        b=XamJd1w9yees3yS+f2IY0I9GsO0XB/TiGlygPrLyfFX35Uphx2t3QMauW8q2CBJfxC
         4Jo6E0CiCe9mEXaqbYw2B299A17WleIPFY6Y3AVDoG+GvPSpyS0eZwn0+v2Ne/L9R/Kk
         Ea/TJyXQxnREHfvCwHN6zDrKRVRtH0o9wt3fjgytxOrYDUPwgwiQ/u7rPke1I8MSPczH
         qwaWX9rAcCJ231u+I2Amx/goM7DztrRW84sEgVbsYuNfgZMSvrRzalREpoz3vMVVlTxc
         dGs+iStgn1nlsOu7HI1JqzIptc/ubCwvtKHwRH2CaikIl6N1WvNo+LmXnRM9ovwxwubE
         5BAQ==
X-Gm-Message-State: AOAM531umvYVAMlDgTV5YoengPN+cLSEbyalnVerEUnl371dc3NHkxpf
        Ti1OifKFS0LBD/7kPd3m1Yw=
X-Google-Smtp-Source: ABdhPJxAGQb1xzLVNWzrbRalojitUGxOkwtv1D3aB8NenYM7gQRUB9BJXnxvWg50VTMHr6NokCXq7w==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr2499452ejj.494.1617785164667;
        Wed, 07 Apr 2021 01:46:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q16sm15413840edv.61.2021.04.07.01.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:46:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Apr 2021 10:46:03 +0200
Message-ID: <87r1jmjxdg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 05 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a new method, refspec_item_format(), that takes a 'struct
> refspec_item' pointer as input and returns a string for how that refspec
> item should be written to Git's config or a subcommand, such as 'git
> fetch'.
>
> There are several subtleties regarding special-case refspecs that can
> occur and are represented in t5511-refspec.sh. These cases will be
> explored in new tests in the following change. It requires adding a new
> test helper in order to test this format directly, so that is saved for
> a separate change to keep this one focused on the logic of the format
> method.
>
> A future change will consume this method when translating refspecs in
> the 'prefetch' task of the 'git maintenance' builtin.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  refspec.c | 25 +++++++++++++++++++++++++
>  refspec.h |  5 +++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/refspec.c b/refspec.c
> index e3d852c0bfec..ca65ba01bfe6 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -180,6 +180,31 @@ void refspec_item_clear(struct refspec_item *item)
>  	item->exact_sha1 = 0;
>  }
>  
> +const char *refspec_item_format(const struct refspec_item *rsi)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);
> +
> +	if (rsi->matching)
> +		return ":";
> +
> +	if (rsi->negative)
> +		strbuf_addch(&buf, '^');
> +	else if (rsi->force)
> +		strbuf_addch(&buf, '+');
> +
> +	if (rsi->src)
> +		strbuf_addstr(&buf, rsi->src);
> +
> +	if (rsi->dst) {
> +		strbuf_addch(&buf, ':');
> +		strbuf_addstr(&buf, rsi->dst);
> +	}
> +
> +	return buf.buf;

There's a downthread discussion about the strbuf usage here so that's
covered.

But I'm still confused about the need for this function and the
following two patches. If we apply this on top of your series:
    
    diff --git a/t/helper/test-refspec.c b/t/helper/test-refspec.c
    index 08cf441a0a0..9e099e43ebf 100644
    --- a/t/helper/test-refspec.c
    +++ b/t/helper/test-refspec.c
    @@ -31,7 +31,7 @@ int cmd__refspec(int argc, const char **argv)
                            continue;
                    }
    
    -               printf("%s\n", refspec_item_format(&rsi));
    +               puts(line.buf);
                    refspec_item_clear(&rsi);
            }

The only failing test is:
    
    + diff -u expect output
    --- expect      2021-04-07 08:12:05.577598038 +0000
    +++ output      2021-04-07 08:12:05.577598038 +0000
    @@ -11,5 +11,5 @@
     refs/heads*/for-linus:refs/remotes/mine/*
     2e36527f23b7f6ae15e6f21ac3b08bf3fed6ee48:refs/heads/fixed
     HEAD
    -HEAD
    +@
     :

Other than that applying this on top makes everything pass:
    
    diff --git a/builtin/gc.c b/builtin/gc.c
    index 92cb8b4e0bf..ea5572d15c5 100644
    --- a/builtin/gc.c
    +++ b/builtin/gc.c
    @@ -889,35 +889,21 @@ static int fetch_remote(struct remote *remote, void *cbdata)
     		strvec_push(&child.args, "--quiet");
     
     	for (i = 0; i < remote->fetch.nr; i++) {
    -		struct refspec_item replace;
     		struct refspec_item *rsi = &remote->fetch.items[i];
    -		struct strbuf new_dst = STRBUF_INIT;
    -		size_t ignore_len = 0;
    +		struct strbuf new_spec = STRBUF_INIT;
    +		char *pos;
     
     		if (rsi->negative) {
     			strvec_push(&child.args, remote->fetch.raw[i]);
     			continue;
     		}
     
    -		refspec_item_init(&replace, remote->fetch.raw[i], 1);
    -
    -		/*
    -		 * If a refspec dst starts with "refs/" at the start,
    -		 * then we will replace "refs/" with "refs/prefetch/".
    -		 * Otherwise, we will prepend the dst string with
    -		 * "refs/prefetch/".
    -		 */
    -		if (!strncmp(replace.dst, "refs/", 5))
    -			ignore_len = 5;
    -
    -		strbuf_addstr(&new_dst, "refs/prefetch/");
    -		strbuf_addstr(&new_dst, replace.dst + ignore_len);
    -		free(replace.dst);
    -		replace.dst = strbuf_detach(&new_dst, NULL);
    -
    -		strvec_push(&child.args, refspec_item_format(&replace));
    -
    -		refspec_item_clear(&replace);
    +		strbuf_addstr(&new_spec, remote->fetch.raw[i]);
    +		if ((pos = strrchr(new_spec.buf, ':')) != NULL)
    +			strbuf_splice(&new_spec, pos - new_spec.buf + 1, sizeof("refs/") - 1,
    +				      "refs/prefetch/", sizeof("refs/prefetch/") - 1);
    +		strvec_push(&child.args, new_spec.buf);
    +		strbuf_release(&new_spec);
     	}
     
     	return !!run_command(&child);

So the purpose of this new API is that we don't want to make the
assumption that strrchr(buf, ':') is a safe way to find the delimiter in
the refspec, or is there some case where we grok "HEAD" but not "@"
that's buggy, but not tested for in this series?
