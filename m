Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F6C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355346AbiBCWjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiBCWjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 17:39:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309F5C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 14:39:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso4380313pjm.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 14:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=F+Tjbhax3oce/OvYKIdXxXW50///4/xMfN1cxA0VGtw=;
        b=jh5XMlVKH+GwP9zVPAb7txCPafaIl87UbsDrHox4dmV/HB9dYyusHi27cN7yr5js5g
         cr0OzwYCHyg2psUGN4g3XLBAQ1wsg3OZG25UN49A7aspFnzAJiWWq9SzXuTFXzJ2n2EO
         ZxnCBVjTKzGs4E8GCyCjsX3ada5XCqbe7isHrzYCgDA0vgPwKg9+ogakaTftKFt3JONW
         Y45lIg+uvCRC5gjroahGwSIK9b53k/XVmE1dXOamw8/KByjpfDtfHJ1lpi5U9FuwXtoR
         yU0bzQ1GmEY33TM27dge8NFhm1ktypAP8naHBo23LJNTS1GLQyegJJiigtH1DoY+duAm
         yBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=F+Tjbhax3oce/OvYKIdXxXW50///4/xMfN1cxA0VGtw=;
        b=eM2Wnm3FPU6NW9+38qur26HxWEKCQdJM5Z6KKRXyu0L9wZXa1aXxVlX+Vtc/9oTY0C
         /8Z3le+0rMdNDkIqHrfr3pb5MFE35oa1UfmXjTMrn5U+1oZsako19ExKPz77BXUHdjY7
         4GN5OVtM0upWHdWg4Dp3VRwRVBsZtK2fjOQejjfNv2pj3ZjBMG5mDc3X1b+cNb7i0tBc
         1y5QS79y8K+FL8wZBym73X87QP1vX4g/HFb6PFdxjt9titLctytCH2/YYJjuG5bIJrLQ
         DZSSYbTC++m93C52sB7tjM9k5xz51xQNjxItiWxyVkNImGnVPvrnGodhMQyDW/2Fqs+T
         F/ug==
X-Gm-Message-State: AOAM533MxjjjAe0gz7SkNhqgqBkvFwx1pxUqeIM4ALdk8xLyOQU8ihjt
        5E3aAPeYvATul8LdGzVOJmA=
X-Google-Smtp-Source: ABdhPJwgkPNDKIbgggJR32ZRQS04txLS0839NqriAxzcxCa8ZjDO1KWULEMTw1Mkh/kIBZf7A/zfpA==
X-Received: by 2002:a17:903:2301:: with SMTP id d1mr127183plh.26.1643927958567;
        Thu, 03 Feb 2022 14:39:18 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id q17sm42349pfu.160.2022.02.03.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 14:39:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bja?= =?utf-8?Q?rmason?= 
        <avarab@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
References: <20220203215914.683922-1-emilyshaffer@google.com>
Date:   Thu, 03 Feb 2022 14:39:17 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 3 Feb 2022 13:59:10 -0800")
Message-ID: <xmqqczk3r2wa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> A couple things. Firstly, a semantics change *back* to the semantics of
> v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
> so that theoretically a submodule with multiple worktrees in multiple
> superproject worktrees will be able to figure out which worktree of the
> superproject it's in. (Realistically, that's not really possible right
> now, but I'd like to change that soon.)

Sounds sensible.

> Secondly, a rewording of comments and commit messages to indicate that
> this isn't a cache of some expensive operation, but rather intended to
> be the source of truth for all submodules.

I'd expect that there is a way (e.g. "git fsck") that helps the
users notice when the actual filesystem layout contradicts with what
the gitdir-to-gitdir link says, and repair the repositories when
they go out of sync if possible.

It would be similar to "git worktree", where a link between the
".git" file that records "gitdir:" in a secondary worktree and the
repository's $GIT_DIR/worktrees/*/gitdir, and the "repair" command
can be used to bring them back in sync after moving the real
repository without telling the secondary worktree about the move.

> I did discuss Ævar's idea of relying on in-process filesystem digging to
> find the superproject's gitdir with the rest of the Google team, but in
> the end decided that there are some worries about filesystem digging in
> this way (namely, some ugly interactions with network drives that are
> actually already an issue for Googler Linux machines). Plus, the allure
> of being able to definitively know that we're a submodule is pretty
> strong.

The other side of the coin is that, even when a configuration
variable says that you are a submodule of the superproject at
location X, if such a submodule gets moved out of the superproject
(perhaps because the end-user wanted to concentrate on that
submodule project alone as an independent project) and the
superproject that used to be at location X got archived away,
trusting and relying on what the configuration variable says would
not help us access the now-gone superproject.  And that would not
change no matter how strongly we declare that it is the source of
truth.

Unless we have a very good way to detect inconsistency and stop
spreading the damage (e.g. the setting thought our superproject sits
at directory X, but that location is now occupied by a different
repository that is not related), I am still skeptical about the
"setting is the sole truth" design.
