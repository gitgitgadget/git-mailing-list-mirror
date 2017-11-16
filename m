Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B18201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 01:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933650AbdKPBnq (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 20:43:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51868 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932697AbdKPBnp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 20:43:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3E6A29DF;
        Wed, 15 Nov 2017 20:43:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QuaH0OqzCXctno3nFhvC0iqByk8=; b=Di36Ya
        Yuuqv2yJb1dnF1rNFj1k9of9NdwjQSE+/MDaP8v0oIBxQKyoSc/Vzp4ThoKqERdx
        tDc+RwyD5v47PiolCC8hVVq0qxL4P7iNB28Gq+0+ePNBZoyCdl857gKqUez5X++H
        DHhuYPc1CGzlHQJX6lALyysmZt7ukYEeSTvtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DO846jukgNr1eG8Od6AWy+rIJ1GKCFTl
        eQKL/AmLT7ob87cI1aqc2ccIFbSvpTXR3AC0DEXkvb6wWsFyJCA9ASia4Fivqq4l
        Lw6BkPXC10Slc1scEZ65L2wQTYHoHdeLL+fmHg5QFbflFejo/uGWP8Lc4OB/oZCj
        R4qgBcqdKOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23CDCA29DE;
        Wed, 15 Nov 2017 20:43:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 97DF9A29DD;
        Wed, 15 Nov 2017 20:43:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCHv4 7/7] builtin/describe.c: describe a blob
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-8-sbeller@google.com>
        <20171114175207.f23d492045d52b8aa16c00be@google.com>
        <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
Date:   Thu, 16 Nov 2017 10:43:43 +0900
In-Reply-To: <CAGZ79kaum5py=14kdFy1a+K_0MzfaD5boYStixh=1aY2tUCV-Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Nov 2017 17:22:51 -0800")
Message-ID: <xmqq7eurxak0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94E5B4E4-CA6F-11E7-9447-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> -git-describe - Describe a commit using the most recent tag reachable from it
>>> +git-describe - Describe a commit or blob using the graph relations
>>
>> I would write "Describe a commit or blob using a tag reachable from it".
>
> using a ref, as we also can use refs.
> I think 'the graph' is technically correct here, but may be too confusing.

Without saying graph over what, "graph relations" is not just
confusing but an insufficient explanation for a technically correct
explanation.  Even though we have "--contains", we say "reachable from"
and nobody has complained---so perhaps we can keep the white lie to
keep the synopsis simpler?

If I were writing this sentence from scratch, perhaps I wouldn't
even use the word "describe".  How about 

    Give an object a human readable name based on an available ref

or something like that?

>>  (Should we also test the case where a blob is directly
>> tagged?)
>
> We do a bad job at describing tags that point at a blob currently:
>
>   git tag test-blob HEAD:Makefile
>   git describe test-blob
> error: object cd75985991f4535c45e2589222a9e6a38fb1d613 is a blob, not a commit
> fatal: test-blob is not a valid 'commit' object
>
> This series changes this to
>
>   git describe test-blob
>   v2.15.0-rc0-43-g54bd705a95:Makefile
>
> which might not be expected (you'd expect "test-blob"),
> so I think I can write a test telling that this is suboptimal
> behavior?

Or a sentence in BUGS section.

A case (or two) I find more interesting is to see how the code
behaves against these:

	git tag -a -m "annotated blob" a-blob HEAD:Makefile
	git tag -a -m "annotated tree" a-tree HEAD:t
	git describe a-blob a-tree

Thanks.
