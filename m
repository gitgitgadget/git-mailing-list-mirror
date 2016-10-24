Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA79A1FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 16:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757647AbcJXQyo (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 12:54:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62025 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756693AbcJXQyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 12:54:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 718CB4851C;
        Mon, 24 Oct 2016 12:54:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=q4/ufI4mrhyc
        UpytF+AYViKVv5k=; b=bg+iflYj7wQmUEr6rvrm5nQtrFW7OGNGr+wopFMnfamg
        5Fr/mY3qxK7zZaeXzfNJS6mSBDsvTAEGYtks/iXbQTaFdXR823SvZw1HmpxoCyN/
        jnLu0oOg6Zas3Q/iRuAGaxN+RhVfihQFu2+zpRJyauUKLZbpurOPq08EiMT3JZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EwECKL
        PQYSIpaAAgRH108JE/sQP7P17sGKUux2ALInjGfmEMi9r8A8CTvKACE1Uc2XAc5X
        GazyamkQ+CF442y3uGvEbJR7+khle5MT07fhgGY85pjjmAYUu6D/OERmOSXxgbKU
        9XBnp0z7fu92YSddZQlC465GDMVvIeL0E0WlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 681D14851A;
        Mon, 24 Oct 2016 12:54:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BCA8848518;
        Mon, 24 Oct 2016 12:54:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: RFC Failover url for fetches?
References: <CAGZ79kaPdSfY_DXL6BDQ9pAma8p61r4m1n81VTxPHYi8zQuZfA@mail.gmail.com>
        <xmqqeg39bk40.fsf@gitster.mtv.corp.google.com>
        <7fdaa160-9262-5d52-7035-8362ca94beea@gmail.com>
Date:   Mon, 24 Oct 2016 09:54:39 -0700
In-Reply-To: <7fdaa160-9262-5d52-7035-8362ca94beea@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Sun, 23 Oct 2016 19:40:57
 +0200")
Message-ID: <xmqq1sz58z74.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8ED28BA4-9A0A-11E6-9F14-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> As to fetching from two or more places as "fallback", I am
>> moderately negative to add it as a dumb feature that does nothing
>> more than "My fetch from A failed, so let's blindly try it from B".
>> I'd prefer to keep the "My fetch from A is failing" knowledge near
>> the surface of end user's consciousness as a mechanism to pressure A
>> to fix it--that way everybody who is fetching from A benefits.
>> After all, doing "git remote add B" once (you'd need to tell the URL
>> for B anyway to Git) and issuing "git fetch B" after seeing your
>> regular "git fetch" fails once in a blue moon is not all that
>> cumbersome, I would think.
>
> One would need to configure fallback B remote to use the same
> remote-branch namespace as remote A, if it is to be used as fallback,
> I would think.

Yeah, I left it out because I thought that was obvious, but spelling
it out explicitly may have helped those who weren't reading carefully.

Thanks
