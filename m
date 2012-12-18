From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 11:22:56 -0800
Message-ID: <7vpq27f9m7.fsf@alter.siamese.dyndns.org>
References: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com>
 <7v1uengsbm.fsf@alter.siamese.dyndns.org> <50D0BC32.2020401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2l4-0007Ns-Se
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab2LRTXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:23:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62683 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab2LRTW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:22:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA847A241;
	Tue, 18 Dec 2012 14:22:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ewqhs3kIxroioK7qF4ksJvUIcgc=; b=FyaMtv
	YkrdOGoegsmkBwYCBXp7rd9/q4mL0HhxnqaL7rNY2S61Zf0dMJDRpFf3zoXpX5Ph
	Rxn8fnV6myV+eJXmqIYb0SACUnl2RyiTtxuWWgikv4jDPkkhldyG4cgrVDIaKuwX
	gWgrcs2Vay9RL5WyoD7PYzwb42ppFzV8pH2e8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mgZRHqQUDPLWSMPO/WMR7NcMvSiRl1fE
	f4PJy8PGnw/Gg05r/uE88I8iHZWl/fttj24aF5QAw70IcpU6lpziGSSlQjv11LVa
	AnP3o7GjYxjzJ3R2qFyjNpnzD1eFB6CNY4oeZOQxQ+v1r2YDEBExPguZzjaQqXwF
	JXu0DpPiMuY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9871DA23F;
	Tue, 18 Dec 2012 14:22:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3BF8A23D; Tue, 18 Dec 2012
 14:22:57 -0500 (EST)
In-Reply-To: <50D0BC32.2020401@gmail.com> (Manlio Perillo's message of "Tue,
 18 Dec 2012 19:55:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5495479A-4948-11E2-B829-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211777>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> Il 18/12/2012 18:53, Junio C Hamano ha scritto:
>> [jch: cc'ed git-completion experts to review implementation details]
>> 
>> Manlio Perillo <manlio.perillo@gmail.com> writes:
>> 
>>> The git-completion.bash script did not implemented full, git aware,
>>> support for completion, for git commands that operate on files within
>>> the current working directory or the index.
>>>
>>> For these commands, only long options completion was available.
>> 
>> I find the "long options completion" is a misleading phrase.  It
>> sounds as if you changed the current completion that does not
>> complete "git commit -<TAB>" but does "git commit --<TAB>" to
>> complete the short options (e.g. "git commit -c"), but I do not
>> think that is the topic of this patch.
>> 
>
> It does not sound misleading to me.
> I'm saying that the git-completion.bash script only implemented
> completion for long options, but not for file names in the current
> working directory.
>
> Do you think I should rewrite the subject and the log message introduction?

The subject sounds fine; it is just "It only does long options"
sounded as if it were viewing the lack of "short options" support as
an issue.  In other words, my knee-jerk answer to "long options, as
opposed to what???" question was "short options", not "files".

If the phrase were "It only does options", the question would become
"options as opposed to what???", which may have given me a chance to
guess "files" as the answer to that question.

> As an example, something like this in the subject:
>
>   git-completion.bash: improve some git commands completion

I think the original is better; you do not touch any "options",
either long or short.  You are improving "paths", and the original
is much clearer on that point.

>
> and in the message:
>
>   The git-completion.bash script did not implemented full, git aware,
>   support for completion, for git commands that operate on files within

With s/for completion/to complete paths/, it would be perfect.  You
do not touch options, and this new log message does not talk about
it.  Much nicer than the one that was posted.

> Note that the performance is the reason why I suggested, in a previous
> email, that git should have some more options to format data in custom ways.
> As an example, there is no way to tell ls-files to not recurse
> directories, and there is no way to also get the file type.

To ls-files, no-recurse is an idiotic thing to ask.  The index is a
flat structure that is read as a whole.  There is no recursion
involved.
