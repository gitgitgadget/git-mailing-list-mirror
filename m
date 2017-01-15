Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AC820A17
	for <e@80x24.org>; Sun, 15 Jan 2017 02:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbdAOCjN (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 21:39:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750780AbdAOCjM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 21:39:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D89A602BA;
        Sat, 14 Jan 2017 21:39:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8a35JoxK8Y7p
        tOvN0PeOqGyejgU=; b=n8q948r3gcgR1Cwtht+uRS/1Q7AnxP3U0N4kDMCQzvs6
        yZ5rAhXebsr0QMIHYJ3j5z3aAEFR0asFt0RzdHXObfdIz8SpF/3WNhEte0wnD+H6
        P3HGUtu97gj63I5DSoJdA26uu6/vCF0j4AHmcYka3bYzT/C44SD4sJO4Y5PYOGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ydTK2Y
        C2RRXR5cfUjxtbyQWfDBjqtbSXhV40W6Uiu5bhc9n+1xTnVX9uetAJnOVHjJygV9
        yqQlogNwvIEk4CXSeqZMos9KnST8vEe4PXTMXOTjr3Wj0qgxPzvim8hSZGDSM9At
        yQEk99GKceZn20y/rGEzdiO8mp+3c7H5tlnP4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 647DB602B9;
        Sat, 14 Jan 2017 21:39:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4C18602B7;
        Sat, 14 Jan 2017 21:39:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty lines in context
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
        <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
        <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
        <xmqqeg06hh6z.fsf@gitster.mtv.corp.google.com>
        <c74c260d-1a4d-39f6-a644-4f90a67d6d82@oracle.com>
        <xmqqbmvaecpl.fsf@gitster.mtv.corp.google.com>
        <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de>
Date:   Sat, 14 Jan 2017 18:39:09 -0800
In-Reply-To: <48bdfd94-2fd4-bd55-d78b-2877e195fb82@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 14 Jan 2017 15:58:25 +0100")
Message-ID: <xmqqy3ydcaia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB6DEDD6-DACB-11E6-9677-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I am also more focused on keeping the codebase maintainable in good
>> health by making sure that we made an effort to find a solution that
>> is general-enough before solving a single specific problem you have
>> today.  We may end up deciding that a blank-line heuristics gives us
>> good enough tradeoff, but I do not want us to make a decision before
>> thinking.
>
> How about extending the context upward only up to and excluding a line
> that is either empty *or* a function line?  That would limit the extra
> context to a single function in the worst case.
>
> Reducing context at the bottom with the aim to remove comments for the
> next section is more tricky as it could remove part of the function
> that we'd like to show if we get the boundary wrong.  How bad would it
> be to keep the southern border unchanged?

I personally do not think there is any robust heuristic other than
Vegard's "a blank line may be a signal enough that lines before that
are not part of the beginning of the function", and I think your
"hence we look for a blank line but if there is a line that matches
the function header, stop there as we know we came too far back"
will be a good-enough safety measure.

I also agree with you that we probably do not want to futz with the
southern border.

Thanks.
