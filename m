Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EBFC05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 02:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBRCrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRCq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 21:46:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C553EF4
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:46:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id i10-20020a17090a7e0a00b002341a2656e5so3108492pjl.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Zqe1Z+Oc5j+ovkUdIPNltQ3CG4uDw5HmVPsBgG64ug=;
        b=h+WgJf5KSf4EVsKMz7QZr8oC6FAPGn5w9kAE7kXWCsGg+Zabde0omV42iCCNE2rAr+
         cE5hH1R//p/oNYwRNHb/joakQ/kAb/adBzBCDXABXEYUSNiQHgVCJuQqfrJfwyo6cKHL
         QYCrA0148DNoQmLH80Eizd3Y5Qxk0vNa9yiZeXWvXxiaR5b0GrKs3WP+7M125PSdx9lR
         0ygOsuYvjwwtMXOewr+X2vjjjI72AVUtHOKqLfiM5wccFtQly/DGhzDfySFqdqCDNq41
         s6B9/T3y3htfWnRJj/rlcVL7UWUcs+kPBYsjFktgkosBD9wFUrXBsToFzP/vRJgr87f8
         goNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Zqe1Z+Oc5j+ovkUdIPNltQ3CG4uDw5HmVPsBgG64ug=;
        b=nNPp9QvjN7QyWb/2zK1MB4dcKoL8vYIx3Qb2Iuw2FKPSP4OULycfPZcms86SZXUkCS
         icAEcl7CsyKCgANOcY1/K7mwkRBPYZBYyvIGlYZq+i6Kf+TOzTirLrWVvfmL3U+0qzhE
         j1DtZTN6+lhPRONE+lukoTvL+2klOqidMG9Zkdc3nz1LNJOGZPfR2xegqhNm6/DNWXrd
         6fX0/HFLQYKl+/FnNQfoGjk//t4Ze4njBGafaWTextG9gVT7OOKvMMrXTtMmIglKQ91y
         vf6Ha7LgCBzyh6QVtR4QjWdOcDmF1aRKHF9sq27dQt/VfnfTYyHq33HaupK+/GVkXOsL
         IEvQ==
X-Gm-Message-State: AO0yUKXrM5zKSH1/TL2gCbzp+jiiGv0qsDoVChDgg5nJjyMjNoOQxC4N
        T4p+XXTeNXc0Jmv7Bq3UiZk=
X-Google-Smtp-Source: AK7set9iizGYbyJrm76uiIcNdSho1NbGvfAaG9NHEQXk1xztynyfW+Pf0n5z/Heme1mPywhMw6m2nA==
X-Received: by 2002:a17:90b:3a87:b0:233:fb7d:845a with SMTP id om7-20020a17090b3a8700b00233fb7d845amr3026567pjb.4.1676688417293;
        Fri, 17 Feb 2023 18:46:57 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id 6-20020a17090a174600b00230dc295651sm3507868pjm.8.2023.02.17.18.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 18:46:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ronan@rjp.ie
Cc:     "Chris Torek" <chris.torek@gmail.com>, git@vger.kernel.org
Subject: Re: Git pull without fetch
References: <CAPx1Gvd8vizeyveKgE2o2GStQsiGxN4aaASqYc81Nk28ogFLJg@mail.gmail.com>
        <49c07b5dc2afbd422d492d59380ad2c2@rjp.ie>
        <fc7d9fdde0443532eb9c32f26f9f054e@rjp.ie>
Date:   Fri, 17 Feb 2023 18:46:56 -0800
In-Reply-To: <fc7d9fdde0443532eb9c32f26f9f054e@rjp.ie> (ronan@rjp.ie's message
        of "Sat, 18 Feb 2023 02:02:21 +0000")
Message-ID: <xmqqo7prk7vj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ronan@rjp.ie writes:

> In the scenario described, `git rebase` will always report "Already up to date"
> because the head of the current branch and the head of the remote tracking
> branch are the same. The prefetched reference lives under refs/prefetch/* and is
> unnoticed by git rebase. This is why I used `git update-ref ...` first: to
> update the remote tracking branch from the prefetched copy.

That is very much working as designed.  Prefetching is merely a
performance thing---until the user explicitly says "I want to update
my view of the other side by fetching and updating the remote
tracking branches" with "git fetch", it will not disrupt
refs/remotes/origin/* refs, and because of prefetching, when the
user finally gets around to say that, observation of the other side
with a real fetch would go faster, requiring fewer objects to be
transmit.

And if somebody wants to lie to the system and say "pretend we did
not fetch anything", then yes, _knowing_ that implementation detail
of refs/prefetch/* hierarchy and taking advantage of it by using
"update-ref" would be a way to achieve that.
