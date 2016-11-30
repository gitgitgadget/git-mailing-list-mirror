Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1BE1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757835AbcK3WSm (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:18:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57162 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757251AbcK3WSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:18:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A35135502E;
        Wed, 30 Nov 2016 17:18:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hHzz58eAhVmphffsxDxzVSps9NI=; b=SlTg4P
        sJchFTqwB+CCQLHdZ3zJJSRu1eT1VjJlOmVRUmR3nFUkOOUSIH2RM9dmtmxOd07/
        glqBvLFZuqyDg80s4mkkvBtnt94cpTSIreaB5RMIy3pfNlnTj9vXwTXQjygtSuJs
        3gnuGrZNOx5cCvSmxRBSkBVDf77HLsillGZ/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yw2+pCHykg5H18UMQ44ENHyfXVf8wX9w
        31DdVX1IlkU1jDawLEcvKxzaGqlMCeSl3aTNfBvWtoGdFckowU+Yxyi7dVaVgzlE
        nT7ivXaJUIRKoMuSKFJze7/mlLRptCyNxTUDP2yQXmRZ3Z22W0BpDoOQR8N8v6iE
        SswkbMHFrqc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AD415502D;
        Wed, 30 Nov 2016 17:18:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 174855502C;
        Wed, 30 Nov 2016 17:18:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
References: <20161122192235.6055-1-sbeller@google.com>
        <20161122192235.6055-5-sbeller@google.com>
        <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
        <xmqqpolcd73b.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kar0F7x5U2yZ30ZnWZ9b=EJA=1nT8rxTMRVJPggyFS_XA@mail.gmail.com>
        <xmqqfum8d4w3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZSAJauwBwrxf+QAhQgyu4ACn+8LrwjpFGVaUQfSzHEAg@mail.gmail.com>
Date:   Wed, 30 Nov 2016 14:18:38 -0800
In-Reply-To: <CAGZ79kZSAJauwBwrxf+QAhQgyu4ACn+8LrwjpFGVaUQfSzHEAg@mail.gmail.com>
        (Stefan Beller's message of "Wed, 30 Nov 2016 13:56:09 -0800")
Message-ID: <xmqq37i8d329.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2495FC0-B74A-11E6-BED3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Nov 30, 2016 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>     git relocate-git-dir (--into-workingtree|--into-gitdir) \
>>
>> I am not sure if you meant this as a submodule-specific subcommand
>> or more general helper.  "into-workingtree" suggests to me that it
>> is submodule specific, so I'll base my response on that assumption.
>>
>> Would there ever be a situation where you already have submodule
>> repositories in the right place (according to the more modern
>> practice, to keep them in .git/modules/ of superproject) and want to
>> move them to embed them in worktrees of submodules?  I do not think
>> of any.
>
>  "Hi, I made a mistake by using submodules. I don't want to use
>   them any more, I rather want to:
>   A) make it a separate git repo again and I'll keep them in sync myself
>   B) ... "

OK, I can buy that.  Thanks.
