Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6954DC63709
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 20:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLGUax (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 15:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLGUaw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 15:30:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874F57BC08
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 12:30:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l26so8474868wms.4
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UR/+ow8m8tx5Z0MwYGw0GpTRRH7Wq4d7ELcTLJS7i+k=;
        b=Yg6PvTlPFGmD79hepKdhYG6mSScLA3WTGT4uDthweZ1l+rs53mL0FxN76NlUf8nx6E
         TYHB8TEigJ0Qo97YmDe1qg4D8n+rZShNzt1saNYSWxgIf72d2zxMtppQONjQduHpLDzF
         f2IrFD6VwA1nJ9wWFNtA/cVyk3xFkD/1Hbtp57NqYN6YNZYVQJusWDc429pYKTmTsY3k
         JUjOg/WaLHs1dUtP7Qljvn39k15yexJQs9dTVyohP8bmqDZEN33SjTCCSwJ0Xg4saRJN
         BakPHhiMLvKqVUNzvd5v9mjb7CNfTk1D296IwyhojahMPISY9Dyqm9P21Jc8uPVKc1Az
         L2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UR/+ow8m8tx5Z0MwYGw0GpTRRH7Wq4d7ELcTLJS7i+k=;
        b=VjD8/0fawzL2XZQ8m8tewge2v0sHFCYRt+RHx51Ybz/m/tpws2VD3yjw3LkdaEFkVM
         Qe/JC/En4IrQVDGPo2Q38bXx0KZKmKWPSMCSuZICEePCmrLRmue1Ori7H8I/m4ADIS2Z
         pfWH43lCwMyjbLoaZH3L0MTxDVrH1J9lWBN+hDBli8fPPrxn4OSwx2b1OGQrlYl4+uZD
         C+GrbBi9ni62M0JlXjmP6K0/5G0mFKR+YB+4hhQ0gBEawCmwb4E0iFN2x7zu997Wi/xc
         awGbHs2suG1KBBBY4MuWbgkV1DRzvsRhW1QsOLQBdG6ACjBZGQPDUO7YHReTPM+MoY0z
         MyEQ==
X-Gm-Message-State: ANoB5pllpLUjhKPxO5cM+hRvvq7d4ZP+WI6vWXIAsOV8pYtJdB+7g6FP
        Rql1svW+3raSjYztsDWu/N0=
X-Google-Smtp-Source: AA0mqf5Ut9pEPX+yNgDLdAmgCkf40i4223JAuEV+pJSwWLoieEWqUlo98JLkO0pSMYcQ5PV14FyBWw==
X-Received: by 2002:a05:600c:4f89:b0:3d1:caf1:3f56 with SMTP id n9-20020a05600c4f8900b003d1caf13f56mr850919wmq.9.1670445049854;
        Wed, 07 Dec 2022 12:30:49 -0800 (PST)
Received: from localhost (94-21-23-215.pool.digikabel.hu. [94.21.23.215])
        by smtp.gmail.com with ESMTPSA id y24-20020a05600c341800b003d1e763ba46sm2669508wmp.10.2022.12.07.12.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:30:49 -0800 (PST)
Date:   Wed, 7 Dec 2022 21:30:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] line-range: Fix infinite loop bug with degenerate
 regex
Message-ID: <20221207203047.GA2996@szeder.dev>
References: <20221205193625.2424202-1-lars@oddbit.com>
 <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221207.86tu27aju3.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 05:52:04AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 05 2022, Lars Kellogg-Stedman wrote:
> 
> > When the -L argument to "git log" is passed the degenerate regular
> > expression "$" (as in "-L :$:line-range.c"), this results in an
> > infinite loop in find_funcname_matching_regexp() (the function
> > iterates through the file correctly, but when it reaches the end of
> > the file it matches $ against the empty string, "", and at that points
> > loops forever).
> >
> > Modify the loop condition from while (1) to while (*start) so that the
> > loop exits when start is the empty string. In this case, "git log" exits
> > with the error:
> >
> >     fatal: -L parameter '$' starting at line 1: no match
> >
> > Originally reported in <https://stackoverflow.com/q/74690545/147356>.
> >
> > Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
> > ---
> >  line-range.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/line-range.c b/line-range.c
> > index 955a8a9535..bdcb810485 100644
> > --- a/line-range.c
> > +++ b/line-range.c
> > @@ -135,7 +135,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
> >  {
> >  	int reg_error;
> >  	regmatch_t match[1];
> > -	while (1) {
> > +	while (*start) {
> >  		const char *bol, *eol;
> >  		reg_error = regexec(regexp, start, 1, match, 0);
> >  		if (reg_error == REG_NOMATCH)
> > @@ -161,6 +161,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
> >  			return bol;
> >  		start = eol;
> >  	}
> > +
> > +    return NULL;
> >  }
> >  
> >  static const char *parse_range_funcname(
> 
> We really should fix this, but why not just count this as a match,
> rather than erroring out?
> 
> That we're mixing up whether '$' always matches here with our iteration
> loop is our own internal bug, we shouldn't error out on a '$'. It's just
> a regex that happens to match everything.

Indeed.  The description of '-L...' in the manpage of 'git log' (and
'blame') states:

    If :<funcname> is given in place of <start> and <end>, it is a
    regular expression that denotes the range from the first funcname
    line that matches <funcname>, up to the next funcname line.

So, if we use '-L' with a funcname regex that matches every line, be
it '$', '^' or '.*', then this would mean that it should denote the
range from the first funcname line in that file to the second.

