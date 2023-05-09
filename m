Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A12C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjEIUWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 16:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEIUWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 16:22:43 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AFE40C2
        for <git@vger.kernel.org>; Tue,  9 May 2023 13:22:42 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a79671a4dso97982627b3.2
        for <git@vger.kernel.org>; Tue, 09 May 2023 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683663761; x=1686255761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DobOCbshlVIssY+mhoVGSHm5biNXWUPHSc48u0OJBIw=;
        b=q6wWs00F95bFuvgVil6EWENSoLgqJoV2QSEffu6hEzCcGpcTg5DAldO0VwOA53ctpT
         CnMF+B1anmBnmLJkDtSOvgWRjSckwoyyZLPMNn7eMpa/pJnDDIsPNV+Mkjnzm1MKZDt0
         kFaa7K3AdC2l94cg7ZVdVmCb8sN9ceNj3Z64KcH1ZZVXCkDcvlDxvFCtHInoSY1TraJ8
         HCx3gTss6oRUGpTjGmNbcyE/R5v1TJ4i8I8B5nJoLx/DwRfq8Ek6rWI6cd/2ja5jg2G+
         4rMXEj70MEe/7UvUWu9QVllJPyXFcsw+WcKNTH6yI0jyvlNfpI2PX5DB+crMynMHOQxU
         VsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683663761; x=1686255761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DobOCbshlVIssY+mhoVGSHm5biNXWUPHSc48u0OJBIw=;
        b=KWWMbNG0JYlIGwF/CQXMSClWKjD06SO7g6Dc5ytEzcfGjqQscgMbmSd9kgaSU1RTEo
         jttEfp3n19Og2sepHTJ6jq840jTDoVWCCjIRkncQbw+wF4s2xvLttcnRkRSTeHdlahOw
         Gd4MiQ8seArdQzUTCIjcMtc7QUQsb1eZ8GeGd6TUvYtkABTG8UG1oILDtYctnhl/CYq4
         jATfnqRq/8V+AsYjvVaPX1g4vXy/dmA3qT0TnD0/1NRKYUiGeevuozGPcztT/TeeTdmf
         t3k7hfLD+MDL/lcwNRN0RhjNGlsylJrZnkXHnXkDladIL4UkzzBlSRmsaB5AoW9T76ur
         KRXA==
X-Gm-Message-State: AC+VfDzsrYqtQm6pnX0tD4jftai58p6btyqfQlL47Xuu9rmzZb9ZVx/v
        9+1lLxhKIdj7ARd4QDjazy9y4GrHc61shUivBa/kiw==
X-Google-Smtp-Source: ACHHUZ76aTQAF1iFj/6lCH9yY+2HpG4P+Y71w2lMuJv0TK1L/5oYKU1kpM5lydr92FNo6B1xuHsSlQ==
X-Received: by 2002:a81:9288:0:b0:55a:824e:a142 with SMTP id j130-20020a819288000000b0055a824ea142mr15120959ywg.23.1683663761389;
        Tue, 09 May 2023 13:22:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z128-20020a816586000000b00545dc7c4a9esm3536565ywb.111.2023.05.09.13.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 13:22:40 -0700 (PDT)
Date:   Tue, 9 May 2023 16:22:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 06/15] builtin/for-each-ref.c: add `--exclude` option
Message-ID: <ZFqrj/gdzkZBYF1V@nand.local>
References: <cover.1683581621.git.me@ttaylorr.com>
 <ea5c0ddc10cd484c2af8505b8078697896ff3bad.1683581621.git.me@ttaylorr.com>
 <xmqqcz3a4den.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcz3a4den.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2023 at 04:22:08PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> > index c01fa6fefe..449da61e11 100644
> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -14,6 +14,7 @@ static char const * const for_each_ref_usage[] = {
> >  	N_("git for-each-ref [--points-at <object>]"),
> >  	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
> >  	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
> > +	N_("git for-each-ref [--exclude=<pattern> ...]"),
> >  	NULL
> >  };
>
> I think the original is already wrong, but the easiest thing we can
> do in order to avoid making it worse is to drop this hunk, as the
> existing usage is this:
>
> static char const * const for_each_ref_usage[] = {
> 	N_("git for-each-ref [<options>] [<pattern>]"),
> 	N_("git for-each-ref [--points-at <object>]"),
> 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
> 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
> 	NULL
> };
>
> and this series merely adds a new "--exclude=<pattern>" as one of
> the "<options>".
>
> As we can see from the fact that for example
>
>  $ git for-each-ref --no-merged next refs/heads/\?\?/\*
>
> works just fine, exactly the same thing can be said about the other
> --points-at/--merged/--no-merged/--contains/--no-contains options.
>
> The SYNOPSIS section of the manual page is fine.

Good point, will tweak; thanks.

> > @@ -2169,6 +2169,15 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
> >  	return match_pattern(filter, filter->name_patterns, refname);
> >  }
> >
> > +static int filter_exclude_match(struct ref_filter *filter, const char *refname)
> > +{
> > +	if (!filter->exclude.nr)
> > +		return 0;
> > +	if (filter->match_as_path)
> > +		return match_name_as_path(filter, filter->exclude.v, refname);
> > +	return match_pattern(filter, filter->exclude.v, refname);
> > +}
>
> Earlier I made a comment about .name_patterns member becoming
> unnecessary, but I think what should need to happen is instead
> match_pattern() and match_name_as_path() to lose the "filter"
> parameter, and take a boolean "ignore_case" instead.

Agreed.

> > +cat >expected <<\EOF
> > +refs/tags/bar
> > +refs/tags/baz
> > +refs/tags/foo/one
> > +refs/tags/testtag
> > +EOF
> > +
> > +test_expect_success 'exercise patterns with pattern exclusions' '
> > +	for tag in foo/one foo/two foo/three bar baz
> > +	do
> > +		git tag "$tag" || return 1
> > +	done &&
> > +	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
> > +	git for-each-ref --format="%(refname)" \
> > +		refs/tags/ --exclude="refs/tags/foo/t*" >actual &&
> > +	test_cmp expected actual
> > +'
>
> These are doing as Romans do, so I won't comment on the outdated
> pattern of preparing the expectation outside the test script.  After
> the dust settles, somebody needs to go in and clean it up.

Yeah, I figured that this series was already getting pretty long, but
that it would be expedient to propagate forward this pattern. But it
should be cleaned up. Let's tag it with #leftoverbits accordingly.

Thanks,
Taylor
