Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA6220437
	for <e@80x24.org>; Wed, 11 Oct 2017 00:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbdJKATj (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 20:19:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751858AbdJKATj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 20:19:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4B69C69C;
        Tue, 10 Oct 2017 20:19:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=738IfSmnRhPYdMltR60mg5dNcec=; b=eKIa7Y
        YMlqQONi7mXCC9LxhEuvW4ul74OyDxn9hsn59KbzC9T4fADwjZCMF0+yLDiqXW5E
        x00DzJ8RxYP4sgpW42Fi2Ee5y/DJvKTnMXZNPnVHmXS0supeDdAdKmYwlhNh7aAr
        N2Xhc4VTGtD9kSt+x+2hDDMX2iSdUUe+LlYVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B3HyITFFvEJOG7qmOeDUklULeAcUmYCK
        pcyKNKETBa0tufv3+F6/VUcqpnigVQnSuuaAFpamc8d2hTNg1SgruHh7dT8tbQ2g
        21Y4yLKHE/eDWkUoMmr5qE3SlKwld2YjyB7sYuXnj3idlE8LNIJycWrMog1IlL1h
        byeIbdHDMSo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 665F79C69A;
        Tue, 10 Oct 2017 20:19:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6D909C699;
        Tue, 10 Oct 2017 20:19:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper repository setup
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
        <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
        <20171010130335.GB75189@book.hvoigt.net>
        <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
        <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 11 Oct 2017 09:19:36 +0900
In-Reply-To: <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 11 Oct 2017 08:31:37 +0900")
Message-ID: <xmqq376qpmcn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDEF89F2-AE19-11E7-9F40-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> A few questions that come to mind are:
>
>  - Does "git add sub/" have enough information to populate
>    .gitmodules?  If we have reasonable "default" values for
>    .gitmodules entries (e.g. missing URL means we won't fetch when
>    asked to go recursively fetch), perhaps we can leave everything
>    other than "submodule.$name.path" undefined.
> ...
>  - ...  IOW, if "git add sub/" can
>    add .gitmodules to help people without having to type "git
>    submodule add sub/", then we can give exactly the same degree of
>    help without even modifying .gitmodules when "git add sub/" is
>    run.

Answering my own questions (aka correcting my own stupidity), there
is a big leap/gap between the two that came from my forgetting an
important point: a local repository has a lot richer information
than others that are clones of it.

"git add sub/" could look at sub/.git/config and use that
information when considering what values to populate .gitmodules
with.  It can learn where its origin remote is, for example.

And while this can do that at look-up time locally (i.e. removing
the need to do .gitmodules), those who pull from this local
repository, of those who pull from a shared central repository this
local repository pushes into, will not have the same information
available to them, _unless_ this local repository records it in the
.gitmodules file for them to use.

So, I think "git add sub/" that adds to .gitmodules would work
(unless the sub/ repository originates locally without pushing
out--in which case, submodule.$name.url cannot be populated with a
value suitable for other people, and we should continue warning),
while doing the same at look-up time would not be a good solution.
