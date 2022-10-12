Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86892C43217
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJLViX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJLViU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:38:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D037D73C0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:38:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9FC4150ECF;
        Wed, 12 Oct 2022 17:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i3jxCCYeDU9PyyV2wqd2bNaoh9/+rJHur1vP34
        lmS1g=; b=eLoHwlYiQ6Jgoy/0SE4vxqu0xzoPxJvsxkWBMsh9neTI76Ljq2RYpz
        FvNMKMu3AfsAN2t2JnhlFjO+dctF2zmtAH9H4+KEQsky6XiYic9jRoDF9UBsnDSn
        7mqsinzIl16KZaon5ZFPJ7MdG/a9E8/kw0LFpRxgC82WHqcGlDnwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1307150ECE;
        Wed, 12 Oct 2022 17:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0273A150ECD;
        Wed, 12 Oct 2022 17:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     sndanailov@wired4ever.net, git@vger.kernel.org, aaron@schrab.com,
        philipoakley@iee.email
Subject: Re: [PATCH v3] docs: git-send-email: difference between ssl and tls
 smtp-encryption
References: <20221012150619.12877-1-sndanailov@wired4ever.net>
        <Y0cxPHNZjTqZR5XE@tapette.crustytoothpaste.net>
Date:   Wed, 12 Oct 2022 14:38:17 -0700
In-Reply-To: <Y0cxPHNZjTqZR5XE@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 12 Oct 2022 21:27:24 +0000")
Message-ID: <xmqqy1tkiuye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F683060-4A76-11ED-8C52-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-10-12 at 15:06:19, sndanailov@wired4ever.net wrote:
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index 3290043053..765b2df853 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -178,9 +178,18 @@ Sending
>>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
>>  
>>  --smtp-encryption=<encryption>::
>> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
>> -	value reverts to plain SMTP.  Default is the value of
>> -	`sendemail.smtpEncryption`.
>> +	Specify in what way encrypting begins for the SMTP connection.
>> +	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
>> +	(unencrypted) SMTP, which defaults to port 25.
>> +	Despite the names, both values will use the same newer version of TLS,
>> +	but for historic reasons have these names. 'ssl' refers to "implicit"
>> +	encryption (sometimes called SMTPS), that uses port 465 by default.
>> +	'tls' refers to "explicit" encryption (often known as STARTTLS),
>> +	that uses port 25 by default. Other ports might be used by the SMTP
>> +	server, which are not the default. Commonly found alternative port for
>> +	'tls' and unencrypted is 587. You need to check your provider's
>> +	documentation or your server configuration to make sure
>> +	for your own case. Default is the value of `sendemail.smtpEncryption`.
>
> I'm happy with this as it stands.  Thanks for taking my suggestions and
> sending a patch to improve the docs.

I marked it as "Expecting a reroll" in the latest issue of "What's
cooking" report, but I do not mind taking it to 'next' as-is,
without adding an extra reference to --smtp-server-port.  The
reference to port numbers here are there to help readers identify
which one is which, not because it is common to use randomly
numbered ports.

Thanks.
