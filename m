Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE65C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377426AbiDTKHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347063AbiDTKHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 06:07:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD31EC58
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:04:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so1499182wrg.12
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f9ZAXi+EM5e0gULCAw6raizZrHhQO8NYDdfN1ltd/ug=;
        b=BIl/AmlBmTKW+5JMftT9/EMSVJDxf1Xy8tmbkzOS+OE30fjiLIDBZfoisKFxuf01Pb
         WhszW3e2nlodWD3OCsVQtTImhos3lbcH6DgxH470fSXO7FcyV+VWO8hjREn3uWcgO0s6
         nWjy3VtOLsSCwEaegbRDTA4fWz/Fx3+bH2KFYU4w/KQ7xr1hw9VPpEtL6bm4bGEht0BM
         /QXcw54sdX73M2lfL5Qrys5VOoHslMfKkley+nTT9Nb0P70qffQu9JRWE7gHNiyzChlS
         TtxnLiwIPTA/nfMW+Vv0w9PNp1vRrGoc8aF0Pti2hlyQxQU2nJ9nDTE6V8hNi7Yngn8s
         dGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f9ZAXi+EM5e0gULCAw6raizZrHhQO8NYDdfN1ltd/ug=;
        b=V6R2ZEnx3SF1raZyCed6rnXXA/lS75snqs8BJLZYgIDC4fj1wiUNwY5+9g/qp2TliG
         Oaw7YfX9eZUMDLrQlcpgsbIaRbBNOX7sV9G2Kjgid3rT+x6QXyE6HHL/mhrUglsPxSRA
         pr1nq1Zxm/uZMezFqZpn3omRCYcvEyImKHDPNs4SKQXUICVSqztW2+9pradP0TgY1ifT
         Fu0RZ0JeXGX0yZoZAqY1fFJd7SGC6rgd1IJC8ISwBh6zw7SCHxWMDw58WTgIuNmlU1Tb
         V4S5oGy3CaCMh2CVrkgSXjqq/HOrOuYMfWi2v7GqV/ZMF0NMmdWGfiSvKXfNPAX8a4n2
         Oe+g==
X-Gm-Message-State: AOAM532/7bILiZUepN9SMo7eZscj5jFQUvKUPzU62lGkemxF149R/APS
        or8zyxpel4qZDjOokvS2zuXTcH+1LsY=
X-Google-Smtp-Source: ABdhPJx4tvsTyoy44rVu+gR7ghO2+wzjnoYjkXdG7I/BpkjbnybQimkW/H5Phi2zAgB8ATs2jla2PA==
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id m1-20020a5d6241000000b00207ac0e3549mr14654199wrv.343.1650449053047;
        Wed, 20 Apr 2022 03:04:13 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id r14-20020a5d6c6e000000b0020a9f757708sm6327744wrz.33.2022.04.20.03.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 03:04:12 -0700 (PDT)
Message-ID: <0825f153-1d03-feb4-1e34-4aaed766deb0@gmail.com>
Date:   Wed, 20 Apr 2022 11:04:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] show-branch: fix SEGFAULT when `--current` and `--reflog`
 together
Content-Language: en-US
To:     Gregory David <gregory.david@p1sec.com>, git@vger.kernel.org
Cc:     ptm-dev <ptm-dev@p1sec.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <a36fd2b0-0573-b93e-a765-ce57a651934e@p1sec.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a36fd2b0-0573-b93e-a765-ce57a651934e@p1sec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gregory

Thanks for working on this

On 19/04/2022 17:32, Gregory David wrote:
> If run `show-branch` with `--current` and `--reflog` simultaneously, a
> SEGFAULT appears.
> 
> The bug is that we read over the end of the `reflog_msg` array after
> having `append_one_rev()` for the current branch without supplying a
> convenient message to it.
> 
> It seems that it has been introduced in:
> Commit 1aa68d6735 (show-branch: --current includes the current branch.,
> 2006-01-11)
> 
> Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
> Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/show-branch.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index e12c5e80e3..892241ce0d 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -812,6 +812,26 @@ int cmd_show_branch(int ac, const char **av, const
> char *prefix)
>   		}
>   		if (!has_head) {
>   			const char *name = head;
> +			struct object_id oid;
> +			char *ref;
> +			unsigned int flags = 0;
> +			char *log_msg;
> +			char *end_log_msg;
> +			timestamp_t timestamp;
> +			int tz;
> +
> +			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
> +				die(_("no such ref %s"), *av);
> +			if(read_ref_at(get_main_ref_store(the_repository),
> +					ref, flags, 0, i, &oid, &log_msg,
> +					&timestamp, &tz, NULL)) {
> +				end_log_msg = strchr(log_msg, '\n');
> +				if (end_log_msg)
> +					*end_log_msg = '\0';
> +			}
> +			if(log_msg == 0 || *log_msg == '\0')
> +				log_msg = xstrfmt("(none)");
> +			reflog_msg[ref_name_cnt] = xstrfmt("(%s) (current) %s",

Do we need a bounds check here? I think we're only guaranteed that 
ref_name_cnt - 1 < MAX_REVS though I found the existing code a bit hard 
to follow

Best Wishes

Phillip

> show_date(timestamp, tz, DATE_MODE(RELATIVE)), log_msg);
>   			skip_prefix(name, "refs/heads/", &name);
>   			append_one_rev(name);
>   		}

