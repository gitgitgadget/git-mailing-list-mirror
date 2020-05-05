Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BFC3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CFB20707
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SrG/A9FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEEAfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:35:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53524 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgEEAfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:35:10 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70522BEC13;
        Mon,  4 May 2020 20:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z5AepCpd5Dw/MJNm7C1g1TUIIcQ=; b=SrG/A9
        FOFrqJUJ3GF8zTGuWCeSuUT8avBC8qQeH++RY83GSyFrPfWN7Ub8k1nhVlVmycxG
        zCesisr5wQGhcnGDGWSOJxsXzqfJIHf6uG5g4EwSkXBFX0A5tuN1iya3FVYIU1Z1
        NVabh4GemHbI3VZE1sSm5gXoIDWPsP0j6BoHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mXpSpekG0h8NkIhjr8WWehzUZzky8uId
        Dmr+5Eds16apdxFOqAfYFgnQy9btA8J5+ju/9t18PCxdsjfb/XDl16pUoK8TfOpA
        mNj+Rc99p61rH5UYTEsRTlVvYpavu9a9Y+81OCe0VFuqYxiFS3O240jxzG0/3CIi
        SLeX3uj76QQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69899BEC12;
        Mon,  4 May 2020 20:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB4AFBEC10;
        Mon,  4 May 2020 20:35:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures with file name/line number
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586538752.git.congdanhqx@gmail.com>
        <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
        <20200504174636.GG86805@Carlos-MBP> <20200504232511.GB29599@danh.dev>
Date:   Mon, 04 May 2020 17:35:03 -0700
In-Reply-To: <20200504232511.GB29599@danh.dev> (Danh Doan's message of "Tue, 5
        May 2020 06:25:11 +0700")
Message-ID: <xmqqlfm7cj7s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4404EFEE-8E68-11EA-A916-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

>> > +file_lineno () {
>> > +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
>> > +	local i
>> > +	for i in ${!BASH_SOURCE[*]}
>> 
>> this line breaks with NetBSD's sh (and probably other POSIX complaint shells)
>>  ...
> This function will be called in CI only, and when the the shell used
> is bash, to annotate the faulty line.
>
> We have a test guarding it already.

Carlo, you said "this line breaks"---implying that you actually saw
breakage when running our tests on affected platforms.  Is that the
case?

It is entirely possible that some shell implementations may try to
parse the contents of the shell function and trigger a syntax error
on that line, even before evaluationg "are we running tests and do
we have BASH set?", so I can believe "we have a test guarding", if
the mention refers to the first line of the helper function, is
insufficient and does break with some shells.




