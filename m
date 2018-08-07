Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE25208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHGLXb (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:23:31 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42850 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHGLXa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:23:30 -0400
Received: by mail-yw1-f67.google.com with SMTP id y203-v6so4660131ywd.9
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 02:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c03QTh4pfxd0Q/afKZ7je8xgJNO2tmxpK5VEXdhAFs0=;
        b=fdATrqhlIeov1BFRg2P2Go0pLfyK8ws0yoMXYHT4w1yYG2PfDL4PVY4pG+T38VCTTY
         WZVskiA8dUbn9p0GSI7F1l4aVGzHkNPtFOzQiJVPPHjsMfdyXoFH6CdVtoSFiNLxeRbA
         FwomnQhSdzKB3VOxomvbW4lVTCbVHwPWye6YYd4sBm+Z3PX7h+KhYI5tA5d4I4qZoyXC
         x/0pkGHBIPRJ1Y6mTR71ThSHJEKuV0z2WsUJUuYxl5MN6jSpFrDJJt3JGXfMvweebaWx
         kt9Me0oj//IkywVXUutiEj4Y0abtIT28LqC7jGI6XJykTElBkLorDgdeBV38Y+7kiO/4
         FaAQ==
X-Gm-Message-State: AOUpUlE88I2PApS593al+w535IV8hlLl97Uq33zz3j8aQDn23bwdfYP3
        gEDmkB4g5QAiWLVMxVoDCBHGCEcWUApwvzC59Ag=
X-Google-Smtp-Source: AAOMgpcZbfiPwNt9xytvlu/tA257Rj7dQLWk5Srqm/wiTI1z1xofTTesG6qLMiVjkKdiVL8YmmqR81CJvF85VirYZgg=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr9168679ywr.16.1533633008696;
 Tue, 07 Aug 2018 02:10:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com>
 <CAPig+cRrC2mf1uuQ1C4Ue4OMZQbgcxXbJ9AXs0y6RSnUrcm7Dg@mail.gmail.com> <nycvar.QRO.7.76.6.1808061510260.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808061510260.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 05:09:57 -0400
Message-ID: <CAPig+cQU-mcUBJGHeZjKeta0_ve8WMr_KL1ToO9j-d=-hS1a=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] line-log: convert an assertion to a full BUG() call
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 9:15 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 5 Aug 2018, Eric Sunshine wrote:
> > Although this appears to be a faithful translation of the assert() to
> > BUG(), as mentioned by Andrei in his review of 3/4, the existing
> > assert() seems to have an off-by-1 error, which means that the "> a"
> > here really ought to be ">= a".
>
> I think Andrei's assessment is wrong. The code could not test for that
> earlier, as it did allow ranges to become "abutting" in the process, by
> failing to merge them. So the invariant you talked about is more of an
> invariant for the initial state.

I'm having trouble interpreting your response.

My understanding is that range_set_append() is intended to be strict
by not allowing addition of a range which abuts an existing range
(although, of course, the assert() checks only the last range, so it's
not full-proof). Assuming that to be correct, then the assertion
contains a one-off-error (according to my reasoning).

I'm sensing from your reply that you seem to have a different idea
about range_set_append()'s intended use.

> My 3/4 would make that invariant heeded throughout the process.
>
> I am still keen on keeping the invariants straight *without* resorting to
> dirty tricks like calling sort_and_merge. Calling that function would just
> make it easier for bugs to hide in this code.

Indeed, avoiding the "dirty trick" would be ideal, although, I still
haven't wrapped my head around it enough to be able to say whether the
computed offset, when applied to the range in question, could cause
that range to abut or overlap an existing range.

(There are, of course, valid uses for range_set_append_unsafe() /
sort_and_merge(), such as allowing -L options to overlap and be
specified in any order. Batch-adding them to the range-set via
range_set_append_unsafe() and letting sort_and_merge() sort them all
out is plenty sensible.)
