From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the fsck machinery
Date: Tue, 03 Feb 2015 19:50:30 -0800
Message-ID: <xmqqegq6nxmh.fsf@gitster.dls.corp.google.com>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
	<cover.1422737997.git.johannes.schindelin@gmx.de>
	<060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
	<54CF70DA.5090506@alum.mit.edu>
	<d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
	<54D0E50A.5030601@alum.mit.edu>
	<2313893ae2200229ccdeb8f71b629445@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 04:50:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIqz9-0005aQ-4b
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 04:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbbBDDuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 22:50:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753242AbbBDDue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 22:50:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E2F93694B;
	Tue,  3 Feb 2015 22:50:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8XfIRY0W206xYUBa0uYkdX5y80M=; b=aVc6Tr
	CypITiC7s9fZxNLrTIRbeHmQe03i05yZuuluq31vsEBkhQbRr5Uo9U2JNU5G9n3J
	yft648qWmM+PXlNmVHz0O3z5CryVUW7SiY5x3GP/TWj5gCsdG6Av0H/InfMHavbO
	i+icqnvbvRhwwrQDPi7FqIDYfeC8rGkyeGmcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZyvN/0uk5GYXszhxq7cE6tN21DZJ7e0
	EDBZxhrUlDlL4tvEDdIrj1On1+4wekhGWNK/euEyTZKRD0BMSddZaA0ZHEwzcatb
	7vxhn+uoufJo68azlHLzLxf5fL5e7mAt0FzO19mjMymaSL1GDiBXuXmKphAvY6Ma
	9vgv2pDBRJ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6360B3694A;
	Tue,  3 Feb 2015 22:50:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7D8736947;
	Tue,  3 Feb 2015 22:50:31 -0500 (EST)
In-Reply-To: <2313893ae2200229ccdeb8f71b629445@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 03 Feb 2015 17:33:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F77B4BF2-AC20-11E4-AD3E-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263347>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> [fsck "level"]
>>         missingAuthor = error
>> 
>> , which looks funny. "level" is a constant, so it seems superfluous.

Yes, it is superfluous, but is one way to avoid the ambiguity with
"skiplist".  Structuring it like this would not be so bad, either,
though.

	[fsck]
        	error = missingAuthor[, other kinds of errors...]

A small set like {ignore, warn, error} is easily maintainable not to
conflict with "skiplist" and others.

So that "avoid ambiguity with skiplist" does not favor either choice
in any significant way.

> This becomes important when I want to catch obvious problems such as
> fsck.missingautor': if I have an extra '.level', I can be certain that
> it is a typo rather than a config setting unrelated to the severity
> levels.

"[fsck] error = missingAutor" would let you catch the typo in a similar
way with the same context clue, so this does not decide which is
better, either.

One clear benefit I can see in it is that you can do

	git config fsck.level.missingAuthor

in scripts that wants to learn the current setting for a single
variable.  With "fsck.error=missingAuthor[,other kinds]", you would
instead have to do a bit more silly post-processing

	git config -l | sed -ne '
        	/^fsck\./{
			# make it "var=,token1,token2,token3,"
			s/=/=,/
                        s/$/,/
                        s/[ 	]*//g
			s|^fsck\.\([^=]*\)=.*,missingAuthor,.*|\1|p
		}
	' | tail -n 1

to grab the last fsck.{error,ignore,...}= thing that has the token
(I personally do not think the latter is so bad, though).

I wonder if

	[fsckError]
        	missingAuthor = error
                missingTagger = warn

wouldn't be a better way, though.  We'd keep the easier scripting

	git config fsckError.missingTagger

There is nothing that says that the top-level grouping must match
the Git subcommand name.  Nothing says that one Git subcommand can
own at most one namespace, either.  Nothing stops us from reserving
fsckError top-level namespace for variable name collision avoidance
with other fsck.* variables, if that gives us a better system.

>>> Unfortunately, I have to pass the `receive.fsck.*` settings from
>>> `git-receive-pack` to `git-unpack-objects` or `git-index-pack` via the
>>> command-line, because it is `git-receive-pack` that consumes the config
>>> setting, but it is one of `git-unpack-objects` and `git-index-pack` that
>>> has to act on it...

But receive-pack at some point decides what, if anything, needs to
be passed when invoking unpack-objects, or index-pack, no?  Why is
it hard to pass "-c var=val" at the beginning where it would have
passed "--strictness=var=val" at the end?

>> Wouldn't that work automatically via the GIT_CONFIG_PARAMETERS
>> mechanism? If I run
>> 
>>     git -c foo.bar=baz $CMD
>> 
>> , then git-$CMD is invoked with GIT_CONFIG_PARAMETERS set to
>> "'foo.bar=baz'", which causes child processes to treat that value as a
>> configuration setting. I don't have a lot of experience with this but I
>> think it should do what you need.
>
> This is true, but please remember that the receive.fsck.* settings
> should be heeded by index-pack/unpack-objects *only* if one of the
> latter programs is called by receive-pack. It would therefore be a
> little funny (or wrong, depending on your point of view) if, say,
> index-pack would respect the receive.fsck.* settings.

That means it would be fine if receive-pack invokes (when it sees
receive.fsck.severity=missingAuthor=error,missingTagger=warn config
meant for it and was told with receive.fsckObjects to check the
incoming objects) a command line like this:

	git -c fsckError.missingAuthor=error \
            -c fsckError.missingTagger=warn \
		index-pack $args...

(or whatever variable names and name structure we settle on).  And
the index-pack command does not have to even know there are
receive.fsck.* variables at all, no?

Another way to do that may be for receive-pack to invoke

	git index-pack --use-fsck-severity=receive.fsck $args...

to instruct it to look at receive.fsck.* variables, again when and
only when receive-pack wants to do so.  I think either way would be
fine, as this communication is an internal implementation detail
between receive-pack and index-pack and is not meant to be exposed
to the end users anyway.
