Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC876C001DC
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 17:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjG0RjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjG0RjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 13:39:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE3DD9
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:39:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d20d99c03fbso1051296276.3
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690479548; x=1691084348;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMvvdKIYbQaqwvlfm48yAZslSGZM8Hz30vKtN3co2nQ=;
        b=hixBEyS+/BBYUN4x4guiYw0lfdMYa6aOCAkkleWvR5YWicRt2evHipg/YuVvUR9rZB
         4nrAjCFKo+o42AtR30zfv/Ka2WWpkS+BJCr2zuwTosJNMRWam+dUDXujjKROG99hGu2E
         F/lPM0iNrZye/8d88Mw/CSAa4kVhwJPUlLWizNyWPJ3QvTSAxG1AlMaCFcLr1fIyH8I3
         jgcdEh4cnubCGHLYPGO3y7TkMln7B9NYXW0FTtoQHHD5B663tkB4U98cif1hf6OW/iNO
         sUAgeuHhZltgLEHcDAg12NARsC4JTx0PwmJ0qNEweeL6Ek06UWZZqcmJUBourQegryyK
         xEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690479548; x=1691084348;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMvvdKIYbQaqwvlfm48yAZslSGZM8Hz30vKtN3co2nQ=;
        b=UljKDZ33dFfvvjautQ+TAKA4eB7v1l4PWtRXrpeibSanNV5yE7GxTLFR5izeHgRGLt
         fYvAL34a1HcWeNRNKFL06atuMlrB8jexn/+JAUcs7CKK9DaeDnitVZ3LvUEh9AisVN0J
         naAwTnzCPrHvliNJjMpqZSGJH5JvGraxx+7e66aQLvgvCbZCqt83+4g78ki/npJydr2u
         bLYMfp4sntR0qL6KCpHWN0/6c9MITq/l4PnvqOd3EtKgc+oWZZgbKEzjhR6wx6ilV4VG
         kTVdzw/tOAKa50qZhC3FRpBYtNzTxZ1CUPk2Y7AB3iWXnnevrvYyVz8oaiCK4uUOXvqt
         WL0g==
X-Gm-Message-State: ABy/qLZo6Q38SVYR/kftUKoxPVCEOBqfnHA3D9babSSU5SJShEvLtm/g
        uE1Np9mDn6kXf4cdG2L+qxqMkWi+33B238Bqd9+E
X-Google-Smtp-Source: APBJJlHdR842vIFr27pHCDsvS8k7UIr3cxGBMdO3YfWlTdzloI/vMtB31eYGvU8638Q/OcboWzaIWO2eiiXgFS1VcZ8p
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:75fe:2dd0:bffd:cf43])
 (user=jonathantanmy job=sendgmr) by 2002:a25:ad8a:0:b0:d15:fc00:fc69 with
 SMTP id z10-20020a25ad8a000000b00d15fc00fc69mr405ybi.9.1690479547775; Thu, 27
 Jul 2023 10:39:07 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:39:05 -0700
In-Reply-To: <xmqqzg3ib2ma.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727173905.356292-1-jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Taylor Blau <me@ttaylorr.com> writes:
> > Suppose that we have an existing commit-graph with v1 Bloom filters. If
> > we then try to rewrite that commit-graph using v2 Bloom filters, we
> > *should* attempt to recompute the filter from scratch. But AFAICT, that
> > isn't what happens.
> > ...
> > If I'm parsing this all correctly, Git used the v1 filter corresponding
> > to that commit, and did not recompute a new one.
> >
> > I think that this could lead to incorrect results if you use this to
> > masquerade a v1 Bloom filter as a v2 one.
> 
> That indeed is very bad.  How hard it would be to construct a test
> case that fails if filter computed as v1 is marketed as v2?  A test
> may be far easier to construct if it does not have to be end-to-end
> (e.g. instrument the codepath you followed through with the debugger
> with trace2 annotations and see the control takes the right branches
> by reading the log).

Ah, thanks, Taylor, for so meticulously investigating this. I'll take a look.

A test should be doable - we already have tests (the ones that use
"get_first_changed_path_filter") that check the bytes of the filter
generated, so we should be able to write a test that writes one version,
writes the other, then checks the bytes.

> > So I think we want to be more careful about when we load the existing
> > Bloom data or not. I think we probably want to load it in all cases, but
> > only read it when we have compatible Bloom settings. That should stop us
> > from exhibiting this kind of bug, but it also gives us a handle on
> > existing Bloom data if we wanted to copy forward existing results where
> > we can.

The intention in the current patch set was to not load it at all when we
have incompatible Bloom settings because it appeared quite troublesome
to notate which Bloom filter in memory is of which version. If we want
to copy forward existing results, we can change that, but I don't know
whether it's worth doing that (and if we think it's worth doing, this
should probably go in another patch set).

> > If all of this tracks, I think that there is a gap in our test coverage
> > that didn't catch this earlier.
> 
> Yeah, thanks for raising a concern.
> 
> Jonathan?

I'll take a look. Yes this does seem like a gap in test coverage -
I thought the existing test that checks that Bloom filters are not
used when a different version is requested would be sufficient, but
apparently that's not the case.
