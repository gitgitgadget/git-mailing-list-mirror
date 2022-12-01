Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A11C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 01:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLABCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 20:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLABCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 20:02:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4646B11C3A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 17:02:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 140so413859pfz.6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 17:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5O//x4TmAcKcF71d+cFjriVhhKkHad8jr9gzPI5MjA=;
        b=qfFezGXV2ONWPlRHVgFPILpn8g70VKXZoUoGip23faTlKrb1y6Mn1KfwYXy8ooB6FY
         zpcQHuSKR3tejucbgCjK1Zb9quVaQrjLmjt4nl+0legTiTFlx0xalPO1NsW7jKSlULWy
         Gv224XxqTPYNHZsdJGJycX6+IV1b0GtfTi6it6IupynAlaJCQ8+VeL6o0ALOoHIsCNNy
         BH3t3P8O/tOEgG5+pXOlD/+4IRCaKVa4OxmNjJdwrGgJIx1R1ta6FIhLxRWFu1O0Zj/d
         EMxercXIe5XPkI2pcRRcrfH79bb0vP1o22hYrMDQtS5pN8JKST2beTgrCbKeQ6wr1YBd
         QrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5O//x4TmAcKcF71d+cFjriVhhKkHad8jr9gzPI5MjA=;
        b=4cthpLZhh/jvclcNTFLR1XVFHczQWfVTdG9d+KG6fTOaaOiykT6/QK0zW0xSS1E50W
         tu+/WA/VqdIP13+w/fKmYYZpEecveby49NSrdn3mYjGAfNLpgFstiI+o6/eQo6bWfERk
         ejwRgO9omMMlIubUOdo7z3j3taWnCoFBzHBsfqGKA8CF+C1botCvmJNxXUkVQ4c3VEYZ
         X81qJw5r2k7MZdGqgpOsBfjxrVzmr7YX7HNToDzEb0mBCwiC4WvQt/UKBhw+H/aOzCSK
         kVakTjB1pyyOK/mh0P4j9qdFeqBfC/1knxEoYb1RsHQmdFsWyDfM5I+v00+nsSW+xdBg
         axMw==
X-Gm-Message-State: ANoB5pm186AQ5F017enzUIkcP6/NFpXJux9lzEia6OYFE1KQt6FBdV6R
        HB8yr2TgAaeZvNpo666EpUM=
X-Google-Smtp-Source: AA0mqf7x86Bp5s2gW6rFZvjTWKvCODRJq5JiNQBovleVbfDp+yKyR1NGQjIG3MmQwPX7RpB7WRjhrw==
X-Received: by 2002:aa7:854d:0:b0:56d:6e51:60ee with SMTP id y13-20020aa7854d000000b0056d6e5160eemr43941302pfn.25.1669856566603;
        Wed, 30 Nov 2022 17:02:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016c9e5f291bsm2139801plh.111.2022.11.30.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 17:02:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] diff: build parseopts array on demand
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Date:   Thu, 01 Dec 2022 10:02:45 +0900
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 30 Nov 2022 19:01:22 +0100")
Message-ID: <xmqqh6ygszpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Calling repo_init_revisions() and release_revisions() in that order
> leaks the memory allocated for the parseopts array in the embedded
> struct diff_options member.  Get rid of that leak by reducing the
> lifetime of that array.

Makes sense.
