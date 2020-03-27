Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E2C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67C62072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jti+lJ/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0V1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:27:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53332 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0V13 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:27:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 787F663171;
        Fri, 27 Mar 2020 17:27:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mXMmYYqZ/vLf
        +3vlwN+34EiQTqg=; b=Jti+lJ/YshxF59eDhmEWpiyCC9lOP2/6Jh9UNGsLELv2
        XZkKwSfB/15rEt/Fm98iQXinCe9tejpIyBU9u7Dofpf9HjrzqlJHmdWW3pcQANsV
        u7Hp6WqVIIo64I9ZrJ+tyrRlibTpK7g6yz+Rq3+CW0s/Bi0C9em1+9JUmL57IaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sTOebU
        x7iMurry5jSkIJ2hi/OBGU5l3mHsYRYVttB12OMAAvqcipWFgTdjI2il1gzqr0zW
        NHjGpZSDu0rJ7Q6X/ryp7YLi274hyogq4A/4TKRGYI8KtBqxZ6WEiuM73vnZzQwD
        shiQQlwsQjjMQvAL07aDUN4bZ5zLgDGX9evXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F75363170;
        Fri, 27 Mar 2020 17:27:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F20216316F;
        Fri, 27 Mar 2020 17:27:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?utf-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
        <tboegi@web.de>,
        =?utf-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>
Subject: Re: [PATCH v3] run-command: trigger PATH lookup properly on Cygwin
References: <pull.587.v2.git.1585143910604.gitgitgadget@gmail.com>
        <pull.587.v3.git.1585269403947.gitgitgadget@gmail.com>
        <xmqqeetdhdxo.fsf@gitster.c.googlers.com> <877dz5bpyd.fsf@igel.home>
Date:   Fri, 27 Mar 2020 14:27:27 -0700
In-Reply-To: <877dz5bpyd.fsf@igel.home> (Andreas Schwab's message of "Fri, 27
        Mar 2020 19:41:30 +0100")
Message-ID: <xmqqd08xfpz4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C2349DE8-7071-11EA-9D36-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On M=C3=A4r 27 2020, Junio C Hamano wrote:
>
>> The name of the ASCII character '\0' is NUL, not NULL
>
> NUL is not a name, it is an abbreviation or acronym.  Its name is the
> Null character.

OK, let's put it differently.

> +	 * See how long the non-separator part of the given path is, and
> +	 * if and only if it covers the whole path (i.e. path[len] is NULL),

When referring to character '\0' like so, write "NUL", not "NULL",
as the latter is how you write a null pointer.
