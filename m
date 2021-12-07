Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbhLGR4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbhLGR4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:56:35 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22449C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:53:05 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q2-20020a056a00084200b004a2582fcec1so9420pfk.15
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=uhyBNdtYpP/pGEqZfixXkqV2yt330B+rKxMNY7AJP6c=;
        b=BlOobWV9onrVwE6PxPU7uQ0QdXWCoTaFrxMG8juY+itpEDoEdB0csoNV8oZ24ZoTp5
         74lFf6Gs857ORpjdUxxL/zwtWUJjp3LxIP2y82SpuBiR4EIDWJqw5pjJMeTDblVnsr7m
         Ov5PhFZXjfUrg+f9rQ7VSIXXwZdJvphEKn53zsNh81ZadDIGdvY2Uklp5avtIDdpAszN
         qN6RKF7mK7S4FlZ8C5dTPSNIOs4/my3jWL4nM0UoMLnFnzUQ+4x+F6omREYQA7cUaE1g
         2Ke+SacRMH9C4ODY5Au2Vodvj/nw3vtH9jPAPp8YGHNKKjH3chfhS3J6hjeF32Nc/2tn
         Hz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=uhyBNdtYpP/pGEqZfixXkqV2yt330B+rKxMNY7AJP6c=;
        b=FAlHQg5zIfoc8aYBp+SLSIMsx7m4fj0z0CQf9xsdddxfVDknLVxkxWL/419WpFE05v
         ni6XrGsqdxUivVMfFddncy5Emnwno1ach1wnBd3NJntk10fHlO0DrMXB2ZDRSMuvTyK/
         0fH8SlyczxhIc485G4NJg0gAc2tU2hJ3BaDr/KBsvkztJKHIrIw6qm8fUQqYzgt/ypE3
         RuG3pOwcn5T+ngcfTX6oRleN5i2mJf4Ov4M83k2boK2RpxEiNPejvXlcBmAgsuvIoAxS
         0mZwaOvD+rLdiwr8qaQcrwKxZHy/KQ6DWYKyEY4zD2MEnHi42PjusKBMdvmQR0WiBB0Y
         EWgg==
X-Gm-Message-State: AOAM5324xnlVSXzuLI5d3jUqPUpRfx2LfBPtMdOP7zBDuV0x5n/zqQD4
        3ZWSeZKqVB3OcITIKxT0q/gfbTMvlAVWW9WmFGxc
X-Google-Smtp-Source: ABdhPJyAZtKtmWO1K1k23npxdGA+wCEbUPnJpuI5gCzFlu9FR4pwMnmUuRE+SRI0z1m9wodlLKfZVsr/VxkJNKaW06q3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:1105:b0:143:a593:dc6e with
 SMTP id n5-20020a170903110500b00143a593dc6emr53001556plh.6.1638899584515;
 Tue, 07 Dec 2021 09:53:04 -0800 (PST)
Date:   Tue,  7 Dec 2021 09:53:02 -0800
In-Reply-To: <kl6lmtldcqjq.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20211207175302.1119160-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6lmtldcqjq.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: Re: [PATCH v5 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> A reader of this description doesn't have any reason to think that
> `hasconfig:remote.*.url` wouldn't respect in-place semantics, so my
> concern in [1] is addressed.
>=20
> `hasconfig:foo.*.bar` seems reasonable from a forwards-compatibility
> perspective. Ideally, it would be nice to see a generic implementation
> that actually handles config values beyond `remote.*.url`, but unless we
> take a closer look at all config values and the conditions we would like
> to support, a generic implementation seems like a premature
> optimization that won't age well.
>=20
> So OK to having a forward-compatible name without a forward compatible
> implementation.

Thanks for taking a look at this.

> Nit: I have a preference for =C3=86var's version [2], which looks more
> consistent with the rest of the function i.e. handling the match using a
> helper function.

I agree - I'll use it.
