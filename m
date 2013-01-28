From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 12:34:00 -0800
Message-ID: <7vlibdvyh3.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
 <20130128081006.GA2434@elie.Belkin> <7vham1xktx.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com>
 <7vr4l5w385.fsf@alter.siamese.dyndns.org> <5106DBB7.70007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvPQ-00020Q-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab3A1UeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:34:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab3A1UeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:34:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8F07C205;
	Mon, 28 Jan 2013 15:34:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8huH7A5GBRE+AcID0o+huIyjGSE=; b=cPP4IH
	FeyMYoQTlp9hSEcW6vv1mfz+AyOV3DtFvOX4TTY8MLNnV0QtmUkHgnW4/FNqQIhX
	FzobiTPTMxNygPtB48Y/UbZtJGjaI1NGkvLHpliHKhMRlnGo+WyeOkXc7vS0/k+L
	MKCZodTcOJOeLPTcp1sZb4nEir32H3/qvME/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C99bZE+kh+gjz7++rT78eNWrWDavcHKc
	CEFlu9O9PPfkw4Y/fRh6/SdVU5nTY1TWV3M+1vkAxnSSCVWfX+JbzjVCTL2PpiBQ
	7wVMsxwsb4qB0r6L5tH79XtefEnh5XFrQc+zCRBgZAxGRc92EFrW0r4CGiwk3BXx
	iV6SejGerc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B90C1C204;
	Mon, 28 Jan 2013 15:34:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2C4AC200; Mon, 28 Jan 2013
 15:34:01 -0500 (EST)
In-Reply-To: <5106DBB7.70007@web.de> (Jens Lehmann's message of "Mon, 28 Jan
 2013 21:12:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D051056-698A-11E2-8D35-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214865>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 28.01.2013 19:51, schrieb Junio C Hamano:
>> Lars Hjemli <hjemli@gmail.com> writes:
>> 
>>>> Come to think of it, is there a reason why "for-each-repo" should
>>>> not be an extention to "submodule foreach"?  We can view this as
>>>> visiting repositories that _could_ be registered as a submodule, in
>>>> addition to iterating over the registered submodules, no?
>>>
>>> Yes, but I see some possible problems with that approach:
>>> -'git for-each-repo' does not need to be started from within a git worktree
>> 
>> True, but "git submodule foreach --untracked" can be told that it is
>> OK not (yet) to be in any superproject, no?
>
> Hmm, I'm not sure how that would work as it looks for gitlinks
> in the index which point to work tree paths.

I was imagining that "foreach --untracked" could go something like this:

 * If you are inside an existing git repository, read its index to
   learn the gitlinks in the directory and its subdirectories.

 * Start from the current directory and recursively apply the
   procedure in this step:

   * Scan the directory and iterate over the ones that has ".git" in
     it:

     * If it is a gitlinked one, show it, but do not descend into it
       unless --recursive is given (e.g. you start from /home/jens,
       find /home/jens/proj/ directory that has /home/jens/proj/.git
       in it.  /home/jens/.git/index knows that it is a submodule of
       the top-level superproject.  "proj" is handled, and it is up
       to the --recursive option if its submodules are handled).

     * If it is _not_ a gitlinked one, show it and descend into it
       (e.g. /home/jens/ is not a repository or /home/jens/proj is
       not a tracked submodule) to apply this procedure recursively.

Of course, without --untracked, we have no need to iterate over the
readdir() return values; instead we just scan the index of the
top-level superproject.

>>> -'git for-each-repo' and 'git submodule foreach' have different
>>> semantics for --dirty and --clean
>
> I'm confused, what semantics of --dirty and --clean does current
> 'git submodule foreach' have? I can't find any sign of it in the
> current code ... did I miss something while skimming through this
> thread? Or are you talking about status and diff here?

I think Lars is hinting that "submodule foreach" could restrict its
operation to a similar --dirty/--clean/--both option he has.  Of
course, the command given to foreach can decide to become no-op by
inspecting the submodule itself, so in that sense, --dirty/--clean
can be done without, but I think it would make sense to have it in
"submodule foreach" even without the "--untracked" option.

> But I think the current for-each-repo
> proposal doesn't allow to traverse repos which contain untracked
> content (and it would be nice if the user could somehow combine
> that with the current --dirty flag to have both in one go).

Perhaps.  I personally felt it was really strange that submodule
diff and status consider that it is a sin to have untracked and
unignored cruft in the submodule working tree, though.
