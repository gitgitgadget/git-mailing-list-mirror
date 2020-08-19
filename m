Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15241C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5115206FA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 22:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="haQZRJvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHSWUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:20:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55380 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHSWUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 18:20:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2991E74207;
        Wed, 19 Aug 2020 18:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6uFINe3PHNHYZim2pIrzjZeFMYM=; b=haQZRJ
        vuWfjr8X+5w0A7vQY1RMSM4T6TlAIFu4QnxxlNzRkPAa/r82Spx/Eegvzd8+q0Yx
        BKjl24SBqwezPJgwPWVLG4M+lsqhaJMRiPzJ2G03RX3b8JmRsSwIxkP4MxVNFtvb
        J/Rbwu5rOYAScXMXDyYmvxl8S8FzVsb/kFEEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iM1M292DxFTviuizB8epKy70UswdUA7k
        zN57PH5X7LsvIKOhO78Jv282t5yZzU6GGcpx1FbN7i7T4e0qnBc+J8rklLowb0hA
        c8V7TXcI81FH0rf9u7y2k+j4GR2c+YtaJtSqPOy/oF4em/WkGR0bSfndIBxOT7Ip
        8y2UcNH3Wpk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21E4874206;
        Wed, 19 Aug 2020 18:20:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3CD074204;
        Wed, 19 Aug 2020 18:20:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v8 4/5] rebase -i: support --ignore-date
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200817174004.92455-1-phillip.wood123@gmail.com>
        <20200817174004.92455-5-phillip.wood123@gmail.com>
        <88535175-0540-c96d-24b5-c4d407422a8c@gmail.com>
Date:   Wed, 19 Aug 2020 15:20:21 -0700
In-Reply-To: <88535175-0540-c96d-24b5-c4d407422a8c@gmail.com> (Phillip Wood's
        message of "Wed, 19 Aug 2020 11:22:46 +0100")
Message-ID: <xmqqo8n6s2fu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C5D2CAC-E26A-11EA-85D0-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +# Checking for +0000 in the author date is sufficient since the
>> +# default timezone is UTC but the timezone used while committing is
>> +# +0530. The inverted logic in the grep is necessary to check all the
>> +# author dates in the file.
>> +test_ctime_is_ignored () {
>> +	git log $1 --format=%ai >authortime &&
>> +	! grep -v +0000 authortime
>> +}
>
>
> I don't know what I was thinking when I wrote that - it should be called
> test_atime_is_ignored() as it's testing the author date

Will tweak locally.  No need to resend.

Thanks.
