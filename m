Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB72C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F54B60E8F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGWRtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGWRtH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:49:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC08C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:29:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u10so2799459oiw.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AMx+7zbsCUFPdl4Oz1DEIRqEkyDsyEropaeLBkmloSQ=;
        b=c3wBXm0HZbXIvS5QHGIJmJyDMw7dQavl/2CZDrMdFc1SzzyoPK8UoFA2UU7Ati5Q2e
         T3l9ATrbLJ47Zc1sMRbOtQR9dGAKNuCys/aPiPEqsoozmrOyu9CIChCBHaqRZA7ACQxC
         rajI7/PDeTBX8RNonIsE1T08BNP1g8e+svFhFZH8skaAdp0xkRwunm8b5SKLzhdKFs5T
         R56F0TxA0zXaJQbi5Pm+wn1SAFJ8k9Cz//O8zyNh+KqUKM/yKyFAMynHTcPSpctnzBH5
         3hvcYEPPkUJnnIEvOpE7b9EK6S/Zdvd79PSC3u45FGtHDwMX7lRS9IrnsGQ4b4xUFws8
         FB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AMx+7zbsCUFPdl4Oz1DEIRqEkyDsyEropaeLBkmloSQ=;
        b=sO77hU4ivBRj4yngDTetys6yxQvONVGj6Det03VvxNmfkIdwIsJTw8vVF475PgJ/U5
         KePUHuGEqggE832Bt9fQjNzaR4j6sne8y0nhiJ5phjPKoBl8SEJFeZY459MMjhJLWbf/
         35RBtR2euWiodXVJvVOtca94mzVmrKFu8GuZL29z019c4NtPjmop0MiJliFWDRWhAaAv
         LCYqrz0pNH12zUYrMZdQzmPm8Zuz86LlkWuW3Fqs28s/8HJ9+paylwvlGniRmRgH9NS0
         //qRc6EhgDp74TNPgctAuq5QK4kg5gOq2uvYA/PBcvs9E50fgjSLtdiXylataR+S/6vn
         HGew==
X-Gm-Message-State: AOAM533YzfI1oms1MpFyr45ropHBkw7ddVZW0fRvWi/bDllHn8kU0Xel
        0GHV0aDscY0zAGlkOg6qwlY=
X-Google-Smtp-Source: ABdhPJx84Ec5NGkJXd/g3LbMmD8jlEUEon53z5Jsr8ewUsw66PBwE+uZPPWH1BrO4uoOHI6lMyVqvA==
X-Received: by 2002:a05:6808:8d2:: with SMTP id k18mr3934245oij.176.1627064979156;
        Fri, 23 Jul 2021 11:29:39 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c21sm2185011oiw.16.2021.07.23.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 11:29:38 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:29:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60fb0a916c9cc_defb208eb@natae.notmuch>
In-Reply-To: <xmqqwnphowdx.fsf@gitster.g>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
 <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
 <xmqqwnphowdx.fsf@gitster.g>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So I feel compelled to say now that I do not think that changing the
> > order of parents for "git pull" is the obviously correct thing to do.
> > And likewise, in the one thread I do remember participating in, I
> > expressed something similar:
> >
> >   https://lore.kernel.org/git/20140502214817.GA10801@sigill.intra.peff.net/
> 
> Thanks for the link.  Many articles in the thread are repeating the
> same opinion over and over (and later even descend into ad-hominem
> attacks) and it is not worth anybody's time to read all of them, but
> I found that there still were some gems.
> 
> In an worldview where the first-parent chain is the trunk history,
> merging in the upstream where you push back to into your working
> repository where your new work is happening as the second parent
> before pushing it back would obviously make the history that used to
> be trunk to lose the first-parent-ness at that point.  And if you
> ask if I just said is correct, everybody would say it is.  So there
> is a concensus that the result of "git pull upstream main" becomes
> a wrong shape for people in one workflow.
> 
> But that does not necessarily mean swapping the parent order would
> produce the history of a right shape, either, even for those with
> the "first-parent chain is the trunk" worldview.

Why not? Everyone who saw a problem agreed it would.

Reversing the order of the parents creates a merge commit like so:

  Y---X-+
         \
  B---A---M  trunk

Most git experts work with topic branches, and when you do that, you get
the same thing:

    topic
      |
      v
  Y---X-+
         \
  B---A---M  master

If you merge topic to master, the first parent of the merge commit is A.

If you do `git pull --reverse-parents` on a trunk-based workflow as
above, you would get exactly the same shape of the history.

How is it not the right shape?

-- 
Felipe Contreras
