Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E1C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbiCISD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiCISD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 13:03:56 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301899FD2
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 10:02:56 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB53518EA20;
        Wed,  9 Mar 2022 13:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=83qjq6Y6Seaz
        LT5zdvPsTrUgVTXoS0i8aet+TIql5C4=; b=f5QEb+EFi8885no35INmWz6DNyXp
        XwCgz64XP9SsoHxs2vKCQRZ9XMjic4js5glukCqkBq3ZZPFgpk3PLn/CX66+FfQk
        BAx2K3uQGbpxLD7h7qWzM/g0aSSbH6+Dk6S/vzlUI7th3KEGpmuVr/eWvBGX/P9j
        mXU8gBi7YnHmHtY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B408418EA1F;
        Wed,  9 Mar 2022 13:02:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1CFAF18EA1E;
        Wed,  9 Mar 2022 13:02:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nuno =?utf-8?Q?S=C3=A1?= <noname.nuno@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: git notes question
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
        <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
        <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
Date:   Wed, 09 Mar 2022 10:02:51 -0800
In-Reply-To: <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
 ("Nuno
        =?utf-8?Q?S=C3=A1=22's?= message of "Wed, 09 Mar 2022 10:11:16 +0100")
Message-ID: <xmqqee3bm2b8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2354E3A2-9FD3-11EC-A7B3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nuno S=C3=A1 <noname.nuno@gmail.com> writes:

> AFAICT, git-format-patch looks to be using --pretty=3Demail and I think
> we can use --pretty in git-format-patch but having to mimic the email
> format "by hand" is just painful and I was hoping a better way could
> exist.

Well, this time it was "Notes:" label, but the next person who
wants to see a deviation from the canned "email" format would want a
deviation different from yours.  Perhaps they want a different way
to format the author name?  Perhaps they want a different way to
separate the title (to be on the "Subject:" line) out of the commit
message?  Perhaps they want to see the log message be indented?
Perhaps they want to see the message from the notes be line-wrapped?
Perhaps they want to see the message from the notes not to be
indented?  Perhaps they want to see the "Notes (amlog):" label to
format the name of the notes tree differently?

Where would that end?  We have to draw the line somewhere.

The customizability via --format=3D<template> is given for these
people who want to futz with that line.  One thing that may be a
good little project to help them is to make sure that the vanilla
"--pretty=3Demail" can be reimplemented as "--format=3D<template>" (I
doubt it is), design a way to fill the gaps (if there are) to get
there.  Once that is done, write down the "--format=3D<template>" that
is equivalent to "--pretty=3Demail" somewhere in the doc, to give
those who want to derive from the canned format some reasonable
starting point.
