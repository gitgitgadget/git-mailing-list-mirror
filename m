Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3065FC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 22:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCOW6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOW6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 18:58:19 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FFB113F1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:58:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5425c04765dso100467517b3.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678921097;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9vleAEWVW8v0nF+3HIpRpFpLoX0LfFvFCnosP2N4qN0=;
        b=ka2gEzdYH5uJxv9liEJ5SK5QYjRwiw2oznSn2k6ER96oQsmFJhGFufZ5i80UAq+diT
         +sa8tN1h2ighz7WqMMAxhAozV5LmeOJY9YHOAHd1Wnqzp9NY92xP+uV7Nrn0ZqtsBK6D
         q7h3VgUotlLG8ZEOqFzb5duQAWqQIp8qG4fFYckbX766C1rJa/JQmIqSYRnEYBsOCyfh
         peG3vCcflxBxalXe0eQaXy+sYtNJsWf6rpshN0N04pJiyWvaiXkuO9dvCTo6BgfSpkRS
         rBQGUUz+yKhcG0V0/G7JOncwjVQUPqc+oqugV3rwfmUEt/7mKqUCdlqAXmQ2Sq0bP0fs
         tppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678921097;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vleAEWVW8v0nF+3HIpRpFpLoX0LfFvFCnosP2N4qN0=;
        b=CH0+Y3uM2z9m2Q8ujueU9Dhe4SZqZ7p1dvYqujFTWWx/4MQl/USTrzOG+duRXaFhUx
         7AgIrKROhKtehjttzlpVvB3TW7+mf0/SEPl4GxOnurusA8Y/H9S1OanzsFXCR8DWSlIQ
         aLWW6QCli2iDvYLg+HcmbyQUdoukfeJH7f8iOD5hN2H77ncca6rsFCiloadYjRyPp99D
         msI6fazfd5vRxolJ+6XB12sHuYVbiNmoTiDIEPggm/f84kwbkb9XKdnjmArO1/3bmkm1
         nL2m8uGHtHcddL9prmQsi1WOGJoGUBO7XUgiOhPvBwJFdlPcRpjx9sRQa7P3FGKjUW1d
         kZzQ==
X-Gm-Message-State: AO0yUKWZbc9zot/QIt4fmal7VG+A45x3LTUxxU1zSCpo4SAo2d4INS0J
        5Gcu7vTD7o/PMsr2SSZVoAG9ydb6WwFBwtgHemj5
X-Google-Smtp-Source: AK7set+d5Vrcn92UTMreUR6AAeY8CMQAZuQc0iPL6yiWp7mX3wZnM+LVzdlIusXY+SntFknofDbGbnvHUO59T5UVU3/P
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:524e:ff9a:ee19:127f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:f507:0:b0:b3b:6576:b22b with
 SMTP id a7-20020a25f507000000b00b3b6576b22bmr8556610ybe.12.1678921097817;
 Wed, 15 Mar 2023 15:58:17 -0700 (PDT)
Date:   Wed, 15 Mar 2023 15:58:15 -0700
In-Reply-To: <abd3e7a67beb80ef687253ddb8bb5fe7a769357f.1678902343.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315225815.170437-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/8] commit-graph: return generation from memory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The commit_graph_generation() method used to report a value of
> GENERATION_NUMBER_INFINITY if the commit_graph_data_slab had an instance
> for the given commit but the graph_pos indicated the commit was not in
> the commit-graph file.
> 
> Instead, trust the 'generation' member if the commit has a value in the
> slab _and_ the 'generation' member is non-zero. Otherwise, treat it as
> GENERATION_NUMBER_INFINITY.

I would replace "Instead" with "However, a future commit intends to
compute and use commit generation numbers even for commits that are
not in the commit-graph file (and thus have no graph_pos). Therefore,
we need a new criterion for deciding if a generation number can be
trusted:" (or something to that effect).

> This only makes a difference for a very old case for the commit-graph:
> the very first Git release to write commit-graph files wrote zeroes in
> the topological level positions. If we are parsing a commit-graph with
> all zeroes, those commits will now appear to have
> GENERATION_NUMBER_INFINITY (as if they were not parsed from the
> commit-graph).
> 
> I attempted several variations to work around the need for providing an
> uninitialized 'generation' member, but this was the best one I found. It
> does require a change to a verification test in t5318 because it reports
> a different error than the one about non-zero generation numbers.

Thanks for investigating, and I think the method in this patch would
work. As you have stated, this only affects the commit-graph files that
once upon a time were written with no generation numbers, and this patch
makes those behave as if there were no generation numbers in the first
place (which is exactly what happened).

