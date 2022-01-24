Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1753AC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245226AbiAXSZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbiAXSZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:25:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CFBC061401
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:25:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x1-20020a17090ab00100b001b380b8ed35so358156pjq.7
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=UQa0DPqc9ETeaI0C0ZUEyQgpSHLiGAxHO4gvIYiQejg=;
        b=NaA4Zv1uYY4RAVn28POL7/YmBP6Vsh0CS1hcDzY/JruSsnBvzQJRmw8ZD8yYQMcKLU
         ziIaX7wmOmLpAQT7CXhGJFWWjML9LlXF810RbZqpvL4OG9qBVfLifDLlX1Wn1Q7v80QM
         DwpkOEMAxbClIFhRIB1M6fDVjHnP/pTo6+k1KZSn7ZszYl4cgs1Cg38zXcc18owqtA9B
         SYtGOgx7kmIixrcEza34N08fBKSbPyWHly/aESbwAREVi5u55hu4z9dp6CgMtTyRH147
         mQewAZI+Rw9zdQSqhjWY26AYR1C5KjcX8Pdb9ZckP657fo5+MjShSFE8SKMVi8wfaDkt
         yUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=UQa0DPqc9ETeaI0C0ZUEyQgpSHLiGAxHO4gvIYiQejg=;
        b=LCqEWUlK7F5J3EmkSjMPUE8yw4PzpOS+AIhmosZfqVfgPwWRzHhkF0AQs2QC0o3S30
         +LAP2R3xxYBxqVHiOaod1m/ZvlLLh2j6idAd86Gwkgcnduw278NaOj8EOf05F/fnuwoz
         sNRYVaJNtbNzsKHBvlzJPowlZsdGsH1NynGt+DFYOEJEtCpy9JjKKNDF/Ga4VotqlAx3
         2dBSrlNBed9OW66kXiEX9uCO2OYCn1Yr+z14bv/kRPutfUkmrQDNk4umCROB7HMSIDqZ
         BXtUBYXqlcI+tzkyPaYbuuWoHXJMdIhF0p4OECxACCzoi7jdr14H5wvDilHOG0m/Sk4J
         Csjg==
X-Gm-Message-State: AOAM532ov+ckSwBFbx0Y50gDD+mHXA/+Tdki9SsmOx5k0VtSGDj2AfrH
        0tov3Yf2VQH1eeKTj/Wev0GpEttrdpOvv1Czv1wt
X-Google-Smtp-Source: ABdhPJxNF+it+hcDEoaS3tiWqpx8V+dutjRQMHkLVKj++rinT9NP74jcI2t1Czxdt/EoCJiv+UllVBYrUq+N6zvFVO6w
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8ec6:b0:14a:c625:eb2d with
 SMTP id x6-20020a1709028ec600b0014ac625eb2dmr15500005plo.26.1643048702821;
 Mon, 24 Jan 2022 10:25:02 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:25:00 -0800
In-Reply-To: <220124.86zgnlgyjr.gmgdl@evledraar.gmail.com>
Message-Id: <20220124182500.2439823-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <220124.86zgnlgyjr.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     newren@gmail.com, jonathantanmy@google.com, git@vger.kernel.org,
        gitster@pobox.com, jabolopes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> The first thing I said in this thread is "Thanks. This fix looks good to
> me.". I'd be happy to have just this fix in. This patch resolves a
> blocked of an earlier series of mine.
>=20
> The rest of the feedback here (aside from the trivial "rm -rf" fix) was
> an attempt to bridge the gap between this & my earlier look in [1].
>=20
> > And I think I'd say the same thing even if I saw your tests as being
> > much more closely related to what Jonathan was checking.
> >
> > That's my $0.02 on "why not?".  The story totally changes if you want
> > to submit these tests separate from Jonathan's series.  If that's the
> > scenario, then I fully agree with you on "it's cheap to add more test
> > coverage so why not include it?"
>=20
> Sure, or maybe he'd be interested, or not. I'd rather try to suggest
> some small proposed changes than submit a patch of my own as an initial
> approach.

If my patch is OK going in on its own, I'd rather do that, and leave
additional changes to other patch sets.
