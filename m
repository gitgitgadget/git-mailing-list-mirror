Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F4601F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 18:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbcIISD1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 14:03:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64559 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753935AbcIISDY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 14:03:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE1523BC40;
        Fri,  9 Sep 2016 14:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UpZ5+9tVfTrvbRp+Q+m6pMP9ktA=; b=VrqkyA
        66kEQ2EBxfb+3gEO+zaX54JFuXDDkNAvDviJI8PrqJ8nShbG+WuT1ENa3lKmTXm8
        j/ZqHzw222ZgX+u0n3S7End5vz0c0AA1InnhTXTeYejKLjEsiZNI7le1t/ijBc+4
        mj1AplDw7fc3j1tqvfRkYXeOE3m7WVR6bTi1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KjxSWnzNg1tBnuZYtlO6vtAuYTeRmjYq
        zdXSaRO6gqrbnL+fara9l0FxrJwZfggeUH1ZdfCGei9AYZ+pAkSzBkaxlMeX3cz7
        2B18kNBj4Y7ro/uEdSoBI9I5xcrnjfmAwEWMy4QATudw7rxZNpi/tDrA/8B6iPUI
        IBg39painMk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A63F73BC3F;
        Fri,  9 Sep 2016 14:03:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29A063BC3B;
        Fri,  9 Sep 2016 14:03:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Christian Neukirchen <chneukirchen@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git commit -p with file arguments
References: <87zinmhx68.fsf@juno.home.vuxu.org>
        <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
Date:   Fri, 09 Sep 2016 11:03:20 -0700
In-Reply-To: <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
        (Jacob Keller's message of "Fri, 9 Sep 2016 09:57:44 -0700")
Message-ID: <xmqq8tv1c5nb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B22E02D4-76B7-11E6-9F16-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> It wants to commit bar too because you already added bar before. It works like:
>
> "git add bar && git add -p foo && git commit" does it not?
>
> I fail to see why "git commit -p <path>" would unstage the bar you
> already added? Or am I missing some assumption here?

Yes.

"git commit -p <pathspec>" were added originally for lazy people who
do not want to type "git add -p <pathspec> && git commit", which
matches your expectation.  If you already added "bar" that is
outside of the <pathspec> given to "add -p", the final "git commit"
step would record the latest contents of "bar" in it.

For obvious reasons, "git commit -p <pathspec>" cannot be a
short-hand to "git add -p <pathspec> && git commit <pathspec>", so
the current behaviour was the best they could do for those who aded
"commit -p", I guess.

