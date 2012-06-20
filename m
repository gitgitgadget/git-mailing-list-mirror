From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Editing the root commit
Date: Wed, 20 Jun 2012 11:25:32 -0700
Message-ID: <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com> <20120620093205.GB10579@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 20:26:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPbC-0004mY-R8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 20:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563Ab2FTSZk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 14:25:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932519Ab2FTSZg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 14:25:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2B68A94;
	Wed, 20 Jun 2012 14:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4HpuoKpCXQTW
	6YWCgNpdYv3+v/M=; b=ALpbL08xi9EM4mNlwu2TlHmh2471vouxpClLxA0UiM0Q
	hecqykKHSLC24gxfDSL5et0yvoBoTPoRYzfma/cOaBO315JbY8rturoNRyRsNqph
	gqsJX7xL6G5+5vxJzuW3D0OG6dj6vkissIpeWmNKfe2LBOrmLoq31M0hNlCSj2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jpd6Me
	0CGmdruQ6XNOeiCaQVFO+70+XJgZ9JhNF+xWyoyGm6sO0PqvxOImWvS53g4936jo
	RexlMPg3pcX0jKwbLPIYT3/nNZeH5LBO97SvHZlRi/ahP2Hnuj8+vA07MwezViqs
	c581nBEAiMF2eu+MYd0zPAFaKCa0ceuHBUxFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23EFE8A93;
	Wed, 20 Jun 2012 14:25:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D7F88A92; Wed, 20 Jun 2012
 14:25:34 -0400 (EDT)
In-Reply-To: <20120620093205.GB10579@arachsys.com> (Chris Webb's message of
 "Wed, 20 Jun 2012 10:32:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 536AAA12-BB05-11E1-8239-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200315>

Chris Webb <chris@arachsys.com> writes:

> Chris Webb <chris@arachsys.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Even though I wouldn't bother doing this myself, I wouldn't mind
>> > reviewing a patch series ;-)
>>=20
>> Okay, I'll take a look when I finish my current project!
>
> I had a bit of spare time this morning and had a quick look through
> git-rebase--interactive.sh.
>
> Apart from the validation, message and reflog code in git-rebase.sh a=
nd
> git-rebase--interactive.sh that would need fixing up to know about th=
is
> case, the essence of this seems to be starting with an orphan commit =
instead
> of a commit descended from $onto right at the end of --interactive.
>
> I'd love to write something like
>
>   git checkout ${onto:---orphan}
>
> (or a variant) but can git be persuaded to have an orphan detached HE=
AD like
> that?

=46or the root commit in the history, you check it out on the detached
HEAD.  Under "--interactive" if the insn sheet tells you to allow
the user to "edit/amend/reword" it, give control back the user after
you have detached HEAD at that commit.  The user experience should
be identical to the case you are replaying on an existing commit
after that point.

But lets step back a bit and look at the whole picture, to make sure
we are on the same page.

    $ git rebase [-i] frotz

looks at where you are, finds where you forked from 'frotz', and
replays everything you have done since you forked onto the tip of
'frotz'.

    $ git rebase [-i] --onto nitfol frotz

replays the same history onto the tip of 'nitfol' instead.

    $ git rebase [-i] --root --onto nitfol

looks at the entire history leading to where you are, and replays
everything you have done onto the tip of 'nitfol'.

What if we do not say --onto here?  I am not asking what the current
implementation does (we get an error message saying "I want 'onto'
specified").  What _should_ this command mean to a na=C3=AFve user?

    $ git rebase [-i] --root

I think it should mean "replay all my history down to root".  The
original root commit should become the new root commit in the
rewritten history.
