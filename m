From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pushing symbolic references to remote repositories?
Date: Fri, 21 Dec 2012 15:11:25 -0800
Message-ID: <7vip7vrof6.fsf@alter.siamese.dyndns.org>
References: <CAD03jn5ACZyxJM9LEOSJov3BsT3W1N0sV3WYwcerJciMSpmSPA@mail.gmail.com>
 <CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:11:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmBkp-0000RU-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 00:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab2LUXLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 18:11:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab2LUXL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 18:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD17A258;
	Fri, 21 Dec 2012 18:11:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rDzhCXgEJIi1Cbiv3cMvMT8DRiw=; b=lUxde8
	HKlcnIJ3NaekayuaWbZOGmxFqzqBriqu0m0PjDdLJHbZcxZKsxXVpSHn926gjrNs
	zKLC5TFcwwks4zbUx3hRWO1KvrEkn4BnQBNq8pMf5YKV7ME7oOQvHb2AHsKb0imC
	X9GgpzuIfajAr98FjNfAXEsmd+PgqWEoRnDDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O//Gvu3j2mYGABkvFf2TlM8jZLmSNZnB
	02pB3GgT7Eu+Bz+P1Yx/GxRkAjnpo2f+Z7iwiFZWizouB3V6V2b6DG7OT0SauZdS
	LPl0QXt7FDHTsy63d2uHJkqyjb63xcrrnGjNML+5CgBsNt6Khc02ace/lkIgthkq
	7x8/3MtBiEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1804BA257;
	Fri, 21 Dec 2012 18:11:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45819A255; Fri, 21 Dec 2012
 18:11:27 -0500 (EST)
In-Reply-To: <CAJo=hJvqptfKqM+6J8Ddfb5qcqjAU8bB_JO9VB-XVsCCf64NUQ@mail.gmail.com> (Shawn
 Pearce's message of "Fri, 21 Dec 2012 13:54:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF31580A-4BC3-11E2-B2BB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212020>

Shawn Pearce <spearce@spearce.org> writes:

> On Fri, Dec 21, 2012 at 11:53 AM, Dun Peal <dunpealer@gmail.com> wrote:
>>
>> Is there a clean and reliable way to do that, or are symbolic
>> references just not meant to be shared?
>
> There is no support for symbolic references in the network protocol,
> so they cannot currently be shared by git push or git fetch.

What Shawn said is technically correct, but do not read it as "we
know what protocol update we want at the network level, but we
haven't got around implementing it".

It is unclear what it means to send symrefs across repositories
(rather, what we want it to mean).  In that sense, the reality is
closer to the latter of your choices.

There are three primary kinds of symrefs to consider:

 * worktree/.git/HEAD is meant to point at the branch that is
   currently checked out.  This is designed to be under sole control
   of the person who is working in such a repository and the outside
   people have no business knowing which branch he happens to be
   working on at this very moment (it can change the next minute).

 * worktree/.git/refs/remotes/$name/HEAD is meant to point at the
   remote-tracking branch of the named remote (e.g. 'origin') the
   local user is interested in, to let "git checkout -b topic
   origin" work, instead of a longer "git checkout -b topic
   origin/master".

 * bare.git/HEAD is meant to point at the "primary" branch at a
   bare, distribution repository nobody works in directly.  The
   branch pointed at by the symref rarely, if ever, changes.

Nobody will imagine flipping worktree/.git/HEAD from outside by
pushing into it (unless you are trying to pull a prank on the user
who is working in that repository).  Also, nobody would want to
update this symref by fetching from outside.  So we won't have to
consider updating the first kind in the following discussion.

It is unlikely that anybody sane wants to update the remote-tracking
worktree/.git/refs/remotes/origin/HEAD from outside by pushing.

It *may* make sense to update it upon fetching, though, in some
cases.  You first clone from bare.git/HEAD and learn [*1*] that the
primary branch at the time of cloning was 'master', and
remote/origin/HEAD in your repository is set to point at
origin/master.  Now the upstream designates a different branch as
the primary (perhaps 'trunk'), and you may want your next "git
fetch" to repoint your remote/origin/HEAD to point at
'remote/origin/trunk'.

However, even this one is not unconditionally a good idea.  The
branch you are interested in might be different from what your
remote designates as its primary branch in the first place.  You may
for example want to follow along 'next' after cloning from me.  E.g.

    $ git clone     git://git.kernel.org/pub/scm/git/git.git git
    $ cd git
    $ git symbolic-ref refs/remotes/origin/HEAD
    refs/remotes/origin/next

It is not clear if it is a good idea to allow "git fetch" to repoint
your remotes/origin/HEAD to whatever I chose to point my HEAD at.

So for the second kind, pushing is irrelevant, and fetching is
"perhaps sometimes it may make sense".

I think that the only one and a half sensible use cases that
unconditionally make sense to update symrefs across repositories are
to update bare.git/HEAD symref:

 - update bare.git/HEAD of a repository that is a local mirror of a
   more authoritative repository with "git fetch --mirror", in which
   case you do want to follow what branch is designated as the
   primary by the project you are mirroring from;

 - update bare.git/HEAD from outside by some means to change which
   branch is the primary one for the project. Only because your
   hosting site does not give you an easy way to do so, pushing from
   another repository that happens to point its HEAD at a different
   branch seems to be one plausible way to do so, but that does not
   have to be the only way.


[Footnote]

*1* We would need to update the network protocol for this purpose,
as most transports do not carry this information and clone has to
guess which branch bare.git/HEAD points at.

The purpose of this message, though, is to illustrate that the
protocol update to carry the information is not the end of the
story, but merely is an enabling beginning. We need to know what
semantics we would want to implement on top of that transfer.
