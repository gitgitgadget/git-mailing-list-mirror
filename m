Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B4C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF79320773
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rgNB2B8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgGNEeI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:34:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52237 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgGNEeI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:34:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FEDA6AFB5;
        Tue, 14 Jul 2020 00:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9sl4I0f4KncZ/R4ESMXkdHPagNc=; b=rgNB2B
        8pS959vZRAGhCuqEXFAbSJ8okjf+3oywIkumW92Ib9szCVe5SINQDAOBbPKVTPnx
        HuvBpJs5qimbpWJRmmEvOPh50LIrgMJCxSCxM18cRIMiaKOTKYtjb0wcXzkxbIfk
        Pgh3ULIGcY2t8rxGGZbC+U7S6EPGwKoShFJNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fIbQZ7/b7a/tdPTPEas1FYCYBFxsBjBN
        NCLE/gecoXXbXsK6Qrx5R1TkuXs411nhowmHmKJfxoanXTXzgnNqzsw4FDBoLKXV
        iEwXEAoEXA5ed+RHdcW31sf0bFg3AnFv/3uVE+h153TprRJ+WDTyHM+Oh5VBpD0+
        ay7hn4u9tAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6763F6AFB4;
        Tue, 14 Jul 2020 00:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E58F26AFB3;
        Tue, 14 Jul 2020 00:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Xu <jasonx98@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Force git diff to create a binary patch?
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
        <20200713223906.GH8360@camp.crustytoothpaste.net>
        <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
Date:   Mon, 13 Jul 2020 21:34:06 -0700
In-Reply-To: <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
        (Jason Xu's message of "Tue, 14 Jul 2020 00:09:41 -0400")
Message-ID: <xmqq5zaqn29t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40FB0F68-C58B-11EA-A9B4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Xu <jasonx98@gmail.com> writes:

>> The description for the --binary option reads as follows:
>>
>>   In addition to --full-index, output a binary diff that can be applied
>>   with git-apply. Implies --patch.
>>
>> So we need to fix either the documentation or the code.
>>
>> I looked into what it takes to fix the code to do this; it's fairly
>> straightforward, but it does cause some testsuite failures which assume
>> the current behavior and will likely involve a small series.  So if
>> other folks agree, I'm happy to pick this up in the next couple of weeks
>> and add support for it that would hopefully hit Git 2.29.

I am not convinced.  

The "--binary" option was invented as a way to tell Git to produce
something that can be applied, where Git stopped at saying "binary
files differ".  So a commit that touches two paths, one text and the
other binary, used to produce a textual patch for one and a useless
"binary files differ" for the other in "git show".  Such a commit
can be made more useful with "git show --binary" to tell the former
to still produce textual and readable patch while showing the xdelta
based "binary patch" Git invented.

So, no, I am less convinced "--binary" that forces "all paths are
binary, so show binary patch" is a good idea.

And viewed with the knowledge of that history,

>>   In addition to --full-index, output a binary diff that can be applied
>>   with git-apply. Implies --patch.

this description is correct---the choice is not between "showing a
binary diff and showing a useless textual diff"; the choice is
between showing "binary files differ" and appliable "binary patch".

