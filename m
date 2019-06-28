Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F661F461
	for <e@80x24.org>; Fri, 28 Jun 2019 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfF1QKm (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 12:10:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59464 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1QKm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 12:10:42 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58A8715DB22;
        Fri, 28 Jun 2019 12:10:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Egzux59C7sWK
        /AUsb6jSEqT9nec=; b=OgASOQ2/Lkwl7lIMGv2lL+P4VZpD/4C6+c6yI/QQzW87
        tCeALMhfWtjh4XqXBy1x+Xa6eAqPHqo1LuqQ/PbAsazbelrBw5M9W3KFo/LZVO1i
        JTDIa7tQNJP8iawr0EJEko1usHWgnIqDn9Uz+bJefVXwLrL+oJXR7244Jc0RFQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=n3LOtm
        7JwuL0GMGoloiw3GNsqkDdiQ74V2JvM7QTdzSXKNzCPxve1r1qbs+JhWCyahu68Q
        r+qUnl09EofMzK/yGE8oA0gEHJSGTxn+DuE2eXaYPDiUhRAsfUwz02svXm/B3IXx
        aXIi2V4yYzd0H64yArqtKsygb3z/A1leLS2yE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CB1715DB21;
        Fri, 28 Jun 2019 12:10:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B043A15DB20;
        Fri, 28 Jun 2019 12:10:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v2 0/9] grep: move from kwset to optional PCRE v2
References: <20190626000329.32475-1-avarab@gmail.com>
        <20190627233912.7117-1-avarab@gmail.com>
        <87y31m6un7.fsf@evledraar.gmail.com>
Date:   Fri, 28 Jun 2019 09:10:38 -0700
In-Reply-To: <87y31m6un7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 28 Jun 2019 09:23:08 +0200")
Message-ID: <xmqqy31l8zcx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 459F8D08-99BF-11E9-ACE6-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Junio. I thought I'd submit this in before your merge to "next", but I
> see that happened. Are you OK with rewinding it for this (& maybe
> something else) or should I submit a v3 rebased on "next"?

Sensible choices are between

 (1) reverting 984c7ccbbf (Merge branch 'ab/no-kwset' into next) and
     then replacing the whole topic with this round, or

 (2) queuing an incremental series based on 984c7ccbbf^2 (i.e. the
     tip of ab/no-kwset as of today)

I think the former is probably good enough.

