From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] submodules: Add the lib-submodule-update.sh test library
Date: Tue, 17 Jun 2014 11:44:50 -0700
Message-ID: <xmqqwqcfl6jh.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>
	<xmqqwqcgo4gc.fsf@gitster.dls.corp.google.com>
	<53A07BCE.5010100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 20:45:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwyNS-0007zQ-6v
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 20:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932851AbaFQSo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 14:44:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296AbaFQSo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 14:44:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25D1B20991;
	Tue, 17 Jun 2014 14:44:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2uRjo3ocOuziNpRcCiBee5zVa9k=; b=VoVYJt
	5iVeoQlahs/Z0MewYEO85eyeOahrocyis4jvBMe+NMe/59uuN9L753CmxciU1GRX
	KZzsOnpdqHj1Gof4jZ/DkRK6uL3fFN1y3Jambfco35npNaD242I4plCAd1c/v737
	CCuJaTXBSly47bfd8kLiYqECp9w+AUugra6KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ecjP0v8AS7CNI224+uVmy5CBZkZJtpbk
	dqOZw6f9GrB5ib+5VVCtz+Pje7Uc/WI3kcBvFEvV6wZWTG8TsEwanSJo0j9KApLR
	cdfXtLB6RkNOUc1KN9joHupGa9arOczon6WDGE6jaUHVKQVZDz///ukpfd0pmIbe
	bCqyD4k8AXw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 199E820990;
	Tue, 17 Jun 2014 14:44:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD0EE2098D;
	Tue, 17 Jun 2014 14:44:49 -0400 (EDT)
In-Reply-To: <53A07BCE.5010100@web.de> (Jens Lehmann's message of "Tue, 17 Jun
	2014 19:33:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 764833A6-F64F-11E3-B8B2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251933>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 17.06.2014 00:49, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>> +		git checkout -b "add_sub1" &&
>>> +		git submodule add ./. sub1 &&
>> 
>> This is not technically wrong per-se, but having the project's
>> history itself as its own submodule *is* something nobody sane would
>> do in the real life.  Do we really have to do it this unusual way?
>
> I agree that this isn't a sane setup for real world usage, but I did
> that because it makes things easier when adding tests for recursive
> submodule update later, as we can then use the same test setup just
> one submodule level deeper.

Hmmm... ok....

>>> +		GIT_WORK_TREE=. git config --unset core.worktree
>> 
>> Hmph.  What does GIT_WORK_TREE=. alone without GIT_DIR=<somewhere>
>> do?  It's not like it is a workaround for "git config" that complains
>> when you do not have a working tree, right?  Puzzled...
>
> It is, it overrides the core.worktree config that would stop us
> from unsetting the core.worktree config with this error message:
>
>   fatal: Could not chdir to '../../../sub1': No such file or directory
>
> (We use the same pattern in git-submodule.sh and some other tests)

Is this a work-around for a bug in "git config"?  Or is this an
expected failure and it is unusual and not realistic outside of test
setup to want to unset core.worktree?  I am inclined to think it is
the latter, but I dunno.

>>> +		sha1=$(git ls-tree HEAD "sub1" 2>/dev/null | grep 160000 | tr '\t' ' ' | cut -d ' ' -f3) &&
>> 
>> Why discard the standard error stream?
>
> Because we sometimes reset to commits where "sub1" isn't present:
>
>   fatal: Path 'sub1' does not exist in 'HEAD'

Huh?  We shouldn't.

	$ git ls-tree HEAD no-such; echo $?
        0

It discards errors that may happen in other situations, too---is
that something we do not have to worry about?

> Cool, that's much better. Due to the sometimes missing "sub1" I
> needed to modify it to drop the error and not fail:
>
>   sha1=$(git rev-parse HEAD:sub1 2>/dev/null || true) &&

The "HEAD:sub1" notation does require that the path exists in the
specified tree-ish.  Even if we tried to express the above in a more
carefully written form:

	# We may or may not have sub1 in HEAD
        if "sub1 exists in HEAD"
        then
        	sha1=$(git rev-parse HEAD:sub1)
	else
		sha1= # empty
	fi

we would end up using "git rev-parse HEAD:sub1" to implement "sub1
exists in HEAD" part, so your updated alternative would be the best
we could do, I would think.

>>> +# Test that the given submodule at path "$1" contains the content according
>>> +# to the submodule commit recorded in the superproject's commit "$2"
>>> +test_submodule_content () {
>>> +	if test $# != 2
>>> +	then
>>> +		echo "test_submodule_content needs two arguments"
>>> +		return 1
>>> +	fi &&
>>> +	submodule="$1" &&
>>> +	commit="$2" &&
>>> +	test -d "$submodule"/ &&
>>> +	if ! test -f "$submodule"/.git && ! test -d "$submodule"/.git
>> 
>> I wonder if we can get away with a single "test -e" (we do not
>> expect us to be creating device nodes or fifos there, do we?).
>
> But a symbolic link maybe?

Symlinks should pose no problems, I would say, without loosening
anything.

	$ test -f RelNotes; echo $?; test -e RelNotes; echo $?
        0
        0
        $ ln -s t tests; test -d tests; echo $?; test -e tests; echo $?
        0
        $ ln -s no-such x; test -f x; echo $?; test -e x; echo $?
        1
        1


Thanks.
