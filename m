From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 04 Jan 2011 15:39:19 -0800
Message-ID: <7vmxngdys8.fsf@alter.siamese.dyndns.org>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
 <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
 <vpqhbdoxpzp.fsf@bauges.imag.fr> <20110104225826.GA2122@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Vallon\, Justin" <Justin.Vallon@deshaw.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 00:39:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaGTg-0001CG-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 00:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014Ab1ADXji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 18:39:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab1ADXjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 18:39:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EED3634CC;
	Tue,  4 Jan 2011 18:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOGRdFYouThrHTVr9n618cwMm2k=; b=AQ+9qi
	hv7dVYVEFHn/jG3B7lmeWl4+KSn6mzCpTB7vSsRAL/Yekrh9oYVXGdxOIMfD/EET
	XahTOm3+lmN7hTlAnP376wOBzZ4diUIi2/M+tV+lyFUHy7QrPCeSEMwMbOuE8z9T
	uQwpwGIsMZZf/LAnHRW1Vak0dLkxHg3dMuZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ocqQK4WOpDyOI3WEDSQDi8jjI4u8wdFr
	W5rASHV83SJ5OWEYYVzC6kGySNad2xc4MuDlnnC00AdlrsfG1XCAJdaFefvj7jJa
	omUCDSKIIps6Ta8lAQjPCeoZWJnUDEvxQ28OVyOgarN+pUAE3UAW+MiNg5sv+doj
	7oWd5ehcA/o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9EA5334CA;
	Tue,  4 Jan 2011 18:40:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D31FB34C9; Tue,  4 Jan 2011
 18:39:59 -0500 (EST)
In-Reply-To: <20110104225826.GA2122@burratino> (Jonathan Nieder's message of
 "Tue\, 4 Jan 2011 16\:58\:26 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F5CDD804-185B-11E0-BC40-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164526>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>> "Vallon, Justin" <Justin.Vallon@deshaw.com> writes:
>
>>> --- a/t/t3404-rebase-interactive.sh
>>> +++ b/t/t3404-rebase-interactive.sh
>>> @@ -71,8 +71,9 @@ test_expect_success 'setup' '
>>>  # "exec" commands are ran with the user shell by default, but this may
>>>  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
>>>  # to create a file. Unseting SHELL avoids such non-portable behavior
>>> -# in tests.
>>> +# in tests. It must be exported for it to take effect where needed.
>>>  SHELL=
>>> +export SHELL
>>
>> (my bad, I wrote this SHELL= without exporting it. Since bash
>> re-exports already exported variables when they are assigned, and my
>> /bin/sh points to bash, I didn't notice)
>
> Isn't that how export works in all Bourne-style shells?  For example:
>
> 	$ env var=outside dash -c '
> 		var=inside;
> 		dash -c "echo \$var"
> 	  '
> 	inside
> 	$
>
> Maybe in the failing case SHELL was not exported but just set to
> /bin/false in .bashrc or similar?

Thanks, you saved me some time responding ;-)

Matthieu's diagnosis is only half correct in that bash is why he didn't
notice the problem, but if in this sequence

	var=foo
        export var
        var=bar
        some-command

some-command does not see "bar" as the value of environment variable
"var", your shell is not POSIX (there is no such thing as "re-exporting").

Either a variable is marked with the export attribute, in which case the
processes spawned from the shell sees the value of the then-current shell
variable in their environments, or they don't for shell variables that are
not marked with the export attribute.

The real reason the problem went unnoticed was because bash automatially
marks SHELL with the export attribute.

Because POSIX shells are required to mark variables they inherit from the
environment with the export attribute, your tests will run with SHELL
exported to the environment if your usual shell is bash (i.e. SHELL is
already exported to processes it spawns), even if you use another POSIX
shell to run your git and tests.  That makes the issue doubly harder to
notice.
