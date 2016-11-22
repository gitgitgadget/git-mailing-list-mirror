Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0021FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754243AbcKVRL6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:11:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51904 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbcKVRL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:11:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EB3550F84;
        Tue, 22 Nov 2016 12:05:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4f1rR7sxE4/yjOMpG9j0g/4+/4w=; b=sNynsv
        wdD8Pb9+t77ah3tCqQdfTxbI1JtrQct7WO2yu0Idus8ScfZEQzd/fv3iUFvxsVq5
        WPDb4GwXGxMKIiM3u+C9ZkPpcy3s/2eTZlDVqNXKdSTaDf6wlm+aCCet/Swbiwcq
        qGV7iIxZOOm70fmrcyqlKjtPISI3GgT1nwtEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s9tLz1rvzdbWPjbp8jjLLPK4RL/2/gFT
        YTXHYgZAnHWGqzaIRd58IMr9RPovHwdvcATvgp7ooYEh7qHpr+AB6WmKHr5vqtAB
        lGVV92MwtJ2QWO321dLuwecIcYinfb88XoX9PQH1FJ1KIE/uhwNgo/QBifCSl0GC
        6pxs0xsUovc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26DB550F83;
        Tue, 22 Nov 2016 12:05:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 96DC650F82;
        Tue, 22 Nov 2016 12:05:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] rebase -i: highlight problems with core.commentchar
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com>
        <20161121190514.18574-1-gitster@pobox.com>
        <alpine.DEB.2.20.1611221709180.3746@virtualbox>
Date:   Tue, 22 Nov 2016 09:05:29 -0800
In-Reply-To: <alpine.DEB.2.20.1611221709180.3746@virtualbox> (Johannes
        Schindelin's message of "Tue, 22 Nov 2016 17:09:57 +0100 (CET)")
Message-ID: <xmqqwpfvqwbq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF8B4856-B0D5-11E6-B6C1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 21 Nov 2016, Junio C Hamano wrote:
>
>> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
>> index 29e91d861c..c1f6411eb2 100755
>> --- a/t/t0030-stripspace.sh
>> +++ b/t/t0030-stripspace.sh
>> @@ -432,6 +432,15 @@ test_expect_success '-c with changed comment char' '
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_failure '-c with comment char defined in .git/config' '
>> +	test_config core.commentchar = &&
>> +	printf "= foo\n" >expect &&
>> +	printf "foo" | (
>
> Could I ask you to sneak in a \n here?

The one before that _is_ about fixing incomplete line, but this and
the one before this one are not, so I think we should fix them at
the same time.

But does it break anything to leave it as-is?  If not, I'd prefer to
leave this (and one before this one) for a later clean-up patch post
release.

Thanks


