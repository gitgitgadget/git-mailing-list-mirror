Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0261F461
	for <e@80x24.org>; Mon,  1 Jul 2019 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfGATY4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 15:24:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56803 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 15:24:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D1A914B369;
        Mon,  1 Jul 2019 15:24:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KxDM83I8Blk4LmJUVR5ks8CGxGg=; b=oeFjOP
        M2PBEoeQzq4I0+AbRaswagDvmacfvXWTggI7493uxWnqDjAeKvDuI83oI3r9iFmi
        vjk/0E7TYq+vFZ2Jg5ZHWciE4sfU35KGk5h3pVnhRwYhVR7IHi+5PdkxbfV7JMPL
        TfYQOZdefy4Q37uF+yn6+P3VopFUita6eyR4o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hN+3qvFynQr/wMgR2FyGX9iZQcAJ7zUv
        ywFEUxEXXBObHVB4/X0rWENfE6QfPkY4/rA6Zb4+aLkFg+3Ew6IzFOpnrWeGo4NH
        rGmIFjNdpcWtJvawZK1ezzTMGMnTwP8UYIEZRArpyYWbKhfajhdFsRM1Fr0KLtEW
        LzWm4V+HLTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22DDA14B367;
        Mon,  1 Jul 2019 15:24:54 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A8AC14B366;
        Mon,  1 Jul 2019 15:24:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Johannes Sixt <j6t@kdbg.org>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
References: <pull.261.git.gitgitgadget@gmail.com>
        <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
        <87muhxr7xv.fsf@igel.home>
Date:   Mon, 01 Jul 2019 12:24:52 -0700
In-Reply-To: <87muhxr7xv.fsf@igel.home> (Andreas Schwab's message of "Mon, 01
        Jul 2019 19:17:00 +0200")
Message-ID: <xmqqtvc55zi3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E70E5F2A-9C35-11E9-931B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jun 30 2019, Johannes Sixt <j6t@kdbg.org> wrote:
>
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> index 79bfaeafa9..4b4d06a1c8 100755
>> --- a/t/t5319-multi-pack-index.sh
>> +++ b/t/t5319-multi-pack-index.sh
>> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>>  		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
>>  		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
>>  		ls .git/objects/pack >expect &&
>> -		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
>> +		MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
>
> You could also use ls -n.

Nice ;-)
