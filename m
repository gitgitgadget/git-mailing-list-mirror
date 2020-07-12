Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D34FC433E1
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 17:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5787420702
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jnH8euNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgGLReZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:34:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59154 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLReZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 13:34:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF7987A877;
        Sun, 12 Jul 2020 13:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=669TXAazTIjqb5WH2bFf2Udsm00=; b=jnH8eu
        NNP6sOlo0yvLQEA1Z74gh9ZdMEw1V+F0dKH6VGQecFsmYdHGAFl3tUU4ci5jD5QA
        GHnk5EV+qtyMIeHOKv+ygsGZ4++Ax9rNydOuS5PeJDCAuRTw15nw/RsdWu+KfkxK
        FW1FGROSWhtWP2yiMEFDFihR8cMIqa8pAK4II=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qOYdVOl34WRGBEDLYx8QLe4PKEhfc5yW
        reNSExEq7+7IoAOXxjEjiVsMQBKlQmiaA45Ya+6/mz0yhOgvgoLO/dOz8Me730TG
        6/Vug/GpZzfDYNM7/Jjt0QXlB1SERDUQkaHLAcbsFhV8wvMGwJraDnYUrUygt7yu
        6RAL+Vx0mMY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C70157A876;
        Sun, 12 Jul 2020 13:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 508CA7A875;
        Sun, 12 Jul 2020 13:34:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 35/38] t: make SHA1 prerequisite depend on default hash
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
        <20200710024728.3100527-36-sandals@crustytoothpaste.net>
        <20200712021350.GA34873@generichostname>
Date:   Sun, 12 Jul 2020 10:34:21 -0700
In-Reply-To: <20200712021350.GA34873@generichostname> (Denton Liu's message of
        "Sat, 11 Jul 2020 22:13:50 -0400")
Message-ID: <xmqq7dv8r61u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC4DA76C-C465-11EA-A8DC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Brian,
>
> On Fri, Jul 10, 2020 at 02:47:25AM +0000, brian m. carlson wrote:
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 307bb2207e..30ab0428fb 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1689,7 +1689,8 @@ test_lazy_prereq CURL '
>>  # which will not work with other hash algorithms and tests that work but don't
>>  # test anything meaningful (e.g. special values which cause short collisions).
>>  test_lazy_prereq SHA1 '
>> -	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>> +	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
>> +	([ -z "$GIT_DEFAULT_HASH" ] || [ "$GIT_DEFAULT_HASH" = "sha1" ])
>
> Tiny nitpick that I noticed in passing, is there any reason why we need
> a subshell here? If not, I would just switch this to a command group via {}.

Nicely caught.  Also we do not write [] but use 'test'.
