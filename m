Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE0F1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdL0THr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:07:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63608 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdL0THq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:07:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5549FBCCBD;
        Wed, 27 Dec 2017 14:07:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PbfmeX9RVbfB
        LkWxQppeBoTBjdY=; b=k6SSBh9dZj2+G+mr/foqIKRUO+VtUJ7pbNSKf9VGUIEl
        XOCpcAw2SN7IHLhGMkJWpPxvBnWkDmF7ZpyxApl7Ve9ra4lMwyEveGomMmpbK+DT
        iA1aVmFFW/V1Pzu0oyTIjHMxcfHjHOXKGqFaXQmeNicYO0VZZy0GNJJZAt4JRV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=py1aYv
        gQzR/gGZgZ9Ckmb3VLd1X9a5K2qIy50ZGeSf+6vyJjijjsnz/VX6fAsFhtO9pcZJ
        RiW5zrXHOZ8JUSSQMfRZSSkP39r1DvzcZ1Pw4NB3t88BDQnelW5LqRs0ntVhPvRD
        0yHD0wkwhhS7S4WppZR01y9mgaTVbixHhbFkE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B204BCCBB;
        Wed, 27 Dec 2017 14:07:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CE61BCCBA;
        Wed, 27 Dec 2017 14:07:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 7/7] wildmatch test: create & test files on disk in addition to in-memory
References: <20171225002835.29005-1-avarab@gmail.com>
        <20171223213012.1962-1-avarab@gmail.com>
        <20171225002835.29005-8-avarab@gmail.com>
Date:   Wed, 27 Dec 2017 11:07:44 -0800
In-Reply-To: <20171225002835.29005-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 25 Dec 2017 00:28:35 +0000")
Message-ID: <xmqqr2rgm1kv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 38D4D3CA-EB39-11E7-A9D7-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	# Turn foo/bar/baz into foo/bar to create foo/bar as a
> +	# directory structure.
> +	dirs=3D$(echo "$file" | sed -r 's!/[^/]+$!!')

Let's not limit this script to GNUism systems.

You want to see if $file has a slash followed by one or more non-slash
letters to the end and strip the whole thing.  We further know that
at this point $file does not end with a slash.  So perhaps

	dirs=3D${file%/*}

is sufficient?

Thanks.
