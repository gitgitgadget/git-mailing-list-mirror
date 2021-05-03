Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC48C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A2D61175
	for <git@archiver.kernel.org>; Mon,  3 May 2021 11:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhECL0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhECL0j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 07:26:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CD9C06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 04:25:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so7273749ejc.10
        for <git@vger.kernel.org>; Mon, 03 May 2021 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YtsHv/r0104TwCV1doRGTrgWURMvLSrSN6dkfmBsIoM=;
        b=AIVrMI31cydjhVS8zTfjmRsE9r+5Saf6z23/ZUeQME+Usv0hiuFsXJT0ZudqjvfywW
         7emvgEwRfED3p3V5KZeA3Gea+xr0TI1T5YVTHZ+S2EkMs8KzqQYZ5FNdBOsaXscT2Si3
         F9f8IO+CeC731SL/flLKgiBNPFnr+fiy6hAJLLXVwixv5IKjC9jV17WfXW+r7hQTPETd
         b1ObzFSgKZ/FLJTNQThoR/oJNKhsAaONsRaNTunLvzRLKRZ6dEkUHaoi6ewvg/rc5Jx7
         Fso5e6r808NSkNv6nU4U9wlZ5g1LJE5Uu8d8ne9pfKgX1HD40zFQBk6mKwbZAVyO4lAQ
         pOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YtsHv/r0104TwCV1doRGTrgWURMvLSrSN6dkfmBsIoM=;
        b=ImHiJw2nwGub+dQYrQZW2m5JG2WhlXkjS/dqrn9+B3t5YaACBmxYl7dDYRrCpfhIGw
         3gzD9zP8vw+WfVNHdvtir8/uzmuYyJgUVJCukFD/zKypodChy4ZeNq91pu6CsJcY0WMd
         BK5ye3QTOm9VaD49ibpqL+7Jl+4H0t/K2XsCCZ2ODkfxIoCS9WbeMjuugLdqtpQQiasl
         ceNPV6niwwy/IBOel0s2l6oEgeCYqWWXlZRUVzo90vhmvV3PO8CLiWypQmouZ0KZFl72
         FNyI5EZ6bmZWScYxAf2LdQb5RZZTDkd0ku8X4rjIoCiOYVLuEgXhg4s47IjXoWs/Uhkr
         muag==
X-Gm-Message-State: AOAM533mVql/OXyi+TpxIXwvJRLkiKrYIec1VjprMJBB8JdRYe2grjJy
        88pghKkHKdc7vii/YWxYDwICD/aHLtU=
X-Google-Smtp-Source: ABdhPJzOEXaO4YndehxSF59hm4wTxFG+zfooYLPt9sUmDWM/fE4w387TBBKbs/0k4XUtmoHQdl9PsA==
X-Received: by 2002:a17:907:2176:: with SMTP id rl22mr11822183ejb.155.1620041145190;
        Mon, 03 May 2021 04:25:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u6sm10332407ejn.14.2021.05.03.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 04:25:44 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/9] fsck_tree(): wrap some long lines
Date:   Mon, 03 May 2021 13:22:13 +0200
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12t5gzfzIxvZs3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YI12t5gzfzIxvZs3@coredump.intra.peff.net>
Message-ID: <87v980vz2f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 01 2021, Jeff King wrote:

> Many calls to report() in fsck_tree() are kept on a single line and are
> quite long. Most were pretty big to begin with, but have gotten even
> longer over the years as we've added more parameters. Let's accept the
> churn of wrapping them in order to conform to our usual line limits.

If we're going to have the churn I'd say just wrap the rest of the file
as well, now it's mostly-consistent in having these long lines.

FWIW I think having the long lines makes things more readable in this
case, but the inconsistency is worse.

If you do take me up on refactoring it more generally, there's also the
one mis-alignment of an argument list to report() in verify_headers().

I wonder if this whole thing wouldn't be better by declaring the format
in the msg_id_info struct. I.e. add this to fsck.h, but that's an even
bigger change...
