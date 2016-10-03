Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B613207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbcJCRCU (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:02:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50966 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751146AbcJCRCS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:02:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4439F42EA4;
        Mon,  3 Oct 2016 13:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Il0n+OToOrXTMyqOqbPp33WRDQ=; b=oUZQ9/
        FXh2isD4f4Jl++rglSaheDaDp5VOLbMvbFh1rUhfGC87B9J2AVpZE9R2NrNoW2wp
        W7Pd+G+aSj8hgNL7t/PB9Khz2no5DG5QH5o4A4iPtnClsmM3bXH3zyKykxe5seGb
        y9cnaV4Ib3TVHd7+bx95MqCb/pjvpNsOArXrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dszRdXwSp7sImt3zbMWfOs2em9ss5zjP
        74y6EzmkAb3sCjX8Sl5hGSvvb8ju4N4bjvrQ8tZgJpVoJIpjX+JQaAqEZvaWVH5d
        wcAKIZaL7IfNVbBP6pL+CMe2wYyXgPHnC+392DFZpzYcMkl2MuCeIsGLI9TGwnn7
        TDyGdlVso3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B13642EA3;
        Mon,  3 Oct 2016 13:02:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B19EA42EA2;
        Mon,  3 Oct 2016 13:02:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
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
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
        <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
        <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
Date:   Mon, 03 Oct 2016 10:02:14 -0700
In-Reply-To: <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com> (Lars
        Schneider's message of "Sat, 1 Oct 2016 20:59:48 +0200")
Message-ID: <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 235C8BB6-898B-11E6-AD63-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> If the filter process refuses to die forever when Git told it to
>> shutdown (by closing the pipe to it, for example), that filter
>> process is simply buggy.  I think we want users to become aware of
>> that, instead of Git leaving it behind, which essentially is to
>> sweep the problem under the rug.
>> 
>> I agree with what Peff said elsewhere in the thread; if a filter
>> process wants to take time to clean things up while letting Git
>> proceed, it can do its own process management, but I think it is
>> sensible for Git to wait the filter process it directly spawned.
>
> To realize the approach above I prototyped the run-command patch below:
>
> I added an "exit_timeout" variable to the "child_process" struct.
> On exit, Git will close the pipe to the process and wait "exit_timeout" 
> seconds until it kills the child process. If "exit_timeout" is negative
> then Git will wait until the process is done.

> If we use that in the long running filter process, then we could make
> the timeout even configurable. E.g. with "filter.<driver>.process-timeout".
>
> What do you think about this solution? 

Is such a configuration (or timeout in general) necessary?  I
suspect that a need for timeout, especially needing timeout and
needing to get killed that happens so often to require a
configuration variable, is a sign of something else seriously wrong.

What's the justification for a filter to _require_ getting killed
all the time when it is spawned?  Otherwise you wouldn't configure
"this driver does not die when told, so we need a timeout" variable.
Is it a sign of the flaw in the protocol to talk to it?  e.g. Git
has a way to tell it to die, but it somehow is very hard to hear
from filter's end and honor that request?

I think that we would need some timeout in the mechanism, but not to
be used for "killing".

You would decide to "kill" an filter process in two cases: the
filter is buggy and refuses to die when Git tells it to exit, or the
code in Git waiting for its death is somehow miscounting its
children, and thought it told to die one process but in fact it
didn't (perhaps it told somebody else to die), or it thought it
hasn't seen the child die when in fact it already did.

Calling kill(2) and exiting would hide these two kind of bugs from
end users.  Not doing so would give the end users a hung Git, which
is a VERY GOOD thing.  Otherwise you would not notice bugs and lose
the opportunity to diagnose and fix it.

The timeout would be good for you to give a message "filter process
running the script '%s' is not exiting; I am waiting for it".  The
user is still left with a hung Git, and can then see if that process
is hanging around.  If it is, then we found a buggy filter.  Or we
found a buggy Git.  Either needs to be fixed.  I do not think it
would help anybody by doing a kill(2) to sweep possible bugs under
the rug.

Thanks.
