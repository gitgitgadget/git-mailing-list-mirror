Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA1C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC4F61457
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFOLBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 07:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhFOLBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 07:01:09 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7388C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:59:04 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso13841958otu.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ZwstatdYx3++JSyTjKAqA0Je/OOXv+YXV0HOCfOsN90=;
        b=ZpvZNJ+expjlOfJsDp5fSyxSX8MgLrCE1KQc98KD/ixu3G+WfpOewy9g55MMkZOgL+
         z4Apl30NeEOpLMkdVsBeEqgwr7oITp60o73xG8PyTroY57dNLJmwAdvWP8IgBAbA+wr7
         09vzzjymoaLnU4/hKNB4P0Q0jElQW9/MUrizfKbgalUW2p8Wt3GA7SSuYM4JEdEa4AOO
         +hJoeYwbDigexTkrfW0beiG5UlOGRD5oNAn3z4EyXDNEw2t/jdvgbKqrBfb/kw4XAaLd
         rK5cGBpJqVKl8jufyp4Yo7BLjU2MKPbi8sVtCMJyNqWZCZpngpYAGXLMcEbyrObJE5vA
         J1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ZwstatdYx3++JSyTjKAqA0Je/OOXv+YXV0HOCfOsN90=;
        b=rOzrnyVbOptKSxRgeyzXwGJPmH2WPjaNTEermGvTJOI6MzEhljN77dMdN/Yx9F9S8a
         +tG5n2iwtxUagBE5fm640qPGTl9mRwsw7RAfHNE75cgkPGI11A3XLffLHoYKiIWm2Qor
         S5qjHCJmtOXREM5dXV42w3CBy76CtArfExOs/AqDY8PJcqNpS5+ACwFaEmenYuuMXB5C
         KbDbLhW2JuPlUzXS3PxL0ObESyvS6yCZMf380ZGJAiPjlHK6nq1Y27fmBAb6rhJFpmbJ
         0XKWN9q5cENp9TCbQ8mQeuOFeiVRdbLZqDVxPvKk8qNqBGFuag3dRsShDA9j0+tg4Ctb
         4XWQ==
X-Gm-Message-State: AOAM532JDPXc38Jlwbqwi2+a/ZUapsecm8kM+AHTFpFzTa+6IssUvyN7
        qw1P2tHiKkn65VDq5WQLmAw=
X-Google-Smtp-Source: ABdhPJzAPfZ/FqTZpvG4mzhO+joenoBnsZJdooB9u6gpgyL1wdM2VJQfMYu68VrFyZgEyKGK/+d3KA==
X-Received: by 2002:a9d:945:: with SMTP id 63mr17620930otp.47.1623754744135;
        Tue, 15 Jun 2021 03:59:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z4sm4070994otq.48.2021.06.15.03.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:59:03 -0700 (PDT)
Date:   Tue, 15 Jun 2021 05:59:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60c887f678c88_e63320846@natae.notmuch>
In-Reply-To: <CABPp-BGstXDbzxpySw7q_jn22HD05MsrZeHNv+kXFHOFS2_WCQ@mail.gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <20210613045949.255090-2-felipe.contreras@gmail.com>
 <CABPp-BGstXDbzxpySw7q_jn22HD05MsrZeHNv+kXFHOFS2_WCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pull: cleanup autostash check
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Currently "git pull --rebase" takes a shortcut in the case a
> > fast-forward merge is possible; run_merge() is called with --ff-only.
> >
> > However, "git merge" didn't have an --autostash option, so, when "git
> > pull --rebase --autostash" was called *and* the fast-forward merge
> > shortcut was taken, then the pull failed.
> >
> > This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
> > works in dirty repo, 2017-06-01) by simply skipping the fast-forward
> > merge shortcut.
> >
> > Later on "git merge" learned the --autostash option [a03b55530a
> > (merge: teach --autostash option, 2020-04-07)], and so did "git pull"
> > [d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].
> >
> > Therefore it's not necessary to skip the fast-forward merge shortcut
> > anymore when called with --rebase --autostash.
> >
> > Let's always take the fast-forward merge shortcut by essentially
> > reverting f15e7cf5cc.
> >
> > Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> I think you are basing the Reviewed-by on
> https://lore.kernel.org/git/CABPp-BEsQWsHMAmwc3gmJnXcS+aR-FtoMJxBRQ=BpARP49-L-Q@mail.gmail.com/;
> is that correct?

No, more like:

[1] https://lore.kernel.org/git/20201205195313.1557473-5-felipe.contreras@gmail.com/

> Messages from folks that they seem to like the patch
> or believe it looks good should be translated into an Acked-by rather
> than a Reviewed-by; from Documentation/SubmittingPatches:

To me an acknowledgment means something entirely different, and must be
expressly given.

> * `Reviewed-by:`, unlike the other tags, can only be offered by the
>   reviewer and means that she is completely satisfied that the patch
>   is ready for application.  It is usually offered only after a
>   detailed review.

Yeah, I read that after I sent v3. In this series I simply cherry-picked
it from a previous series.

I guess I'll just avoid both.

-- 
Felipe Contreras
