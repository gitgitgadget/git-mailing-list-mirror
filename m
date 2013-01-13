From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Sun, 13 Jan 2013 14:56:53 -0800
Message-ID: <7vsj64hetm.fsf@alter.siamese.dyndns.org>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
 <7v8v7zbcoi.fsf@alter.siamese.dyndns.org> <50F178C8.40806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, felipe.contreras@gmail.com,
	peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:57:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWUU-0001mK-26
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 23:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142Ab3AMW45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 17:56:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44044 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab3AMW44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 17:56:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBBAAC4D2;
	Sun, 13 Jan 2013 17:56:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8iIMMaAjB9veuZqxhtousxFkvNU=; b=Gm0ywV
	3geqSGvIlaT9EBZOYDuOIQx/NEKGf9BDZ1WIatNd+5dCVEkUeBn2gC360Dpk31yV
	6MqogxE4xtcxzR7aOEVuUPMEfiji8YCANC85jnrEfuijCLqSUa1fK4m97UzKgGs1
	klS8DMdf4C6+JuR/jjRHbS5ARLLRjgYDmBv0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oqCzra4DwZ+MikANbhCBA8ZLMnLJMUz8
	H/DUFXfsGZ4D6yEHY+btpgsTPM7boQ1Ac9SBkXN8lFCQjSj/zniAEPnuHHgV2rQz
	uyMdcq7e3HRpgg+kFNPS+l4PhEJ0tWSjKVDqro86QPx7E3HLHigvjf30abZrv7Lr
	9dT98nMD62U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0262C4D1;
	Sun, 13 Jan 2013 17:56:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235BFC4CE; Sun, 13 Jan 2013
 17:56:55 -0500 (EST)
In-Reply-To: <50F178C8.40806@gmail.com> (Manlio Perillo's message of "Sat, 12
 Jan 2013 15:52:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86DBBCC0-5DD4-11E2-951D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213405>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Il 11/01/2013 23:02, Junio C Hamano ha scritto:
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
>> 
>>> +# Process path list returned by "ls-files" and "diff-index --name-only"
>>> +# commands, in order to list only file names relative to a specified
>>> +# directory, and append a slash to directory names.
>>> +__git_index_file_list_filter ()
>>> +{
>>> +	# Default to Bash >= 4.x
>>> +	__git_index_file_list_filter_bash
>>> +}
>>> +
>>> +# Execute git ls-files, returning paths relative to the directory
>>> +# specified in the first argument, and using the options specified in
>>> +# the second argument.
>>> +__git_ls_files_helper ()
>>> +{
>>> +	# NOTE: $2 is not quoted in order to support multiple options
>>> +	cd "$1" && git ls-files --exclude-standard $2
>>> +} 2>/dev/null
>> 
>> I think this redirection is correct but a bit tricky;
>
> It's not tricky: it is POSIX:

I know that.  It is an instance of "Even it is in POSIX, we may want
to refrain using it, because some shells get it wrong, and it is
easy to work it around".

>> effect during the execution of the { block } (in other words, it is
>> not about squelching errors during the function definition).
>
> What do you mean by "squelching"?

Silencing, not showing the end user.  Sending to /dev/null.

> I have added tcsh to the sh list, but it fails with:
> Badly placed ()'s.

tcsh (and csh) are not even in the Bourne shell family and is not
expected to be able to run any non trivial POSIX shell scripts.  The
completion script for it does not dot-source this but instead lets
bash read it, so it is fine.

>> It however may affect zsh, which does seem to dot-source this file.
>> Perhaps zsh completion may have to be rewritten in a similar way as
>> tcsh completion is done (i.e. does not dot-source this file but ask
>> bash to do the heavy-lifting).
>
> Ok, I was wrong on assuming all modern shells were POSIX compliant.

Shells in csh family will never be, and being non-POSIX is not a
crime.  It only matters when such a shell is allowed to dot-source
this script, and this script uses constructs that such a shell does
not understand.

> I will change the code to use a nested {} group.
>
>> This function seems to be always called in an subshell (e.g. as an
>> upstream of a pipeline), so the "cd" may be harmless, but don't you
>> need to disable CDPATH while doing this?
>
> I don't know.

The caller of this function figures out the value of $subdirname,
and calls you; your "cd $subdirname" may not go to ./$subdirname as
you expect, but to the $subdirname directory under one of the
directories listed in CDPATH, before running ls-tree or ls-files.
