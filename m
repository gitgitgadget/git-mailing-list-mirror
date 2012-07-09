From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Sun, 08 Jul 2012 19:17:03 -0700
Message-ID: <7vhathn0f4.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
 <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 04:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So3Xt-0002gg-HB
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 04:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab2GICRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 22:17:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab2GICRK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 22:17:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3F6D9DC1;
	Sun,  8 Jul 2012 22:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzTRgV5TqJybV1+419lKtCp6q9o=; b=g9zefZ
	rAj9PIBHtkpui1+AeA8HyEbvRym3Q8B+Nunr2eM/EZ7cfhbHl+NYrVpo1heg+OFO
	0Nz6JOg0zR3YoAnVq2LX1SViJpRl4VV23UJHQron9KLp+yb6RJED0mSXWSzEjY7k
	Q7C+KGTXEmeOgLKg/as0O/l5NeAsZC46G2kqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGZfXN75U+JrwiuMGfpe/wFyxv9TanEZ
	ZBojrukcSlWC5g1V4w0CyWF+MZW8p2td2WF6mq9IT15Qq9Y55heUhFDOaPbwFUbX
	df5C6+rYgYiMkchV0vKy69rkcWEgfVn2R1UrNVb8hB6p6xbnwtLahGJvwULjb5LX
	t/3KcHZmadU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA8669DC0;
	Sun,  8 Jul 2012 22:17:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EB5F9DBB; Sun,  8 Jul 2012
 22:17:05 -0400 (EDT)
In-Reply-To: <4FF9A261.3040907@web.de> (Jens Lehmann's message of "Sun, 08
 Jul 2012 17:08:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D7D4B64-C96C-11E1-8C6B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201188>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> What you describe here is exactly how I think "git submodule rm" and
>>> "git rm --recurse-submodules" should behave.
>> 
>> If you have a directory A with a file B in it (i.e. A/B), "git rm A"
>> is refused and you have to say "git rm -r A".  So I can see why the
>> above description of the mine is wrong with respect to "-r" option
>> (all cases should fail if you did not give "-r" option).
>
> I think that depends on how you see submodules in the context of
> the superproject.

I am OK with "git rm path" removing the submodule working tree and
the index entry for path without -r (of course "git rm dir" would
not remove submodule "dir/path" in a plain directory "dir" and needs
to be spelled "git rm -r dir" or "git rm dir/path" but that is the
same if "path" were a regular file and a submodule is not special);
thinking about it again, I think it makes more sense, because a
submodule is just one single path entity in the context of the
superproject.

>> But I do not think "git rm" needs "--recurse-submodules".  Wasn't
>> "--recurse-submodules" the option to control, when you tell Git to
>> do something to submodule "A", what should happen to submodules
>> contained in the submodule "A" (e.g. "A/B" that appears at path "B"
>> that itself is a separate project bound as a submodule to "A")?
>
> Nope. Only the "--recursive" option to the git submodule script
> works like that (and almost everyone seems to use that option by
> default anyway). But for all commands that understand the
> "--recurse-submodule" option (currently these are clone, fetch,
> merge, pull and push) that means "include submodules in what you
> do and don't stop at the first level but recurse all the way down".
> Without this option they won't even touch the first level of
> submodules.

OK, but what does "rm --no-recurse-submodules path" could possibly
mean in that case?  If you remove "path" by definition anything
underneath "path" cannot be remain, so in the context of "rm", once
you decide to remove submodule at "path", not recursing is an option.

So I still think "--recurse-submodules" does not make any sense to
the "rm" command.  I would understand a "Do not attempt to remove
submodules and ignore their existence altogether" option, even
though I do not think it is useful.

> All other core commands happily change the index without updating
> the submodule's work tree.

What are "all other core commands"?  "fetch" by definition does not
touch working tree inside or outside working tree.  "add" is about
recording the state from the working tree to the index, and
following the earlier point you raised (I unfortunately culled from
the quote), as the rest of core Git considers a submodule a single
path entity in the context of the superproject, "the state from the
working tree" for the submodule is where its HEAD points at, so it
is correct not to look at the working tree.

Without going outside the context of "rm", I think the current
behaviour of "git rm path" for submodule is merely punting---erroring
out against a request for an unimplemented feature.

If you ask an unpopulated submodule to be removed, we could simply
rmdir() it and remove the entry from the index, but that is far
insufficient for handling a submodule repository that is already
"init"ed.  And we did not want to plug the "check if removal will
lose any state from the submodule repository" logic because the
information is no use for us for a long time until we added the
"gitfile" support to allow us to relocate path/.git for the
submodule safely away when we remove the working tree of it.

But now we do have gitfile, so we could remove submodule working
tree.  I think not erroring out and removing only the index entry is
a irresponsible thing to do.  It would mean that we pretend as if a
feature that was earlier unimplemented (hence errored out) is now
supported, but it does not do what the user asked us to do, no?

I do not know what other commands you have in mind, but some of them
may be similar "recursing down and performing an operation that
potentially can fail is too complex, and we are not sure if we have
enough sequencing infrastructure to guide the user to sort out the
mess in the half-result, so let's punt and not to that part and have
the user sort out" half-features, and if that is the case, I do not
think it is prudent to model "rm", which is something that we now
could implement properly, with the necessary infrastructure already
in place, after them.
