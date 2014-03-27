From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git feature request: Option to force Git to abort a checkout if working directory is dirty (i.e. disregarding the check for conflicts)
Date: Thu, 27 Mar 2014 10:46:29 -0700
Message-ID: <xmqqk3bfedqi.fsf@gitster.dls.corp.google.com>
References: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Jonas Bang" <email@jonasbang.dk>
X-From: git-owner@vger.kernel.org Thu Mar 27 18:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTENy-0002Gi-E0
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 18:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbaC0Rqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Mar 2014 13:46:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755585AbaC0Rqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 13:46:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 727DE77385;
	Thu, 27 Mar 2014 13:46:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lNkkz7dk99H4
	RhKcmiRq7fDHcio=; b=Oa78bQTZCWH70VSuZoczo3gUfy2ckHzEeuCqkUSXVE+u
	qAUBjBs+HPNSmloErayT/Q6aQjhhsgobGHICnDxeHWGMMYBpEgzKXzLh/27D5vV1
	HCANftIpdqmkSOMXeB9BE2CrsT1q0mhjp4ZHPXemdo037Em5w8bDaBy9FZpR6yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MrwFwG
	SiY0Mb3EDyEZ180kQFfQ4eAEdPFqY3qMNUdtxKW6V+JrS7Hra5Stn1ej9Vw5LhRr
	Mg/IGxWuvQJlOc9py91va3MbtR/pYlBS78fji7obiqVWVOlycE07T65PdtS4ddx9
	tmqI00JfDDHCflyXcD0YUnZUiQViBko9/2QSU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EB1777384;
	Thu, 27 Mar 2014 13:46:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BA147737C;
	Thu, 27 Mar 2014 13:46:31 -0400 (EDT)
In-Reply-To: <004d01cf49d7$c8b9cd90$5a2d68b0$@jonasbang.dk> (Jonas Bang's
	message of "Thu, 27 Mar 2014 17:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB509ED8-B5D7-11E3-9D81-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245300>

"Jonas Bang" <email@jonasbang.dk> writes:

> Hi Git developers,=20
>
> This is my first Git feature request, I hope it won=E2=80=99t get me =
hanged on the
> gallows ;o)=20
>
> *Git feature request:*
> Add an option to Git config to configure the criteria for when a "git
> checkout" should abort.=20
>
> *Name proposal and options:*
> checkout.clean false <default>=20
> checkout.clean true=20

A configuration variable without command line override will make the
system unusable.  When thinking about a new feature, please make it
a habit to first add a command line option and then if that option
turns out to be useful in the real world (not in the imaginary world
in which you had such a feature, where even you haven't lived in
yet), then think about also adding configuration variables to
control the default.

Also, a useful definition of "clean"-ness may have to change over
time as we gain experience with the feature.  And also as a user
personally gains experience with using Git.  It is somewhat
implausible that a boolean true/false may remain sufficient.


> *False behavior:*

What is "false"?

Ah, when the configuration is set to "false", which will be the
default?

> As is:=20
> When doing a checkout then Git will check if your working directory i=
s
> dirty, and if so check if the checkout will result in any conflicts, =
and if
> so abort the checkout with a message:=20
>
> $ git checkout some_branch
> error: Your local changes to the following files would be overwritten=
 by
> checkout:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0some_file
> Please, commit your changes or stash them before you can switch branc=
hes.
> Aborting=20
>
> If no conflicts then:=20
>
> $ git checkout some_branch
> M =C2=A0 =C2=A0 =C2=A0 some_file
> M =C2=A0 =C2=A0 =C2=A0 some_other_file
> Switched to branch 'some_branch'=20
>
> I.e. it will only abort if there are conflicts.=20

Sensible.  This is the behaviour that is very often depended upon by
people who use Git with multiple branches.  Are you thinking about
changing it in any way when the new configuration is set to "false",
or is the above just a summary of what happens in the current
system?


> *True behavior:*
> When doing a checkout then Git will check if your working directory i=
s dirty
> (checking for both modified and added untracked files), and if so abo=
rt the
> checkout with a message:=20
>
> $ git checkout some_branch
> error: Your working directory is not clean.
> Please, commit your changes or stash them before you can switch branc=
hes.
> Aborting=20
>
> I.e. it will abort if working directory is dirty (checking for both m=
odified
> and added untracked files).=20
> I.e. you can only do checkout if you get "nothing to commit, working
> directory clean" when running "git status" (ignoring ignored files th=
ough).=20

The above two say very different things.  For some people, having
many throw away untracked files is a norm that they do not consider
it is even worth their time to list them in .gitignore and they do
not want to be reminded in "git status" output, and the latter
definition of "checkout.clean=3Dtrue will kill checkout when status
says there are some things that could be committed" would suit them,
while the former definition "checkout.clean=3Dtrue will kill checkout
when there is any untracked files" would be totally useless.

So I can understand the latter, but I do not see how the former
could be a useful addition.

=46or some people it is also a norm to keep files that have been
modified from HEAD and/or index without committing for a long time
(e.g. earlier, Linus said that the version in Makefile is updated
and kept modified in the working tree long before a new release is
committed with that change).  The default behaviour would cover
their use case so your proposal would not hurt them, but I wonder if
there are things you could do to help them as well, perhaps by
allowing this new configuration to express something like "local
changes in these paths are except from this new check".

I dunno.
