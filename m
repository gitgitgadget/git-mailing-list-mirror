From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 10:57:08 -0700
Message-ID: <7vfwqfkphn.fsf@alter.siamese.dyndns.org>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net>
 <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
 <20110322134358.GA19064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lasse Makholm <lasse.makholm@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:57:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q25pj-0004BD-6M
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 18:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863Ab1CVR51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 13:57:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1CVR5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 13:57:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08F764977;
	Tue, 22 Mar 2011 13:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pSFPs9artKIXifAK3rIO2D9313A=; b=CE4noW
	MGReEo4H83lhUryMUhaQ5C1oHMRir2mChLDQoIph5/wAQZ8CAA3GWjYAHS2ApEMm
	3Iq530dvf05gMDv/XdHnUokKsidk5Jb3xtXJIGkD1jz+GrSmzhK4aV5F7bcTY+JY
	LxyqycE3maH+q8wPnSf++n09U5MxgbQIXvuCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u25cux7+4waIYrdBOT9+CxRqFCX7VbvY
	PctOOkzhqs4jDhx9udOBot5JAVMA9NvzPgQIvvOu+gHFiREeWnjfeCNyOjjUxay6
	QUrcb76mE9ABm607VrXh7NGwqctmpO+mC3i2x9LGmz1a4U+yQuLNPTZDAv07jTu6
	nwVfzK8rcRI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1E8C4976;
	Tue, 22 Mar 2011 13:58:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AF4104975; Tue, 22 Mar 2011
 13:58:49 -0400 (EDT)
In-Reply-To: <20110322134358.GA19064@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 22 Mar 2011 09:43:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E7B109A-54AE-11E0-8E23-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169754>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 22, 2011 at 02:35:10PM +0100, Lasse Makholm wrote:
>
>> On 22 March 2011 14:28, Jeff King <peff@peff.net> wrote:
>> > But I think that is a little too magic for my taste. Although the false
>> > positives ("!echo 'literal $#'") and false negatives (you want "!foo" to
>> > _ignore_ its parameters) are pretty obscure, I would prefer to keep
>> > things simple.
>> 
>> Then how about simply:
>> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 6468a68..8097480 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -586,9 +586,16 @@ If the alias expansion is prefixed with an
>> exclamation point,
>>  it will be treated as a shell command.  For example, defining
>>  "alias.new = !gitk --all --not ORIG_HEAD", the invocation
>>  "git new" is equivalent to running the shell command
>> -"gitk --all --not ORIG_HEAD".  Note that shell commands will be
>> -executed from the top-level directory of a repository, which may
>> -not necessarily be the current directory.
>> +"gitk --all --not ORIG_HEAD". Note that any arguments you pass
>> +when running aliases are simply appended to the shell command.
>> +This means that "alias.foo = !echo $# args: $1, $2 and $3" will
>> +not do what you expect. To use alias arguments as positional
>> +parameters, wrap your command in a shell function:
>> +"alias.foo = !foo () { echo $# args: $1, $2 and $3; }; foo"
>> ++
>> +Shell commands will be executed from the top-level directory
>> +of a repository, which may not necessarily be the current
>> +directory.
>
> Yeah, that certainly improves the situation.

The first addition is indeed a huge improvement.

    Note that any argument you pass when running aliases are simply
    appended to the shell command.

The original didn't explicitly say it but it really should have.  The
example that comes before it, "alias.new = !...", should be updated with
an invocation that takes a parameter, perhaps like this:

    With this alias defined:

	[alias] since = "!gitk --all --since"

    you can view commits in the last week with:

        $ git since 7.days

    because this expands to "gitk --all --since 7.days" by concatenating
    the arguments supplied at runtime to the alias.

Then say that "Note ..." to stress that point.  The description at that
point has become much better.

With that understanding already there,

    This means that "alias.foo = !echo $# args: $1, $2 and $3" will
    not do what you expect.

is no longer true; nobody sane would expect that if you made them realize
that "simply appended" already.  Just dropping that sentence would make
the resulting text flow much better.

    If you want to refer to arguments given to the alias, you can
    wrap it as a shell script, e.g.

	[alias] reversed = "!sh -c 'echo $2 $1' -"

    or a shell function, e.g.

	[alias] reversed = "!reversed() { echo $2 $1 } && reversed"

    and invoke it like so:

	$ git reversed one two
        two one

I personally think the former "sh -c <str> -" is the more traditional and
well understood form (iow, an idiom) for people who breathe shells.

> +----------------------
> +alias.foo = !echo $# args: $1, $2 and $3
> +----------------------

While I totally agree with the formatting advice you gave here, we may
want to avoid this notation; neither "git config alias.foo = !echo ..."
nor writing "alias.foo = ..."  in .git/config file would work.
