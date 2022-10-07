Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF675C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJGWYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJGWYl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 18:24:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E61DF6
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 15:24:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id s16so4690212ioa.6
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDSvr3fQ3hWA2ALgWSVLvPyGWtWWhQDCurrbf6vHxgg=;
        b=FS2yrAyMIXtn8pAbIJ/nGQ7Ce3yaaYpwmFQZ+iY+xIQzdEU13OujhFSu4CvWSvDGVq
         hoFHtFGLBrcGWX03jCTv1Uca2barxRuQ84JAxaj0xTLApfU08O0XxKdxg52wJ2hW91it
         WHg3xvjSMcA+Fn2qWESyHfEmOLIolpDpQ10CeDVBzokgMVW0pEsMEXUleXkjn3wvtksS
         jh+BIjBScYO4HgYdrwgktngbntFq8dyOktXwP3fT/BamTA7cl2FO22vZOlGIgGgnX2KQ
         2nRoAoOhS4nANGzXQKfGu+dgDoUrWoFIwlWX1jG9k+q8HDsHtdTEFzu1PtHFIN3uD1sF
         avGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDSvr3fQ3hWA2ALgWSVLvPyGWtWWhQDCurrbf6vHxgg=;
        b=a00eFpE6orLk2U7oR+snuh58j9whSfxIKqWXHiosvapfMj6bN5OGzwXlKfASsD1CW1
         ofbTef387HFkWIKhFXpRYLKoVi1XbeWf7pzv7zJ58Xsv4dhyMU72I30ZwONgZWRtiBX2
         ILs9GJnxe/cR5xk+ugB9LFDRG9cHposzOhRiRDhiYsUsPj8+bag4msFrNLnU31VoR3Sy
         jWmUvcY/mGTzNtyxR3u61ytCgVedrSI9r3iev5Iq2goITdvqGpDLL3NGWZrUsg5cfW+x
         wIuYdNHN7s7u3FHzxrgedem0hEKVoHjp/4yi9fqd5mkpvibKGrJb9gkYb6nA2yIJ+1iS
         VTZg==
X-Gm-Message-State: ACrzQf2ODzUqX9ZTb8fbHuQ/qD6j/jlJmkN0Pg0eH2/eF7XDjjnnLMmy
        oU/pQWtkTYc430usByGYoqioAw==
X-Google-Smtp-Source: AMsMyM5gAqc+b3SvmXVqZffMoHGp+hrd6ygL/eqvm8malOZS0/hrJTvD0Oscr+NmdDfwHF1HlemhOw==
X-Received: by 2002:a05:6638:4495:b0:363:1e09:57e5 with SMTP id bv21-20020a056638449500b003631e0957e5mr3577051jab.177.1665181478180;
        Fri, 07 Oct 2022 15:24:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f11-20020a02a10b000000b0036390180240sm930084jag.177.2022.10.07.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:24:37 -0700 (PDT)
Date:   Fri, 7 Oct 2022 18:24:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org,
        martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Y0CnJBzTbNgRIqZ+@nand.local>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
 <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2022 at 06:26:57PM -0400, Jeff King wrote:
> > +static void insert_record_from_pretty(struct shortlog *log,
> > +				      struct strset *dups,
> > +				      struct commit *commit,
> > +				      struct pretty_print_context *ctx,
> > +				      const char *oneline)
> > +{
> > +	struct strbuf ident = STRBUF_INIT;
> > +	size_t i;
> > +
> > +	for (i = 0; i < log->pretty.nr; i++) {
> > +		if (i)
> > +			strbuf_addch(&ident, ' ');
> > +
> > +		format_commit_message(commit, log->pretty.items[i].string,
> > +				      &ident, ctx);
> > +	}
>
> So here you're allowing multiple pretty options. But really, once we
> allow the user an arbitrary format, is there any reason for them to do:
>
>   git shortlog --group=%an --group=%ad
>
> versus just:
>
>   git shortlog --group='%an %ad'
>
> ?

I think that if you want to unify `--group=author` into the new format
group implementation, you would have to allow multiple `--group`
options, but each such option would generate its own shortlog identity
instead of getting concatenated together.

Thanks,
Taylor
