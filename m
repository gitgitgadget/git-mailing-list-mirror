Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D931FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbcLTSTL (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 13:19:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751441AbcLTSTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 13:19:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74A7959047;
        Tue, 20 Dec 2016 13:19:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tVMwiXo3c0Rw0JEAitO9917Mu2I=; b=svhwP3
        i22mc5ReZSLwYiU70pQnwTKuAT2Prc6wCQaBwyXl6RxI3hoiLo9nCpR8fwn2G9MR
        eU76r89FRu4qO4qk5h5jxl3v27BnsvPVUIJmntqX4fv8TBEQ2eBQo73XeUnCMWBA
        tFNITJEN4Efq0XHXhD93tZcb4hOX70z7TjJ6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyD45IYqHRstuM6gq32ynjufCLNfOZjq
        LA04gL+pWCZpzoWvPFYpfCLsPlaSThvPNeWxBHCXFQiotySlUe/dhxH0BdiVnwcQ
        8/1uRmO6S337Su6BjluVmVOKewkOF9DU7BWJTx9pxwOUE5eEcyzDOCmo6lkJaWOF
        I6V4+Kkboc0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3DC59046;
        Tue, 20 Dec 2016 13:19:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCA6159045;
        Tue, 20 Dec 2016 13:19:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Allow "git shortlog" to group by committer information
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
        <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com>
        <20161216133940.hu474phggdslh6ka@sigill.intra.peff.net>
        <20161216135141.yhas67pzfm7bxxum@sigill.intra.peff.net>
        <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org>
Date:   Tue, 20 Dec 2016 10:19:06 -0800
In-Reply-To: <16b115e0-3a7e-a5c2-1526-44bbcfc97db8@kdbg.org> (Johannes Sixt's
        message of "Tue, 20 Dec 2016 19:12:32 +0100")
Message-ID: <xmqq60melazp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC04C35E-C6E0-11E6-9167-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.12.2016 um 14:51 schrieb Jeff King:
>> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
>> index ae08b57712..6c7c637481 100755
>> --- a/t/t4201-shortlog.sh
>> +++ b/t/t4201-shortlog.sh
>> @@ -190,4 +190,17 @@ test_expect_success 'shortlog with --output=<file>' '
>>  	test_line_count = 3 shortlog
>>  '
>>
>> +test_expect_success 'shortlog --committer (internal)' '
>> +	cat >expect <<-\EOF &&
>> +	     3	C O Mitter
>> +	EOF
>> +	git shortlog -nsc HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'shortlog --committer (external)' '
>> +	git log --format=full | git shortlog -nsc >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done
>>
>
> May I kindly ask you to make this work on Windows, too? Just
>
> sed -i -e s/MINGW/MINGW,HAVENOT/ t4201-shortlog.sh

HAVENOT???

>
> on your Linux box and make it pass the tests.
>
> Thank you so much in advance.
>
> -- Hannes
