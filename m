Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03549C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6023613F8
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhD2A3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239775AbhD2A3h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:29:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1337C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:28:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id z7so12633901oix.9
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wGl6htKOM3MXmgPkO9LXYw+UbxSXOEuDwcQirwe8Bu4=;
        b=egbe1kHzd/QfATjwCf8RtPRDgjSeVoLmeg8aaAWAYqtfQDzAeSJScD5QK1YSChb38j
         gHKWI+RCOBwjM7iVCnWxKCE4x06JEqJkiqYwPh4d3NrD8PlBGHc++zqlnI0SwTYSfWkk
         xqIEl7z87ACP3xiwYNbcEiN+ltK4JTJkacf8ZWjXVLFs1wRBQH4DnHHs3OgsBc4c+VrG
         Z/kVnX4T6MH0iedTPpdJ72bw9rfxZa5VcovRM9II3VCDYABUduk0HA9TFQC7tCou/gS+
         E3g2LZSYHUR8YcFkEO2TZqeLxrqTojQOkZYEwjBULy24qxUJf8yqrN9jKnV9ZxtCkDD5
         flhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wGl6htKOM3MXmgPkO9LXYw+UbxSXOEuDwcQirwe8Bu4=;
        b=t5VoHXZosrDGaaD7WWOV1MDzUprqlD11ZUAuCNRVFtXdeVADB+SxMl3RDbJ6RyzIFJ
         TSN94KwoWHrD/cqX9oEAfN8dwP1oUkX2RaMnXFrChnj39gdDURBM2gubCgV85DcyRXPP
         EIWNDqFzqRQYOJsvhbDTmIx0zzJsn71Pva5xJAIjh8Z2L2i2v8QFsSATc3lkrvKf0Wcm
         182xnqZ88VWcwFCmxulSGJBVhnuPwx+UeETcQb9ya3PO7qV1ikjY5RsPEDcL6kzrtlq7
         sRV2ezJO0VtRQUq8Vsr4a8J+U32uuP6OXnK4xVeZ1ecslXTUU2xZ/OYQ2Yefzg5BxNuq
         6f0A==
X-Gm-Message-State: AOAM532DIhBMVQF98dIi8t5CxWaUwZ6mNELVNkp3UcReyoAeAEdYbNr3
        /EPt9uidA6a8zerzfsIiwtE=
X-Google-Smtp-Source: ABdhPJzRpvfpN6ruv9b51oFo1dKDCgGSOJ9EqidlMRUJ5PYI878EMyK/qyB/ScITt1fnVoTDaBhJbA==
X-Received: by 2002:aca:30d7:: with SMTP id w206mr5678017oiw.163.1619656131396;
        Wed, 28 Apr 2021 17:28:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id m127sm335674oib.32.2021.04.28.17.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:28:50 -0700 (PDT)
Date:   Wed, 28 Apr 2021 19:28:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?QW50b2luZSBCZWF1cHLDqQ==?= <anarcat@debian.org>,
        git@vger.kernel.org
Message-ID: <6089fdc1bfc0f_a9ef2081e@natae.notmuch>
In-Reply-To: <YIRiSJDem/JaBHuN@camp.crustytoothpaste.net>
References: <87mttofs5t.fsf@angela.anarc.at>
 <60836fa129078_ff602089c@natae.notmuch>
 <87k0osfpt8.fsf@angela.anarc.at>
 <60839422353fc_10cb9208c7@natae.notmuch>
 <YIRiSJDem/JaBHuN@camp.crustytoothpaste.net>
Subject: Re: how to rename remote branches, the long way
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-04-24 at 03:44:34, Felipe Contreras wrote:
> > I see.
> > 
> > That makes me think we might want a converter that translates
> > (local)main -> (remote)master, and (remote)master -> (local)mail
> > everywhere, so if your eyes have trouble seeing one, you can configure
> > git to simply see the other... Without bothering the rest of the word.
> > 
> > I'll give that idea a try.
> 
> I don't believe this is a helpful response, and judging from the
> follow-up, neither did the OP.

That's fine, you don't need to find it useful.

> They're not trying to do anything dangerous, improvident, or harmful
> to others and they are trying to solve a problem that many people have
> and that is due to an inherent limitation in Git (its inability to
> rename remote branches easily[0]), so there's no reason to respond in
> this way.

What is "in this way"? Proposing another solution more people (including
me) might find simpler, and more viable?

> There is a difference between being firm and steadfast, such as when
> responding to someone who repeatedly advocates an inadvisable technical
> approach, and being rude and sarcastic, especially to someone who is
> genuinely trying to improve things, and I think this crosses the line.

I wasn't rude. You are free to disagree.

> [0] Regardless of how you feel about this _particular_ rename, one would
> want the ability to do this to preserve reflogs for _all_ remote
> renames, and so this would be a valuable and desirable feature to have
> in Git anyway.

I never claimed otherwise.

It's perfectly fine for two people to work on two approaches to solve
the same problem.

Cheers.

-- 
Felipe Contreras
