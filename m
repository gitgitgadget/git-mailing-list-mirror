Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F6C433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 016BF20773
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nTH3LAqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgGNEek (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:34:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51494 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgGNEek (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:34:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48916D19DC;
        Tue, 14 Jul 2020 00:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=9sl4I0f4KncZ/R4ESMXkdHPagNc=; b=nTH3LA
        qRvwM51Rw5YKisTPZqfQylARd3ECblOiolaTJDPo+veh9KQ0c6blL0zGvTRhUlLQ
        CZ/5c+pN2yAWLmrSN24J6HKWpq7AZ4gwxA/fEe+goJKjuOaO63e0c8LsVRGA24xh
        Pp0B1HFtfVdPWVO5DjPjwu7hhcsxFD24taHwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pFLER65DN8ekOtKvU04m1h4VTyYGeTjM
        kFAjMi1nba5iyQJKnfDJgc/iE2sbQT+wkQpB3tOOv0t+ZsSmy77i6tD1GJffGAOl
        /G+fAE0kR728kMHgloODGc+r6m/k9eUQV2azqUFOU1nh3SmHmyHIhK/Mc5xjh8RZ
        UH54dWlNLg0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41549D19DA;
        Tue, 14 Jul 2020 00:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86538D19D9;
        Tue, 14 Jul 2020 00:34:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jason Xu <jasonx98@gmail.com>, git@vger.kernel.org
Subject: Re: Force git diff to create a binary patch?
In-Reply-To: <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
        (Jason Xu's message of "Tue, 14 Jul 2020 00:09:41 -0400")
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
        <20200713223906.GH8360@camp.crustytoothpaste.net>
        <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Mon, 13 Jul 2020 21:34:35 -0700
Message-ID: <xmqq4kqan290.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5339C520-C58B-11EA-B023-843F439F7C89-77302942!pb-smtp21.pobox.com
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
