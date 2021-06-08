Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033B8C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9436127A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFHHbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFHHbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:31:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A1C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 00:29:16 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id o5-20020a4a2c050000b0290245d6c7b555so4773317ooo.11
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=lpk6kdj/++K+Vl8DpT8OtrNSoIaVdani05xLpHAEyF0=;
        b=TDSpp5wbz88KWqF786BjRbuodQqlbpHN+Eo1+LiQCjtRjFuOEGM6tvJUwfdsmkfOU6
         LuZE04jBWVcd9rKvCeXj0rOOh4YW9SNPLWyo96FTeU45kax3at9nqPzZe++aNhK3N3q5
         THPh84Hg58XyksTQRwTOUCslItZDF++YRcdSZhFp5rELcR0vy318lULgCTFGbR/hB3e9
         KWD5KbfxovMfHmfk9z4l7ezGTiny//xwve0bYvMfHughQb7hVnZWJj0d2YpYhjrTwKxd
         ubATIU6tJUfmbGBrXdrcoASa0FBy5XpnXvcov15RHX+EWpjBMF94j9LKnggVb7X/KwWY
         DiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=lpk6kdj/++K+Vl8DpT8OtrNSoIaVdani05xLpHAEyF0=;
        b=TNfNBFrsQpEzYRv0eOtQS9diePGEwDQ9IxIgdx9gAD+Q3P2XgjCh0+yr8iR/otC/K8
         lhC7gCR9sK2QjvC6fm3NR2b6N7I42K902+CyPjQUPOB6oHsPEV89BHkO+FJBiegdjNap
         xU/t0aTSe3/3Kcv+4yECd0TpveS5YSvOsZlIubaHlDNiYv9TV84MnYNjluBiEhyOpP9h
         OWLvnDxZtoA5svx8cws+XZPUBkn1M7nDD8eKGGzKgPX0lH+e8go3UBtV9UY+KcleNNJ2
         QDxJ3A1K43PedXmM3Rc+zLu1Ee2W4earv46M2PHccY2eR28k9Wno2jHT6TpbTb6dFfGC
         CAKg==
X-Gm-Message-State: AOAM530qPpChS6hcJcCBvjOG9x8UBc1XI5jZ5WLene0bjowlElYwMNUP
        2G2zJ75Y3yUbCryX3nZIfbA=
X-Google-Smtp-Source: ABdhPJxIr1rl7L6llvp6iSwufTVAZvV4sDS1g+imn1uLbhwqmMdc83VpWL6qDGS860qXqEgKivg/XA==
X-Received: by 2002:a4a:c287:: with SMTP id b7mr16537256ooq.8.1623137355550;
        Tue, 08 Jun 2021 00:29:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k8sm456717ool.5.2021.06.08.00.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 00:29:15 -0700 (PDT)
Date:   Tue, 08 Jun 2021 02:29:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60bf1c49e3f89_1a2cb92082b@natae.notmuch>
In-Reply-To: <xmqqy2blorn0.fsf@gitster.g>
References: <20210608015807.906101-1-felipe.contreras@gmail.com>
 <xmqqy2blorn0.fsf@gitster.g>
Subject: Re: [PATCH] doc: merge: mention default of defaulttoupstream
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Commit a01f7f2ba0 (merge: enable defaulttoupstream by default,
> > 2014-04-20) forgot to mention the new default in the configuration
> > documentation.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/config/merge.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
> > index cb2ed58907..6b66c83eab 100644
> > --- a/Documentation/config/merge.txt
> > +++ b/Documentation/config/merge.txt
> > @@ -14,7 +14,7 @@ merge.defaultToUpstream::
> >  	branches at the remote named by `branch.<current branch>.remote`
> >  	are consulted, and then they are mapped via `remote.<remote>.fetch`
> >  	to their corresponding remote-tracking branches, and the tips of
> > -	these tracking branches are merged.
> > +	these tracking branches are merged. Defaults to true.
> 
> That's definititely an improvement.
> 
> Will queue.
> 
> By the way, is the convoluted description around remote-tracking
> branches still understandable to those who often work on a branch
> forked from another local branch, or would readers be helped if we
> had a two separate descriptions (one forking from remote and the
> other forking locally)?

I don't think there's any fundamental difference between origin/master,
and master. In both cases setting upstream to that simply means "I want
`git rebase` to use this by default".

There is a separate question of where you should fetch from when
upstream is 'master' but that's another topic.


What does require explanation is the triangular workflow. Separating
descriptions for a triangular worflow, and a two-way workflow might make
sense.

-- 
Felipe Contreras
