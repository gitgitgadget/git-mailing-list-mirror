Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65EC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC9D6104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhHKUTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKUTM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:19:12 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4A8C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 13:18:48 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so4853752otu.5
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=YHNM9BiWKvTJXbPsf7w+z768B8YSMPFRWfV1nhoVm7s=;
        b=JHlU8kdBdi6d9mNcM0FZCpxXMLbfEoSqW/fTzT3GsHijubshOefF190I43PPV3Fnch
         wwsgS60NqNzkVhCoQUMKFVrCLMGV8tNrO5kxu1KA1MxQHcxo4j5nlj5x0C95b09xONDo
         V9vPHqDqol/lJXCJfu61SQxCuhRwL+hdPKHCayKLMDNT5hW0g5naH+slbq09tocYtoe7
         OVSGrTxW3pglSC3KT2ab2jRBs4/RQf+fX5krWRAhwEmx5eBhdQeCTUWceZEKdP0u3O+c
         Fq7JWHOwkBVqVNg0ugbQia/JZzcwNwDo0SffTOHxCwp8AboUO003+LIfD0Lfy0m1vyQ9
         DzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=YHNM9BiWKvTJXbPsf7w+z768B8YSMPFRWfV1nhoVm7s=;
        b=Yykjjt3Oi/GCB0g43fYeKgtcjfgcdMvsnCoo24XyfUh4FO2a2w9R4roZUOlUy9WWqk
         o3+LSzAoGA/q/ySBPkHiOuJiUZ9G17Cg8oeD/bURp6UfxoJr5SLzpoXFL62jOJl/GEKB
         DUa2h4Ni5sYi1ip9zs+b9hr7fvDSl/d172X4jqt377gBSkh0GhUc/Y69mA2fXSZpUmT2
         6hYO6kLNSe6McJXt4d/pX6spOiREnwXky1/DRYfth48pIbZsnFA70LfPr2KqdY2lz10L
         fMsNtk28+EdzcNWGGrFc0JTekT3fcmBK6Uml0xac1NMyVzyUMy7HLlulHqatm2zr7aVt
         tfDQ==
X-Gm-Message-State: AOAM530YyFug3XGP+02+5Vh32ueXggwlJeG9qlrPc7rQqkS3MU7dfuhM
        gqzpX4fU1pZ6glXylo68nv8=
X-Google-Smtp-Source: ABdhPJx/uttG8A+JARD3EjZX6pTBSaq76HEOq0wc4vgEN8YfgCdeHxxLDbt5FtrZ+z9jRul5LK0zNw==
X-Received: by 2002:a9d:704e:: with SMTP id x14mr553369otj.293.1628713127368;
        Wed, 11 Aug 2021 13:18:47 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id h187sm68890oif.48.2021.08.11.13.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 13:18:46 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:18:45 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
Message-ID: <611430a5b83e1_19f82083b@natae.notmuch>
In-Reply-To: <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, Aug 11, 2021 at 09:00:18AM -0700, Junio C Hamano wrote:
> 
> > A more notable aspect of the above list is not the similarity but
> > difference from the rest of Git.  The above organizes various
> > operations on the staging area in a single command as its operating
> > modes, so you'd use "git stage --diff" for comparing with the
> > staging area but use something else ("git commit --diff HEAD"???).
> > 
> > It is a good example that illustrates that the proposed organization
> > may not help learning or using the system for operations that also
> > apply to other things like commit and working tree (in other words,
> > "git stage --grep" may not be such a good idea for the same reason
> > as "git stage --diff").  But if it were limited to operations that
> > apply only to the index (e.g. "git add" and "git rm"), it may be an
> > improvement (I think we added "git stage" synonym exactly for that
> > reason, already).
> 
> One thing I find off-putting about "git stage --diff" is that to me,
> "stage" reads as a verb. So it is like "git add --diff", which seems
> out-of-place; there are two verbs in a row.
> 
> I do not mind the term "staging area", but using "the stage" as a noun
> is simply confusing to me in this context.

OK, but "stage" can be a noun.

Here is one of the definitions:

  : a center of attention or scene of action

This definition doesn't imply what the action is about, but
"commit stage" should be perfectly aligned with that definition.

Here's another one:

  : one of two or more sections of a rocket that have their own fuel and engine

These rocket stages need to be prepared before the launch, just like
changes before a commit. A commit can be thought of as a single-stage
rocket, and just like parts can be added and removed from this
single-stage before launch, so can changes before a commit.

I understand why this might not seem natural to native English speakers,
but it's perfectly aligned with the etymology of the word "stage"
(to stay).

I'm not saying it should be thought of this way, merely that it *can*.


Either way, I also thought about adding yet another command
`git staging-area` and diff instead of an option be a subcommand:
`git staging-area diff`, but to be frank I don't think anybody would end
up using this command, especially without default aliases (like
`git sa`). So I opted against it.

Even though `git stage --diff` is not ideal, it's the least bad option
in my option.

-- 
Felipe Contreras
