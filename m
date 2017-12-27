Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24E51F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdL0T5c (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:57:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65361 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751184AbdL0T5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:57:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CAAAB7B17;
        Wed, 27 Dec 2017 14:57:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k9UzrdQYlMJBtoGzOC4KzCClLJ0=; b=xu2pQU
        6qJcPABD6N5D7PyWVr+PMJumKuCOc8EKysDKjrX70D5edB9bgx8Fh6y3MoH8dQAg
        f3zo8tO3FUFsHXjKbGMvB9LkJXLqsQ0sE6yVFfJkGv5UG8i6WWbWMTlKfsFGWNA4
        OOqNIGehdr6e+Zf1jafDO8goOiCjXXwRG2+3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gw6oMtPPxhtc5rP7I1QzNeuK6kAlcMyf
        5t2zS0vxQbocX+XvphhPwXDpYO/qcrkSCPdin0GpKLbi87I2VgfTrUUnaaUgHtEM
        NacatFj9gfGrFvpiYVtMgZYYtc/L1OLkcjNrLOIDmyV9qu8rze9YzLFKJtr1q+Df
        VVJxlDo6nSQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 903B6B7B15;
        Wed, 27 Dec 2017 14:57:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 135C4B7B14;
        Wed, 27 Dec 2017 14:57:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
        <20171212012422.123332-1-sbeller@google.com>
        <20171214212234.GC32842@aiede.mtv.corp.google.com>
        <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
        <20171214225200.GA44616@aiede.mtv.corp.google.com>
        <xmqq374cspgw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYiL0St-600sjxN5gjLSfyRodS1=AqxyALsidntXkg_xA@mail.gmail.com>
        <20171227185907.GE149622@aiede.mtv.corp.google.com>
Date:   Wed, 27 Dec 2017 11:57:29 -0800
In-Reply-To: <20171227185907.GE149622@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 27 Dec 2017 10:59:07 -0800")
Message-ID: <xmqqefnglz9y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C402900-EB40-11E7-AEC3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>> On Thu, Dec 14, 2017 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> I think it would make it a better companion to --pickaxe but we need
>>> to align its behaviour a little bit so that it plays better with the
>>> "--pickaxe-all" option, and also needs to hide mode and name only
>>> changes just like pickaxe.
>>
>> I looked into this, and the small changes needed led me to thinking
>> it could be integrated into the diffcore-pickaxe code completely,
>> roughly like (spaces mangled):
>
> Nice, this looks promising.

Indeed it is very simple, straight-forward and nice ;-)

>> I disagree, as the user doesn't have the content, but the hash
>> over the content only and wants to know more about it....

(correcting Stefan)  The user can do "git cat-file blob $oid" to
learn about the contents, so from end user's point of view, the
"pickaxe with object ID" can be seen as merely a short-hand for

    git log -S"$(git cat-file blob $oid)"

almost.

But that is a tangent in this response.

> Interesting --- I come to the opposite conclusion.
>
> The pickaxe-style behavior seems more consistent and simpler to
> explain and better matches the use cases I can think of.

Yeah, I am more leaning toward agreeing with you.
