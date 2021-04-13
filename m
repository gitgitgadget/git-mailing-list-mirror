Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3141C43461
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904DB613CE
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 18:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbhDMSGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347524AbhDMSGR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 14:06:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36ADC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:05:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d21so354315edv.9
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H45h3XtcA/1YRTCWA1bGKxX9ue22xLkdX2c2XoyEgRs=;
        b=N0pFubQmjsCsRsHOR4RIBnTvC4MFh7c9l1ZcDBd6dt2c3Jv/eQsl6RmSnUhRf+VVoK
         4ouxGk+kJ5vEaMjfqx+BMeJPJHsapn2Nv87ZG8LoVEDTF9WnqZdW8849eAaAuXyi2Kx3
         //6LCRxZavdfoyPrMiFlg6QsjEAxdCjS5zpJAj/8IQy+9UQlqEBasLn/tMo2f4YJc+5H
         Kxpmknava05FjUS9ACscicv2+1O1raeVur2WK9Yo9xP/oxmnXnDEQ76VSVDZKc2khPb0
         zzo7OjmzLIEVR5Y+PJZBiKuZnudN13bf3NyLrtm5UdJL1Sq+lAGm/rhM9AF+vbrCysNy
         oVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H45h3XtcA/1YRTCWA1bGKxX9ue22xLkdX2c2XoyEgRs=;
        b=Y1JSpWwV55YnoY1gSzjG0aYPTUNIChS0aZkgKsHzTjJM5wunW1AH4ud0zjGGOMmtI7
         Z59M7rakPn4+fKYn0doJc63wdSHbkwgVbylP7xlvRdnhYx28AXrWNex1thlkH3ps/zmI
         pVCv3Km2wuBl0tQOfjZ+SZ3FS9tAMq8HU307MM1VB01HrUmt+bWLz7+aokG+9cZtzNsD
         6khNjpph/Mo7PDjfFVkDa5CQMq8e07ZiypVnnlohNa/ccQZgmelwceAIhWs6oRbtAz+E
         Uk8QAS4ZLSqk1atZXP01TsOsRGfTMkG/innfiJw6HkUWEV5EBo/N7dKwterX4hQ0I1Ne
         WJ9w==
X-Gm-Message-State: AOAM533wIObE6SEfJa7hxOtEL7KDCmPBfeiE90oKHwP/Yris7ZZroo5a
        iUe0vUn+5CNMtu2iNb+AaPk=
X-Google-Smtp-Source: ABdhPJxxhTPPnCzUheSZH1X8qDkuaPElVkqm3F41T8vQeLUXoNpqpSlRzOg4mfPwtxI4mnDxgOfcGA==
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr26410148eds.84.1618337155507;
        Tue, 13 Apr 2021 11:05:55 -0700 (PDT)
Received: from szeder.dev (94-21-23-40.pool.digikabel.hu. [94.21.23.40])
        by smtp.gmail.com with ESMTPSA id p9sm9779048edu.79.2021.04.13.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:05:55 -0700 (PDT)
Date:   Tue, 13 Apr 2021 20:05:52 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <20210413180552.GI2947267@szeder.dev>
References: <20210403090412.GH2271@szeder.dev>
 <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
 <YG4hfge2y/AmcklZ@coredump.intra.peff.net>
 <20210412213653.GH2947267@szeder.dev>
 <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHTcHY+P7RuZJGab@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 07:47:41PM -0400, Jeff King wrote:
> On Mon, Apr 12, 2021 at 11:36:53PM +0200, SZEDER Gábor wrote:
> 
> > All what you wrote above makes sense to me, but I've never looked at
> > how partial clones work, so it doesn't mean anything...  In any case
> > your patch brings great speedups, but, unfortunately, the memory usage
> > remains as high as it was:
> > 
> >   $ /usr/bin/time --format=elapsed: %E  max RSS: %Mk /home/szeder/src/git/bin-wrappers/git -C git-partial.git/ gc
> >   Enumerating objects: 188450, done.
> >   Counting objects: 100% (188450/188450), done.
> >   Delta compression using up to 4 threads
> >   Compressing objects: 100% (66623/66623), done.
> >   Writing objects: 100% (188450/188450), done.
> >   Total 188450 (delta 120109), reused 188450 (delta 120109), pack-reused 0
> >   elapsed: 0:15.18  max RSS: 1888332k
> > 
> > And git.git is not all that large, I wonder how much memory would be
> > necessary to 'gc' a 'blob:none' clone of e.g. chromium?! :)
> > 
> > BTW, this high memory usage in a partial clone is not specific to
> > 'repack', 'fsck' suffers just as much:
> 
> I think the issue is in the exclude-promisor-object code paths of the
> traversal. Try this:
> 
>   [two clones of git.git, one full and one partial]
>   $ git clone --no-local --bare /path/to/git full.git
>   $ git clone --no-local --bare --filter=blob:none /path/to/git partial.git
> 
>   [full clone is quick to traverse all objects]
>   $ time git -C full.git rev-list --count --all
>   63215
>   real	0m0.369s
>   user	0m0.365s
>   sys	0m0.004s
> 
>   [partial is, too; it's the same amount of work because we're just
>    looking at the commits here]
>   $ time git -C partial.git rev-list --count --all
>   63215
>   real	0m0.373s
>   user	0m0.364s
>   sys	0m0.009s
> 
>   [but now ask it to exclude promisor objects, and it's much slower;
>   this is because is_promisor_object() opens up each tree in the pack in
>   order to see which "promised" objects it mentions]

I don't understand this: 'git rev-list --count --all' only counts
commit objects, so why should it open any trees at all?

>   $ time git -C partial.git rev-list --exclude-promisor-objects --count --all
>   0
>   real	0m11.723s
>   user	0m11.354s
>   sys	0m0.369s
> 
> And I think that is the source for the memory use, too. Without that
> option, we peak at 11MB heap. With it, 1.6GB. Oops. Looks like there
> might be some "leaks" when we parse tree objects and then leave the
> buffers connected to the structs (technically not a leak because we
> still have the pointers, but obviously having every tree in memory at
> once is not good).
> 
> The patch below drops the peak heap to 165MB. Still quite a bit more,
> but I think it's a combination of delta-base cache (96MB) plus extra
> structs for all the non-commit objects whose flags we marked.
> 
> It does seem like there's probably a good space/time tradeoff to be made
> here (e.g., caching the list of "promisor" object ids for the pack
> instead of inflating and reading all of the trees on the fly).
> 
> diff --git a/packfile.c b/packfile.c
> index 8668345d93..b79cbc8cd4 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2247,6 +2247,7 @@ static int add_promisor_object(const struct object_id *oid,
>  			return 0;
>  		while (tree_entry_gently(&desc, &entry))
>  			oidset_insert(set, &entry.oid);
> +		free_tree_buffer(tree);
>  	} else if (obj->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *) obj;
>  		struct commit_list *parents = commit->parents;
> diff --git a/revision.c b/revision.c
> index 553c0faa9b..fac2577748 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3271,8 +3271,15 @@ static int mark_uninteresting(const struct object_id *oid,
>  			      void *cb)
>  {
>  	struct rev_info *revs = cb;
> +	/*
> +	 * yikes, do we really need to parse here? maybe

Heh, a "yikes" here and a "yuck" in your previous patch...  This issue
was worth reporting :)

> +	 * lookup_unknown_object() would be sufficient, or
> +	 * even oid_object_info() followed by the correct type
> +	 */
>  	struct object *o = parse_object(revs->repo, oid);
>  	o->flags |= UNINTERESTING | SEEN;
> +	if (o->type == OBJ_TREE)
> +		free_tree_buffer((struct tree *)o);
>  	return 0;
>  }
>  
> 
> -Peff
