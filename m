Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFEC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FD22063A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tElp59hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHEWZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:25:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53314 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHEWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 18:25:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3A6F8A5DA;
        Wed,  5 Aug 2020 18:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3jltQpKNMbcbLORWb3lYzhNlvhA=; b=tElp59
        hwP8rCm1qCB2LK7eMH1EL6M+ABDUZZBN5wmkyrOCeBHfqppFKn9s3cim80pHA7mL
        m3t9HYbEemsU/r0EHiXTWZ3TpM0MMcvdZF2kXQB19WdiXgwI2eD8fnaQ3y28dvSJ
        YwwEeC/2ZQcuLS2wXKJKd7UzaE4gfl/gLXf3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xu5JN/0xwut/QBg9n45P5T/NrXrTsijp
        szy/o1yHeyAWPGbQQoXkLcglZPf64UrZMtsDyOvF64ab1otsvloezHnU68DlZmr1
        Dr+3SqtVZJXffDBXajZcnRTVCJAUat/Gd/vU0nmPZVdOALTvI5J8ppQp03t08J1R
        A6CFgB4cahY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA5028A5D9;
        Wed,  5 Aug 2020 18:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35DB58A5D8;
        Wed,  5 Aug 2020 18:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        johannes.schindelin@gmx.de, liu.denton@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-4-shouryashukla.oo@gmail.com>
        <20200805210104.GH9546@syl.lan>
Date:   Wed, 05 Aug 2020 15:25:17 -0700
In-Reply-To: <20200805210104.GH9546@syl.lan> (Taylor Blau's message of "Wed, 5
        Aug 2020 17:01:04 -0400")
Message-ID: <xmqqd044n31u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ABD4AA8-D76A-11EA-8C2B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>  test_expect_success '--for-status' "
>>  	git submodule summary --for-status HEAD^ >actual &&
>> -	test_i18ncmp actual - <<EOF
>> +	cat >expected <<-EOF &&
>>  * sm1 $head6...0000000:
>>
>>  * sm2 0000000...$head7 (2):
>>    > Add foo9
>>
>>  EOF
>> +	test_i18ncmp expected actual
>>  "
>
> I think that this is on the right track, but you can use a '<<-\EOF'
> here instead of '<<-EOF' to make the tabulation a little more flexible.

You are correct that the patch could have indented the here-doc and
the line with EOF with a tab to make it easier to read.

The leading '-' after '<<' is what controls tabulation, so <<-EOF as
written in the patch is good enough; you do not want to quote it
further, because $head6 wants to be interpolated.


