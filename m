Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D5C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 00:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBWAMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 19:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWAMI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 19:12:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388D3BD85
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 16:12:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u10so10960383pjc.5
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Uj00+8gPGSVaza5eqgPwCD7g9nmd2cdR3UDPAQw/Mw=;
        b=eMJ0hbGjtvsClIvpJysAExxsmkfkINqkxCDruGbyrD2dXgDWmyfmZ4s+r3O6jfpvPr
         d66VcOSRl+iFGeMQikDSHqXm1/XVJ7z3gQUFVIv9XmCPeqmvA1uSBboip3PmLJaipPdz
         DeAuyGs/IfzYMGaALEOCTh/4JNpMIrBi7hjlFLLaMqHxF8KXHUQFYLd7WAshVMMU5pHb
         RmkY1EJLBh9ErIqcsWPt9PPA3F8JVHUUyl+ABJiPiLJidFq57+EZaWFH0szVf0K9/mer
         9YWGgKlD2FaNP3iXMw9KPnAT+EEYHA1bI/74fQ2y8Hl5L9kONw+azjQMf3fHPeZpenRD
         EbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Uj00+8gPGSVaza5eqgPwCD7g9nmd2cdR3UDPAQw/Mw=;
        b=dvEwmGFTJbd9TNZCzObMIFjyzWSggI7avoLOclOiK+QglzSU+K4bQt/+pTRrvTQ5wN
         7ALpNJJagPV+S98//n9t6Y3O4Dgpavin8yxfGgJ21l/idxgOrIrhyEMzsM0pQq/Bjy75
         G5KtN4ieBP+MvLtwCqGAEVqKoLn920Hx/KUG4NWvRMHGSxkG0SbQK5b+dvdIJnZ3ZzLp
         I+RFDZzO6dbE6mhgafxUimENySe65WLrPUzyLd85p7tXlPZm1uF8UaD9yaBJOzJuHmUi
         TXj/mNuuMUuw+Q69to5+vgGKNCMoKuVY8RLF/ECzK52c0PYTaR1hgnWNhBkHMteTg8Xx
         yyMw==
X-Gm-Message-State: AO0yUKW8I2PESemDkYZOW/WdbCvIL/QVwTXaSDAag7iVEZYn6tRFfYUV
        nCCKKdlrEQnVh3IQOXfq6JI=
X-Google-Smtp-Source: AK7set8MphL8081DGJGi6vMHluCOnH+AFbRjZ8qNv/IFSahibgVeWTxZAbmd/NY3QL0r6fogns/Mcw==
X-Received: by 2002:a05:6a20:4e1c:b0:bc:4d0c:ce45 with SMTP id gk28-20020a056a204e1c00b000bc4d0cce45mr7895825pzb.53.1677111126385;
        Wed, 22 Feb 2023 16:12:06 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b005941ff79428sm2408931pfo.90.2023.02.22.16.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 16:12:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 3/3] rebase: add a config option for --rebase-merges
References: <20230222051709.464275-1-alexhenrie24@gmail.com>
        <20230222051709.464275-3-alexhenrie24@gmail.com>
Date:   Wed, 22 Feb 2023 16:12:05 -0800
In-Reply-To: <20230222051709.464275-3-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 21 Feb 2023 22:17:09 -0700")
Message-ID: <xmqqh6vdb5pm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +rebase.merges::
> +	Whether and how to set the `--rebase-merges` option by default. Can
> +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
> +	true is equivalent to `--rebase-merges` without an argument, setting to
> +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
> +	`--rebase-merges` with that value as its argument, and setting to false
> +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
> +	command line without an argument overrides a `rebase.merges=false`
> +	configuration but does not override other values of `rebase.merge`.

OK.  And ...

> +static void parse_merges_value(struct rebase_options *options, const char *value)
> +{
> +	if (value) {
> +		if (!strcmp("no-rebase-cousins", value))
> +			options->rebase_cousins = 0;
> +		else if (!strcmp("rebase-cousins", value))
> +			options->rebase_cousins = 1;
> +		else
> +			die(_("Unknown mode: %s"), value);
> +	}
> +
> +	options->rebase_merges = 1;
> +}

... this fallback parsing that is called after parse_maybe_bool()
finds the value a non-Boolean ...

> @@ -815,6 +829,13 @@ static int rebase_config(const char *var, const char *value, void *data)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "rebase.merges") && value && *value) {
> +		opts->rebase_merges = git_parse_maybe_bool(value);
> +		if (opts->rebase_merges < 0)
> +			parse_merges_value(opts, value);
> +		return 0;
> +	}

... looks pretty much standard way to handle such an "extended
Boolean" value.  Nicely done.
