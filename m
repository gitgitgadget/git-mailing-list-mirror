Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FED0C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A13764E1F
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 03:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhAaDlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 22:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhAaDlN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 22:41:13 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BEC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:40:33 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b81so8364396pfb.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 19:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qpmbFM/LA4EYrahGLddOz1G/YRhy/VpOs8UuJ1H9nJ0=;
        b=D9AeYBAWZCw7czWTj2l9HVeCS6tTFBRZWvJ+Oa2L7yuiRrs1lImXGJYnR//aI362ez
         0USsHwGpTiBRb0oOr3xolgHW/N9UkV55S+KTk1OwDUg9DPYQlw6xbh4+qC34vc/f9NRr
         fHlejCcLmK5NUUDiMM8Tb4cC6OaKJjagfj65M36JOq8l2bBV/N6iDReMSMieKtHDPhMP
         JN4Q/BRYAhB4EBiljEJ64v/ox4k4pRAkvCCF0ITl5ggufc/Ld4gsOMch2sGbev9Bolv4
         NftiR/ZTE3IAk+3X7TzaLweydt5w7/wUVjMo2KZcN0dFewC6yvTjUCJ0FSs+7G4iBF1o
         5gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qpmbFM/LA4EYrahGLddOz1G/YRhy/VpOs8UuJ1H9nJ0=;
        b=TrA71lZA9/XirpfIc+F7OLbePHZ0AzsQ9T4kU8UBc5P0gmaqjZ610JJJv3imYfjoFL
         LCbR4K42iOxvbZuA8u+yyEjrFTgyUNrfWG+0qJ0jduAvVj79vDoN0D9vRddt5kFo4SKt
         g7QVM1YN+4vh2CeMnA+Kcs3xOLEad+tu4ljptGxtRWhbEyfmnzJyiAcL902oUQgx6FX3
         hvhZpDW/3rKT9mUV/ArEfp8vn+oQHaFdIx4JeAUHZlzIh+ASX1T3ZMTeF9rPHA3AZQL8
         Yi/RqZlvUOfVhn8GQuy8IXseSJE3o1pqLUd3JsmvHeHVDax8HJB2K1SCQs268Z4TEZ7D
         pxmQ==
X-Gm-Message-State: AOAM531GESJiWjPJ743m/HKhnN3C7SZzTTIxIAiCHTw6D4rgKPBjz2iX
        goS7U/An3Npe9m8hmu17egnH6hv0Lph+LicajvqP
X-Google-Smtp-Source: ABdhPJzuQ6vlzNoONDs3RZyLBAHM32CZdyn6/x/ctdjieuyzGb5XXZ/zn09Vd7+QMG/HGvb/aGKirtx7nMkbJcaJVCpY
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:1cd4:0:b029:1c1:2d50:94c9 with
 SMTP id c203-20020a621cd40000b02901c12d5094c9mr11012136pfc.31.1612064433108;
 Sat, 30 Jan 2021 19:40:33 -0800 (PST)
Date:   Sat, 30 Jan 2021 19:40:30 -0800
In-Reply-To: <20201222000220.1491091-7-emilyshaffer@google.com>
Message-Id: <20210131034030.1025259-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-7-emilyshaffer@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v7 06/17] hook: implement hookcmd.<name>.skip
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If a user wants a specific repo to skip execution of a hook which is set
> at a global or system level, they can now do so by specifying 'skip' in
> their repo config:

Usually the present tense describes the situation before the commit, so
maybe s/they can now do so/they will be able to do so/.

> -static void append_or_move_hook(struct list_head *head, const char *command)
> +static struct hook* find_hook_by_command(struct list_head *head, const char *command)

"* " -> " *"

[snip tests]

For the tests, I thought of the case in which we skip a hookcmd that was
never specified as a hook, but that's probably not very useful.
