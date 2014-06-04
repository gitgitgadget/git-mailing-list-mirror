From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Date: Wed, 04 Jun 2014 10:24:06 -0700
Message-ID: <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
	<1401874256-13332-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mara.kim@vanderbilt.edu,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFAU-0001Hf-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 19:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbaFDRYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 13:24:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62885 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaFDRYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 13:24:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71D8C1C072;
	Wed,  4 Jun 2014 13:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crol9q3DH28DRHzYgPrwCxWhEzU=; b=E8Gxqn
	RPugIBCJ6+3YNQeBsXWpPOlqoB5fl7evyIjJ9gO8IPiAnaf2v8BCMoA3CWojgEJI
	wLqvvqM9PNvbn8TFTMNT1eZVpeiQiv9+l11hmJDXEPVloJnfs1I3GL2pYl4FdOCC
	h1Rb+8RG+ciXmHF3Yz1YSeuoQlmJkTuWUsNOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n12dfnGVZMVRrJ78zIdX9wzV/de0cg72
	ZX46Y0wl+dDsGZfFlMCNDRoqg0LSciUTg+PtY1690pgFGGPAxejujw6QoCOJsGgS
	51By37oMmBCxCyiLG/+ppOWKq1idZAx5aKWl6++x9mpB2rOkVgcsBfZU3O9qFG+u
	app05hRpDmQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6821A1C071;
	Wed,  4 Jun 2014 13:24:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6B421C06A;
	Wed,  4 Jun 2014 13:24:08 -0400 (EDT)
In-Reply-To: <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
	(Chris Packham's message of "Wed, 4 Jun 2014 21:30:56 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 096589B0-EC0D-11E3-9EBB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250747>

Chris Packham <judge.packham@gmail.com> writes:

> On 04/06/14 09:05, Junio C Hamano wrote:
>>> Also, going --recursive when the user did not want is a lot more
>>> expensive mistake to fix than not being --recursive when the user
>>> wanted to.
>> 
>> Having said all that, I do not mean to say that I am opposed to
>> introduce some mechanism to let the users express their preference
>> between recursive and non-recursive better, so that "git clone"
>> without an explicit --recursive (or --no-recursive) can work to
>> their taste.  A configuration in $HOME/.gitconfig might be a place
>> to start, even though that has the downside of assuming that the
>> given user would want to use the same settings for all his projects,
>> which may not be the case in practice.
>
> And here's a quick proof of concept. Not sure about the config variable name
> and it could probably do with a negative test as well.

I would be more worried about the semantics than the name, though;
re-read the part you quoted with extra stress on "has the downside".

I think I heard the submodule folks (cc'ed) discuss an approach to
allow various submodules to be marked with "tags" with a new type of
entry in .gitmodules file in the superproject, and use these tags to
signal "by default, a new clone will recurse into this submodule".

E.g. if projects standardized on "defaultClone" to mark such
submodules, then $HOME/.gitconfig could say

    [clone]
        recursesubmodules = defaultClone

Or the projects may mark platform specific submodules with tags,
e.g. a .gitmodules in a typical superproject might say something
like this:

    [submodule "posix"]
    	path = ports/posix
        tags = linux obsd fbsd osx
    [submodule "windows"]
        path = ports/windows
        tags = win32
    [submodule "doc"]
    	path = documentation
        tags = defaultClone

and then the user's $HOME/.gitconfig might say

    [clone]
        recursesubmodules = defaultClone win32

to tell a "git clone" of such a superproject to clone the top-level,
read its .gitmodules, and choose documentation/ and ports/windows
submodules but not ports/posix submodule to be further cloned into
the working tree of the superproject.

Of course, if this kind of project organization proves to be useful,
we should try to standardize the set of tags early before people
start coming up with random variations of the same thing, spelling
the same concept in different ways only to be different, and if that
happens, then we could even give a non-empty default value for the
clone.recursesubmodules when $HOME/.gitconfig is missing one.

Just a random thought.
