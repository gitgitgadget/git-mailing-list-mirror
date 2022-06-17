Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991AC43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 21:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiFQVsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiFQVsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 17:48:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470AA1D0C3
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 14:48:01 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e1-20020a17090301c100b00168d7df157cso3273253plh.3
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=H623Ln4WoubLu4kxP9bDdaSAqzOIhq2q0ckkhUfO6MQ=;
        b=VqrkrB0+zzUKr5188svj3xmBl0IDum5c/YLx0XSqONvuMBFmX1PY8DgOguGPEYT0fK
         Kh4s/Q4JTOGRXONiZExVT8uWcvaYUX/NPGFVKvytesKOVEl3rHiSEYxtsNOrEvug3xa3
         aktoa3BhvgGHb3qilMd43rmARmBBUlbOcgna6WlVK1vtsQuNlpLcgC2+ok2rAnSc7x3P
         y6yx8G9M0TjkKpsIAKeieokjBQeIlcooKKcX0kgrN9wkvrse8vJHe78c75EmWVBz+W0D
         Xx60quuCej6Z6HpILN+x1vWEHIU7sdBwtWfpTk1B6PJ4/N4v4yYcaqBhXDkBgcYrG5zo
         hlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc:content-transfer-encoding;
        bh=H623Ln4WoubLu4kxP9bDdaSAqzOIhq2q0ckkhUfO6MQ=;
        b=hA9ZyoJq1tR61flmGXEsrpQXaAp/vxyd3rKa/pO9KM4ukeEgvdkDp3KbB/wmdwQhbl
         e+PXvHfdtHcJ5vBrf/Vrcd7vx1k14xmhFtGSK1uuBE1czlSzyoUjqoanR152mQypVmkg
         imyDP0FGdvTk4cFifOK9ZEbjUvO4kx5tNstIKDar17wVRPUqhYiN/ElGHfGj4LYBVTNS
         olfqJJ0LWE/OlxGJCwkn1XtwpOnuSftr0DBV5W8TpmpilCq3TfMDFTl1MogwSGueviCO
         NyYILds4Cawv5d4n85bpdRFEVFRa4jUmX3s8/KuRL6HUoBh2rqzmLMLmoSCV5c20Y4rC
         dU0g==
X-Gm-Message-State: AJIora/q4RGsBf+i3g+Tw10sV9tSBAExNpPbfNIVqn/yF8tVCoPkUxmE
        Wv0Ui2lDXrB3USev3zT2Qj4uO3JUGwjQPsSidUY+
X-Google-Smtp-Source: AGRyM1vEqOuxVhCrvhpjYzfXbtI7kNRO1uPfEblexWl+iXBkBV6Ke/OF88WWpDZOOYA5ICuq0FXkVRiG0fVRGEkXo7d6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr682229pje.0.1655502480367; Fri,
 17 Jun 2022 14:48:00 -0700 (PDT)
Date:   Fri, 17 Jun 2022 14:47:57 -0700
In-Reply-To: <cover.1655350442.git.hanxin.hx@bytedance.com>
Message-Id: <20220617214757.2713875-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: Re: [RFC PATCH 0/2] Re: An endless loop fetching issue with partial
 clone, alternates and commit graph
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:
> On Wed, Jun 15, 2022 at 10:18 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > [+cc Stolee]
> >
> > On Tue, Jun 14, 2022 at 03:25:13PM +0800, Haiyng Tan wrote:
> > > I think it's caused by using lazy-fetch in
> > > deref_without_lazy_fetch_extended().  In lookup_commit_in_graph(),
> > > lazy-fetch is initiated by repo_has_object_file() used.  has_object()
> > > should be used, it's no-lazy-fetch.
> >
> > Hmm. Are there cases where lookup_commit_in_graph() is expected to
> > lazily fetch missing objects from promisor remotes? If so, then this
> > wouldn't quite work. If not, then this seems like an appropriate fix to
> > me.
> >
> > Thanks,
> > Taylor

I think that if a commit is in the commit graph, we would expect the
commit to also be present. So changing to has_object() makes sense.

> We can see the use of has_object() in RelNotes/2.29.0.txt[1]=EF=BC=9A
>    * A new helper function has_object() has been introduced to make it
>      easier to mark object existence checks that do and don't want to
>      trigger lazy fetches, and a few such checks are converted using it.

Also relevant is the comment on repo_has_object_file() in
object-store.h.

> So, an appropriate fix can be that let lookup_commit_in_graph() pickup
> oi_flags and pass it to oid_object_info_extended(), then the fetching
> loop will be prevent by the given flag OBJECT_INFO_SKIP_FETCH_OBJECT.

Hmm...why not change it to has_object_file() instead, as Haiyng Tan
mentioned?
