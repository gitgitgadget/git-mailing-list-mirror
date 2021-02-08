Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EFDC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C07264E8F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBHXos (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:44:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51671 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBHXod (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:44:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6440124573;
        Mon,  8 Feb 2021 18:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PNks0Xp9K6P6xUjD/2LbIp7r6HE=; b=RZKoi7
        XgWf2lxOEPWI7NbKDXnWH8rA5R96XzQnVVsimIDKaMn7DOUjw810yxTUvSNxjtA1
        /Mu9b8i+T9mFovMUIWxdORnSj51mrygkkjmuOsIoURYooVe6vFpGajccZWgYrAbX
        0vwlB36dZAn17tDGzZ2dYkQRaLcAZg0QnfX6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dS5QgK6ArMgKA8FIwt7x7+I5AZiXbTA+
        wW34xe7j+BByh3Xyj+dkzCYZf13l+ujJw9NhmjG5oOzbu15UF8QGG3EBHFgRoyX4
        smqDazQPVZQ0cUBdiR717uZK14SvXXr4+pM+8PRie428pI67nZ7HE+ow4V+I8Upy
        q8g5evtUvAw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADBCF124572;
        Mon,  8 Feb 2021 18:43:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E341D124571;
        Mon,  8 Feb 2021 18:43:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection
 based on basenames
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
        <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
        <xmqqsg677j2u.fsf@gitster.c.googlers.com>
        <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com>
        <xmqq4kim7964.fsf@gitster.c.googlers.com>
        <CABPp-BH_DWEE-3M96e=PPNwDqeYPaax9s1kBDhS8a6GtxsW=Mg@mail.gmail.com>
Date:   Mon, 08 Feb 2021 15:43:40 -0800
In-Reply-To: <CABPp-BH_DWEE-3M96e=PPNwDqeYPaax9s1kBDhS8a6GtxsW=Mg@mail.gmail.com>
        (Elijah Newren's message of "Mon, 8 Feb 2021 14:00:30 -0800")
Message-ID: <xmqqzh0e2kib.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 799D2FBE-6A67-11EB-A89A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm sorry, but I'm not following you.  As best I can tell, you seem to
> be suggesting that if we were to use a higher similarity bar for
> checking same-basename files, that such a difference would end up not
> accelerating the diffcore-rename algorithm at all?

No.  If we assume we use the minimum similarity threashold in the
new middle step that consider only the files that were moved across
directories without changing their names, and the last "full matrix"
step sees a src that did *not* pair with a dst of the same name in a
different directory surviving, we know that the pair would not be
similar enough (because we are using the same "minimum similarity"
in the middle step and the full matrix step) without comparing them
again.  But if we used higher similarity in the middle step, the
fact that such a src/dst pair surviving the middle step without
producing a match only means that the pair was not similar enough
with a raised bar used in the middle, and the full-matrix step need
to consider the possibility that they may still be similar enough
when using "minimum similarity" used for all the other pairs.

And because I was assuming that requiring higher similarity in the
middle step would be a prudent thing to do to avoid false matches
that discard better matches elsewhere, my conclusion was that it
would not be a useful optimization to do in the final full-matrix
step to see if a pair is something that was a candidate in the
middle step but did not match well enough (because the fact that the
pair did not compare well enough with higher bar does not mean it
would not compare well to pass the lower "minimum" bar).


