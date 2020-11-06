Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBCFC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 16:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E25206E3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgALm97B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFQbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 11:31:37 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B78C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 08:31:36 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 13so705001qvr.5
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 08:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=tuGN37UJshFSHUd519B0DHDmoOG+P0HeEVrwDY2QviU=;
        b=XgALm97B/LtqajyH9wywecAwxicBWu5gCYKjBF6IwXthShMRZG4/c4Csp9iGbZjbgl
         83NsICD158hwS5T7mUvuMEa7cAqUZKlT7ON7I0/xvE/lfyVcSEM9lqC+GLIMFiwKmhtj
         CFX6DONRVjSG9EUq0MsTYQ6jDVUkX3MNSy7CxWbNwb1MLNyl1qKBARZsjtgvGaiq4wFy
         X9EKfmUoXR9kYe18xHtzjo2KXygp6VM+WQn+kHwwLL3mxWW5f9WSQxZ2emxI7N0jOOk4
         BkPmE5XhW5ki6xlQn67k87fGqge/aNW4Voa1+NBkJ7oI8zXIZ/I/SbitR1Xom/PS8pTA
         6GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=tuGN37UJshFSHUd519B0DHDmoOG+P0HeEVrwDY2QviU=;
        b=C5FctVt4uU816a39V2c6bDrGBr+aUB2KPah6R0vwGszjK/dnqstpf3MQDDgaeG4iU4
         vHK4udRT6aHnoZaUKCaPkt2pvSm8w5H/YYmV1GdTx99SLh5Ut1AIv/YOnPDKljafdjC6
         spJ6N7GeEUNwrVKGFJlgtrSzEYpTnFwnE7zGhzGlpcwK6gb+hlvgHrMIEvLg3X8G4gXZ
         KyMrmzxgWgHTKiDw4tVVngfbOIPScWZCOdPqVogslImTCnOJydnky9SAiim1HSE+e8L9
         Vj5ohc8dYJ2TaXmq2SBjy5yaxLp7ijZvGDVfIR7D1/t+EkiJxiH+VRU4LnNCmDjTV7ho
         h4PQ==
X-Gm-Message-State: AOAM5306cyKzD8zsU/LXKTogvYjfVTt2YRVWdXtim2fDd+I4tzlexyYh
        5wAyHDcVV5GoMe9438VMv2eK/z9cYH0=
X-Google-Smtp-Source: ABdhPJxSeL1PC5zWrX62kAjWDh8bInZDFfStuhXJonjItFxC3UWfyRjle3T0oXUZ/UP+nKzkmNArgg==
X-Received: by 2002:ad4:41d0:: with SMTP id a16mr2411249qvq.37.1604680295819;
        Fri, 06 Nov 2020 08:31:35 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z6sm778857qti.88.2020.11.06.08.31.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2020 08:31:35 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: ["BUG"] builtin add-interactive does not honor 'color.diff. frag'
Date:   Fri, 6 Nov 2020 11:31:32 -0500
Message-Id: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
To:     Git mailing list <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

I tried the builtin add-interactive for the first time today, 
and noticed a very minor difference with the Perl version.
The title says it all.

Repro:

# Change the default color
$ git config color.diff.frag "magenta bold"
# Compare
$ git add -p
# and
$ git -c add.interactive.useBuiltin=true add -p 
# I'm on latest master
$ git --version
git version 2.29.2.154.g7f7ebe054a

Cheers,
Philippe.


