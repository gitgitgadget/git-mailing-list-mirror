Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1BDC83F18
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 22:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbjH2WTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 18:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjH2WS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 18:18:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC981AE
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 15:18:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7814efcccbso5861281276.0
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693347532; x=1693952332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HzXxY6BU3hdty2GaYtM5YTiaIbfs3fp5vBDUPGjL7Cg=;
        b=uvoeWq+j9qCk09KUo+rHoymNWeAtm/8MMVLjh9Djo12cY8vBtgo6Cgp/zz5eMLXfYK
         T48wFS7rECI8ANJEtzKtlO5rmwjPOHowV/8PzsVl9qMPO+OrGFiUMzzxKg/RTsvb+zj9
         xpdk2XJmmgkI6KhCIqtDpNYePnTmW/WUfkw+yyZRW6FawrwRRIkeYitYlPcTnoypG6GI
         ic0BLAmm24YEBuxAe3BJfq+wJnBrNjBokwlYjOx5997mxSc9f84iKc6ETOCYJu/Ie7Yg
         fGuyKNFP3csD3c7tygToDtR2sk3H1yOoNcVFDj6WTGbfQcqV7w2FvOQU0F2528ZcoZLR
         96iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693347532; x=1693952332;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzXxY6BU3hdty2GaYtM5YTiaIbfs3fp5vBDUPGjL7Cg=;
        b=Hh4PWs9c9ENWE4nCUdTCZr5VdwydRHoa91vGpW1PXfmlx+Qqpg1Jx+Aw1fqWGaWppf
         PkYgrbmcLw8FL6c5Yq26sFxztVc7KjCIPovCv7IBuMT5kFC5BLKmcqfflQYBhEZO7aRd
         1OiM9R4ERrImSdc0E2kWuoZi8JJeC/MEajbpQc/uTDrRDob1/cJZiYDqu+MPtqMiLFyG
         ZN74BRl2pfJYpe8HtR3GiBCtLlDElXKhdvafnsMSFdT+aWAQUPIQzsQU/5zSAuUOQnDK
         EOxd6EPFSauY9tcu1Qm/XRlgCheM0MJSQwjEHi+ioy1L1C4j/5aknljN7ls7y7KAYBRd
         zfWg==
X-Gm-Message-State: AOJu0YxgnVGzItfJ7BPAXgrVagz53FO3BHzMk6usJZS4VESz6MzXJWlW
        UIgFdkkbKxBMTlIV3cACbumm3ARoyTVclAdbFns6
X-Google-Smtp-Source: AGHT+IE3/7MmFHx2NAR5aGmwmuPrWYvyYdirnchdgERLmYSlnwLcaWhu/pQK4CqjfmNDM1AIbxkSApstltw9qMnNwQZI
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:ec07:4d48:eb22:d87c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:158c:b0:d77:ff06:b58b with
 SMTP id k12-20020a056902158c00b00d77ff06b58bmr11364ybu.10.1693347532017; Tue,
 29 Aug 2023 15:18:52 -0700 (PDT)
Date:   Tue, 29 Aug 2023 15:18:49 -0700
In-Reply-To: <20230825170656.2598201-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230829221849.562285-1-jonathantanmy@google.com>
Subject: Re: [PATCH 00/15] bloom: changed-path Bloom filters v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:
> I mistakenly sent my reply to an earlier version [1]. (Taylor has seen
> it, so this note is more for future readers who might be curious about
> what that email reply contains.)
> 
> [1] https://lore.kernel.org/git/20230824222051.2320003-1-jonathantanmy@google.com/

I think that this patch set is good for merging. There is a discussion
between Taylor and me at the link above in which Taylor thinks something
is OK and I think that that thing is OK except in a very specific
situation (there exists a commit-graph chain in which the different
layers have different Bloom filter versions). (Hopefully that's a good
summary of the discussion.) I think that the situation is narrow enough
and have seen that Taylor (whose capabilities I have a high opinion of)
has looked into it. I think the only way for me to be fully convinced
is to write a test that includes these different layers and see how the
code functions.

So I think that we can merge this patch set. An alternative would be
to wait for me (or someone else) to write such a test, but if it's just
me that's worried about this situation, it's probably not worth waiting
just for this.

The other outstanding thing is that Szeder Gabor pointed out that Bloom
filters are not applied to root commits so some of the tests don't
test what you would expect [2]. I've updated the tests and pushed the
results to GitHub [3]. I'm OK with using that version, or the current
version (in which case I'll resend the updated tests once this version
is merged).

[2] https://lore.kernel.org/git/20230826150610.GA1928@szeder.dev/
[3] https://github.com/jonathantanmy/git/tree/changedpath
