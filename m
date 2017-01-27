Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB8B1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbdA0SSB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:18:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52824 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754137AbdA0SRl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:17:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CB7A6116D;
        Fri, 27 Jan 2017 13:17:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eXvCzPir3hiL4vNQjQWvH/lmoEo=; b=UQMZRS
        nNzIW8OSeQR2KPsXov0FxfFseDyJfm5vrSGJhnjesFprw0/D7bYhMobls8aaX3bE
        Iz6Bmb7ELATs46Fg1N/DXT/Xp4TeeDMBGfo+LIU8Q+vYmih4/wkFGuo/wUkl0G2Z
        BBy+Ghfgi8ZeHCggpEjLBr0vC91bXygP0a+2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DRrK6Afw0/iFMZEbE7kIGZW0zztwsyND
        voOz2YiDXAkB2vlCkVXM2wB2kZ6R43yK9Dk5du1TDR0IeVjmRqxfc51ITxWKjo+W
        aW/eIUx1pKvmbPnjdNowYrAdLYggGKPKPOeIt7Yr5Tochw+ls0jHDC7J4TNqXok8
        MJ/VBPt+npE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 222C26116C;
        Fri, 27 Jan 2017 13:17:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 698746116B;
        Fri, 27 Jan 2017 13:17:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <cover.1485442231.git.johannes.schindelin@gmx.de>
        <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
        <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 27 Jan 2017 10:17:37 -0800
In-Reply-To: <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 26 Jan 2017 11:27:52 -0800")
Message-ID: <xmqqpoj8z7su.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E26CCAD4-E4BC-11E6-B2C0-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to save us extra round-trip.

Junio C Hamano <gitster@pobox.com> writes:

>> +`GIT_SSH_VARIANT`::
>> +	If this environment variable is set, it overrides the autodetection
>> +	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
>> +	push' use. It can be set to either `ssh`, `plink`, `putty` or
>> +	`tortoiseplink`. Any other value will be treated as normal ssh. This
>> +	is useful in case that Git gets this wrong.
>
> Similarly this should mention GIT_SSH_COMMAND at least.  It is crazy
> to set something that will cause misdetection to core.sshCommand and
> use this environment variable to fix it (instead of using ssh.variant),
> so I think it is OK not to mention core.sshCommand (but it would not
> hurt to do so).
>
>> diff --git a/connect.c b/connect.c
>> index 9f750eacb6..7b4437578b 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -691,6 +691,24 @@ static const char *get_ssh_command(void)
>>  	return NULL;
>>  }
>>  
>> +static int handle_ssh_variant(int *port_option, int *needs_batch)
>> +{
>> ...
>> +}
> ...
>
> The string that came from the configuration must be freed, no?  That
> is what I recall in Peff's comment yesterday.

The leak needs plugging in some way.  

Because this thing is merely an escape hatch that somebody who needs
it needs to use it always (as opposed to one-shot basis), we do not
need to support the environment variable and go with only the
configuration, which may make it easier to plug the leak.

>> @@ -817,7 +835,8 @@ struct child_process *git_connect(int fd[2], const char *url,
>>  				ssh_argv0 = xstrdup(ssh);
>>  			}
>>  
>> -			if (ssh_argv0) {
>> +			if (!handle_ssh_variant(&port_option, &needs_batch) &&
>> +			    ssh_argv0) {
>
> I like the placement of this "if the user explicitly told us" much
> better.
> ...
> And that reasoning will lead to a realization "there is no reason to
> even do the split_cmdline() if the user explicitly told us".  While
> that reasoning is correct and we _should_ further refactor, I didn't
> want to spend braincycles on that myself.

This _should_ above is a lot weaker than _must_.  

IOW, I think it is acceptable to always split GIT_SSH_COMMAND into
tokens before we realize that the user used the escape hatch and the
splitting was a wasted effort.  This is exactly because this thing
is an escape hatch that is expected to be rarely used.  Of course,
if the "wasted effort" can be eliminated without sacrificing the
simplicity of the code, that is fine as well.




