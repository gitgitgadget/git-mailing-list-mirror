Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADB8207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 16:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbcI2Q6J (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 12:58:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52582 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933901AbcI2Q6G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 12:58:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 152ED410A1;
        Thu, 29 Sep 2016 12:58:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l8CuHIszCyzc
        pQFyPGcEz+RLmMc=; b=IA3yXw/XKzMq8UOpA4uzCLKReSU52zlzsETKdq4la2gh
        Q+ivrMvN776c/U9QKNZaN2+IHhDiiNRwgrYv/KQb+j4u8lP90jp0TArYh1J+pzCq
        7TRsaGY88Jhszb8mmqUhnrTrmIv2lwp7uOhwv889nurrlpQKwVohi4pViaaUPHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KUE50H
        evqaQF4IY6RIzqSQmCBtXDUJTFY72Az1Cpom9E7OTR1IGIGFLZoeEShG5FZut0Hs
        wHTzEFj0eoLLDlOHyH35/eOmkwRi/t2m1uicAv3lOf1dj6PlNNU794iuzxuNX97S
        yRRxbL0p7ojIuDUxlQeoIuZ79L9SMY0gjm+yw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C20F1410A0;
        Thu, 29 Sep 2016 12:58:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E95634109E;
        Thu, 29 Sep 2016 12:57:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
Date:   Thu, 29 Sep 2016 09:57:57 -0700
In-Reply-To: <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Thu, 29 Sep 2016 13:57:47
 +0200")
Message-ID: <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0A8820C-8665-11E6-9873-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> 1) Git exits
>> 2) The filter process receives EOF and prints "STOP" to the log
>> 3) t0021 checks the content of the log
>>
>> Sometimes 3 happened before 2 which makes the test fail.
>> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>>
>> I added a this to wait until the filter process terminates:
>>
>> +wait_for_filter_termination () {
>> +	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" >/dev/nul=
l 2>&1
>> +	do
>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>> +		sleep 1
>> +	done
>> +}
>>
>> Does this look OK to you?
> Do we need the ps at all ?
> How about this:
>
> +wait_for_filter_termination () {
> +	while ! grep "STOP"  LOGFILENAME >/dev/null
> +	do
> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
> +		sleep 1
> +	done
> +}

Running "ps" and grepping for a command is not suitable for script
to reliably tell things, so it is out of question.  Compared to
that, your version looks slightly better, but what if the machinery
that being tested, i.e. the part that drives the filter process, is
buggy or becomes buggy and causes the filter process that writes
"STOP" to die before it actually writes that string?

I have a feeling that the machinery being tested needs to be fixed
so that the sequence is always be:

    0) Git spawns the filter process, as it needs some contents to
       be filtered.

    1) Git did everything it needed to do and decides that is time
       to go.

    2) Filter process receives EOF and prints "STOP" to the log.

    3) Git waits until the filter process finishes.

    4) t0021, after Git finishes, checks the log.

Repeated sleep combined with grep is probably just sweeping the real
problem under the rug.  Do we have enough information to do the
above?

An inspiration may be in the way we centrally clean all tempfiles
and lockfiles before exiting.  We have a central registry of these
files that need cleaning up and have a single atexit(3) handler to
clean them up.  Perhaps we need a registry that filter processes
spawned by the mechanism Lars introduces in this series, and have an
atexit(3) handler that closes the pipe to them (which signals the
filters that it is time for them to go) and wait(2) on them, or
something?  I do not think we want any kill(2) to be involved in
this clean-up procedure, but I do think we should wait(2) on what we
spawn, as long as these processes are meant to be shut down when the
main process of Git exits (this is different from things like
credential-cache daemon where they are expected to persist and meant
to serve multiple Git processes).


