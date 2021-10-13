Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9068C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947466113D
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhJMNgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhJMNgn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:36:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9FC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:34:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so8521574wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ilZuRUVHVFzSi+/aav25g5yKwdmUmZkTZfleoO2GSlY=;
        b=BQ3AyqfozKNnqV0cjLU3IsMTb8AKqvGBxVaS2pp2m41FSYt0acgAGFk7wDLQOQZnzm
         c/Nj3NeRBTb6bzljYNhC8ACfpHnnpVVONA7OZgollHoh32p7SRBw/q9VoShOXnbqAYjP
         ibHPMBwVSujRLltKc71unQULjKDZSy42kSok63bQOPR/zwSBtJIQNKdqFto3ac5r83VI
         O1rZYiQFI2gFtddhcfV3L4UTPBdRE0YGKY1txMW5nD963st0d7Y7jrW1xl/fmVkXOv69
         EU0q0Ne8H0xtivJWxNanGUjLnknXVmg0fDXDxmE8wVNVleQRICi0XflMXLajFQZkZbd0
         lfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ilZuRUVHVFzSi+/aav25g5yKwdmUmZkTZfleoO2GSlY=;
        b=NMZvyXEE2R5CnapYRYr/8Hp8JgBHE/JMV+eNMSIa8aUfbiGy38djFRMsAp+xiGsQuL
         IUWqY4O2DA06sjp3Y3a/Qr/gXwDhP2SjieX6ra3SrX7pdofpvHZDKr/WEbswuAdKdGX9
         zvCIFswnKOQBD0NFfed7e3sGnoI038Dj8hSWIxgHqQSvvZ1Z+BQCyG0EB35Z8Dsokvnd
         43zb5Gdg4U9xXuktK+q7IFx7mwlVyBthkWdV2YofRJRVJMJuJq3XM8ncOek58kNw1K+R
         scWtyJkgMJZVCXG/mEchxGJGKdZOI4XgrKTPd5jUCR3ZRVWpq7mziv5F/UPxeSDrO1bF
         scqQ==
X-Gm-Message-State: AOAM531BQJl8CyeEjxgMvQmF56B8BElmBvqZsvIKxHKxCAezUGy+Z8Ju
        LdzlA6CwOACq9Ad59DwT/dGeY/mTy4NcyA==
X-Google-Smtp-Source: ABdhPJxReztF90qiNop9V7/66FX/NPQruIYCjg3m+u/yhX1lO09BZKI5PoCioTLfBiqeVaiskxCwEg==
X-Received: by 2002:a05:600c:3546:: with SMTP id i6mr13086778wmq.146.1634132078355;
        Wed, 13 Oct 2021 06:34:38 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c14sm13244838wrd.50.2021.10.13.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:34:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/unpack-trees-leakfix
Date:   Wed, 13 Oct 2021 15:33:19 +0200
References: <xmqqv9239k15.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqv9239k15.fsf@gitster.g>
Message-ID: <877dehhwuq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Junio C Hamano wrote:

> * ab/unpack-trees-leakfix (2021-10-07) 2 commits
>  - unpack-trees: don't leak memory in verify_clean_subdirectory()
>  - Merge branch 'ab/sanitize-leak-ci' into ab/unpack-trees-leakfix
>
>  Leakfix.
>
>  Will merge to 'next'?

I think it's ready, but I see you peeled of the 2nd and 3rd patch. I
re-rolled a v3 which should address Elijah's outstanding comments there:
with
https://lore.kernel.org/git/cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com/

I can submit that after this one if you'd like, but having that missing
clear_unpack_trees_porcelain() seems easy enough, and will make that API
and its users leak-free.
