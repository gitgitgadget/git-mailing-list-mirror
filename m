Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 483E41F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 13:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeKMXHT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 18:07:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52296 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMXHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 18:07:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE73B1163B9;
        Tue, 13 Nov 2018 08:09:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SduVVYVUkkY8
        FZxpIw2r3hK+vhQ=; b=hlc4tKRS7koReKFuZ9iLnSdbGj9GhztO98ggXzxStWtG
        BB4pkCZFT4yIZVQjVO1jv9wJEDBeauGCXpTn2pX0IL437ycRNiyq2Cs1iDfMeEJs
        QLqed6/yd6liQVpDqQpQI3L7soM0TB27u3l2LgIPCkbxA7Y26AfOiVlQQgb9BcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SNoFCb
        xa0qxZeTCNJo1XBeuavfGNM5yX9VsLfodEQk3YxVGR0DhiCgXggm2TOMaURKIQn7
        EBbLpq/47MGo26c6PZiOeGZtc46jqG1i3C6yB/VIJn/6bXBQDnRxx35PO+maxSfF
        GsTnNWkOw3lc+1a1KmgYF2oiHU3e89ikZxHMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7F911163B8;
        Tue, 13 Nov 2018 08:09:13 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 227781163B7;
        Tue, 13 Nov 2018 08:09:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Fredi Fowler <inredikawb@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Using no- for options instead of duplication
References: <01020167094ab871-ca8d8728-0102-4d93-a4ff-d554b4aec59f-000000@eu-west-1.amazonses.com>
        <xmqqmuqdwq2e.fsf@gitster-ct.c.googlers.com>
        <877ehh2scg.fsf@evledraar.gmail.com>
Date:   Tue, 13 Nov 2018 22:09:12 +0900
In-Reply-To: <877ehh2scg.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Nov 2018 11:18:39 +0100")
Message-ID: <xmqqh8glunt3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50F0F5A2-E745-11E8-B94F-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This doesn't spew out a histogram, but you can use the various "git
> grep/blame" one-liners (https://www.google.nl/search?q=3Dgit+grep+blame=
)
> plus shell one-liner to get something useful:
>
>     git grep -e '^--no-' -e '^--\[no-' -n | perl -F':' -anpe '$_=3D`git=
 blame -L$F[1],+1 $F[0]`' | perl -pe 's/^.* (\d{4})-.*\) /$1 /' | sort -n

Yikes.  I cannot easily unsee this X-<.


