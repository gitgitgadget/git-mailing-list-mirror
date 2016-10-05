Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711721F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 22:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941810AbcJEWPU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 18:15:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60474 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934248AbcJEWPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 18:15:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7023B43930;
        Wed,  5 Oct 2016 18:15:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nvGkSL2S2hiV
        Sx0jJ1oDrVVnxW0=; b=wGeA87tPYybo7jtht4+a9G/G06eefJt8wgWtVWyOhho2
        hWTz7OIByHFeM/L0qfT/JlovIOCeWnpWwOzO3zzpRrMoZv0RyUzMjggjyiYXjOw6
        t5PD/2qdgVMQMvkwZvdg96T2viclOzRqMDsjXIkmjWVji+ywXJvs2tgYvNd5vQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bhX1r0
        NxEwAPljMmoMWBl0iZe/14oNDfilNXDnNvTvjZh62r1QpuWOMi18HnLF73qM6Fvh
        FDTpKnNbjsC1C958p31KeyBuRmWljoATiGmCKBotYOaNMfniUy+xQECh8oJq08ES
        vqYHZR5D1xcpc5yZeCQRHnLxiOfDaFEj3ovPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67FAA4392E;
        Wed,  5 Oct 2016 18:15:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF2924392C;
        Wed,  5 Oct 2016 18:15:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
Cc:     Jeff King <peff@peff.net>, Leho Kraav <leho@conversionready.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
References: <20160906214550.Horde.ducOghtmsQb9pQ6lixxddVz@webmail.informatik.kit.edu>
        <20160907151251.30978-1-szeder@ira.uka.de>
        <20160907151251.30978-6-szeder@ira.uka.de>
        <20160907174841.Horde.Ru1LBEeLKomznlWVG-ZnS-Q@webmail.informatik.kit.edu>
        <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
        <xmqq4m4qrapv.fsf@gitster.mtv.corp.google.com>
        <20161005232609.Horde.VetzEIKHDJUdcaOod9sHxuK@webmail.informatik.kit.edu>
Date:   Wed, 05 Oct 2016 15:15:13 -0700
In-Reply-To: <20161005232609.Horde.VetzEIKHDJUdcaOod9sHxuK@webmail.informatik.kit.edu>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 05 Oct 2016 23:26:09
 +0200")
Message-ID: <xmqqwphmmoi6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3169AE22-8B49-11E6-B3C8-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Gut feeling tells me that I should take this as a subtle
> encouragement to look into adding 'versionsort.postreleasesuffix',
> shouldn't I ;)

It is more like "this made me realize that these are merely 'suffix'
after the real release name, no pre- or post- about them", also
known as "I think PREreleasesuffix was a mistake and we weren't
thinking clearly enough when we added it."

To me, this looks like a list of possible suffixes that can include
an empty suffix to denote "the real thing", e.g.

    versionsort.suffix =3D "-alpha" "-beta" "" "-gamma" "-delta"

and that position in the list determines the order of things inside
the same family of versions that share the same "non-suffix" part.
