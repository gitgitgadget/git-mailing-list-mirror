Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D8C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007AE2075A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 20:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="swt7XFRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHGU7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 16:59:43 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C5BC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 13:59:43 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mu14so2442968pjb.7
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/L/gKnvNdcJDGovSqvLK2X9lj/arD1co+GSD6hRXubU=;
        b=swt7XFRaGwcmTCzuEA4Iu0zXpWO+kmIE7zGSKKLN0nEvxda9L9QEtPl7MklMSRbm9w
         EpsGuqxNulD3cBS9DjQe8oB95sy5/cbBtEr7XZrTc5Ept15Vdosev/vsZfGKe790b6Rk
         jOcWNTg7wD8SlIucuUfZ01vpW9sFrPAeTX4SGHSYUf1ct6MivNW9Phf0uoktlJElT41p
         EDTBtkly4cDl4SUEL7Pc7ap50iL0uILTMzbMXzCwmWQW2ZlFs0cvoAQxjot134+h+0/v
         xWy3fSvXX3Q/1MZjnoVyogUpBSpNjT1y4eN+QgZHxLW8gRE0HB9HMqX81MHP9qFh5ssC
         h3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/L/gKnvNdcJDGovSqvLK2X9lj/arD1co+GSD6hRXubU=;
        b=PEoDm0XwhImYKyK39QSW+dFvVWM+mzPoG+zQ18WEVVn3WrApSrWmy7Xg4gQVHXsoJH
         AtBu498ql2iFdwVgTByfUwcL6SKIiBmgIjTBbL5qcDv/sKlJA4zCKwEuIAKCBpSaeVnc
         landVYDlXDnzHAW9LVfgcDc/W4Gy3eiVUgWxmcTOIvr2g1dLxR9bd5MUsAa4mxCxKvWF
         ohoF7riBRuIm1LGNFn/gksvnPqBdIs0Fw+jPadvLH0RceFz4s0ON0BHtK1Ss9b19QF6I
         y37GtwPbyATdSZdyIWIVhdKtU31os9MGxAQ3bSWr+T1A7rOfkGjufpFxTAeAAX3oTRsb
         ++5A==
X-Gm-Message-State: AOAM5318kEuUTc9xxD5QFRrGD6PifrvZbyiemiCw2RD8xvUOnLGn7Xkb
        bgMyVK85f9YLy+Hina+WMcAE/iSAIdqw+bRj9sPb
X-Google-Smtp-Source: ABdhPJwXSPu37kZgHR2Y0ReFH5nYxXc3/iVbLCOX1zUEcZebTrQL1//XhJLsYAbssXHyL49mpmA0qy5VbelwtTkeGyv/
X-Received: by 2002:a17:90a:e990:: with SMTP id v16mr15726012pjy.194.1596833982718;
 Fri, 07 Aug 2020 13:59:42 -0700 (PDT)
Date:   Fri,  7 Aug 2020 13:59:40 -0700
In-Reply-To: <xmqqpn84n3pi.fsf@gitster.c.googlers.com>
Message-Id: <20200807205940.2734236-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqpn84n3pi.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: Re: [RFC PATCH 2/7] fetch-pack: allow NULL negotiator->known_common
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Hmph, both the default and the skipping negotiator seem to put NULL
> > in known_common and add_tip when its next() method is called.  Also
> > they clear known_common to NULL after add_tip is called even once.
> >
> > So, how have we survived so far without this patch to "allow this
> > (i.e.  known_common method to be NULL)"?  Is there something that
> > makes sure a negotiator never gets called from this function after
> > its .next or .add_tip method is called?

[snip]

> > Is the untold assumption that mark_complete_and_common_ref() will
> > never be called after either mark_tips() or find_common() have been
> > called?
> 
> Shot in the dark.  Perhaps clearing of .add_tip and .known_common in
> the .next method was done to catch a wrong calling sequence where
> mark_complete_and_common_ref() gets called after mark_tips() and/or
> find_common() have by forcing the code to segfault?

Ah...yes, if I remember correctly, that was my original intention when I
set them to NULL.

> If so, this
> patch removes the safety and we may want to add an equivalent safety
> logic.  Perhaps by adding a state field in the negotiator instance
> to record that mark_tips() and/or find_common() have been used and
> call a BUG() if mark_complete_and_common_ref() gets called after that,
> if enforcing such an invariant was the original reason why these
> fields were cleared.

Sounds good. As I said in my reply to your query on patch 1, we might
not need to set NULL anymore, but if we do, I'll do this.
