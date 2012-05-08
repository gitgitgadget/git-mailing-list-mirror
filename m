From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit path vs rebase path
Date: Tue, 08 May 2012 10:25:26 -0700
Message-ID: <7v1umuwpo9.fsf@alter.siamese.dyndns.org>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
 <7vaa1j7vg1.fsf@alter.siamese.dyndns.org> <4FA8BBB0.1080406@viscovery.net>
 <CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
 <4FA8C5DB.5060002@viscovery.net>
 <CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
 <7vhavqwqpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 19:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoAJ-0007Zo-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2EHRZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 13:25:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab2EHRZa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:25:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6276748A;
	Tue,  8 May 2012 13:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S9KU9Eah/qUhCT5Z7TwyWQbu+Uk=; b=Mwmeak
	lZUwkQfetoq7fPYwERRb6ETA/O31EYTUEsVnm2lw6ZqFIJvZiVtJyA6SbpFhlTRJ
	WWyLcNJE9JtzCUqZpkxTZA764WPOZS7WcMSCrejYyY3JhJ0qjiY4vTaUt6lwFH5B
	MnAhJrTxTgEA+IkmZV4NltS4bk6xBiUB/k0y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vrL5PBfhUyLwMatgs1QwBxlummsN2R40
	iZ96bBxUkX8RiiqtQF3i6n/5ZwnDX/rA28nT3Kth7uHOL31I0PU+SlPQFx7YMA/3
	0RoRUBg/YHxYPfTcL+3YdjuRAh6aokurIAypEIo/aTolyogsXMu1LhmbZKjvg6NO
	IqJoCp1WUz4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB4227489;
	Tue,  8 May 2012 13:25:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E71C7482; Tue,  8 May 2012
 13:25:28 -0400 (EDT)
In-Reply-To: <7vhavqwqpz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 08 May 2012 10:02:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE282562-9932-11E1-AD56-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197398>

Junio C Hamano <gitster@pobox.com> writes:

> Steven Penny <svnpenn@gmail.com> writes:
>
>> Johannes Sixt wrote:
>>> Are you saying that the new pwd function will also be used on Cygwin? That
>>> would be a bug.
>>
>> The linked patch should fix the problem for _MinGW_ users.
>>
>> The problem will persist with _Cygwin_ users.
>
> What does a full pathname, fed as a parameter when invoking Windows native
> binaries like notepad, look like in a Cygwin environment?  That is, if you
> are writing a bash script that is meant to run in a Cygwin environment,
> and if the script takes the name of a file in the current directory, but
> it needs to chdir around for its own reasons before spawning notepad on
> the file, i.e.
>
> 	#!/bin/bash
> 	file="$(pwd)/$1"
>         ...
>         cd ..some..where..else..you..have..no..control..over
>         notepad "$file"
>
> what is the right incantation to replace `pwd` in 'file="$(pwd)/$1"'
> above?
>
> Whatever that is, using that instead of `pwd` in git-sh-setup.sh here:
>
> 	test -n "$GIT_DIR" && GIT_DIR=$(cd "$GIT_DIR" && pwd) || {
>
> would be the solution.

Actually, the above is stated rather poorly.  The path that ends up in
$file must be usable by both Windows native and Cygwin programs, as the
user may be using "vi" from Cygwin, or "notepad" like your example.

If there is no way to formulate $file to be acceptable for both, I do not
see any sane solution other than one side compromising for the rest,
perhaps by having

	$ cat >notepad.sh <<\EOF
        file=$(cygpath -m "$1") && exec notepad.exe "$file"
        EOF

on the end-user side, or something like that.
