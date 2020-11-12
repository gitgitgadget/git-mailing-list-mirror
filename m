Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F34C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BD92100A
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rh3Umh1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKLR5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:57:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57447 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKLR5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 12:57:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4546AA27B;
        Thu, 12 Nov 2020 12:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2TKJdqliFspP
        NEdgvokukEyw/84=; b=Rh3Umh1rrUpAnxw8e+5cXuV1fnCNaIUbckp6jHLbRzsa
        A6YNkyV87V3mZ6a9Acp9+ipGUuqEqGW5y+SqqMfnJ2X7xCBjdOnCvOvyCbNoExj5
        Bo1EGSJPy1OB3IYJhNd2nBbI/5tc8TbPaVR+ANqnXVGzBOT9KEzv3z106veFx5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Xx5ugL
        KzXI32J5eVUrCgsUWaQQW0hjmrwyRC3oVh9/fD5UQ/xfgAaQyUpVvtv6s4AVUu3v
        878tYFAvjERpfP0LOamkrw75fHuS/DI2yajHv25+GEHSCo6OqzuwB9/jSrIk1EeH
        XmjdD3fuiMlJqsp9uSNpl7lKOD+YDw3k/ZJiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB97FAA27A;
        Thu, 12 Nov 2020 12:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3FAB2AA279;
        Thu, 12 Nov 2020 12:57:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git format-patch --range-diff bug?
References: <20201112174353.GD4270@szeder.dev>
Date:   Thu, 12 Nov 2020 09:57:46 -0800
In-Reply-To: <20201112174353.GD4270@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 12 Nov 2020 18:43:53 +0100")
Message-ID: <xmqqk0uqjw4l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9284C7CC-2510-11EB-9DDA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> 	: The output of the range-diff command is what I would expect to be in=
cluded in the generated patch &&
> 	git range-diff v1...v2 &&
>
> 	: But that is not what we get embedded in the generated patch &&
> 	git format-patch -1 --range-diff=3Dv1...v2 v2 &&

The other day I did something similar and ended up with

	git format-patch --range-diff=3Dv1 v1..v2

Would it help not to use the three-dot form?  From my reading of
"git format-patch --range-diff=3D<previous>" description, it only
needs to give a single range (i.e. previous side of series of
commits) as the other range to be compared are by definition the
patches you are producing, while v1...v2 syntax is to give two
ranges with one option.  So...
