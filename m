From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push branch descriptions
Date: Wed, 14 Nov 2012 05:57:37 -0800
Message-ID: <7vr4nwb832.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:58:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYdTX-0008QG-GP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918Ab2KNN5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:57:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342Ab2KNN5k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 08:57:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C2F6A12;
	Wed, 14 Nov 2012 08:57:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+eDdrAmi444ZPTwu4sD5fiwc9H4=; b=SmgkNv
	pOurDNMuxKhD14o0Ypg9UCLmA17zmgei2ExjZSuUHDGSY35oDbtTUs7hwtDSD8oa
	qlh/gNLqVYTFRNdOYdq8RITAaRUojjdS2jrNAx6oxmoPGphA8LcrymndqSqo9HD+
	KOZEhc2S7NxtaRQMRpa5MecOVQCrZ7XBHTBOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cHJLV5T35GHuen32J5gRvr3A4rro3PBY
	VU923XFcCE7py2Nlj7nBe6yEfG+r31KaM1uYz9neVdlTXhUgdN7XKf9gzZ6wEJUI
	N6I39qg+cXcXfrS4LBXGDoWCYCEiKI+89dK+vTePtfPv1vmm8ZQl62XWcX1Nacxu
	EOducpmuTbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62FCF6A11;
	Wed, 14 Nov 2012 08:57:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4E1B6A0D; Wed, 14 Nov 2012
 08:57:38 -0500 (EST)
In-Reply-To: <CAB9Jk9ABenaj=R0a6OW2GCsin8PdDCW3ZbuQbu6G0jnGG3s+sA@mail.gmail.com> (Angelo
 Borsotti's message of "Wed, 14 Nov 2012 08:20:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40312FC6-2E63-11E2-AD40-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209720>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> currently, there is no means to push a branch description to a remote
> repository. It is possible to create a branch, but not to set its
> description.

Correct.  You have to go to the remote repository and run "git
branch --edit-description" there; there is currently no way to do
this remotely, which may be an issue, but...

> Would not be more correct to push also branch descriptions when
> branches are pushed?

... I do not think "git push" is the best place to do so, given the
inherently local nature of branches and branch descriptions.

Imagine the project creates a branch "magic" to enhance its system
with magic words.  The description for the "magic" branch in the
project may say "support magic words" or something.

You and your friend are tasked to add a handful of magic words,
e.g. "xyzzy", "frotz" and "nitfol".  You may start your work like so
on your "magic-xyzzy" branch:

    $ git clone git://example.com/zork.git/
    $ git checkout -b magic-xyzzy -t origin/magic

And you say something like "add xyzzy magic" in its branch
description.

    $ git branch --edit-description magic-xyzzy

After finishing your work, you may push it

    $ git push origin magic-xyzzy:magic

Should the description of the subtask "add xyzzy magic" overwrite
the purpose of the project wide "magic" branch "support magic words"?
Most likely not.

The local nature of the description becomes even more clear if you
imagine the case where the push at the last stage gets rejected due
to non-fast-forward error (in other words, your friend has already
pushed her support of the "frotz" magic to the "magic" branch.

In fact, you would normally not directly push your magic-xyzzy
branch to the magic branch, but you would do something like this
once you are done:

    $ git checkout -b magic -t origin/magic
    $ git pull origin ;# to update with her work
    $ git merge magic-xyzzy
    $ git push origin magic

And the last "merge" is where the description for your magic-xyzzy
is used to fill the commit log template for you to explain your
merge (that is, you are merging a branch whose description is "add
xyzzy magic").  There is no reason to propagate the description of
your magic-xyzzy topic to the description of shared magic branch
when you push, as this merge commit already records what the branch
that was merged was about.

So you could modify "git push" to set the branch description when
you push to create a branch remotely, but in general, "git push"
should not be updating the branch description with the description
of your local branch.  This comes as a consequence of the fact that
the purpose of the branch in the remote central repository is, more
often than not, different from the purpose of the corresponding
branch in your repository.

It would conceptually be a lot cleaner to treat updating of remote
branch description as a separate "repository management" class of
operation, similar to setting the repository description stored in
$GIT_DIR/description.
