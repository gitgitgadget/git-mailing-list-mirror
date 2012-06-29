From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Fri, 29 Jun 2012 14:03:15 -0700
Message-ID: <7vvci93k6k.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
 <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
 <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
 <7v8vf551iu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 23:03:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkiLb-0006Cc-Av
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab2F2VDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 17:03:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab2F2VDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 17:03:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB5AB8585;
	Fri, 29 Jun 2012 17:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PBpt0VEpwSq++0zCxik8kZs4iSU=; b=D62ksT
	xDlNST/w9E8bPUi/8JQbx2KN9wsTW+5FZ/3dMgounHma6KgG758NXWiyy4em4/lP
	qCEf9hpU2zSpQ3t5+FVFPF8e4TEiMPZWw8q7kCSs9A4bcAyS+bbihOdImsfs0E0y
	iL2uqBV1MnOy5XdhOMsmBc1+/LtofrNEH7SCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yf547nAA1tXf/4Svu0D3UHRkLhQcmV0p
	5GpPnwF4xWrxG0JpfosRkYYC6DbfdCB9Ckx+Bibe3CwIahZ0iJ67+styc/uX1e5x
	pJu4u2uLgV5dDKceT3qaX6C6iGgAYx+uV4EHamNVh5QehJ7iLtA8P+JQLONrmM5n
	jzqqUmNXV4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDEF58584;
	Fri, 29 Jun 2012 17:03:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C11C8582; Fri, 29 Jun 2012
 17:03:17 -0400 (EDT)
In-Reply-To: <7v8vf551iu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Jun 2012 13:03:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D93EDA3A-C22D-11E1-8F78-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200831>

Junio C Hamano <gitster@pobox.com> writes:

>>> Declaring that a checked out submodule _must_ have its controlling
>>> repository as ".git" at its root level, i.e. it should be accessible
>>> without using GIT_WORK_TREE/GIT_DIR at all just like a normal Git
>>> repository is, would be a clean way to avoid the issue altogether
>>> and it still will allow the top-level superproject to be structured
>>> in a funny way to require GIT_WORK_TREE/GIT_DIR to access it,

Let's think aloud a bit with a simple example.  Imagine there is a
directory hierarchy $HOME/a/b with a file $HOME/a/b/c in it.

'$HOME/a' is a working tree of a Git managed project.  In a normal
layout, there is a $HOME/a/.git directory there that houses its Git
repository, and everything (recursively) outside $HOME/a/.git in the
directory $HOME/a are working tree files of that repository.  You
can

	cd $HOME/a
        git add b/c

to add the file at path b/c, and commit the changes to it.

You can relocate $HOME/a/.git elsewhere, say $HOME/git/a.git, by
exporting GIT_DIR=$HOME/git/a.git as long as you work at the top
level of the working tree.  When GIT_DIR alone is set this way, you
are giving no clue to Git where the top-level of the working tree is
(remember, you relocated $HOME/a/.git away so there is no ".git" in
the $HOME/a directory), so your $(cwd) will be always taken as the
top level of the working tree.

It is inconvenient if you want to work in $HOME/a/b.  So you can do
this:

	GIT_WORK_TREE=$HOME/a
        export GIT_WORK_TREE
        cd $HOME/a/b
	git add c

and everything works again.

Or $HOME/a/b may be a separate project, and $HOME/a/.git repository
binds that as a submodule.  In a normal layout, a $HOME/a/b/.git
directory is there that houses its Git repository.  'c' is a file
that appears at the top level of that working tree.  When you are at
the top-level of the superproject's working tree, you see b/ and Git
knows it is a submodule, not a subdirectory of the superproject.  It
cannot allow "git add b/c" to the superproject.

And this will continue to work with GIT_DIR/GIT_WORK_TREE when you
move $HOME/a/.git elsewhere.

What happens if you also moved $HOME/a/b/.git elsewhere?

This will still work when you want to work inside the submodule:

	GIT_WORK_TREE=$HOME/a/b
        export GIT_WORK_TREE
        cd $HOME/a/b
	git add c

to record the change to 'c' at the top-level of the working tree of
the submodule.

*BUT*

There is no ".git" in $HOME/a anywhere, so this breaks when you are
in the superproject's working tree. There is no longer anything that
tells Git that the $HOME/a/b path is a project boundary.

You could look at the index to notice b is known as a submodule, but
that is not a usable solution in general.  You could have done "git
rm --cached" it, perhaps because you wanted to do something clever
with it, e.g. in preparation to move it, in which case we still
would want to treat it as the working tree of a separate Git
repository that is not yet (or no longer) connected to the working
tree of the $HOME/a/ repository.

By the way, without any of the GIT_DIR/GIT_WORK_TREE hack, the
following sequence does not work correctly (it is a bug nobody cares
about), and we may want to correct it.

	mkdir -p /var/tmp/x/a/b
        cd /var/tmp/x/a
        git init ;# create a/.git
        git init ;# create a/b/.git
        >c && git add c ;# a/b/.git knows about c at the toplevel
        cd .. ;# back at a
        git add b/c

Even though a/b/.git does not yet have a commit and 'b' has not been
registered as a submodule to its index, Git run in 'a' should notice
that b/c belongs to somebody else, and refuse to grab it.  It has
enough cue (namely, the presense of a/b/.git and the directory being
a proper Git repository) to do so, but it currently does not use
that clue.
