Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A3C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A16320706
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 19:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vT/MpPz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHXTgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXTgK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 15:36:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE96C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:36:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so11749562ybi.23
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YR7bqfoD5+3P7chsw7kx3nYoKIfei1jUEgLq6aMSrsQ=;
        b=vT/MpPz0HXvzy6flFveHlYvWTl4BlkmgNeIK2b00UBoIvRjxmAtMyxg+AepxkZw9ER
         rCYLDOkOALIKRD+mC1gn/o43JCpfGOxvGsGM/asMkjpReSjKC7J5o7y56DfMJbMeMu3a
         pq0oIg+GbDBK5QgpxMucFb22ibYJKNJiV7hd+sGU8qFzp2IXqCq0hYHl6b6XJ7HyQCAg
         FUNV8Qy/0vz0GVvc5ChkloTiq0TQN3gvk56NaSyE7Q9klWAN+kKTqYqeUCBGmobLW2VZ
         ZjfJJ+PsrdX/hfZcFniNRzrltIsjOqMXci+3q7GQeoVHXuXIJ3eExoiqKwtd7Tz6V0FY
         x/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YR7bqfoD5+3P7chsw7kx3nYoKIfei1jUEgLq6aMSrsQ=;
        b=imLpdtERa0xNATukBRb/mV+UJeR8/9QRwDvQhABw+52Z4KYlq4HCChH3lqmsUfktLF
         EjPezs8aLztQ20/QW1Mbojwl6fjDFioYmuHzLxcxJdslGtObzHO0sl3icFtlOVTAn0rC
         leHQxOu/2RZRvJzzN7xtt37cw6slkSyvSrNL57I1mPegF6o9l10BHuPnhKhIkI/hUpuX
         Mur0AkseI557keoMTPMJYdbRKIUejbUiTZQPN4GxkQspN1LY+sGklj3YKIhZVkl45y2r
         ZYOB2N/ZiFZ3jL46Ocqvnpk+dX9vvj3qF4oSz5QitIFgmqLFq3w4UcTK1fBy+Q8j6iJN
         9DFg==
X-Gm-Message-State: AOAM530TR+OtwRV8r3CfnNfxKIxRBSh3ROEUr0MDgAakdylxtfLW/FqV
        3azX+9+oJMp8DTvmJDeljXdONGIyWTj2zQKEs82Y
X-Google-Smtp-Source: ABdhPJyOmcuTMrGVvEHdmoGSPenchb9a3NMvDT2Y2lJJQdFg80pIevcHHiXf3B5G9MrTmgmU04yYU+qEALzj+ka6NclO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a25:610d:: with SMTP id
 v13mr10060797ybb.308.1598297769960; Mon, 24 Aug 2020 12:36:09 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:36:06 -0700
In-Reply-To: <20200824191656.3870231-1-jonathantanmy@google.com>
Message-Id: <20200824193606.3883431-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200824191656.3870231-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH] fetch-pack: in partial clone, pass --promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When fetching a pack from a promisor remote, the corresponding .promisor
> file needs to be created. "fetch-pack" originally did this by passing
> "--promisor" to "index-pack", but in 5374a290aa ("fetch-pack: write
> fetched refs to .promisor", 2019-10-16), "fetch-pack" was taught to do
> this itself instead, because it needed to store ref information in the
> .promisor file.

Oops...please ignore this. This has already been sent out as
https://lore.kernel.org/git/20200820175116.3889786-1-jonathantanmy@google.com/
