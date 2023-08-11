Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4086DC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjHKWNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjHKWNl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:13:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3576CE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:13:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583c49018c6so28506407b3.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691792020; x=1692396820;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+GwEMxSCG4LBmJCKLDnsgGNZKAGfCMgGsvR7bWEXxQ=;
        b=pv22yK14vUFxijFohoqVgspg09FCnTuDhMEaaM1vV9S1OktWLI91/lb4AAWDvxI5Ut
         SEoM2/5XYg/5SGAc8Euy0i6AMAcDuCHzgfB9oHNEGRkfVwMFHdlg7XrjoYX4HQ3mt8Rs
         cpHSQHgdYobAXkbOt1MX0koTqsaIzmu0bnSEd8s1t33tftKz4t/BgIPYrKOVfYSRzZH0
         7dpThL+6eIQkhENxfH8RR0yDjDSa8+lcgRcCu+tfs1BbaOX5A7wE5Fq+2f1wWU/dZAx1
         x/EJuSqjBT438mA+R4Es5BUVhjrEqc2jkCMnTAhiJZgNv3bYu6EIYJvjxMG097nTpUcy
         eM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691792020; x=1692396820;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+GwEMxSCG4LBmJCKLDnsgGNZKAGfCMgGsvR7bWEXxQ=;
        b=Ysp+TQ5nF69QWaJpT6c3FO31umAMoyWh5Emnt5GKavTteHY7ObMdo8S0SOerh1sQLP
         hlit31FK3AAGd8hxF+Omjkqu8ulHzfDtu9JGw8KsN0yZn22t8O6IoqJUckt9SW3TvCiI
         pxARekYQ+Gf+CAFbEmf4fH3pG8OWmW4gEfvOFPOsEGD7xWJcuB4bTvSedCyCqwrKEA23
         2hDeRQVNitG9Jba6pzR+qq+QXDQXHqxbLyJjjv4tE02a6IqfwxLSQuUwRtQhzvJwYEL2
         o6A3gZuYpnMyUQR5KMqCDsYTQB56aUWqFTaOb79ZXU2PAo0yjS1ujDK2vOMAsMV8g4of
         ORzw==
X-Gm-Message-State: AOJu0YyhPUeWErdHTF7lI++3ZkiTzBDbndU8bj3N8jbxTXaw2wwWl6cB
        jIW95lX4xexDwEAQlwT5yPVx4GA6BpFKZcH4g9Y0
X-Google-Smtp-Source: AGHT+IG9yWnSmumNqKiVLHZVx79EvbkFb2DWC0VJfPeN6ECHXaba3hnysJFoYr8aIZ3ddYJFvUU/lGweRs9DOSm5tkdY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae12:0:b0:584:41b7:30e7 with
 SMTP id m18-20020a81ae12000000b0058441b730e7mr53942ywh.0.1691792019992; Fri,
 11 Aug 2023 15:13:39 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:13:37 -0700
In-Reply-To: <cover.1691426160.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811221337.3331688-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH 0/6] bloom: reuse existing Bloom filters when possible
 during upgrade
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On both linux.git and git.git, this series gives a significant speed-up
> when upgrading Bloom filters from v1 to v2. On linux.git:
>=20
>     Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=3D0 git.compile commit-gr=
aph write --reachable --changed-paths
>       Time (mean =C2=B1 =CF=83):     124.873 s =C2=B1  0.316 s    [User: =
124.081 s, System: 0.643 s]
>       Range (min =E2=80=A6 max):   124.621 s =E2=80=A6 125.227 s    3 run=
s
>=20
>     Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=3D1 git.compile commit-gr=
aph write --reachable --changed-paths
>       Time (mean =C2=B1 =CF=83):     79.271 s =C2=B1  0.163 s    [User: 7=
4.611 s, System: 4.521 s]
>       Range (min =E2=80=A6 max):   79.112 s =E2=80=A6 79.437 s    3 runs
>=20
>     Summary
>       'GIT_TEST_UPGRADE_BLOOM_FILTERS=3D1 git.compile commit-graph write =
--reachable --changed-paths' ran
>         1.58 =C2=B1 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTER=
S=3D0 git.compile commit-graph write --reachable --changed-paths'
>=20
> On git.git (where we do have some non-ASCII paths), the change goes from
> 4.163 seconds to 3.348 seconds, for a 1.24x speed-up.

My main concern is that this modifies the code somewhat pervasively
(tracking the version of Bloom filters and removing assumptions about
what Bloom filter versions are in memory) in return for what I think
is a small speedup, when considering that we will perform this
operation only once for a given repo. I'll defer to server operators
on this (or other people handling large numbers of repos), though.

Putting that concern aside, I've reviewed the code and assuming that
we're OK with modifying the code in this way, this patch set looks good
to me, and hopefully my review will be of some help.
