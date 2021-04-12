Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355CC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE56061289
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhDLThs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:37:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56828 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbhDLThq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:37:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 191F0118A55;
        Mon, 12 Apr 2021 15:37:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PodWKnPitltz
        SHI1dEGSYFdtstQ=; b=mgxZKIhrPnYS5sxLl/lJzD21qhu+MFxXs9XeK18fgu5+
        GddSaG7VlcO+QtUdqTA0n6+mqikLr+tZgeo4A4oGEUUM1RFXpMH3M+lIGSpNP94N
        iN0g+rmz2XUF5VNYDO5IKXpOwa0AViIyssngWM3vM7pI6CEBBvqZ/VpdCR0/yww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YgF8Az
        cvNmudxKk+EJExBlYchu23DbNow51l0uBKTQOKo+9hD5cZSxZ0ERdlgvvHYAgy3s
        ePn6ZMSY4QTxnjrjLkkJVE0oHzoDrQyZZjNzFHcgzcp/6yMDJiwrxm3HyUB5LK0h
        VeWZYOCGc+/cF57DlQPwesEdBB8KsWizdzl1Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1ACD118A54;
        Mon, 12 Apr 2021 15:37:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46FCC118A52;
        Mon, 12 Apr 2021 15:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
Date:   Mon, 12 Apr 2021 12:37:23 -0700
In-Reply-To: <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 12 Apr
 2021 13:09:04
        +0200")
Message-ID: <xmqqa6q3cn0s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82131CE0-9BC6-11EB-9D80-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  test_path_is_file () {
> -	test "$#" -ne 1 && BUG "1 param"
> -	if ! test -f "$1"
> +	if ! test -f "$@"
>  	then
> -		echo "File $1 doesn't exist"
> +		echo "File $@ doesn't exist"
>  		return 1

What does it even mean to call

	test_path_is_file Documentation/ Makefile

with this patch applied?

If there were three files "COPYING Makefile", "COPYING", and
"Makefile", what would happen when you did

	test_path_is_file COPYING Makefile

(without dq around them)?

I think this particular medicine is far worse than the symptom it
tries to cure.


