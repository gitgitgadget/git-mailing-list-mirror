Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02D5C4167B
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B743C63243
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 20:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbhKOUez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 15:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhKOT0S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:18 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E959C09A5DC
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:42:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso9521405pgv.22
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 10:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QNq04eWkofHvqqjB6c8t/UY7990x2tZv/TAV1fzHdQY=;
        b=BhVMPABG1dZUAv1vfkP6pp04bGvWQJnzpO0H1yDMH0sjFjG1cXgS3qAFy+ZZ13mSlL
         TkOMInnOBK//nOUXe/RoH7/OOZsyQTLHzPbz4e4edc9TyfA64c07TOKGmGv4UHYq6ix6
         ciwpJlzK0YDfXYOEI26KnUcEb5djev6GPv3pxHs7w1roFYna5+TusmZ3eaJVeT3dEhlD
         VojO6PeKe4rRY/yXDsApjiDNhlFn9a+ffdz2fz2MsC7st65uCu40VvmiEKJ3gKkMbzkO
         Qz4QEEcjZa8Rkc1gi+vqdVPlf8DrfusQiXw3Uyc7ALdj25oxMpkb0YOFUhbkbOO7eX/4
         ZvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QNq04eWkofHvqqjB6c8t/UY7990x2tZv/TAV1fzHdQY=;
        b=cAsSfr854vdGD5LjlCEkAhSKx1YUjdNH175PDq77qF0GoSldwbZcWCENJYd4mm6R6R
         TYeyCD3BbbIN2ZaXXMZ0NZgfNMj88EzisdIgY3p98xXPQK9NaymQuaPNsc4fNw42tdsg
         u/eXfcdOZ5yv2WNvL6exWLfokTa1BgcM1Jk4oqlJRzqH8KVSpKxCfJzqmoQTjTwTskJp
         ya+vViSwlUOVZAgyXWQzEWdJ27Vb75L5NNYnFoPDlpctFAWf117esUCcWApp3e72MmQ3
         uL1nY9WWVxT6ltonZKPNlqW9y018ffJ9+ZfQ5bveL7jR1mvV3uPCXcT+7w030syz4c3p
         W16w==
X-Gm-Message-State: AOAM5328TEVZQKjt5a05B1CorTpnVCCmJFVdZ25031Oy3T9XigmbNl+O
        zNO8hAlDutH7rRU9pDp2lNNdl4IXIA82dvKIbSxA
X-Google-Smtp-Source: ABdhPJz1EDkCMaW5/+dURePBYInCUZmIXJoSAF/nHkCPqwzkbWwHHEYnYOQdpkeje1A4dCbhiPc++Hn6Wu8CYX494Fu1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:230c:: with SMTP id
 mt12mr65789304pjb.63.1637001775792; Mon, 15 Nov 2021 10:42:55 -0800 (PST)
Date:   Mon, 15 Nov 2021 10:42:52 -0800
In-Reply-To: <20211028183101.41013-2-chooglen@google.com>
Message-Id: <20211115184252.1077901-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211028183101.41013-2-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v4 1/6] t5516: add test case for pushing remote refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In detached HEAD, "git push remote-name" should push the refspecs in
> remote.remote-name.push. Since there is no test case that checks this
> behavior, add one.

This is technically true, but reading the documentation, it seems that
this should also happen when we're not in detached HEAD. Maybe write:

  "git push remote-name" (that is, with no refspec given on the command
  line) should push the refspecs in remote.remote-name.push. There is no
  test case that checks this behavior in detached HEAD, so add one.

The test itself looks OK.
