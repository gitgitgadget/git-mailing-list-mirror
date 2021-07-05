Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C56C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A586196C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGETyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:54:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64669 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhGETyt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:54:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FF7312952B;
        Mon,  5 Jul 2021 15:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=12EZAcQTsCtE
        EM4bsCN4/B4SuFZ5+OKEPV9eksE7cEg=; b=YVDLy7pLPPOlucLjM5gVksX1fvF9
        qo8ADppsqGHAecbbbqt2EiBSOweW/NC6M58akTesM8JL2fLhSFbT4d8aLEg/RioK
        fs2tuy89DXKqEQ2FShUtwgWWJzd6Sk3du9sn4xH7WsiWieJcbTUUi8Gp/ftuvrjO
        D+70XdsTfGLoNss=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58DC6129528;
        Mon,  5 Jul 2021 15:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D65F2129527;
        Mon,  5 Jul 2021 15:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
        <xmqqczs0popg.fsf@gitster.g>
        <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
Date:   Mon, 05 Jul 2021 12:52:07 -0700
In-Reply-To: <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 3 Jul 2021 22:03:25 +0200")
Message-ID: <xmqq8s2kmtco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7C07724C-DDCA-11EB-93B0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> True, but the scenario described on StackOverflow is a bit different.
> Commits were filtered out, and branches still pointing to them cannot
> be deleted with "git branch -d" or "git branch -D".  Git fsck only
> reports them.

I have a feeling that the "filtering out" process shouldn't leave
these stale branches hanging around in the first place (in other
words, it's the job of such a tool that deliberately "corrupts" the
repository to remove these branches, so that the user won't have to).

But I agree that it should be easy to recover from such a deliberate
repository corruption.
