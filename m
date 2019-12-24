Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63323C2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 10:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316F720643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 10:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3f1f7l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfLXKMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:12:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35763 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLXKMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 05:12:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so16066183qka.2
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZdgQWhX2wjkjghItrHr2DEz4tPUim8NrT5nOABRVe+8=;
        b=m3f1f7l7ZLgQ1dL5+qS2W6XZz3ZJPQbQkLUpeGCqcjkyK9Pplxxeg0pPNzpL83V5BD
         h9q+oI8A8n6DOpRf4Q/lNAJItFSaQ++jEV/0jC9+4pjQe622nVeaL1EISvauqfFDe3cn
         W0uuPCv7xHdI0+ZxjZFWD1Um90aleSiaHMw+o3e1IPFhZxWRtb/cB76N1WikLgxVlY3d
         1BdmWW55zRJrONsjCOAvYmE28L5eowGyvAUja1vedFteYQQubwQGkYV6c3RqRfogOfOS
         JgGJVz+VnHMeBBMD4gi9aq+JnirKdcLjWZfBnepViXwCqzFJQNMARyx3r3TIC0G9pvoU
         0jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZdgQWhX2wjkjghItrHr2DEz4tPUim8NrT5nOABRVe+8=;
        b=liRu6UrdZ5TI+sA8MAqdyQELfkIYtsbSPx7QNZJumHeXD3UPO4x3c8FRipmPNa2PgY
         pokMqBk+noZIUs+j6JvW1n+SYn4rgVwTjFjI1xfTR9izAXp+ITY++YhPE0yGl8vs0Gs8
         qcJJf0y8foAsULguqYA2B9e1C6J+Rk7ZsOLTaGxG7IFnYcDJbNZ9rfqNLtLUrKeoInYc
         JIzkBF0G2iQmYgv/ihrNBQJ3gQqw/88K+axraGK/L8uiGNY5LhSDo+/okaGwQGkX9hQp
         89HukUF2cAn68pscrZNCPxwZ1tfraH7l9IfJI8FvLHMI0/PhEdtv6WYsg/IQ/jkD5eT5
         YXWA==
X-Gm-Message-State: APjAAAVzSnXGILunw7Dxl4a2LiDh1Dg6sZPNTsUxR6B1sGmt4tYrJdiT
        CV+uXTEnwc6CVEV85o0iuox0PfzS
X-Google-Smtp-Source: APXvYqy+Y+YglKY7y0Hh5K3roTiuOpcTPFSS6//kM6++0O2+X+fmUbnv6tGEhCLEB9R80We9UOGs0g==
X-Received: by 2002:a05:620a:1522:: with SMTP id n2mr29807098qkk.108.1577182336877;
        Tue, 24 Dec 2019 02:12:16 -0800 (PST)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7406027qtb.43.2019.12.24.02.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 02:12:16 -0800 (PST)
Date:   Tue, 24 Dec 2019 05:12:14 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 7/7] merge: teach --autostash option
Message-ID: <20191224101214.GA2744494@generichostname>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <f43c10e4818c91a8c6e9d5e0ce2a04710db3e300.1571246693.git.liu.denton@gmail.com>
 <nycvar.QRO.7.76.6.1910212103080.46@tvgsbejvaqbjf.bet>
 <20191224100507.GB2743221@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224100507.GB2743221@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 24, 2019 at 05:05:07AM -0500, Denton Liu wrote:
> > >  	OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
> > >  		N_("merge strategy to use"),
> > >  		0),
> > > @@ -671,6 +671,10 @@ static int run_merge(void)
> > >  	argv_array_pushv(&args, opt_strategy_opts.argv);
> > >  	if (opt_gpg_sign)
> > >  		argv_array_push(&args, opt_gpg_sign);
> > > +	if (opt_autostash == 0)
> > > +		argv_array_push(&args, "--no-autostash");
> > > +	else if (opt_autostash == 1)
> > > +		argv_array_push(&args, "--autostash");
> > 
> > Or shorter:
> > 
> > 	argv_array_pushf(&args, "%s-autostash", opt_autostash ? "-" : "--no");
> > 
> > Ah, but that would mishandle `-1`. I bet I will be puzzled by this
> > again. Maybe it would make sense to mention in a code comment that it
> > can be `-1` in which case we leave it to `rebase` to use the config
> > settings to determine whether or not to autostash.
> 
> I copied this over from the rebase case. I'll add a comment there as
> well.

Actually, on another thought, this happens in a couple of places in
builtin/pull.c. I'm not sure that it's worth the noise of commenting it
every place where this happens. I dunno. I'll send a re-roll out and if
someone else brings it up again, I'll add the comments in.
