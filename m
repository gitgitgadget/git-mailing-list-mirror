Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1815C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE39206E3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 19:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9qT8UsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgKIT4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgKIT4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 14:56:37 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D7C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 11:56:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 9so3587293pfn.5
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=RxGZBjVltkICrzbARtiJg9xCNZpoaa462ceCU/kRTq4=;
        b=W9qT8UsJ0LUMYFk6sXm1QqI+55aHfQpGMXU8MVzFl5t0LbIwlXcDBZ28l+tRFflP0x
         N/jYw0yNlpbc9ZDR/ywMK975ADNAmH+VGcBsktpPZpxg9Ua6TP/9WfwkB/5flapKfeSd
         aERLsFafqVNA+AKBoUK6BFup9eE7aGdcRlodWTiaautSuL+eXCKuDtup1RBIOb5cQutw
         9HNkG9wRFoz3YZc7AZMxzlD9mlEZ9K640Nm/uSHzv8yq7fv/chLy05PcMv+nT8dwzomB
         begzdEITAsjpli9vTF0pD4CVLvv7+eh+emHT8a+7ViI7ockQVeNc3cHph6lS42fIBnDd
         BhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RxGZBjVltkICrzbARtiJg9xCNZpoaa462ceCU/kRTq4=;
        b=gWfOBkzl9uEAQRxOjmb5ZUGTt743mSEf6jKn8c1SgKC+06LsFa5h5zFz/uB9bsP4Iy
         SgICBLW89GmPtB7BjfmL4MAfDJmtz34WpHOkYJaRkMrRg7WHTyOgzmMNMwHZhsQ4rb9u
         crg0c5l8m/PYSCjfQgEPGdVQHF00Ck0pYw7nd2wP2FkNcSZYacCbwEqDHTGqL68Px04m
         baTyW2pcaa76otOg4spdttcMgSNdzsmt3GryAMmPFl1aroqkCwSqIGEOJAwWRANu0X94
         OGmyg4cPemPaDknMSXaxUZKjK4LpgB5/A+BrZjShwBGYiOMgTnWCNFJEEGQUnmkpi0pP
         o8UA==
X-Gm-Message-State: AOAM531wcMVblnPbSuYf+b6tJFNbjUdNwRJ/PP43bdFzUlzgFUuE32Uc
        UF1+4HNq8ae4YREtXNDxSYD0/pFgZAn1p3DyGr6n
X-Google-Smtp-Source: ABdhPJxrbXZuACyArAI4RQv+Y1LKfsHOsYbpI8Zu9K9z6lqRQL/amzsEYwEa0QR01ZnhCIQOfhGtvo1Q+M5cUziqhuL0
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:3704:0:b029:18b:9bad:522c with
 SMTP id e4-20020a6237040000b029018b9bad522cmr14931557pfa.5.1604951796390;
 Mon, 09 Nov 2020 11:56:36 -0800 (PST)
Date:   Mon,  9 Nov 2020 11:56:30 -0800
In-Reply-To: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
Message-Id: <20201109195630.2511149-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqft5qs5qs.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH 4/4] Doc: push with --base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, jrnieder@gmail.com, jonathantanmy@google.com,
        git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> People expect that a single repository at their hosting sites can be
> used as the central meeting point for the project, just like CVS/SVN
> servers were in older world.  "git push" would need to accept that
> reality and start common ancestor discovery eventually.

Thanks for your reply (and everyone else's). I was thinking that a more
rudimentary form of the feature would suffice, since I wasn't expecting
much more need in the future, but looks like this isn't the case. I'll
be thinking of a more comprehensive idea.
