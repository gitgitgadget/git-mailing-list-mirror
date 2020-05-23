Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CAC433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9E220727
	for <git@archiver.kernel.org>; Sat, 23 May 2020 23:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrEvZnia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgEWXSl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388016AbgEWXSl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 19:18:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965BC061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 16:18:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so6603272pjb.0
        for <git@vger.kernel.org>; Sat, 23 May 2020 16:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dz5qWz39ARBtY1AxuBSU/xrxuh6I2F3leO8zLjLQSis=;
        b=FrEvZniayO6+rtkKkKARpqE38jrqDvg47BHsAT3Hh2AtZoD5gFL3d4iR5ZwQqOeJIY
         8DhaD5HQUMgsXMY3YznBPelFAehYmF7w9FXpanJYA/h5NbNwkhOowRlnAm6tGPLQw7kk
         efPgsBq1wwMzk2pb2Y1rJak34mfx6m5LQJk3UG5tSsE+A7IWWQCcTIjTkjKsgbIlQENc
         EMOxsUEH+VrLJAcOicytGcjWOM1vToamSezvK326rWdSc1yW9Gk56bEjRQQT3NTz8tf3
         DYAJ6psfS2DvHWKwdWdeC39KtTysTUcYtc8tka2gqLmH/qUHXnrljSYHfi9daTYi/q7/
         Dyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dz5qWz39ARBtY1AxuBSU/xrxuh6I2F3leO8zLjLQSis=;
        b=QbWvLDt4YXsu6HM0gOAJjlXEcjo46fBPiaJAKRXgESRGc6fKdrXKvXd9u5zcgrAX0F
         zfznrQs4IVorwBL7g9pDPEUzpHSV9nNFv3uWKl/3xe6mLEjykC1Dq5TFaJ7Nwt4X6N64
         u1E1ZJixbBaBU0FX8TiT1vjVdGBKa54QuKKkz7NbLskN0YxWAVr3fEH4ayoYytZXJ1wQ
         QCBefWdXcx3NnJqNT1VOhf0n4G/IGnQZzJt1AkEv4VLhzO1GjVvjneQeP48E0BcY/lvZ
         RAqQCtXFajWXHQcjx0dAt7HJIHSymchuz1hozc9U9CkOV1E8vSTJB3BWdFH/xA4LR9ec
         p9wg==
X-Gm-Message-State: AOAM531YAVHtAfwhw6Vk3/teitZLVoUiBNmlupWaL6v9b3PQQsfBy6Rq
        AbpWzKqfw5HIW9KmuWuEDXNStaSfpTY=
X-Google-Smtp-Source: ABdhPJzy7vkD7gItsABuVRDMJD4Ff1c6ex1P7RoqN75GpwOjh31xqiJh/KqJtmRh/qwnqUTtKb/7KQ==
X-Received: by 2002:a17:902:be08:: with SMTP id r8mr22063581pls.260.1590275920755;
        Sat, 23 May 2020 16:18:40 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id y65sm9931612pfb.76.2020.05.23.16.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 16:18:40 -0700 (PDT)
Date:   Sun, 24 May 2020 06:18:38 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        liu.denton@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200523231838.GB1981@danh.dev>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
 <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33127873-fb19-2bd5-3028-bcd1757e92e5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On 2020-05-24 00:19:38+0530, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> I believe you missed Danh's v3 comments[1]. I'm mentioning them inline with
> some additional comments.

Thanks for checking this.

> On 23-05-2020 22:09, Shourya Shukla wrote:
> > 
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index f50745a03f..7e844e8971 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -2284,6 +2284,50 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
> >   	return 0;
> >   }
> > +static int module_set_branch(int argc, const char **argv, const char *prefix)
> > +{
> > +	/*
> > +	 * We accept the `quiet` option for uniformity across subcommands,
> > +	 * though there is nothing to make less verbose in this subcommand.
> > +	 */
> > +	int quiet = 0, opt_default = 0, ret;
> > +	const char *opt_branch = NULL;
> > +	const char *path;
> > +	char *config_name;
> > +
> > +	struct option options[] = {
> > +		OPT__QUIET(&quiet,
> > +			N_("suppress output for setting default tracking branch")),
> 
> As '--quiet' in 'set-branch' is a no-op and is being accepted only for
> uniformity, I think it makes sense to use OPT_NOOP_NOARG instead of
> OPT__QUIET for specifying it, as suggested by Danh.

Yay, I still think it's better to use OPT_NOOP_NOARG, (and with shortopt q,
which I forgot in previous reply.)

	OPT_NOOP_NOARG('q', "quiet")

> Also, the description "suppress output for setting default tracking branch"
> doesn't seem to be valid anymore as we don't print anything when set-branch
> succeeds.

OPT_NOOP_NOARG will take care of description itself. Even if we choose
to not use OPT_NOOP_NOARG, a better description should be provided.

> > +		OPT_BOOL(0, "default", &opt_default,
> > +			N_("set the default tracking branch to master")),
> > +		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> > +			N_("set the default tracking branch")),
> > +		OPT_END()
> > +	};
> > +	const char *const usage[] = {
> > +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> > +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),
> > +		NULL
> > +	};
> > +
> 
> I also agree with the Danh here that '--quiet' could be removed from usage.
> There's no point in mentioning '--quiet' in the usage when it has no effect.
> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 39ebdf25b5..8c56191f77 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -750,33 +750,7 @@ cmd_set_branch() {
> >   		shift
> >   	done
> > -	if test $# -ne 1
> > -	then
> > -		usage
> > -	fi
> > -
> > -	# we can't use `git submodule--helper name` here because internally, it
> > -	# hashes the path so a trailing slash could lead to an unintentional no match
> > -	name="$(git submodule--helper list "$1" | cut -f2)"
> > -	if test -z "$name"
> > -	then
> > -		exit 1
> > -	fi
> > -
> > -	test -n "$branch"; has_branch=$?
> > -	test "$unset_branch" = true; has_unset_branch=$?
> > -
> > -	if test $((!$has_branch != !$has_unset_branch)) -eq 0
> > -	then
> > -		usage
> > -	fi
> > -
> > -	if test $has_branch -eq 0
> > -	then
> > -		git submodule--helper config submodule."$name".branch "$branch"
> > -	else
> > -		git submodule--helper config --unset submodule."$name".branch
> > -	fi
> > +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"
> >   }
> > 
> 
> Danh questioned whether '$branch' needs to be quoted here. I too think it
> needs to be quoted unless I'm missing something.
> 
> 
> ---
> Footnotes:
> [1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet/T/#maf26182b084087ed08a2a72d3da2ee2026b1618e

For the better record, I think it's better to use a permenent link,
just in case lore.kernel.org go into the dust someday,
people can still have a reference if they have an archive.

https://lore.kernel.org/git/20200521230453.GB2042@danh.dev/

-- 
Danh
