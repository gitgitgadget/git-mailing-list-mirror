Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E2C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0B522C9F
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL3TIsd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHGVIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:08:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE0C061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 14:08:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so1687582lfp.7
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uAnsYdalw2gp4r+hQpagHth85MExTKxDuHdAarANdzA=;
        b=AL3TIsd2PrUxZd4tHLW7MjEBN7co8zsV4QK8axpDfaN6utDOWUCCGIzutcVOtg4s8G
         eqcsMdWY845Drtp195Gw+wPeW0M9PpFCtzORhE8GmgbXTL5OO/tIt7VQRH2KTOvravot
         muh+wc8qK4e2rUM7aQiRLU9tIOLWadv29pYnzq8UMNVHSGjj9bC6cQZWyBv0mGwf+Fq/
         MFgOIJIAPBiC+qhjKRibuByRis1O9PvL785IF96hH1HBzU77mLJAHa8Pwi+8SCg6I4cL
         EPEmsEKAb9ewJcvRP57DBqeVWhRtqqijy56JeTxJvhl7hgyerb8F+xQdINlU+SjLqds4
         2bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=uAnsYdalw2gp4r+hQpagHth85MExTKxDuHdAarANdzA=;
        b=Q3G95Xt24fWYLNTiAbzuZcIqKpCe69LwcIgbJv0gU7Vv0PO3al4Y0NeZUUQJZ75+t7
         VmerUktB6ErI7LahJWX/q0IjB3lihaJ4gkP4p+eHQJ9BR6pArPdwOAGncitsSUrzW0Ko
         P0f4HdJY/JWIDJ5LuR4kUEIR1efP7bI1VJuL+dx3MOC+LNKdnVQ76/4urNKbmZCzecLw
         9wJyXysVTvfwVj2iB1IBISCvkMcNkwT2QRV0LMdMlx+7zJ8ELXV54YjNad9ZDd8bc11H
         CAT3En+90rUxrrua4nH0DNE/S4xtjq2S1zMa/HpVZKx5KpIuPZlgJfqIu7uqV5x5ip6j
         ++vA==
X-Gm-Message-State: AOAM532frhkHa2Os/Cqd8RjB5sdpfgnmD8yu8u43MW4Qw2yDmCJ4xUsF
        KnyvYWhDIFX93OE0uslandE=
X-Google-Smtp-Source: ABdhPJzMJ+TnCHymWDAXYdlGtd2gSaJX2Qfx2yqIwHfsjywDw3hEVx8++H8Wm/J+tC5Byp3oQ5Zovw==
X-Received: by 2002:a19:c7d7:: with SMTP id x206mr7115897lff.67.1596834526638;
        Fri, 07 Aug 2020 14:08:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x4sm4239527ljd.34.2020.08.07.14.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 14:08:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <xmqq8seqgrx3.fsf@gitster.c.googlers.com> <87a6z6kxmm.fsf@osv.gnss.ru>
        <xmqqv9hufaxc.fsf@gitster.c.googlers.com>
Date:   Sat, 08 Aug 2020 00:08:44 +0300
In-Reply-To: <xmqqv9hufaxc.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Aug 2020 13:39:11 -0700")
Message-ID: <87y2mqjh9f.fsf@osv.gnss.ru>
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
>> I had no intention to introduce --diff-parents, at least for now, and
>> maybe never. What I said about it was theoretical discussion rather than
>> actual proposal.
>>
>> If we agree on the above, I intended to instead propose something like:
>>
>> --diff-merges=first-parent or just =first
>
> OK, so the combined, combined-dense and split were meant to work
> with all the parents, and off is the only one that means comparison
> with no parents.  That makes sense.

Yeah, exactly, thanks!

The only question regarding it I then have for now is what are
preferences for names selection inside single option? Abbreviated yet
somewhat sensible, or verbose? I mean:

--diff-merges=first vs --diff-merges=first-parent

--diff-merges=comb vs --diff-merges=combined

etc. What's better?

Thanks,
-- Sergey
