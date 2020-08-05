Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B9C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D6922B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7fcF4za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHEU1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHEU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:27:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2FC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 13:27:46 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so24283233lfp.7
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HOGzHpKMm05ce8jario53d5xhoMDX+3u7tGxdH7HWI0=;
        b=Q7fcF4zam0JPVq0/RtLJKygP+0D9/sF95ZhPlzSgJBoJytZB/Wvp2R78Eu1AtaPEtm
         jFclGjxFrSsJ+leep4UwB1k+4ubIbimMDfVw3KPOsSIc7+D/jRp3o96HTzAcQWiENqgf
         S49ZMCmakusBYSz+I6zNnBvMAKsvCI8VFONbm29H54F158ZVPst09jSQ72CUrw37viho
         IVyIgWlHALwYArwtb6bpqHIvc7Fu6vS+piKrYbaHBEHOEXA9lzYjZNcaqHsclrPoL7wG
         9bPzl5o4jRFtIDnxf/wTcPrnfNZnWa70sfPliWZ462uY5dAjRM3xr6LmSv1F6m2uHCxh
         vxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HOGzHpKMm05ce8jario53d5xhoMDX+3u7tGxdH7HWI0=;
        b=no5nMA2Q/wPAAx2YIf5Z9KAFjTbtC+JvdIUkS2J4xHBGOuXQ1QM/bOTVX8Vk0YuB5J
         S23fdRnQvJg9bcRmYe2Uw0Ze7W1KTRlUWGEOVd36+J8eHsruboM9yf06aCwrZ581pxB1
         tY9axE2CniHsltgE5qwQQrpOB+A0ZxjEKy9h9s/BVvZ02fZbdSCwvptNaSlSESGEa4wc
         BWz+6rAvVaCJW70mJeMdbf6RhgqtniChm08FKpUQWzddYpbM5RAWUaJhcp1nk9bcpK2W
         CMIAra4ISKBvvg0mY2VuftCXA05AZSTSZ7QB+hTqMR2nSclTcDqnAuxZkVJLwhYPdLYS
         rLBA==
X-Gm-Message-State: AOAM533HKJy1WKiWV3afOAZquN/Qt4p5gEtabasUb0K0YTsa8J2voL2a
        /53+am2TU/pLnl3BL2XrTDip8r+9
X-Google-Smtp-Source: ABdhPJyOjNQIFt9fyLvEPL1DklvfpZwL8r8gLmiorI2uK2UD1RIFdIQU+NqoTFoDyp1FX8CtXBBd1g==
X-Received: by 2002:a05:6512:312b:: with SMTP id p11mr2352742lfd.202.1596659263673;
        Wed, 05 Aug 2020 13:27:43 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r14sm1592671lfe.29.2020.08.05.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 13:27:42 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200728163617.GA2649887@coredump.intra.peff.net>
        <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <87k0ydp0hc.fsf@osv.gnss.ru> <xmqqeeoloz74.fsf@gitster.c.googlers.com>
        <87d045nfju.fsf@osv.gnss.ru> <xmqqsgd0opzd.fsf@gitster.c.googlers.com>
Date:   Wed, 05 Aug 2020 23:27:42 +0300
In-Reply-To: <xmqqsgd0opzd.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 05 Aug 2020 12:24:38 -0700")
Message-ID: <877ducltxd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Yes, we can invent the rule that implied options don't ...
>
> "invent"?  It is nothing new, isn't it?  IIRC, Peff's "first-parent
> implies 'm' but can be countermanded with --no-diff-merges" defines
> "implication" exactly that way.  I do not think that is a recent
> invention but it is just following the patterns set by other options
> that has conditional implications.
>
> IOW,
>
> 	$ git log --no-diff-merges --first-parent -p next
> 	$ git log --first-parent -p --no-diff-merges next
>
> should both mean the same thing.  The user said no patch is wanted
> for merge commits with --no-diff-merges and --first-parent does not
> affect it.

I disagree, but I drop the issue for now for the goal of making sensible
progress with --diff-merges. I'll do the patches without this
modifications of the tests.

Thanks,
-- Sergey.
