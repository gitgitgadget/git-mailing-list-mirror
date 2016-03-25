From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 09:02:39 -0700
Message-ID: <xmqqegay5yw0.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:02:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUCH-0006QE-2G
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbcCYQCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:02:44 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752830AbcCYQCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:02:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A02A4EF30;
	Fri, 25 Mar 2016 12:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TVXHcLiYcT1vTfENWKkjDuoecfs=; b=P7G3wy
	oTxq26qy5x/Se1Ao+qVhc3H2UBY7vuzvZPHXHNon9SeUaxJJBA0/oSInM5i3OT/Y
	KQApl5CCXzCZ+rdu+HuPquKtl5GRXmMiA3Js3gH6N3LttBgsNqiu62Da75jDfKaU
	Rh2PVAW7u5mIi/LOuZUm+0USMSNVvJUzKWR9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DZ5aX+6guhy3MTH3YuolcU42F4Jp943S
	YJrWqSQj6KCAQnDZ1qJr0uchFrwQeZ3jXUnyg7uCkrzD9Z9sGV3iFrPo0szFzdXJ
	esNlmuUH5E5Dsjp3B96EdVIrQKUFgG0Oe9KfZQ+21V/UUM9+tdQgoWXPQH6KhJ7K
	jitsDVxJ+Qw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EF524EF2F;
	Fri, 25 Mar 2016 12:02:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4D274EF2D;
	Fri, 25 Mar 2016 12:02:40 -0400 (EDT)
In-Reply-To: <xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Mar 2016 23:28:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00B64946-F2A3-11E5-91D8-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289897>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> The usual early machinery of Git is to change the directory to
>> the top level of the working tree and pass the actual path inside
>> the working tree as `prefix` to the command being run.
>>
>> This is the case both for commands written in C (where the
>> prefix is passed into the command in a function parameter) as
>> well as in git-submodule.sh where the setup code runs...
>>
>> Adhere to Gits standard of passing the relative path inside the
>> working tree by passing it via -C.
>
> While -C _also_ works, I do not think it is "standard" in any sense.
> What made you think so?  -C is a way to tell Git to chdir there
> before doing anything else, without even adjusting the command line
> arguments that might be paths, and "chdir there to go to top" may
> (or may not--I haven't thought things thru) have the same effect as
> passing the prefix into functions, that is merely true as a side
> effect, I would think.
>
> So this change may not be wrong per-se, but if the lossage of prefix
> is the final goal (as opposed to an approach to gain other benefits,
> e.g. "now we do not have to use prefix, we can simplify these other
> things"), I do not know if it is worth it.

I actually do not care too deeply either way, as I understand that
the long term goal is to have "git submodule" itself rewritten in C,
so that places that currently call submodule--helper would become an
internal call.

The way all the subcommand written in C works is

 - The start-up sequence does the repository discovery, which
   involves crawling up to the top-level of the working tree, and
   compute "prefix", where the end-user was when the command was
   invoked;

 - The subcommand implementation is called with this "prefix";

 - When the subcommand implementation interprets the command line
   arguments and option arguments, it prefixes the "prefix" as
   needed.  If, for example, "git grep -f patterns" is invoked
   inside "sub/" subdirectory, when the command line and option
   arguments are processed, the process is already at the top level
   of the working tree, so it needs to read the patterns from
   "sub/patterns" file.  "git ls-files 'Makefil*'" invoked inside
   "sub/" subdirectory needs to limit the output to those that match
   not "Makefile", but "sub/Makefil*".

The hope of doing an incremental rewrite of the whole thing by
enriching submodule--helper is that the bulk of the code there will
be reusable when the entirety of "git submodule" is rewritten in C,
so they need to take the "prefix" the same way, whether the caller
is calling from "git-submodule.sh" script via submodule--helper, or
the eventual C implementation of "git submodule" is making direct
calls to them.  As long as the correct "prefix" is passed to the
routines that are driven via submodule--helper, it does not matter
and I do not care how it is done.

The current code of "git submodule" whose higher parts are still in
shell would would:

 - The start-up sequence in shell does the cd_to_toplevel and finds
   the prefix;

 - "git submodule--helper list --prefix=$prefix $other_args" is
   called; as this is called from the top-level of the working tree,
   internally its "prefix" is empty, but $other_args must be
   interpreted relative to the $prefix passed with --prefix option.

If we instead call "git -C "$prefix" submodule--helper list $other_args",
then

 - This command first does another chdir(2) back to $prefix;

 - The start-up sequence of "submodule--helper" does the usual
   repository discovery again, which involves crawling up to the
   top-level of the working tree, and compute "prefix".  This
   happens to match what -C "$prefix" gave the command.

Making calls to submodule--helper via "git -C" feels a little bit
roundabout because of this "caller tells to chdir, and then it has
to again chdir back up" only to rediscover the same information.

Again, I actually do not care too deeply either way, though, as long
as the correct "prefix" is passed to the routines that are driven
via submodule--helper, which would assure that the C code you write
today will be reusable when "git submodule" as a whole is redone in
C.

Thanks.
