Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB6DC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF58205ED
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1vxL+ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgCOQku (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:40:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56058 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgCOQku (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 12:40:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 712044C8D2;
        Sun, 15 Mar 2020 12:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=INlGrfhaYJIzBL9jmgT71TPj8aw=; b=E1vxL+
        ssuSglPvKMAEbhnBZiLXaSwKqnuk33Im9y+e3LXTkPyqqqTmR3A8auLIEyRkwmST
        l5mZTL2krb7ZkWlKouo46FPwontlJ4Ppnfvb2XBPAB1h+jn56wmXy2iqL5I5eN+F
        8UAyzmPfPDAxAH/eAyEPyRgXpHBcVXWJkrlgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X+yVLDEhe6pFmTmuKi/4nVVFfPcr39IC
        Frj7LVk6dmacl/fvXKunseNJSf9Fc0LtZJiXSjzQMYvvEBgMUNQTm8qgI6vbRlqf
        pHkEkP9dYpogZ4qsX4FhANqELbwtjPoXKJFIh6c6DVJAkFoDllSUsKqZzJKp1RPj
        e+AkGsYBWyo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 685DE4C8D1;
        Sun, 15 Mar 2020 12:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED7734C8D0;
        Sun, 15 Mar 2020 12:40:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] t: increase test coverage of signature verification output
References: <20191127174821.5830-1-hji@dyntopia.com>
        <20200304114804.19108-1-hji@dyntopia.com>
        <20200304114804.19108-2-hji@dyntopia.com>
        <nycvar.QRO.7.76.6.2003150020010.46@tvgsbejvaqbjf.bet>
Date:   Sun, 15 Mar 2020 09:40:47 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003150020010.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 15 Mar 2020 00:25:40 +0100 (CET)")
Message-ID: <xmqqzhcha7w0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B93D31B8-66DB-11EA-AF92-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Hans,
>
> I was wondering why your patches made the CI/PR builds fail on macOS and
> Windows. This was a pretty hard thing to figure out, see below:
>
> On Wed, 4 Mar 2020, Hans Jerry Illikainen wrote:
>
>> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
>> index 8a72b4c43a..1922c1c42e 100755
>> --- a/t/t6200-fmt-merge-msg.sh
>> +++ b/t/t6200-fmt-merge-msg.sh
>> @@ -6,6 +6,7 @@
>>  test_description='fmt-merge-msg test'
>>
>>  . ./test-lib.sh
>> +. "$TEST_DIRECTORY/lib-gpg.sh"
>>
>>  test_expect_success setup '
>>  	echo one >one &&
>> @@ -73,6 +74,10 @@ test_expect_success setup '
>>  	apos="'\''"
>>  '
>>
>> +test_expect_success GPG '

Ahh, thanks for a pair of sharp eyes.

