Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCFFC433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiAFROD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiAFROC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:14:02 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5458DC061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 09:14:02 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id t66so3332951qkb.4
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 09:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/JjDUuBq1KhUPDSpWrgGMd1P70TqqJCjdCdNzWJRcPY=;
        b=sWR47gJHpRFF5SBQcNJWMlNFY0FSnOpKnVp2DrabZzjgk48xwUAwgsF8H/EKnm7Nq8
         tXJynN4XruQjL/D0aCau8JvjS51a78d/ZZXhFrkAwOoCnU+8CkuejVl7z+4dCItuXZwH
         Ho0yUqzhb0jMfzcqBN0IVQfP14Er0I0ARI1qya6lbn7NcLwV8I0XFfLpjxzy+VzLnlT8
         kru+vwKytBPLm1nyTtGe3xdE4aKd8a0cWMaS5WKULkz0XQF22p3tqub1BtSa+bxO9fgA
         bGt4UHRJHpPEQ9jaktwDlS1BZp22EkLtpoAAmUQZ57miI7BMpCb55rUug85dH8N9GEEw
         zO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/JjDUuBq1KhUPDSpWrgGMd1P70TqqJCjdCdNzWJRcPY=;
        b=3hXkU8SibGauk18LS5CxPjMA+6K44j9c6nbC6oA/idy23t7HxTliyhyC+x+TFrYR3d
         NB+b/iJ3oDf9gD251gKrD+tKJnaiCx9+Gl6LC8NYVtuDtr4k44PLKUjfJmwWQZUul3ZI
         kGP6DHfdLgyhIN6xqtHtY0GwIJ5jxJmBskclvz7GMleJOiSJnqeZV2TjX1i1W8CCdrVC
         ucFzsDW8Sw3r3cGJ1jOt6Gc2ExYO0oTkzNNbji6EkEPHZVWEbIl1CGCrVUwUmQ9DecF5
         MfqMXI7K2jzLQEH7sDyVQQ5zTw4a2+CN5bH2kQtArNoG4bmfZguJbJ3ICFHvBLmea+qF
         nvGA==
X-Gm-Message-State: AOAM5314DVoWr/jkwf7KyMaI7GoM8uhmbVoke7lKu2ULBoSQ7CTRKQct
        46lqNJ9GP9OYTlHSMRjgu1ReqA==
X-Google-Smtp-Source: ABdhPJwlTuIzI9vJDt4ELMPzRNPl6fCDN+cDuTKXZHI99eERnrwAaLuTQ7KJMht1NyIPbNJ1zl3M8w==
X-Received: by 2002:a05:620a:199a:: with SMTP id bm26mr2224805qkb.132.1641489241527;
        Thu, 06 Jan 2022 09:14:01 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r187sm1702768qke.11.2022.01.06.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:14:01 -0800 (PST)
Date:   Thu, 6 Jan 2022 12:14:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        levraiphilippeblain@gmail.com, phillip.wood123@gmail.com,
        Tilman Vogel <tilman.vogel@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] builtin/pull.c: teach run_merge() to honor
 rebase.autostash config
Message-ID: <YdcjWG/67JlxTjfF@nand.local>
References: <20220106150226.77458-1-johncai86@gmail.com>
 <YdcjCKTrK+W/FCw1@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdcjCKTrK+W/FCw1@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 06, 2022 at 12:12:40PM -0500, Taylor Blau wrote:
> On Thu, Jan 06, 2022 at 10:02:26AM -0500, John Cai wrote:
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 100cbf9fb8..8423e420ee 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1133,7 +1133,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >  			die(_("cannot rebase with locally recorded submodule modifications"));
> >
> >  		if (can_ff) {
> > -			/* we can fast-forward this without invoking rebase */
> > +			/*
> > +			* We can fast-forward without invoking
> > +			* rebase, by calling run_merge().  But we
> > +			* have to allow rebase.autostash=true to kick
> > +			* in.
> > +			*/
> > +			if (opt_autostash < 0)
> > +				opt_autostash = config_autostash;
>
> This looks OK, and prefers the value of autostash given over options
> over the configured one. But it may be a little clearer to construct it
> that way explicitly (see the conditional "if (opt_rebase)" inside of
> cmd_pull()).

Oops, ignore this suggestion. run_merge() looks at the static variable
opt_autostash, so you really do need to be manipulating it directly.

Nevermind: what you wrote here looks fine.

Thanks,
Taylor
