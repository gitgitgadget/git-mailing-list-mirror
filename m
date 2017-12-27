Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A3A1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbdL0S5Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:57:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63903 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752310AbdL0S5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:57:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55AA5BCB3E;
        Wed, 27 Dec 2017 13:57:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GFafCOvDGHAqXZM1jgI5A/HUAJo=; b=Ynp0Zl
        XBsgdB8Fxf/cnmnh/yAYq2DFkBMLWynQrEc643pRDqpClg4gow/6OLajjl0bLcY9
        AemsAUuabjTcd6sqyyHU2Hnqmk+Lu5AtOtyR/BHWKoX4lFVZHYF2Si/nPuv8uLrS
        UveP0hzSbNX8MKYBVOa/KKIVZDhmDEB/gPSSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ARtLMHtkPaPJY9g0AqFUe16kLsTvgGtj
        1/SPbIqVWjySQJB9tWDrpgAMsJrvgFIDuFUqzPe0lEJoIMZ4h2cZ/GJdDer4jApg
        /1MI2HC5m6FVIshP+vUBofgciTkCbMvkeAGtvQYOrf4a9BoTC+og0CpsFeFIzEQS
        Qv789mee+nk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CE7BBCB3D;
        Wed, 27 Dec 2017 13:57:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BC82FBCB3B;
        Wed, 27 Dec 2017 13:57:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Vadim Petrov <tridronet@yandex.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] setup.c: move statement under condition
References: <3853941514059379@web42g.yandex.ru>
        <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
Date:   Wed, 27 Dec 2017 10:57:20 -0800
In-Reply-To: <alpine.DEB.2.21.1.1712232332000.406@MININT-6BKU6QN.europe.corp.microsoft.com>
        (Johannes Schindelin's message of "Sat, 23 Dec 2017 23:48:18 +0100
        (STD)")
Message-ID: <xmqqvagsm227.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4EF8262-EB37-11E7-ABF9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I suppose that if the condition is fulfilled then the previously
>> obtained value will not be necessary.
>
> I have to be honest: this commit message (including the subject) left me
> quite puzzled as to the intent of this patch.
>
> Maybe something like this would have spared me that puzzlement:
>
> 	Avoid unnecessary offset_1st_component() when prefixing filenames
>
> 	In the abspath_part_inside_repo() function that is called
> 	somewhere deep in the call-chain when prefixing paths, we
> 	calculate the offset of the first component, but under certain
> 	circumstances, the result is not even used.
>
> 	This patch changes the code to avoid that.

Sensible.

>> diff --git a/setup.c b/setup.c
>> index 8cc34186c..1ce0189fa 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -35,7 +35,6 @@ static int abspath_part_inside_repo(char *path)
>>  		return -1;
>>  	wtlen = strlen(work_tree);
>>  	len = strlen(path);
>> -	off = offset_1st_component(path);
>>  
>>  	/* check if work tree is already the prefix */
>>  	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
>> @@ -49,6 +48,8 @@ static int abspath_part_inside_repo(char *path)
>>  		}
>>  		/* work tree might match beginning of a symlink to work tree */
>>  		off = wtlen;
>> +	} else {
>> +		off = offset_1st_component(path);
>>  	}
>
> Up until recently, we encouraged dropping the curly brackets from
> single-line statements, but apparently that changed. 

That is not quite correct.  We do encourage 

	if (...)
		single statement;

with or without

	else
		another single statement;

IOW, when both sides do not need curlies, we save vertical space.
On the other hand, when one side needs curlies, we tend to add to
both to make it easier to spot the correspondence, i.e.

	if (...) {
		compond statement;
		compond statement;
	} else {
		single statement;
	}

or the other way around.


	if (...) {
		single statement;
	} else {
		compond statement;
		compond statement;
	}

> However, we still encourage to put shorter alternative code paths
> (i.e. the blocks after `if` and `else`) first, in your case:
>
> @@ -35,18 +35,19 @@ static int abspath_part_inside_repo(char *path)
>  		return -1;
>  	wtlen = strlen(work_tree);
>  	len = strlen(path);
> -	off = offset_1st_component(path);
>  
>  	/* check if work tree is already the prefix */
> - 	if (wtlen <= len && !strncmp(path, work_tree, wtlen)) {
> +	if (wtlen > len || strncmp(path, work_tree, wtlen))
> +		off = offset_1st_component(path);
> +	else {
>  		if (path[wtlen] == '/') {
>  			memmove(path, path + wtlen + 1, len - wtlen);
>  			return 0;
> 		} else if (path[wtlen - 1] == '/' || path[wtlen] == '\0') {
> 			/* work tree is the root, or the whole path */
> 			memmove(path, path + wtlen, len - wtlen + 1);
> 			return 0;
> 		}
> 		/* work tree might match beginning of a symlink to work * tree */
> 		off = wtlen;
> 	}

This also may allow you to further dedent the if/else chain and make
the result easier to follow.  I dunno.

Thanks for a review.
