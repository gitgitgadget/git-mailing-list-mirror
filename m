Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05FC27C76
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 11:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAVLvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 06:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVLvI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 06:51:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A5166EA
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 03:51:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so6658313wms.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 03:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eTf11cfHh/8SKOSEF3BVk+heGX2CP26bVdfcb2Mlvg=;
        b=gRoa3ka3/VXcOulJrXxFqGqCG1FcMTFtx4Fj9U+QyqP1ytArxrkoGso8w6SxagOrFO
         PAWHlGDwIkkYU/Lbbe7ZT1zH7ge1OS8QeWkXSYvvOkeevLsQ7mrC7AZlOgIeZd7ghfKX
         Of9ohp2rIjn6iutATuwPKV9WZAgN1+AU8/pFC54q+Cubog3AYdKwKpzozsYl3WniRpfr
         rgbbHDNIr5s3FcSYUZdH0ECAGEpNJNF2cjLQanG5jyA3HZ0/ICVeq2+tG8qxv5E/rdfZ
         sJY54p8P5V8k2AjMYvxy5cCRM4o/BN+hBTB0/S6kscIZQvHI1rGDUf6vWZJZCG0VtI1M
         Ua6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eTf11cfHh/8SKOSEF3BVk+heGX2CP26bVdfcb2Mlvg=;
        b=mJ5gqXdaC2TvcdVPCPJ/JEMTKU+TKaG44hJj/+HokLwsVorOC1t3fV9ftyrTTtg4oP
         uFMOaH4vmSLU2MyQzlbLXCM2jPiqyQSzHb2YYcrhs9v3tvOaYdwo0WHHzanWaAK8rrL6
         A4wftLiK8IOMek4h1lOEOcc8Ua1cfqnRksGfOA0AwEZJ7+DndWEg5T8UVtoj60+KC0UJ
         krgItOU0Z9T/FFWY47A1/LzmKl4+PXyHGiX8+BNcXUVRNaLrBrJinCk7lxHRUCbeyKE6
         DDwh1mmZfxvExl5qtacQclhz++ioJD1kRasSbuPP5HkvUoc8DKzt6pq6XsD5abzhDNMk
         2WiQ==
X-Gm-Message-State: AFqh2kpyEdQnW1zaoTNW7HVavBUH2vne2wYSfbxk1SFil0GZTfh6nPi7
        auVhYqxtwV9yiHdFZQADpSg+ei5YGww=
X-Google-Smtp-Source: AMrXdXs4SPsBCrtB0Ygyl762aWnpqi5PYAOLDAVGnUemkcenOUZdP73xNl3Qct9l8srlf9VVuv1R5Q==
X-Received: by 2002:a05:600c:358b:b0:3db:2e6e:7826 with SMTP id p11-20020a05600c358b00b003db2e6e7826mr8984996wmq.5.1674388265120;
        Sun, 22 Jan 2023 03:51:05 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c181000b003d1de805de5sm7297265wmp.16.2023.01.22.03.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 03:51:04 -0800 (PST)
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com> <xmqqbkmruykg.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <766b25e1-2d7a-7b5c-10a9-43e545a57dba@gmail.com>
Date:   Sun, 22 Jan 2023 12:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqbkmruykg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21-ene-2023 17:50:55, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Let's stop using find_shared_symref() in die_if_checked_out(), to handle
> > correctly ignore_current_worktree.
> 
> This says what the code stops using, but does not say what it uses
> instead.

I thought the code for that was a better and clearer description.  I'll add
some details to the message.

> Factoring is_shared_symref() out of find_shared_symref() is probably
> a good idea that can stand alone without any other change in this
> patch as a single step, and then a second step can update
> die_if_checked_out() using the new function.

OK.  I'll split that in two.

> As the proposed log message explained, updating die_if_checked_out()
> with this patch would fix a bug---can we demonstrate the existing
> breakage and protect the fix from future breakages by adding a test
> or two?

2/3 and 3/3, I think makes more sense on its own commit.

> > -	const struct worktree *wt;
> > +	int i;
> > +
> > +	for (i = 0; worktrees[i]; i++)
> > +	{
> 
> Style.  WRite the above on a single line, i.e.
> 
> 	for (i = 0; worktrees[i]; i++) {

Sorry.  I'll fix that.

> 
> Optionally, we can lose the separate declaration of "i" by using C99
> variable declaration, i.e.
> 
> 	for (int i = 0; worktrees[i]; i++) {

OK.  Yes, I was playing with this, changed my mind and ended up with this and
the other style below, mess.

> 
> > diff --git a/worktree.c b/worktree.c
> > index aa43c64119..d500d69e4c 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -403,6 +403,33 @@ int is_worktree_being_bisected(const struct worktree *wt,
> >   * bisect). New commands that do similar things should update this
> >   * function as well.
> >   */
> 
> The above comment is about find_shared_symref() which iterates over
> worktrees and find the one that uses the named symref.  Now the
> comment appears to apply to is_shared_symref() which does not
> iterate but takes one specific worktree instance.  Do their
> differences necessitate some updates to the comment?

I think the comment still makes sense as is for the new function, both the
description and the recommendation.  I will review it again.

> 
> > +int is_shared_symref(const struct worktree *wt, const char *symref,
> > +		     const char *target)
> > +{
> 
> What this function does sound more like "is target in use in this
> particular worktree by being pointed at by the symref?"  IOW, I do
> not see where "shared" comes into its name from.
> 
> "HEAD" that is tentatively detached while bisecting or rebasing the
> "target" branch is still considered to point at the "target", so
> perhaps symref_points_at_target() or something?
> 

I tried to maintain the terms as much as possible.  I'll think about the name
you suggest.

> >  const struct worktree *find_shared_symref(struct worktree **worktrees,
> >  					  const char *symref,
> >  					  const char *target)
> > @@ -411,31 +438,8 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
> >  	int i = 0;
> >  
> >  	for (i = 0; worktrees[i]; i++) {
> 
> Not a new problem, but the initialization on the declaration of "i"
> is redundant and unnecessary.  Again, we can use the C99 style, i.e.
> 
> 	const struct worktree *existing = NULL;
> -	int i = 0;
> -
> -	for (i = 0; worktrees[i]; i++) {
> +	for (int i = 0; worktrees[i]; i++) {

I'll fix this.

> 
> > +		if (is_shared_symref(worktrees[i], symref, target)) {
> > +			existing = worktrees[i];
> >  			break;
> >  		}
> >  	}
> > diff --git a/worktree.h b/worktree.h
> > index 9dcea6fc8c..7889c4761d 100644
> > --- a/worktree.h
> > +++ b/worktree.h
> > @@ -149,6 +149,12 @@ const struct worktree *find_shared_symref(struct worktree **worktrees,
> >  					  const char *symref,
> >  					  const char *target);
> >  
> > +/*
> > + * Returns true if a symref points to a ref in a worktree.
> > + */
> 
> Make it clear that what you called "a ref" in the above is what is
> called "target" below.
> 

Again, that was an attempt to maintain the terms from find_shared_symref().


Thank you for your review.
