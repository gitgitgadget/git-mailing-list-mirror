Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF097C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0A20756
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mKlcUkQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789769AbgJZS3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:29:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56477 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784713AbgJZS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:29:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68E40E30DC;
        Mon, 26 Oct 2020 14:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mzK1WqAwLZNI
        APSe2b6dPXltsVg=; b=mKlcUkQMD9QZF6uNMyc1RnPOfm8oTFgbdf+7L3GHfaMQ
        K7Yl20nVCW6K2je3ouDoz/pIzk0eOQr8CpFHDejoCmZ3Pu1Vy8XJDW/bOhg+i9vv
        6t4Z7Si1ERLJrFGSdUaOCVepfvHm6P4XtnbXx9NzjFi+YeJ589C2OKDRFy2ygTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wJQTgQ
        iZmwYr6BtRzQD7VDBdSuExeEUNWAL7krWlIXQpZ3wGJd/ONVXPgBfjrVK+39T+EC
        Yq+uLOVeVtil5EtzGNf+/vUCq3HygnMObuMgE8saISMGXYyKA5vReWu2ZK/ciMyR
        h/C+ONf+CBMIRtFhoPww7z2paWNhYrcxX854g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61267E30DB;
        Mon, 26 Oct 2020 14:29:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9FF74E30D3;
        Mon, 26 Oct 2020 14:29:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] remote: add meaningful exit code on missing/existing
References: <20201026144825.26537-1-avarab@gmail.com>
Date:   Mon, 26 Oct 2020 11:29:30 -0700
In-Reply-To: <20201026144825.26537-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 26 Oct 2020 15:48:25 +0100")
Message-ID: <xmqqlffset85.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3099B1EE-17B9-11EB-8E75-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the exit code for the likes of "git remote add/rename" to exit
> with 2 if the remote in question doesn't exist, and 3 if it
> does. Before we'd just die() and exit with the general 128 exit code.
>
> This changes the output message from e.g.:
>
>     fatal: remote origin already exists.
>
> To:
>
>     error: remote origin already exists.
>
> Which I believe is a feature, since we generally use "fatal" for the
> generic errors, and "error" for the more specific ones with a custom
> exit code, but this part of the change may break code that already
> relies on stderr parsing (not that we ever supported that...).

Sounds like a worthy goal.  One thing that disturbs me somewhat,
which the time will solve without any of our effort, is how the
calling scripts and machinery decides when they can start relying on
the exit codes.  A "git remote tell-me-what-you-can-do" command that
may or may not say "exitcode" to its standard output is added?
"test $(git version) -ge 2.30 || old_way"?

The changes to the code all looked quite straight-forward and=20
the tests look sensible, too.

Thanks.
