Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7022C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D8420871
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="up0E0uJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK0SCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:02:15 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39739 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfK0SCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:02:15 -0500
Received: by mail-pl1-f202.google.com with SMTP id x5so9980223pln.6
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfAm56ekDYhKk1CaPQAfCLwXHezb9dyS3OsigHymmZ8=;
        b=up0E0uJbmlKw5xhSo8jS4EPfIIrfUeyYbdW/J1U2PxMWntom5p9AOI2IfRvxAkC6pA
         tgDdBzSThwTrPWzr5GvPtxOUxvh9UytARhSgT8WU1Scu3MVTKl2+iQihrfoooGy/J6hP
         O2/TUU6Wjh3UP0syLPIl2HutAQjETzh4HMRF+Fcp5OpbMwSbZVUld2mlDm+mlNSdiHt+
         6qGQ1NsZRZl1sbJQCDnF8AL0tYYaH3wVDUX5vCV1V+5aIUc6nHJY0e1O+xcIdpqDiIxq
         WOdCCznWWz1qPbmAcwG7gT1AWbbvcUXLX4/AbhdQ8kPGm7ljB36u5++TBhqWbph25Hg8
         1NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfAm56ekDYhKk1CaPQAfCLwXHezb9dyS3OsigHymmZ8=;
        b=WL4jbxmui61puxLgDBagw7u5OCegMiUvm3eLem8tGUyB+R6EfgB3QGlZkROL8eHu2e
         +PlVIl/vYeh+GZquMPoNDPsweA1mGx1X6OzBS7GOcDjKierLDMTxZRjtwqzuwNQ5yjGy
         4xkbm4RRWTDW/Vou3Mz7JY+kAIBxtGUbP6HzqpKc8zGe+q/Zdfd8tbGxqy6kSAK+8Zj8
         SZCupl5pbSLJqp+exZnbjw3P5MtVDZ3hrEivDjJCooOcLuUrRHhbwL80X8IlS3dn4YvV
         6kwJd7dmrNTSAS9y8YhDqI4Zbrlm/ycdmwdyq0iCzn6AUvmz+SbEGMTQTBp4oi9EqhoS
         I83A==
X-Gm-Message-State: APjAAAXuSZJg8dU4AuNqiW9Pbx4O4GiCH2NB5zf3IKF+luZk4H5s9EIs
        t2cAVPSOKN+9LycLVUoPeo0RKv+/anNzTDHrZpx9
X-Google-Smtp-Source: APXvYqxSxs2Tf0dKnYLofF9Um9Hd+ONZ3pvV7pFzhxuh6cHvNakINhe34UHY/xRi02UahNGsQKBH42AVRQ5CkBPFV9PS
X-Received: by 2002:a63:4b52:: with SMTP id k18mr6375394pgl.394.1574877733338;
 Wed, 27 Nov 2019 10:02:13 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:02:10 -0800
In-Reply-To: <20191112103821.30265-3-szeder.dev@gmail.com>
Message-Id: <20191127180210.168901-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191112103821.30265-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v2 02/13] t6120-describe: modernize the 'check_describe' helper
From:   Jonathan Tan <jonathantanmy@google.com>
To:     szeder.dev@gmail.com
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The 'check_describe' helper function runs 'git describe' outside of
> 'test_expect_success' blocks, with extra hand-rolled code to record
> and examine its exit code.
> 
> Update this helper and move the 'git decribe' invocation inside the
> 'test_expect_success' block.

decribe -> describe

Otherwise, patches 1 and 2 are relatively straightforward and look good
to me.
