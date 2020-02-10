Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304AC3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0408120733
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luLLqPM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBJW3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:29:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44757 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgBJW3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:29:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id y5so4393484pfb.11
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=je8BIsIOG97huUrIBkQCYSbdc1jqyao/Bnl6dTxetmg=;
        b=luLLqPM9UPfJcGeXR0cLDN2F4hXADo15NrH+8BiTJuHi3RTwm8xrYeqMH8UKiQmSGP
         ZJNuZJ+AilIZzL+QBsSTLQgMdMktlQIRkSkCHJr/iYTCNCmxkyeurbqcrf6iSE+i/Cq2
         llCtaN/s7gh8E+u0QmUWwSA5YhFWwYb932DgLZkme7wwalJRKPgrJnOsXqOoHCE8/IQK
         +ELlG6mBqorIN77gf4lZDikVOqsFYbCLz/NMujvqcvoBroE8+Lkt4gmWrTrrtA2bJAuO
         lIYrAcxTKYgVfZeapi20LhZDPpkSdRdqplcg5L04+waYFKCwRfvhvQy0GJCIAjLzq0jo
         n4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=je8BIsIOG97huUrIBkQCYSbdc1jqyao/Bnl6dTxetmg=;
        b=ZVU7liLRP6D/pYwYOdwTPQrC/pDyfBjh910loO8VzpaOP1G318JoH27i/hO4Jx12b4
         YG4fvE4xQeVcN7jteK6dfckX4/omc2+xBI1O4mM79BqDKLtdXJ1cl0IweKF/yQWrAq4n
         2wMtm5wvFnfxTEXT86uaz7e417Y8yHun/C07sI80t2mAjqXJa/ZPxn6rVJ6DXO6gjlK3
         mMF+JoW068iPOCDKVBF3a1142uT1YHtBuflnVFpRCvdZju+aNWrYD/5oBum6Zr43X7oL
         ehiOCkxfOcGoGqLQyVw5T5lng8wT51VUvMM2RPVkofY1LhVo3s9srTnrE89r5GLCf2wN
         3DdA==
X-Gm-Message-State: APjAAAUdd+4OG8ru/wMZ/OALV64ii1mSmpsct+dVro1moErWnD3HySoB
        BPBOPwcl/hsQ4MTOIkONufqmGg==
X-Google-Smtp-Source: APXvYqxf+ujB5DfsN6UM9ebj+uVYDe+kR5tA3DwRhWT/SKc3V0Ce9aOlZOGpgYWTKR1LvtVcKOX9qQ==
X-Received: by 2002:a63:cf14:: with SMTP id j20mr3692986pgg.67.1581373777840;
        Mon, 10 Feb 2020 14:29:37 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w8sm1509460pfj.20.2020.02.10.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:29:37 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:29:32 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200210222932.GC190927@google.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
 <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
 <20200210194253.GA46461@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210194253.GA46461@syl.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 11:42:53AM -0800, Taylor Blau wrote:
> On Mon, Feb 10, 2020 at 11:30:46AM -0800, Junio C Hamano wrote:
> > Derrick Stolee <stolee@gmail.com> writes:
> >
> > >> +static const char turn_off_instructions[] =
> > >> +N_("\n"
> > >> +"Turn this message off by running\n"
> > >> +"\"git config %s false\"");
> > >
> > > I have mixed feelings on the use of these instructions. Perhaps at
> > > minimum the addition of these instructions could be left to a
> > > separate patch than the creation of advise_ng().
> > >
> > > My biggest concern is that this adds unexpected noise to users who
> > > want the advice to stay. I'm calling attention to it, because this
> > > part isn't a simple refactor like the rest of the patch.
> > > ...
> > > I definitely tend to recommend more tests than most, but perhaps this
> > > unit test is overkill? You demonstrate a good test below using a real
> > > Git command, which should be sufficient. If the "turn this message off"
> > > part gets removed, then you will still have coverage of your method.
> > > It just won't require a test change because it would not modify behavior.
> > > ...
> >
> > All good suggestions.  Thanks for an excellent review.
> >
> > Another thing.
> >
> > advise_ng() may have been a good name for illustration but is a
> > horrible name for real-world use (imagine we need to revamp the API
> > one more time in the future---what would it be called, which has to
> > say that it is newer than the "next generation"?
> > advise_3rd_try()?).
> 
> What about calling this new API 'advise()'? The first patch could call
> it 'advise_ng' or whatever other temporary name we feel comfortable
> using, and then each subsequent patch would update callers of 'advise()'
> to use 'advise_ng()'. Once those patches have been applied, and no other
> callers of 'advise()' exist, a final patch can be applied on top to
> rename 'advise_ng()' to 'advise()', and update the names of all of the
> callers.

I think this is the precise strategy called out in the patch
description.
https://lore.kernel.org/git/pull.548.git.1581311049547.gitgitgadget@gmail.com

> This makes for a rather noisy final patch, but the intermediate states
> are much clearer, and it would make this series rather self-contained.
> 
> On the other hand, having a version of 'advise_ng()' on master makes
> this topic more incremental, meaning that we can pick it up and put it
> down at ease and have more self-contained projects.
> 
> I don't really have a preference between the two approaches, but if we
> go with the latter, I do think we need something better than
> 'advise_ng'. Maybe 'advise_warn'? I don't know.

I like that this opens up the possibility of advise_err(), advise_die(),
whatever to meet Peff's suggestion.

 - Emily
