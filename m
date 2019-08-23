Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1575B1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 16:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436826AbfHWQlg (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 12:41:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436778AbfHWQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 12:41:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDD8D75A02;
        Fri, 23 Aug 2019 12:41:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ePliPyJ0jVuX
        egMhqw/vDeDC6ic=; b=N3Tmh11ZOq0nnIFwSCiGavbnUWln3WMmG3FXDh7sgqnn
        dHsQ7KgtXz2mmCUmBe3w9g3a+nKUIUccyX6sEgkNaL/k0VrKmkRxhw1Gz3lyPA/6
        lWm3rjtzI/oM/PkraJPuYuJJVjcqtoFJCCQWwcGy7RYVj6UPW92yw1rGoiKYZBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UV3S0y
        EFh5XqeVg0sTRe8PMXP7fRohe9fFhtXL0+RY9BlYqa6EBCY9fRkO0S83FL/fqj1w
        tLx69wUEQQ4wqwnPxjAoRqW/gXe1GRUdrWTqx62HU5wKpVf3+ofp0EQZPrJzYrrd
        qQHfkvMoiuAOywkTFeB7vrX4X3KHPYdtMAvog=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6A9475A01;
        Fri, 23 Aug 2019 12:41:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2197D759FF;
        Fri, 23 Aug 2019 12:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug: interactive rebase's 'edit' insn copies notes to newly inserted commit
References: <20190823133850.GK20404@szeder.dev>
Date:   Fri, 23 Aug 2019 09:41:28 -0700
In-Reply-To: <20190823133850.GK20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 23 Aug 2019 15:38:50 +0200")
Message-ID: <xmqqef1bn8av.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC489872-C5C4-11E9-A0AC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> ...  However, once
> rebase stops for the 'edit' instruction the user can do just about
> anything, so I'm not sure how rebase could figure out when to copy the
> note and when not.

True.

> This doesn't happen when inserting a 'break' instruction between
> picking the "second" and "third" commits, and then adding new commits.

Meaning the original note for the second one is carried to the
rewritten second, and the one for the third is carried to the
rewritten third?  That would be a reasonable outcome.

> Alas, the 'break' instruction is not even a year old, and I have been
> using 'edit' for this purpose for over a decade now...  so
> re-training my fingers will be hard :)

Probably a section in the tutorial and/or the example section of the
"git rebase -i" documentation should encourage use of "break" when
inserting a brand-new commit in the middle.

Thanks.
