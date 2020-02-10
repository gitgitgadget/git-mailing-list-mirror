Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F44C35254
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8720715
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="1h8j3H0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJTm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:42:56 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35324 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 14:42:56 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so3238866plt.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2aAwH/f7Vs1gSFV/PTqbiPHT1lr4oP8cdrM5MYsKl0=;
        b=1h8j3H0UFPNxRGMORh0FiOo3CIU2F0IPYEhID3wcEuWbzZ2TVc0AOD8HMZJ4UdZCtS
         US51PUG9hPH7et40eNOKnhz1CI9xC/VlbcWpkj6bKy/Fck0GHQyd9pju+wW/gbKFoAF+
         1np2ac2Z2qHGLA1PJvQu3s647zj4XWcFg7jlPyls9Z0IOatwQrX0ZBLAEyUqnVXodQrK
         Q2S9WNNcWYPC2TJ08amSfFlvBT551+pEiVf1EQgV7I5TbP5VoJSLK3roqYxjy4dGb8L+
         cGEUrmy0TFqaKqdp6UTj6tDNEvOeB2Q01lzWAqPh0ZrJYoblosTrJ99COyYCq64GFJhi
         sk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2aAwH/f7Vs1gSFV/PTqbiPHT1lr4oP8cdrM5MYsKl0=;
        b=Jho3U8hn4HhtOKqRf7ZWR4J8hCLkqrBTMTMpG9YBSqQXj/XTuChGp6uswDcjnXlebp
         CuPmJOLsHGfZlyTLkiPjbigAlMqHEq/NA3g14u2fRLj9ix28yKFd6B86mBArJRRWo/9V
         gDpYxPi6nb9PncH3B6XxaQAt2tL+MTamEoNNU0ydoyOf+gR6oXt+mmII7mPLVxlkZGWP
         fxtHtEMNNBvGoP6WbhLnibiGxEl6tfTGOH0nYUly4mmCZFNBL6yztrnTFLsipDVekw4r
         bvyW+Esg5vDUVMWIt3EjTypvhQnvBUaTUSqFVLKnJtITEhe43yxq0yNfYmP6W6CPjDK1
         hCWQ==
X-Gm-Message-State: APjAAAXqXnBLFIsQ3s8z2P5fkhici0GZxHkpTF51XxHGISUs8Hx+KLZl
        R1d75bYfji6mGv29/LzcR7ggyQ==
X-Google-Smtp-Source: APXvYqwauyRT75qz/TGA7rzy7UVF1ttNx8iFAo8k82gSa99AbxcJumBHXvzI55VMClTG0zap2mfktQ==
X-Received: by 2002:a17:902:321:: with SMTP id 30mr15020748pld.130.1581363775300;
        Mon, 10 Feb 2020 11:42:55 -0800 (PST)
Received: from localhost ([205.175.106.6])
        by smtp.gmail.com with ESMTPSA id 7sm1271915pfc.21.2020.02.10.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:42:54 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:42:53 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200210194253.GA46461@syl.local>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
 <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 11:30:46AM -0800, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
> >> +static const char turn_off_instructions[] =
> >> +N_("\n"
> >> +"Turn this message off by running\n"
> >> +"\"git config %s false\"");
> >
> > I have mixed feelings on the use of these instructions. Perhaps at
> > minimum the addition of these instructions could be left to a
> > separate patch than the creation of advise_ng().
> >
> > My biggest concern is that this adds unexpected noise to users who
> > want the advice to stay. I'm calling attention to it, because this
> > part isn't a simple refactor like the rest of the patch.
> > ...
> > I definitely tend to recommend more tests than most, but perhaps this
> > unit test is overkill? You demonstrate a good test below using a real
> > Git command, which should be sufficient. If the "turn this message off"
> > part gets removed, then you will still have coverage of your method.
> > It just won't require a test change because it would not modify behavior.
> > ...
>
> All good suggestions.  Thanks for an excellent review.
>
> Another thing.
>
> advise_ng() may have been a good name for illustration but is a
> horrible name for real-world use (imagine we need to revamp the API
> one more time in the future---what would it be called, which has to
> say that it is newer than the "next generation"?
> advise_3rd_try()?).

What about calling this new API 'advise()'? The first patch could call
it 'advise_ng' or whatever other temporary name we feel comfortable
using, and then each subsequent patch would update callers of 'advise()'
to use 'advise_ng()'. Once those patches have been applied, and no other
callers of 'advise()' exist, a final patch can be applied on top to
rename 'advise_ng()' to 'advise()', and update the names of all of the
callers.

This makes for a rather noisy final patch, but the intermediate states
are much clearer, and it would make this series rather self-contained.

On the other hand, having a version of 'advise_ng()' on master makes
this topic more incremental, meaning that we can pick it up and put it
down at ease and have more self-contained projects.

I don't really have a preference between the two approaches, but if we
go with the latter, I do think we need something better than
'advise_ng'. Maybe 'advise_warn'? I don't know.

> Thanks.

Thanks,
Taylor
