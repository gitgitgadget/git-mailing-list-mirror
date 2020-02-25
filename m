Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288EDC4BA02
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CD42176D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qxHzKROy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgBYWCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:02:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61292 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgBYWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 17:02:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E845FB1A0A;
        Tue, 25 Feb 2020 17:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pNJyXqaPP0bNiPMFGIhRJB+8Ubk=; b=qxHzKR
        OyGmRRKNZb9Xrsvzzfxbj3DO37UWAr4u3u96V2U9rjHHwcgv30Fu2RaeNlcsDrUT
        1hMeVghLtXoPH8yb/J6bv6Ci8CgtQOCzrfJliwoaUJVXsUzHLW0PcA+Vy3nEQFg8
        SHgb9iHz17fneN8yLkmWFYqeANw3TPmjO6BOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v7ep6r7rCo83iywUjWzp5c/qQIrYEVos
        hOHauTH2a4vs57kHMmtz3XMKTmcSFQYqoKtzTJRiHoIRWMEF4mqhOYq0Rd66nZlO
        3GVdoAhXqE8NM5AHh1nQc2Egf7zv9sMKhiN/W0WXsa/inOEuFWebFW5DuVX1Snr2
        QMIKON3afDU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E036CB1A09;
        Tue, 25 Feb 2020 17:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 065F6B1A08;
        Tue, 25 Feb 2020 17:02:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
        <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
        <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
Date:   Tue, 25 Feb 2020 14:02:34 -0800
In-Reply-To: <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
        (Heba Waly's message of "Wed, 26 Feb 2020 10:19:25 +1300")
Message-ID: <xmqqy2sql405.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 887B9D64-581A-11EA-AE25-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> I wasn't very happy about having to keep the list of config keys in
> memory, but that was a good enough solution for now.

If you force your programmers to specify the advice_type as a small
integer, and the setting is stored in the config as string keys,
somebody MUST have a table to convert from one to the other.  So I
am not sure if it is even sensible to feel unhappy about having to
have a list in the first place.  Are we looking for some kind of
miracles ;-)?

On the other hand, it does bother my sense of aesthetics a lot it
our code forces our programmers to give a small integer to us, only
so that we convert that integer to a string and use the string to
look up a value in a hashtable, every time the program wants a
lookup.  Performance-wise, that's not a huge downside.  It just rubs
my sense of code hygiene the wrong way.

Especially when the primary way for our programmers to specify which
advice they are talking about is by passing an integer, and if we
need to have a table indexed by that integer in the program anyway.

We could instead do something like:

    /* advice.h */
    #ifndef _ADVICE_H_
    #define _ADVICE_H_ 1
    extern const char ADVICE_ADD_EMBEDDED_REPO[];
    extern const char ADVICE_AM_WORK_DIR[];
    ...
    #endif

    /* advice.c */
    const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
    const char ADVICE_ADD_AM_WORK_DIR[] = "advice.amWorkDir";
    ...

and the callers can still do

    advise_if_enabled(ADVICE_NESTED_TAG,
		      _(message_advice_nested_tag), tag, object_ref);

with the benefit of compiler catching a silly typo, without having
to have any "enum-to-string" table while letting the config API
layer do any caching transparently.  As these calls will never be
placed in a performance critical codepath, that might be more
appropriate.  

I dunno.




