Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5CBC71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjH2RxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjH2Rwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:52:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D964E9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:52:39 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d7485d37283so4490708276.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693331558; x=1693936358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94yxijUvo8/z3Adsxxn+pMFTVrWkIqXIH0+fIeDKvmU=;
        b=N6Zi4M1jAPuTEWW4e8iW5/1rChUnPdje0Ve3v27ObBzfbxmku6tR3PawtNoNPFX/MX
         qQy6uU1vjjDhGtEYwhK8U/R4yYqgGMITnUcHF0fkNzwmARXBfARL6lNt6x+G0dbBNMto
         dvfD/raGi9uxX2N8RLQz2PvHLdBTa3ZG19VXxFyYikLW/SCLvX5foJdf6Bv15fuN0L3Q
         45sYKs6ZFo0bnVdLf7pPm4cy1UnQM5BzRi9Aa/tY6jcoDX9TQ/OCQdgOhAtWahkUZLoJ
         rFoXtsL5U+HqDSF5ZRPtCBJhi2VA+WQuDIWFxnJnAiVBJZkMcxvqQoaavHREA/ys/oMp
         hP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331558; x=1693936358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94yxijUvo8/z3Adsxxn+pMFTVrWkIqXIH0+fIeDKvmU=;
        b=TlnuA9Bi+nECph2Ad/UyoWjPcSl7e2mdGstlLiMlmAT0LG3rKhuBhdLyPiSjupGeXC
         fGNVQTiYu+kAKmnldmU9sBFh6YGpTJZ1/y5iZaoKscaK/Y0lxLUMrU3eACq3iGBItEnp
         H71ZlRsKOfTaRuQ+MlYdiXGT2VC03qcFE6UdLDZh99hQ1urTpN1oZWEEAtj1jpsZVsB9
         TpHz6sgm2egNH6G2ARBAjVpmJ8mXT0gdwCtrNyFHJDn+GsleDNn4mJrn4K+vQX5G//e7
         zLnTb5xnV1l2ic5qcMAWXGcSlStH2GgcqeNG2JU5njuQoPRB8P503L//KBGyREjLgiTF
         OA7A==
X-Gm-Message-State: AOJu0YxFOYBNlfLBxZm1wXrhupzL0E25RGYv50O52g1WXVfLKi/z1AZk
        XnCfRqnHhvLJ+AgV2AgwzMo8MuGiLLhoPek9Hd23FQ==
X-Google-Smtp-Source: AGHT+IEd2t26+YsxPAgUDmRcGbwXudmaQjUh99amOcLo/881MuaHCseKaR9not05onZq5zEjEzofEw==
X-Received: by 2002:a25:51c9:0:b0:d7b:95ff:14f with SMTP id f192-20020a2551c9000000b00d7b95ff014fmr14279ybb.61.1693331558293;
        Tue, 29 Aug 2023 10:52:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n188-20020a25dac5000000b00d7745e2bb19sm2298366ybf.29.2023.08.29.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:52:38 -0700 (PDT)
Date:   Tue, 29 Aug 2023 13:52:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] builtin/pack-objects.c: support `--max-pack-size`
 with `--cruft`
Message-ID: <ZO4wZdaR/I06n+E8@nand.local>
References: <cover.1693262936.git.me@ttaylorr.com>
 <b6d945197faaef8243bddf78f672a340404e6ac4.1693262936.git.me@ttaylorr.com>
 <xmqqr0nld9u9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0nld9u9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 10:42:06AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > When pack-objects learned the `--cruft` option back in b757353676
> > (builtin/pack-objects.c: --cruft without expiration, 2022-05-20), we
> > explicitly forbade `--cruft` with `--max-pack-size`.
> >
> > At the time, there was no specific rationale given in the patch for not
> > supporting the `--max-pack-size` option with `--cruft`. (As best I can
> > remember, it's because we were trying to push users towards only ever
> > having a single cruft pack, but I cannot be sure).
>
> I am reasonably sure it was the case but then I do not recall we
> ever discussing how the second cruft pack gets consolidated into one
> by combining it with the existing one.

Yeah. We write the combined cruft pack just like we would any other, and
record each packed object's most recent mtime available from either:

  - a loose copy of that object, if one exists
  - the mtime of the .pack file for any packed copies of that object
    which may exist
  - the mtime of that object as recorded in an .mtimes file (if that
    file was packed as cruft).

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 868efe7e0f..a046994a43 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1190,8 +1190,7 @@ static void write_pack_file(void)
> >  		unsigned char hash[GIT_MAX_RAWSZ];
> >  		char *pack_tmp_name = NULL;
> >
> > -		if (pack_to_stdout)
> > -			f = hashfd_throughput(1, "<stdout>", progress_state);
> > +		if (pack_to_stdout) f = hashfd_throughput(1, "<stdout>", progress_state);
> >  		else
> >  			f = create_tmp_packfile(&pack_tmp_name);
>
> An unintended change, I am sure ;-)
>
> It is very surprising that absolutely no real change is needed to
> allow cruft packs to honor the settings, other than removing the
> seemingly artificial inter-option-compatibility roadblocks (all
> hunks for it omitted above as they were trivially obvious).  I am
> sure the first hunk to fold an "if" statement onto a single line is
> not what makes the feature to actually work ;-)

Hah, this made me laugh. Indeed, a whitespace change around this
if-statement is not the make-or-break change we needed to make this
feature work!

I'm happy to clean this up and resubmit it, but you may have already
done so, in which case I'll leave this as-is.

Thanks,
Taylor
