Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB54C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 15:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbiD0Pti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiD0Psv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 11:48:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C003EF1F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:45:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d5so3096461wrb.6
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cwZFRVKr9yF50xO3xc7lPxN4VuPGH/D4RADqgO+fX3o=;
        b=QmY3GVbS2gnrD/oJaWthtj1B6xDJMfFUxTiBpBveiUprel4s7FgY+nIFeyDHyPBUBQ
         RnA09oN8mEuJpdTAf6RhlAhJ4de+QfwrFpjOyi0974gwvWeXSKXumhfGuKQfwxp5dGch
         ksRKBRU4KR3mjvx+fy/Jit3ZVC8Fikc+lYCf6zoGSsdKynw+/D06bJ0TuK8LfkVlGiH3
         hMNI6Mp11XNmPXpITTUBbL0oMLcpVGgS0ER2cskFMQ1eohK0oVc/rr2sZW9sBSWjfGwN
         zWRBY0xpAeb2OfcTJulwrmJ0n+/43f7Muh6z8z/A9FMDZb3CsF/2yglqsIf+HQCxaNdE
         QlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cwZFRVKr9yF50xO3xc7lPxN4VuPGH/D4RADqgO+fX3o=;
        b=XKcfKrro2tqH6QYr93qfjB9Gn053hdmtJd22frcaT1jK8H6WuUWF8nDVEzMfKFjaor
         Mm73V9asvaxcdNoPCNF2JqzT88MU/tYDGe5hbgs8TciesJehzrf82AswkVzW7xrz7DWm
         BLOsVYNeE9hSTSGe2cLYNFNs6euJeLIO2cp/SQYqPiMtEviKkibNAEKkj14KkLhdwIrO
         YE4cfFB5uXlrYXKpMgSmiIvSHs3XRkgvsy99P/CtcepVGRAEnLtKiCQ637ds0Mdkmme+
         0PwUGp6CM7J9x8SyrkFuh1uMs1B8IrcWrJvl7x76RxGNEmQWv/kSGS9HqHAOeCctGe79
         uGfw==
X-Gm-Message-State: AOAM532TA3EdsxncxIHRyVIW1GLMk2dpn+52vYNGsnKrwy5RN1apFCyc
        OW4t9azmahzlgjQmU7LqtAEcve1McTQ=
X-Google-Smtp-Source: ABdhPJyGW/LnB6gafT5srFf+596bp5jurdnCoMOGKeateODlFUswwsgea5Ef6nf7uziYcjNGXqBz0g==
X-Received: by 2002:a5d:4645:0:b0:20a:db5d:258f with SMTP id j5-20020a5d4645000000b0020adb5d258fmr12525662wrs.135.1651074337280;
        Wed, 27 Apr 2022 08:45:37 -0700 (PDT)
Received: from localhost ([2a02:2149:8ba4:e400:b4f9:19f2:e54:30c8])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm1758283wmj.11.2022.04.27.08.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:45:36 -0700 (PDT)
Date:   Wed, 27 Apr 2022 18:45:26 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu
Subject: Re: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Message-ID: <20220427154526.uuhpkoee322l7kmz@compass>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-4-kioplato@gmail.com>
 <220411.86o817j2dt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220411.86o817j2dt.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/11 01:11PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Apr 10 2022, Plato Kiorpelidis wrote:
> 
> > Simplify dir_iterator_advance by switch from iterative to recursive
> > implementation. In each recursive step one action is performed.
> >
> > This makes dir-iterator easier to work with, understand and introduce
> > new functionality.
> >
> > Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
> > ---
> >
> > [...]
> >
> > @@ -45,34 +45,53 @@ struct dir_iterator_int {
> >  
> >  /*
> >   * Push a level in the iter stack and initialize it with information from
> > - * the directory pointed by iter->base->path. It is assumed that this
> > - * strbuf points to a valid directory path. Return 0 on success and -1
> > - * otherwise, setting errno accordingly and leaving the stack unchanged.
> > + * the directory pointed by iter->base->path. Don't open the directory.
> > + *
> > + * Return 1 on success.
> > + * Return 0 when `iter->base->path` isn't a directory.
> >   */
> >  static int push_level(struct dir_iterator_int *iter)
> >  {
> >  	struct dir_iterator_level *level;
> >  
> > +	if (!S_ISDIR(iter->base.st.st_mode)) return 0;
> 
> style: missing \n before "return".
> 
> Also, the one existing caller before this patch is:
> 
>     if (S_ISDIR(iter->base.st.st_mode) && push_level(iter))
> 
> Why not continue to do that?

In this patch I also fixed a problem that's subtle. Previously, when we called
dir_iterator_begin() and the specified path is invalid the call won't return
NULL. Instead the call succeeds and the first call to dir_iterator_advance()
fails. I believe that's unexpected. The expected behavior would be to return
NULL from dir_iterator_begin() if the specified path is invalid. Successful call
to dir_iterator_begin() suggests that the root path is valid.

To deal with that I introduced two states for the most recent directory. The
first is just pushed into the levels stack and the other pushed and activated.
This way we can "activate" the root directory in dir_iterator_begin(), but we
also need to reorder the calls to push_level() and activate_level() as a result.
We need to push directories after we read them and activate the most recent one
when dir_iterator_advance() is called.

I'll document that change in the related commit in v2.

Do you have any objection about this change?

> > +/*
> > + * Activate most recent pushed level.
> > + *
> > + * Return 1 on success.
> > + * Return -1 on failure when errno == ENOENT, leaving the stack unchanged.
> > + * Return -2 on failure when errno != ENOENT, leaving the stack unchanged.
> > + */
> > +static int activate_level(struct dir_iterator_int *iter)
> > +{
> > +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> > +	int saved_errno;
> > +
> > +	if (level->dir)
> > +		return 1;
> > +
> > +	if ((level->dir = opendir(iter->base.path.buf)) != NULL)
> > +		return 1;
> > +
> > +	saved_errno = errno;
> > +	if (errno != ENOENT) {
> > +		warning_errno("error opening directory '%s'", iter->base.path.buf);
> >  		errno = saved_errno;
> > -		return -1;
> > +		return -2;
>
> Perhaps we should just add an enum for these return values instead of
> adding more negative/positive values here. That makes your later calls
> of activate_level() more idiomaic. E.g. !activate_level() instead of
> activate_level() == 1.

Yes, I agree. It was bothering me while I was writing these parts. I'm happy you
suggested a way to make this cleaner by using an enum.

> >  		warning_errno("failed to stat '%s'", iter->base.path.buf);
> > +		return -2;  // Stat failed not with ENOENT.
> 
> Don't use // comments, use /* .. */
> > +	} else if (stat_err && errno == ENOENT)
> > +		return -1;  // Stat failed with ENOENT.
> 
> Missing {} here for the else if.
> 
> > +	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
> > +	struct dir_iterator_level *level = &iter->levels[iter->levels_nr - 1];
> > +
> > +	struct dirent *dir_entry = NULL;
> > +
> > +	int expose_err, activate_err;
> > +
> > +	/* For shorter code width-wise, more readable */
> > +	unsigned int PEDANTIC = iter->flags & DIR_ITERATOR_PEDANTIC;
> 
> We usually don't add \n\n in the middle of variable decls.
> 
> > [...]
> >
> > -		if (!de) {
> > -			if (errno) {
> > -				warning_errno("error reading directory '%s'",
> > -					      iter->base.path.buf);
> > -				if (iter->flags & DIR_ITERATOR_PEDANTIC)
> > -					goto error_out;
> > -			} else if (pop_level(iter) == 0) {
> > +	if (dir_entry == NULL) {
> 
> Don't compare against NULL, use !dir_entry.
> 
> [...]
> 
> > +		if (errno) {
> > +			warning_errno("errno reading dir '%s'", iter->base.path.buf);
> > +			if (iter->flags & DIR_ITERATOR_PEDANTIC) goto error_out;
> 
> more missing \n before goto/return.

I'll fix the coding style in these parts in v2. I'm sorry about that.
