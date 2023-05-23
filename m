Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAA2C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 23:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbjEWXA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 19:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEWXA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 19:00:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FFC2
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:00:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba83fed50e1so844406276.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684882852; x=1687474852;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MsG56yqpDUm3tRIEHLkeKIvhheIvP71Q/S+OIVVSMVk=;
        b=pf2hZn4V4Wg58P0wf4QyXEQKYfDA+CJcSz60y+XUlc2mDjFKXTRlGrVFrkdIaKyOLR
         wMOZsOblV6DWPxLHZt3VoOY3drT/HQRhavYC7nxQkZUgMS5M7h8y2uMT3BajFGjvLxHC
         hlpFqgd8f5Soj8cX8cTyhjIO2+y3nerJy1/BnqfICVMIno5yH8Y6L//YO7HnO2Yw24wy
         eb8PfZ2SZf8Nif7iDH8fQqw+qDZxlQ6hZ0YSzwYDha5awpE4ZKbk/xBOyzWrIN2c/jiU
         JkqhwCTDxWoWx8xOdpu6HwnvHU6i9zA6oJf/n3yg3kkmzctrpwEv283THhaQ6/7xaMI8
         jJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882852; x=1687474852;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsG56yqpDUm3tRIEHLkeKIvhheIvP71Q/S+OIVVSMVk=;
        b=iO7wfRGv2tHo6n8MV7PpfSYKJ5vSNow+PPWsplhr7+pbAaj0vhJGtJG0Le8wAYVfJB
         ffEcGVsqm87YjR0gPNWCvhxQgZszlQukc82v2xqj+uLkCFFWo9FDfqv+JJ0Txqn9Yydn
         Cme8oxtlOHelQgdOAGY8iYrPJrWzzq2yxD3lZKHIrnvG97KezrurhbZvLlkxB92udoeR
         iKpzi2Ew/iud9WDVYeMztnXIdrCudkWSCRiThbpUW/GkX/Kr0ISrcRBhM8B8S+Jty1FD
         neIpPzzy75sKncNoJtOu6cFRQ4lUMT+rjaEg7LXfWfsH5LiFGigvye3VV3+aSjojBCvS
         kB+w==
X-Gm-Message-State: AC+VfDysor1xicn66u6U5Muw7GRKTqVqGyH2lAB7Aydup1sZL7KLjt2N
        Z2jyHdDvOeLUqvVx0v+sUrpcp14KIYszdlsNVGrz
X-Google-Smtp-Source: ACHHUZ4XVxcV5GbFVAL2Qf0HwN+CeRGnSubKYDGFTCeaoURp+qw+qhrMCLVzWEazMqhXvUys5rMtScb7c1Z5F6A+ACX2
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:d932:2c4c:8f58:98ff])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8750:0:b0:ba8:1646:c15d with
 SMTP id e16-20020a258750000000b00ba81646c15dmr9101805ybn.1.1684882851917;
 Tue, 23 May 2023 16:00:51 -0700 (PDT)
Date:   Tue, 23 May 2023 16:00:49 -0700
In-Reply-To: <def26c71-0fbb-58a3-f1cd-f8e532b67503@github.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523230049.1225412-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> I notice that you didn't update the commit-graph format docs,

Ah, thanks for the reminder.

> Here is a potential plan to consider:
> 
>  1. v2.42.0 includes writing v2 format, off by default.
>  2. v2.43.0 writes v2 format by default.
>  3. v2.44.0 no longer parses v1 format (ignored without error).

First of all, thanks for your comments on the migration process - that
is indeed the most complicated part of this.

The code change to support 2 versions seems not too hard (duplicate
murmur3_seeded() and modify one so that we have one version 1 and
one version 2, and teach fill_bloom_key() to call the appropriate one
based on the struct bloom_filter_settings) but this requires both the
code author and reviewer(s) to check that we don't have cases in which
we read or write one version when we're supposed to do it with the
other. And the benefit of doing this seems to just be giving server
administrators an opportunity to perform the migration at a more relaxed
pace, which I think there are other ways to accomplish if we really
wanted to do this, so I wanted to avoid having 2 versions in the Git
codebase.
