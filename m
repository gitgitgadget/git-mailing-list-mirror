Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1DEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGTUWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGTUWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:22:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA7271D
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:22:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-577323ba3d5so37189577b3.0
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689884525; x=1690489325;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kQd8TNAw05+LpxLOoSKb5jBynxlSiAS8dDIf3knS7j4=;
        b=1A50D47mt7i1dATXmjc2whmt8ilwFTgcWDtlNMVu4XH4ukghLuSHpMn+vzmLBCRPfQ
         fKEIR/NPLB+8SSUcj+FUiEGPjiZTHXcJPj4beQIKzsgolZaWRi4wUlIP/GnCH+b6mz32
         Oa82ORUJnKWCjImn5M6g2hLNyaz8cQnN2GQRo8NRGGLQKw3zJLMRMt+HHVJXPJoUSKe8
         0U6scApbONeGRoSxhd4PXh8gz4k30QRpGAsnR3kgSmmGIE1f9snQYhk87Od23VFZsAAI
         KW03RT98/Oribygnug+DhcGXbGRK+ZkRTsyM/4VejVOzAg3G94dMciDf3Ll4eK+r7oaM
         RXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884525; x=1690489325;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQd8TNAw05+LpxLOoSKb5jBynxlSiAS8dDIf3knS7j4=;
        b=WfRCpCIZdRU6RNT9wU8QY2IzidFsvhQYgI9Wvvv50k+YnSlk5F5ZNatMbe1ItGnB4x
         4m2VTIySAbZ/iZ717JFQK1WqeoOXwfghUmperOZbutHjM74cH+zCnIhRnJ4tYmPHnU5x
         fMlvAGw0ZtuHXCkwMiLRZbMp84wPXWNU/tky7Dl2/QXxtOHTk07gzKDq0ZCR+qnz6Qp5
         Lwsd5n9VRb2Najj32E9BC1nPQYcItlVMNdbDWtEFom8WV7AM15Ldm31+xuc+TI08Hwqo
         6JkLtwlrflX1USGi72T2Ss1JOIGhuIVavhd7i73WURii3bL8w93AbPZD8hGRUC6jASuy
         cudA==
X-Gm-Message-State: ABy/qLbcuVW8CM3EiHpktGKhFIDXcxseBbxXQafBN/cQ6ygArMr2saBC
        9Z+DX+oEVpeagtJVkegLPNHx+UpyVho5VBjD/4pB
X-Google-Smtp-Source: APBJJlEj0C5d+zOkF7RJzrrKjIArkww3SG2QPFSr50WOSX4M3kmz9zJWP4dOGvEl4uiq3JT6mu1sHwuAK+ngj49hUZA9
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a81:c805:0:b0:57a:6bb:c027 with SMTP
 id n5-20020a81c805000000b0057a06bbc027mr98081ywi.1.1689884525097; Thu, 20 Jul
 2023 13:22:05 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:22:03 -0700
In-Reply-To: <cover.1689789226.git.me@ttaylorr.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720202203.3816309-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/4] commit-graph: avoid looking at Bloom filter data directly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> Hi Jonathan,
> 
> Here's a few commits (and one fixup!) that could go before the second
> patch of your series, with the fixup! getting squashed into the second
> patch itself.
> 
> The first three are preparatory, but the fourth patch should allow us to
> drop the Perl hackery necessary to dump the raw contents of arbitrary
> Bloom filters.
> 
> Feel free to pick up these patches (or not), just wanted to get these
> out there as a possible suggestion.

Ah, thanks! I'm on the fence myself about whether this really needs to
be more rigorous (the Perl part just gives us an offset; we still check
that what's at the offset is correct) but since you have written the
patches already, I'll just include them.
 
