Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E3FC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E4460E77
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhH3VUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhH3VUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:20:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE032C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:19:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m4so9354319pll.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cyAUMExy+e1/oYeElnCiJzQQnO3ai6nE6qZwfCtF9Yw=;
        b=F3vTw127oUf3axk9VpfGiGF9RUKADmle0JG71WbOnkbXyWkYnJXLGRYoGJvVytnIzU
         LUiiB9SgJANAuP77sP751ENlyZw9gqgcvvyMXUO+ch5c2SDz+RIClctXI3WHITWkY8oM
         LYkxb63EA/FIzWrwKjD69AYOu0K6NK9Enhsx25mcKbKkNpZqApjj2HzQ95y5PXeIJ5Hj
         4r6WMQpThflK79qaTwY/jWzgkFinRmMFNXrQAo+bBlNCKkC36AuI8V5ukDbQyhMFak3U
         3Q4G92k8Ij1viXm1d0sz6HJfMOhXzNxRtaVUOieSPYGvYs5AH9iqu4D+n1J1JIbI/eMO
         8R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cyAUMExy+e1/oYeElnCiJzQQnO3ai6nE6qZwfCtF9Yw=;
        b=QlKClesunhPIL6473aBvfTUiKwdFJTK3rA2o5mswcLX5cva4aAz6xkkHIH4eZ3FykB
         zI0xcwHS3wNTIMwF29CGfmEMlW4j+CSM1RNMJctKlu1NS4TYxUFFDvzqcXpKQyH6KjME
         VQ1vOHTewCHBTg8K5E0MYEkvImdKr+VXzeLTylFfqDm1CPU3ud2jiMFLlXzA6sRx78SK
         lR19T2shva4huKE9mZY0yjXmePbWE3Y+/zguEjvhDYim2/LfRZUyCD2OUO8mT/dTshVQ
         3cO0vUjKJOLqE81NIGUvQF4iUNg0lvvq7WtVFN0CtTd5K0jos4e0jaO6cMMmh4DhwTUJ
         s7JA==
X-Gm-Message-State: AOAM533lfTS9AIXxe9G/n3wHCdlgh1mm5T5+Gvt5h6dlIpcljIu+vcfR
        n70WSaF6FIcjcaEtFiQAP25nSKJzZln8Tw==
X-Google-Smtp-Source: ABdhPJxoIbE0Duzrwld8aK5haYzF288yfgd+qOPOPL7FYzPj+Z4DnRc88Kr69QVX+wvgbi3VzPfthw==
X-Received: by 2002:a17:90b:1d02:: with SMTP id on2mr1163564pjb.21.1630358386142;
        Mon, 30 Aug 2021 14:19:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:16fe:83fb:786f:9778])
        by smtp.gmail.com with ESMTPSA id 5sm4797379pfl.135.2021.08.30.14.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:19:45 -0700 (PDT)
Date:   Mon, 30 Aug 2021 14:19:39 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
Message-ID: <YS1La6YYAnJk4Sg8@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
 <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
 <xmqqwnotaq0e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnotaq0e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.10 15:33, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > +	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1},
> 
> No need to resend to only fix this, but I'll add SP after "1" to
> match surrounding lines while queuing the patch.

Ack. Fixed in V3. Do you also want me to rebase this on
ab/retire-advice-config?

> > @@ -5149,8 +5150,13 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >  		oidset_insert(&interesting, &commit->object.oid);
> >  
> >  		is_empty = is_original_commit_empty(commit);
> > -		if (!is_empty && (commit->object.flags & PATCHSAME))
> > +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> > +			advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +					_("skipped previously applied commit %s"),
> > +					short_commit_name(commit));
> > +			skipped_commit = 1;
> >  			continue;
> > +		}
> >  		if (is_empty && !keep_empty)
> >  			continue;
> >  
> > @@ -5214,6 +5220,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
> >  		oidcpy(&entry->entry.oid, &commit->object.oid);
> >  		oidmap_put(&commit2todo, entry);
> >  	}
> > +	if (skipped_commit)
> > +		advise_if_enabled(ADVICE_SKIPPED_CHERRY_PICKS,
> > +				  _("use --reapply-cherry-picks to include skipped commits"));
> 
> I agree with the change in this hunk that advanced users may want to
> squelch this "what to do" hint.
> 
> I am not sure about the earlier hunk that reports when some commits
> have actually been skipped.  When --no-reapply-cherry-picks is in
> effect, the user is expecting that some commits are cherry-picks
> among other (hopefully the majority of) commits, and even those
> users who do not want to be taught how to use the command would want
> to learn the fact that some commits were skipped (and which ones).
> 
> Using two separate advice configuration variables feel way overkill
> for this.  I wonder if the previous hunk should use warning(), i.e.

Switched these to warnings, squelched by "--quiet" as suggested below.


> > +		if (!is_empty && (commit->object.flags & PATCHSAME)) {
> > +			warning(_("skipped previously applied commit %s"),
> > +				short_commit_name(commit));
> > +			skipped_commit = 1;
> >  			continue;
> > +		}
> 
> possibly squelched by "git rebase --quiet".
> 
