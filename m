Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118EF202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbdCOTwq (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 15:52:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51463 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753410AbdCOTwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 15:52:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C7397E480;
        Wed, 15 Mar 2017 15:52:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wKCeM8Ky1JqgKo/yovlkx9ZYavU=; b=WvksBh
        9Lunhk9nmWFKLNpge1oTgWaKKaMdWPUCWYCXceGahYQBKDd5SyI+kzhQ1KhrQhOs
        dHR1mrpthes9xKhzJAA+NYhth7gu/FaBAobwKBctUCag2U/jwFFkNwKy5EBVH7HI
        gxU3Uw8xkjFzycAWDLkMMIHJ+x6H6N+dgrXOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ncE49vAzR2QLy865dQ12od7Ax/PIYx+j
        9l7oL8SXj6QF2kqRwbv7fE/vMs+TlHUDcINFmg7Sa26vuPrhm1LG7HyVN6RirQVH
        k5G6GKkKxzh1UlJyeWdFryqFi1NOBuzWAS2jnoDPTo9kSuqtTGCvfFbNSn9FfoYC
        AfHSpJQwaMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8575B7E47F;
        Wed, 15 Mar 2017 15:52:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C64B87E47D;
        Wed, 15 Mar 2017 15:52:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule-config: correct error reporting for invalid ignore value
References: <20170314221440.18259-1-sbeller@google.com>
        <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 15 Mar 2017 12:52:41 -0700
In-Reply-To: <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 15 Mar 2017 11:29:32 -0700")
Message-ID: <xmqqh92ue2ra.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3E005F8-09B8-11E7-BF1E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> As 'var' contains the whole value we get error messages that repeat
>> the section and key currently:
>>
>> warning: Invalid parameter 'true' for config option 'submodule.submodule.plugins/hooks.ignore.ignore'
>>
>> Fix this by only giving the section name in the warning.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule-config.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 93453909cf..bb069bc097 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>> @@ -333,7 +333,7 @@ static int parse_config(const char *var, const char *value, void *data)
>>  			 strcmp(value, "all") &&
>>  			 strcmp(value, "none"))
>>  			warning("Invalid parameter '%s' for config option "
>> -					"'submodule.%s.ignore'", value, var);
>> +					"'submodule.%s.ignore'", value, name.buf);
>
> Obviously correct.

But isn't this even more obviously correct?

	warning("invalid parameter '%s' for option %s", value, var);

