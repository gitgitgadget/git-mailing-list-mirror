From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Sun, 30 Oct 2011 00:08:45 -0700
Message-ID: <7vaa8jrm6a.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com>
 <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
 <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
 <7vobx2z60w.fsf@alter.siamese.dyndns.org>
 <CACsJy8DdQXXoYT2gB2L5z6pdCNU_vL2w7c8eJvKRGX2T9iAC3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 08:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKPW0-0005IT-31
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 08:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab1J3HIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 03:08:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1J3HIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 03:08:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BD774CAD;
	Sun, 30 Oct 2011 03:08:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GoS5ASpa22pBJynfrC5YBhowkhY=; b=YaJ0g+
	BjlsImouR3TjKDVp5OnLTk7miGnk5jqxYMFKN3wXOfHeyszM8u3oEl0lkDg8seVB
	t/m8bm/RpkHIHL2b4xJXZTP9Wwnpouv2vGaah42UJ0vBguL8v6mBXGsRPLGGNrel
	5JAyh/0zNyyYJpW4ksVz9P3CvROBpR8wDYCZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oo3VlAi6QFBB1MMcMZLFaCi91Z+dtEHm
	3AcFZYl7UU1Klg3c+ypEGOw7Q+qy31BhlI9T0Y+VCM8AUKvNTblKrcHXoa0khCjv
	BeoR6QgQef3JYPn6KfEB8YU6FinBUAH2EY4DawoZNbcubH4bwHlWTETIdyETJ5Rb
	FwSAqBSx0XE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63E204CAB;
	Sun, 30 Oct 2011 03:08:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D01614CAA; Sun, 30 Oct 2011
 03:08:46 -0400 (EDT)
In-Reply-To: <CACsJy8DdQXXoYT2gB2L5z6pdCNU_vL2w7c8eJvKRGX2T9iAC3Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 30 Oct 2011 12:55:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 029FB5A2-02C6-11E1-84D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184464>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Note that this has nothing to do with read_directory() discussion we
> had in the notes-merge patch...

I think we are in agreement on that point.

Going back to your example...

> $ GIT_DIR=clone2/.git git add clone2/2 3
>
> $ GIT_DIR=clone2/.git git ls-files --stage
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       1
> 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       3

You probably found a bug here. It is simply wrong to choose not to add
clone2/2, especially without telling the caller anything.

	Side note. I just did this and I am not getting what you saw above.

        $ mkdir -p /var/tmp/j/y && cd /var/tmp/j/y
        $ git init; git init clone2
        $ : >3; : >clone2/2
        $ GIT_DIR=clone2/.git git add clone2/2 3
        $ GIT_DIR=clone2/.git git ls-files
        3
	clone2/2

	The behavour is different when clone2/.git already has commit, and
        whatever codepath that gives these two different behaviour needs
        to be fixed.

By the way, I think I know where you are coming from.

If we think clone2/ and everything underneath belongs to a repository that
is _not_ governed by our GIT_DIR (which usually is .git), it may be nicer
when the user attempts to add clone2/2 (which would normally belong to
clone2/.git) to at least warn about it, or even error out. I would not be
entirely opposed to a change in the behaviour if the above example were
done without GIT_DIR and produced an error, like this:

    $ git add clone2/2 3; echo $?
    error: clone2/2 is outside our repository, possibly governed by clone2/.git
    1
    $ git ls-files
    1

After all, if clone2 were a submodule of our repository, we do notice and
error out an attempt to add clone2/2 to our repository, so if we changed
the way how "git add" behaves to do the above, I can buy an argument that
calls it a bugfix.

When GIT_DIR=clone2/.git is given, however, the caller explicitly declines
the repository discovery. We do not know how the repository we are dealing
with (which we were explicitly told with $GIT_DIR) and a directory whose
name is ".git" under "clone2" we happened to find in read_directory()
relates to each other, especially when our index does not have clone2 as
our submodule.

We however *do* know that our working tree is our current directory, so
it would be wrong to do this:

    $ GIT_DIR=clone2/.git git add clone2/2 3; echo $?
    error: 3 is outside our repository, possibly goverened by .git
    1

The command should just add clone2/2 and 3 as it was told to.
