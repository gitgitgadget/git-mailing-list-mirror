Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9016CC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHKWPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHKWPp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:15:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9774F1703
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:15:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57320c10635so29129987b3.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691792144; x=1692396944;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zvEN3B2F2vSZGKvdyrRwYOI3u7lTWt1qXx1lenY0OOU=;
        b=VvRrOHj8MwrPVa/xGSiZHdeM2xWeG++34vru8QC0b2fUU1E0LQqkrwz3nSN/SHP131
         /xwTKfCOkcPP/XU6NM0mZIqwTdWFSO/AzpPEXgPoQGsdPE2zR20xhtEsNPyeDrSE1OPL
         SGEiqzYgWobyTtyeY8ow2TjTk+eq4sZDE1csR+30QRSCpV0o1t3TrQEejvJO0AnwqoBs
         tb8o9bxen7+yAp5xGeGPvkAagJI+WqL+4lKwuIjEXpwFewYd1r7cQKjQxFmDx/gtjLhi
         mRLoQAG2Plt77wy+ZNMxRFkH0BOEYxSGE70YIzd47vbIFFMEpeHxOvbsxp2K/XUVGXJF
         YDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691792144; x=1692396944;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvEN3B2F2vSZGKvdyrRwYOI3u7lTWt1qXx1lenY0OOU=;
        b=dR6UO1dybOQni/js43N6SPudDpV9bN2AmY/KpEX9fRRTfIYk7F2QAHqJb1+B0G4A8z
         SLB2VY8ByTCaF5HigY5csvLXujZxXlGOgNfJHmd070eu2TSEEZBqWIMTkKDhvVMlgGvg
         30jvOm6W3dnpcTPZkDYhLO85jQqunaKNQNReT19IhA3Ut3Y6xswcvtqs+zeepBGAL5SR
         odSe918PkfNxYDFe1dQNTYEoA6f0wYF4njDi6LfnhINb8ccCYf1NBX/yg3snSgWtr9yb
         0FUVDWdyZhhke5vPWUKmOYl8Ui6+Bq0FpP8fThmuf3KBRtjz/WLK7r60ufUR4ZFqsqji
         yAdw==
X-Gm-Message-State: AOJu0YwPnzyuqC+Pbe5lCAJxNrI6RqWhdrWcmA/d5mlTf2BZW1pUZyjg
        hs8JjrHJIBx/E00km6Xli8p4EjkOrajViDSMgJYS
X-Google-Smtp-Source: AGHT+IHMGzMWRdGEFir58ohcj1j9H/YIOZgKG93b2NpxT7+iSQw+24CpB0syopkv4Y7IJgpoRb+qZNa/7rbBwCVAwVDh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4efe:1e02:1aef:3b66])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ad15:0:b0:583:a3c1:6b5a with
 SMTP id l21-20020a81ad15000000b00583a3c16b5amr54292ywh.4.1691792143943; Fri,
 11 Aug 2023 15:15:43 -0700 (PDT)
Date:   Fri, 11 Aug 2023 15:15:41 -0700
In-Reply-To: <ZNKj9vwZv4kKJEcL@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811221541.3332720-1-jonathantanmy@google.com>
Subject: Re: leak in jt/path-filter-fix, was Re: What's cooking in git.git
 (Aug 2023, #01; Wed, 2)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Tue, Aug 08, 2023 at 03:22:40PM -0400, Jeff King wrote:
> > Since this hit 'next', Coverity complained about a small leak. Fixed by
> > the patch below.
> 
> The patch below looks good and makes sense to me. That warning is
> awfully long, though ;-).
> 
> In any event, I expect that 'next' will be rewound before this topic
> graduates, since it is meaty and we are in the middle of the -rc phase.
> 
> ...and we also have my series on top [1], so it may be worthwhile for
> you, Jonathan, and I to figure out how to combine our efforts here. I
> think that this could likely get squashed in to Jonathan's topic
> if/after it gets ejected from 'next'. We can take my patches together in
> the same series, separately in a different one, or discard them
> altogether.
> 
> If we do decide to pursue the approach in [1], I think combining
> everything together into one big series makes the most sense for ease of
> merging.
> 
> [1]: https://lore.kernel.org/git/ZMv14grkM7x7Sf8m@nand.local/
> 
> Thanks,
> Taylor

For what it's worth, whatever we decide sounds good to me.
