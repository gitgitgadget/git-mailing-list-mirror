Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABEAC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 23:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbiEFX72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 19:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiEFX71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 19:59:27 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0A22299
        for <git@vger.kernel.org>; Fri,  6 May 2022 16:55:39 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E756411BD2F;
        Fri,  6 May 2022 19:55:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/kVp+LW4lwNN9O9GLlcAyn/gMlzTefek6DlDXe
        81oc8=; b=PynDOvY2OLHTlwe90rtKTNsF9ZqxqwxrmAhPozJd92A1yd+FW3vt9z
        PyK8P/6H80jiIJgddhZiK0WiigIllQ+JgF2RdO/LkplCwQwidGNVy20KAbGdG/+P
        em4Ytm6PbSNahxlPWEQgQuXzxvOwnEFGilZUzZbfWT1toJBjxzaFU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEAC111BD2E;
        Fri,  6 May 2022 19:55:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5282911BD2D;
        Fri,  6 May 2022 19:55:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com>
        <xmqq7d79gjre.fsf@gitster.g>
        <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com>
        <xmqq1qx6jq0b.fsf@gitster.g>
        <CAPUEspjOPNTMrBdLQMKcbXYY7G+Vm1br++7C3rq6Bs+5xZ4yHg@mail.gmail.com>
Date:   Fri, 06 May 2022 16:55:36 -0700
In-Reply-To: <CAPUEspjOPNTMrBdLQMKcbXYY7G+Vm1br++7C3rq6Bs+5xZ4yHg@mail.gmail.com>
        (Carlo Arenas's message of "Fri, 6 May 2022 15:57:13 -0700")
Message-ID: <xmqqfslmi5c7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06BEC08A-CD98-11EC-9DD9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> makes sense, but I still unsure about the two questions I had above:
>
> * would it make sense to make it run ONLY if both variables are set to
> YES or is it enough to use one (most likely the GIT_TEST one) that we
> would enable independently in CI?
>
> the advantage I see of having both variables is that it is even less
> likely to even run accidentally in a desktop somewhere and maybe break
> that test, and also keeps the meaning I wanted to attach to it with
> that ugly looking flag that no one should ever try to enable in their
> workstations unless they really know what they are doing.
>
> The advantage of ONLY having the GIT_TEST one is that it will be
> easier to enable in CI and for whoever wants to play with it on their
> workstation as well, but might still encourage people trying to make
> it work and wasting their time.

Those who want to use it in CI would need to be told (or have to
figure it out) by the patch that adds either IKNOWWHATIAMDOING or
GIT_TEST_WHATEVER, and as long as the patch does its job well
enough, I do not see much difference either way.  The only possible
difference is if we use IKNOWWHATIAMDOING then a special CI job that
may run with tweaked /etc/sudoers would run the test in this series
*and* the other test we borrowed IKNOWWHATIAMDOING from, which may
not necessarily be what we want to do.

> * since we have to enable CI for these to be useful, would that be
> something to be done in an additional patch as part of this topic
> branch and you will only pull the commits before it to maint to avoid
> conflicts, or should it be done completely independently as a mini
> feature branch that depends on this one that will be pulled to seen
> and merged downwards from it?

I'd expect that nobody pays attention to GitHub CI runs on
maint-2.30 - maint-2.35 branches when I push out.  I am hoping that
these fixes are built on maint-2.30 _without_ CI integration (i.e.
the SUDO tests won't be run due to lack of IKNOWWHATIAMDOING in the
CI environment).

A single branch, without CI integration, based on maint-2.30 would
be prepared.  Let's call that cb/path-owner-check-with-sudo topic.

It is merged to another branch, based on v2.36.0.  Let's call that
cb/test-path-owner-check-with-sudo-in-ci.

On that latter branch, changes to CI to tweak /etc/sudoers and set
IKNOWWHATIAMDOING would be created.  That latter branch will
percolate down starting at 'seen', through 'next', 'master' and
finally to 'maint'.

After all that happens to prove the primary topic (sans CI) is
sound, the tip of maint-2.30 would be updated by merging it, i.e.
cb/path-owner-check-with-sudo, and then the result would be merged
to maint-2.31, ..., percolating upwards to maint-2.35.  The
resulting maint-2.35 may be merged to 'maint' after that but that
should become a "already up-to-date" merge, I would expect, because
'maint' by that time would have got cb/path-owner-check-with-sudo as
part of merging cb/test-path-owner-check-with-sudo-in-ci already,
and the merge of cb/path-owner-check-with-sudo is the only thing
'maint-2.35' has that hasn't merged to 'maint' at that point.

> true, but the apparent check for ULONG_MAX (which should have a
> comment added) was really a check not to overflow when assigning the
> value we got into uid_t, by sacrificing an unlikely to be valid
> ULONG_MAX as an uid.

Are you worried about uid_t wider than ulong?  strtoul() with !errno
test covers the case, doesn't it?  SUDO_UID cannot have any integer
that cannot be represented in uid_t and if strtoul() does not say
ERANGE, we know whatever value in SUID_UID did not overflow ulong.

> it ALSO avoids someone trying to sneak a value that would overflow in
> one of the most common configurations we will run where sizeof(long) >
> sizeof(uid_t) && MIN_UID_T >=0, by using an equivalent to MAX_UID_T

Sorry, -ECANNOTPARSE.  If strtoul() can parse everything in uid_t
then where is the room for overflowing?  We are trying to protect an
unsuspecting user who temporary has become 'root' via sudo, and not
somebody deliberately hurt themselves or others by setting SUDO_UID
deliberately to strange values (once you are 'root', you have easier
ways to hurt other people).
