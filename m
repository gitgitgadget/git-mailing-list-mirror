Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952BEC46466
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 03:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1422078A
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 03:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNbk3XQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgJCDuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 23:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCDuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 23:50:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79007C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 20:50:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k3so3772692ybk.16
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 20:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PlyBBeOrBvKrol8yw17xdCaW5UE5jq032MGefNrnGuc=;
        b=YNbk3XQMhJCUr0M6Zqn+rcD+/uKNvFiMWxBJghDPPrjEizPdIB6K8gzNoqxRg+No25
         JLe/h8yujZ6DJeRMHJibkbQ9XY9kwfO3CLWwagxqjiEcBmCJivANz5a7CeiGIyUaYkuC
         56hqKAlTcKtqaaYAMLdKnxH05U7NMOtKI4pveOX3EHW/Eu8ed/DKXNF3Ep0EaNIdYnBS
         rp7jxUHG2sLcLnblH1Kwd/d/ALt28tsIFNac41uDX42lJtzbqiGzErTnoqg/BM8iQMMz
         JSeMxN7sQM+Urf71U8uu5vhKNFiujBeflGC3YBPTaYPaj+LP9OqEPucU2/7yPBRrslST
         8ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PlyBBeOrBvKrol8yw17xdCaW5UE5jq032MGefNrnGuc=;
        b=ujxGd7FBs+WGqnVA8i9VPqEaymDVWLth1n1wKrCbobAJQH8Nzw9RKmSrxn+gmiItZt
         ODxY3RkIODLMjq6MF9mi1tILXxGZu+CqTY1gMj9PNthA/oc+bnjTc05HTnAmmnyfPomg
         e1gXnxXVbe5ejv3J/0MBqSLRYhcO6KJ+Iq9VRQ1Bam2IIrgKf+zN6kUzX3RSpv/G83nP
         looahesuJpJjmuRxJc4HlHeDKEuGgoXq/u5Nz7RJGv6AdKZff+ZEcY6I591nwUtP9IzZ
         VAaZ4xcdfWe44r1hTzJXwgC3tmGicofFXY4QPoWt9mc6C2jzdRq7ixJxUnUdRhBKJvmg
         RqOQ==
X-Gm-Message-State: AOAM533aXJc6wY/tcWkBzCebQQKvrcAdvEhbWK7CkCL0o86heehyHGIC
        6+b+pfTa869NMACw1+AdMIDi/vIisp1q
X-Google-Smtp-Source: ABdhPJz2Ywhzy9kD5bHOcpNuzEqX5UNcRYBGXEUJZEGaiF6K4ppP5VQmjSz6VeMQmUh9DAunbr3Tbw/wxd9t
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:6b48:: with SMTP id
 o8mr7552349ybm.16.1601697051624; Fri, 02 Oct 2020 20:50:51 -0700 (PDT)
Date:   Sat,  3 Oct 2020 03:50:50 +0000
In-Reply-To: <xmqq8sco8era.fsf@gitster.c.googlers.com>
Message-Id: <20201003035050.151766-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqq8sco8era.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> If we have a setting of "core.recordTimeZone", do we need to make it
>> as a command option as Junio suggested earlier?
>
> Usually we add command line option --[no-]record-time-zone first
> without configuration option when introducing a new features like
> this one.  Once the feature proves useful, we'd add a matching
> configuration variable for convenience, but leave the command line
> option (negative form in this case) so that a configured per-user
> default can be overridden as needed.

Any recommendation as to where to add this command line option?
Should the option be added separately in "git merge", "git rebase",
"git commit", "git pull" and other places as OPT_BOOL?
Or could it be added directly to handle_options in git.c?
If added to git.c, it will only be added it once.
Then an environment variable(such as GIT_RECORD_TIME_ZONE) can be added
to save the option and datestamp in date.c can set offset accordingly.

