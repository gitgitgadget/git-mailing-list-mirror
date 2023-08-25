Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8562EC3DA66
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 17:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjHYRHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbjHYRHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 13:07:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7431FF5
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 10:06:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbfcb8d90so17547677b3.1
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692983218; x=1693588018;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ye7Z6qucvYPTHWrRavU5AzrUsqDyF1r8WhrLWh67/Bs=;
        b=qYHnJ369C7zmBO1VBEoRDrrxJ4QPJNWnH9cRfO4uiZBue7hNKUriXy7ICNh3OMbyPW
         UMPM4bBAkUGZtXwvfddWMkF5rr2g9+ITd25rMzEYimB/w4bBneDTwaX/X/AtRL1POn2d
         +o1qpEhUdvGWBLzFaaLHgHJigfiivVq6t/A195BZ+yFWE+qEoFcUFp7lyW/ch/xjjUOu
         IZTSZwD2XjU6peNtBowXTRPPBxEA6rmDglZGGMplu0G+/pgfdgXQD+el8qTha53MA8HU
         FaGihx/Y49JWjWeTMLe320kMKe+F3HH93ux/DEQXVkHx/laVZ1q2mbPy+s83UfY/BFJq
         Z2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692983218; x=1693588018;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ye7Z6qucvYPTHWrRavU5AzrUsqDyF1r8WhrLWh67/Bs=;
        b=eBXqOXGxHDnmzcUFRR6yl25QgOwJd+phsuszkla03K4oHnSLvO0iAtUKKJNqTJDIzv
         kZq9T9ES7rWAju7LqEyKkB3l4Cv+6oQ6mJdC6QqVrVjLlP8gVqKTbZwA04tUFNcQcnf0
         ibZ1pupYZZG8StNiA2b1CFiIqIvqt3G+Hjg/Ep3uyneY/GtXfziLA2w2zF8GSQS9h7/h
         u6kWXisx8JIq1JDhbOlLXK6adUHaSivy5xHiYEuVa1t9O8a/aX8bnVJstPidr+TXiQLj
         dymrk25Vk44BvGEAW4EMqAhBI2ByB2Ful4L5XUa26Y8L+NnhkQ9o7S/4HLMnnQ8N97Yw
         CaUg==
X-Gm-Message-State: AOJu0YwuYdcKQUiQzJPUpgo75rLllDH7P+e3KXXFTvgAuMViOT4pi0LZ
        WFMnF/Zj8cUQnkxgdB4ZcAOxClikkdtT9fbBZmlt
X-Google-Smtp-Source: AGHT+IFcqICv2f46eimUUVCOak1fvulV6jv1Rc7BdfPbC4KsjzEnZtplmJq+/TWg6X1LJs2o9Wo5Y80k/M5XW9LwWPUx
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3542:abaa:d8d5:eddb])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b60c:0:b0:592:83d2:1f86 with
 SMTP id u12-20020a81b60c000000b0059283d21f86mr284337ywh.4.1692983218603; Fri,
 25 Aug 2023 10:06:58 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:06:56 -0700
In-Reply-To: <20230824222246.2320443-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230825170656.2598201-1-jonathantanmy@google.com>
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
> Taylor Blau <me@ttaylorr.com> writes:
> > Jonathan Tan (4):
> >   gitformat-commit-graph: describe version 2 of BDAT
> >   t4216: test changed path filters with high bit paths
> >   repo-settings: introduce commitgraph.changedPathsVersion
> >   commit-graph: new filter ver. that fixes murmur3
> > 
> > Taylor Blau (11):
> >   t/helper/test-read-graph.c: extract `dump_graph_info()`
> >   bloom.h: make `load_bloom_filter_from_graph()` public
> >   t/helper/test-read-graph: implement `bloom-filters` mode
> >   bloom: annotate filters with hash version
> >   bloom: prepare to discard incompatible Bloom filters
> >   t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
> >   commit-graph.c: unconditionally load Bloom filters
> >   commit-graph: drop unnecessary `graph_read_bloom_data_context`
> >   object.h: fix mis-aligned flag bits table
> >   commit-graph: reuse existing Bloom filters where possible
> >   bloom: introduce `deinit_bloom_filters()`
> 
> Thanks. I had one small comment (sent as an email reply to one of the
> patches), but everything else looks good.

I mistakenly sent my reply to an earlier version [1]. (Taylor has seen
it, so this note is more for future readers who might be curious about
what that email reply contains.)

[1] https://lore.kernel.org/git/20230824222051.2320003-1-jonathantanmy@google.com/
