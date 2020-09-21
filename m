Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B86C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D009420874
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp6EWaTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIUImj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUImj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 04:42:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AAC061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:42:39 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p65so11559139qtd.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVoKZn4r7vdg4+3g18ZfvXwOOEqvEVijhHwaZSfLjgU=;
        b=Hp6EWaTxyf/MY2uaxhQ0m/9tX7QlEiq0fvO+O/1Lof3Vsz+kj4IKVru4GrnQm+7K+p
         3ANYoFnaObw0tdIyxBYxoLfHWfgUx+Jizv6vEkdnz7U+UfXcINMJ4rWcZoZqvI2tnpZ8
         hVj+XvdHmCouCC1kIJMQrdWscHKwTZyBUkJPiMrUkW4+2QsUjcXWFWs3KgVBOmBISwxQ
         WDzrj2rdnW9aEx2DEpY8bCr4KrSFm/EJOB3YvacXg0ikpzG0N+ZwqZyt9+dIU4TS3u4z
         oxLNiqbF8Km2zMHU/XCda0bEECwjZbjpW5be1D/g7CXns9myLO40eGvuAvSzuOUINyRw
         9IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVoKZn4r7vdg4+3g18ZfvXwOOEqvEVijhHwaZSfLjgU=;
        b=WME2NrGp8DBR8BGUcopP7fwLQNOBERybsPpSPqq/7f+rvATM5/Le7m4Yj6y0vcc+GS
         eu47vLTjJ0s/wb35iFceHsJ5Vz43xC9nK3sea3I/LzUs1IqlgBwKfmAK3F/rFwisbcpi
         NwkhlImBuB6Er6gDGxl9tOqFYYIFIRGil+H26qRFfZQHnwPeZsF81BO5/76A7PXlkstv
         akD/6JlSVpkWDeyY6Am842n4tF6WQzPKeIKTyrNZKAjw0+vwkl1Mc6fui8xMWHA1V+Ky
         hQQpgIrWXfVC3AEI+ayOxv1Nqgo1hEg6+Noh/tt+UOF0aOITO5vVmFs09fvVGSFf7+CL
         7v2g==
X-Gm-Message-State: AOAM530mqZ2iW+vIJmCcq5sX4r1R7glsnEP9CJ+A+DPSl/mabosu6RcL
        h+1h8KhbtN9hM1Z9v7ldvwU29LVgbS1D3GUW
X-Google-Smtp-Source: ABdhPJyEw/mDzQU2hZuSzKkj0EeN0bteGHFzckMvxdJgeA3+fC/XmpN5NXwdJJr7cMPrAxNJQA7UvQ==
X-Received: by 2002:ac8:1387:: with SMTP id h7mr45969325qtj.386.1600677757891;
        Mon, 21 Sep 2020 01:42:37 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id p3sm8498991qkj.113.2020.09.21.01.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 01:42:37 -0700 (PDT)
Date:   Mon, 21 Sep 2020 14:12:31 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20200921084231.GA64896@mail.clickyotomy.dev>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200919170316.5310-2-shrinidhi.kaushik@gmail.com>
 <xmqqft7djzz0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqft7djzz0.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/19/2020 13:03, Junio C Hamano wrote:
> Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:
> 
> > Adds a check to verify if the remote-tracking ref of the local branch
> > is reachable from one of its "reflog" entries.
> 
> s/Adds/Add/

Gotcha, I will reword the commit messages for all three commits.
in the patch series.

> > When "--force-with-includes" is used along with "--force-with-lease",
> 
> A misspelt name for the new option is found here.

*Facepalm.* Thanks, will update.

> > [...]
> Makes me wonder, if in_merge_bases() is so expensive that it makes
> sense to split the "were we exactly at the tip?" and "is one of the
> commits we were at a descendant of the tip?" into separate phases,
> if this part should be calling in_merge_bases() one by one.
> 
> Would it make more sense to iterate over reflog entries from newer
> to older, collect them in an array of pointers to "struct commit" in
> a batch of say 8 commits or less, and then ask in_merge_bases_many()
> if the remote_commit is an ancestor of one of these local commits?
>
> The traversal cost to start from one "local commit" to see if
> remote_commit is an ancestor of it using in_merge_bases() and
> in_merge_bases_many() should be the same and an additional traversal
> cost to start from more local commits should be negligible compared
> to the traversal itself, so making a call to in_merge_bases() for
> each local_commit smells somewhat suboptimal.
> 
> If we were talking about older parts of the history, optional
> generation numbers could change the equation somewhat, but the
> common case for the workflow this series is trying to help is that
> these local commits ane the remote tip are relatively new and it is
> not unlikely that the generation numbers have not been computed for
> them, which is why I suspect that in_merges_many may be a win.

Nice! We can definitely try batching commits from the reflog and
pass it along to "in_merge_bases_many()". As for being faster than
calling "in_merge_bases()" for each commit entry in the reflog --
I am not familiar with how the former works. Do we still keep the
"reflog_entry_exists()" part? It might still be faster to go through
the entries once to check with "oideq()" in the first run.

Also, I was wondering if it is worth considering this:
  - check if the reflog of the HEAD has the remote ref
  - check if the reflog of the local branch has the remote ref
  - check if the remote ref is reachable from any of the local ref's
    "reflog" entries using "in_merge_bases_many()" in batches as
    suggested here.

The first two (we can even skip the second one) runs are relatively
fast, and the third one might be faster than checking "in_merge_bases()"
for each reflog entry. I suppose adding these three steps would make
the process slower overall, though. For context, I was referring to
your message [1] on the other thread regarding checking the HEAD's
reflog.

> > [...]
> > +		/*
> > +		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
> > +		 * mode, and if "--foce-if-includes" was specified, run
> > +		 * the check.
> > +		 */
> > +		if (ref->if_includes)
> > +			check_if_includes_upstream(ref);
> 
> s/foce/force/; 

Yes, sorry about that; will update.
 
> I can see that the code is checking "and if force-if-includes was
> specified" part, but it is not immediately clear where the code
> checks if "--force-with-lease" is used with "tracking" and not with
> "the other side must be exactly this commit" mode here.
> 
>     ... goes and looks ...
> 
> Ah, ok, I found out. 
> 
> The field name "if_includes", and the comment for the field in
> remote.h, are both misleading.  It gives an impression that the
> field being true means "--force-if-included is in use", but in
> reality the field means a lot more.  When it is true, it signals
> that "--force-if-included" is in use *and* for this ref we were told
> to use the "--force-with-lease" without an exact object name.  And
> that logic is not here, but has already happened in apply_cas().
> 
> Which makes the above comment correct.  We however need a better
> name for this field and/or an explanation for the field in the
> header file, or both, to avoid misleading readers.
>
> > diff --git a/remote.h b/remote.h
> > index 5e3ea5a26d..38ab8539e2 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -104,7 +104,9 @@ struct ref {
> >  		forced_update:1,
> >  		expect_old_sha1:1,
> >  		exact_oid:1,
> > -		deletion:1;
> > +		deletion:1,
> > +		if_includes:1, /* If "--force-with-includes" was specified. */
> 
> The description needs to be tightened.
> 
> > +		unreachable:1; /* For "if_includes"; unreachable in reflog. */

OK, you're right. Perhaps, we could rename it to something like
"if_includes_for_tracking" and update the comment description
with saying something along the lines of:

+  /*
+   * Set when "--force-if-includes" is enabled, and
+   * if "compare-and-swap" is not provided with the
+   * exact commit to be expected on the remote (in
+   * "use_tracking" or use_tracking_for_rest" mode).
+   */


[1]: https://public-inbox.org/git/xmqqsgbdk69b.fsf@gitster.c.googlers.com

Thanks again, for taking the time to review this.
-- 
Srinidhi Kaushik

