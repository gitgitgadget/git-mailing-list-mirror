Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EC0C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351427AbiC3V5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiC3V5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 17:57:11 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939D2672
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:55:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t66-20020a625f45000000b004fabd8f5cc1so12756975pfb.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Y+ycKjVAL+u0bs4wzPYMhmtfbwuetYo5X+3H+CRn6do=;
        b=OXOOEDkMvMqfHyTIVDkZoRKm56W5IA26D5LfW52I47eNxyBLsKvmTGQyBBv2EPup9+
         R8jHwjq8ug+OWXu/olq9/YDRuAcDsFxQXgxh7THg5mWKmgNFB2ncP3so0Z8bzBMC1WSf
         eoXmD1DiKihhYINQoXq++zLafr9x7ZB66A4pLVszsNMnNQPYbHurS8eHJyoosthEdjIY
         x3FMli3nSQfskgwc9j7FM7rDxWVoHZNNjov+KwHvHqmAeizbXpqXZ+BlAuVa9+cl0MD3
         xFd4aGG0zgXaeMTQZ8OWoJhyEmz7pYgGWrMN7HXBnQt4ZkJ6I0pK1EkQNyuUmPkYRIK/
         GJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Y+ycKjVAL+u0bs4wzPYMhmtfbwuetYo5X+3H+CRn6do=;
        b=ZU3LULkJZssQsKyXBA2JtfzvCeE0BoO2ZpWIcZn7kP94JbOhSWzOuIAA/t1KD77glt
         VU2xkU95zaEUYu0t5lYT5Pn75tfAv0kiO2Wm/Swza+zGzYcR/PpqSD/6rzacwso6TU7f
         gxTONl8AN30shibfJYcDCA0J8JdZsnjw5KSNRh1uJMTjFyQDzMOgvbfgwEi2KsyIdN2J
         8WR8fxqatH89+1M3kwa1JTqCwaG7IQwd7Wg/m7DO53VTg7rxMDFjXthUGMjgXuiNFtlY
         4t9OZMz7UHkO0aG+SshB/bUowCjdFn0Wz6UhDZ/Uyo9tWEww0kNn39AVMKUb658UVGwk
         Z2Hw==
X-Gm-Message-State: AOAM531OSHnrVU5S+eEH0+d7CWgq59jzeWw/Vfy/3L69HmkxqsPwyTFf
        NLDY/XGTRz/OOJcoUC0xAz9oZLb0t5l8ChYnCVvb
X-Google-Smtp-Source: ABdhPJyQWp6Pnc1V4L8KOY9LjlBuRtynCwWMS21UYc0UwuvJ27KPcqpIGCJt7f1RE8be7CBKTt0AUsh95HD69QrhvsNO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:d44c:0:b0:380:8c48:e040 with
 SMTP id i12-20020a63d44c000000b003808c48e040mr8077496pgj.14.1648677324741;
 Wed, 30 Mar 2022 14:55:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:55:22 -0700
In-Reply-To: <20220328191112.3092139-2-calvinwan@google.com>
Message-Id: <20220330215522.2302571-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: Re: [PATCH v3 1/3] fetch-pack: refactor packet writing and fetch options
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:
> A subsequent commit will need to write capabilities for another
> command, so refactor write_fetch_command_and_capabilities() to be able
> to used by both fetch and future command.
> 
> Move fetch options set in `FETCH_CHECK_LOCAL` from the fetch state
> machine to above the state machine so it is set by default. The
> initial state of the state machine is always `FETCH_CHECK_LOCAL` so
> this does not affect any current functionality. This change prepares
> for a subsequent commit that doesn't need to check the local state, but
> still requires those options to be set before sending the fetch request.

I think it would be clearer to rephrase "that doesn't need to check the
local state" to "that will skip FETCH_CHECK_LOCAL". It does literally
mean the same thing, but I had a mental block with "initial state...is
always FETCH_CHECK_LOCAL" in the preceding sentence.

I agree with some of the others who said that this change should go into
its own patch.

Otherwise, this patch makes sense.
