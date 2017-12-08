Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484641FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753423AbdLHWsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:48:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50802 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752610AbdLHWsx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:48:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2D03AEA05;
        Fri,  8 Dec 2017 17:48:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dhJIF2guRRVL
        lP1CvaGq4DYnLRU=; b=ohmxdiciARmhNNdoHxQaEqZNZDNNvh9itZFNCgOhc8lb
        0MEhOKJCUaGDG3lgf315cSE5HPtzoEvAWD7LgP83LcwOgzNZIYwab0gzkGkm4Ugm
        qBbtvVmhXd7Q3KTtE1KoahtyR28RYXI9VZBjSS1QjpnFWcojtjP9mlAEeUA5AWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mkj6tx
        aMirfb4otEeqQ5g0dThDGsdFjydEbDLZzImwKw0V74ex7K3Q7rZXjr8EteUT13r1
        qKoSOl84DK/l7RafYtHvEY3HCkV6jbZCmcvab8Vp4A/PWLYkcsFkvZ/1lWpc/wVM
        2ha5rdl5033bCCbr1HaYL5tibxxYFrrI2JqOs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAB46AEA04;
        Fri,  8 Dec 2017 17:48:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46A8BAEA03;
        Fri,  8 Dec 2017 17:48:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 2/5] Makefile: under "make dist", include the sha1collisiondetection submodule
References: <20171208223001.556-1-avarab@gmail.com>
        <20171128213214.12477-1-avarab@gmail.com>
        <20171208223001.556-3-avarab@gmail.com>
Date:   Fri, 08 Dec 2017 14:48:51 -0800
In-Reply-To: <20171208223001.556-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 8 Dec 2017 22:29:58 +0000")
Message-ID: <xmqqvahg6dkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6857D4A-DC69-11E7-9988-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Include the sha1collisiondetection submodule when running "make
> dist". Even though we've been shipping the sha1collisiondetection
> submodule[1] and using it by default if it's checked out[2] anyone
> downloading git as a tarball would just get an empty
> sha1collisiondetection/ directory.

While I can see that you are not including everything, but I do not
see _why_ you chose to do so and hardcode the burden of maintaining
the list of files we need to copy in the Makefile.

This is much better than shipping a tarball that would not build at
the endgame stage, of course ;-)

Thanks.
