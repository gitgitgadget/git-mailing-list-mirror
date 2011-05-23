From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve errors from 'git diff --no-index'.
Date: Mon, 23 May 2011 12:22:34 -0700
Message-ID: <7vpqn9usqt.fsf@alter.siamese.dyndns.org>
References: <4dd98da1.1bf98e0a.4eb4.6fc5@mx.google.com>
 <7vlixyw4cx.fsf@alter.siamese.dyndns.org>
 <BANLkTinKpSP5oEms914TWD7Tsjab1B87QQ@mail.gmail.com>
 <7vhb8mw1e6.fsf@alter.siamese.dyndns.org>
 <BANLkTi=Uf8X+Bkd+CZ9qz0wXhHn8wwYzrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anthony Foiani <anthony.foiani@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 21:22:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOaiK-0002Bw-FL
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 21:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295Ab1EWTWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 15:22:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab1EWTWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 15:22:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12EDB4CE0;
	Mon, 23 May 2011 15:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L9X3ccAcvdlZN6hSrLQEFBBw8eA=; b=U3vmUF
	HYLUMtpHkpmm92ks8YYEe7/cek25W2/TuWUEQxHO7IA4BPB4S1O/AeRGa3mIBTN1
	qtxr0n1l1rPz1B4xvblPa0IAAwq6Kz8r3Pl57tdtv9d7X2ZAi3v0V8/FNppI/Tiz
	8XgIwjHURHAiEMCxqci63BQQJikOXW6fMH1lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YGLtltsUkwHheqBlpyinP0/ohkCVMe8G
	ur3RcJZcJxJRTjkTiuA1BUnOhI/M6826NlJQXSkvz08H8ai01FY/4moc8YkLDtZ/
	MpRD9+joVd17JVZcJCqP7Jwb/DP528My8i2PBf/rMHPy7J0pkKZW8FVONAr3fbb7
	hHdx4GCy0IQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4A004CDF;
	Mon, 23 May 2011 15:24:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F27724CDE; Mon, 23 May 2011
 15:24:44 -0400 (EDT)
In-Reply-To: <BANLkTi=Uf8X+Bkd+CZ9qz0wXhHn8wwYzrA@mail.gmail.com> (Anthony
 Foiani's message of "Sun, 22 May 2011 22:05:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52883D86-8572-11E0-B0DD-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174262>

Anthony Foiani <anthony.foiani@gmail.com> writes:

> $ ls -al /tmp/{foo,bar}
> -rw-rw-r--. 1 tony tony 0 May 22 10:09 /tmp/bar
> -rw-rw-r--. 1 tony tony 0 May 22 10:00 /tmp/foo
>
> $ # current git tip:
> $ git diff /tmp/{foo,bar}
>
> $ # with my patch:
> $ ../git/git-diff /tmp/{foo,bar}
> warning: neither '/tmp/foo' nor '/tmp/bar' are tracked, forcing --no-index

I actually consider this a regression. We are giving an output that the
user wanted to see, and I do not see a reason why we need to warn.

A tangent.

One thing that I have always been unhappy about --no-index is that it does
not really mesh well with the notion of what a "git diff" is. "git diff"
inherently is an operation to take two collections of contents labeled
with paths, and show series of patch output between corresponding paths in
these collections, while rename/copy detection may affect the definition
of "correspoinding paths".

A typical "I know 'git diff' has a lot more features like color-words that
my platform 'diff' does not support, so let me use 'git diff' instead"
session does something like:

	$ git diff [--no-index] /tmp/foo /tmp/bar

but such a request does not compare "two collections of paths that have
corresponding paths" at all. We could say we are comparing a collection
that has tmp/foo with another that has tmp/bar, but then we should either
emit a delete patch for tmp/foo and a create patch for tmp/bar, or emit a
rename patch to create tmp/bar out of tmp/foo if we want to be consistent.

But that consistency goes totally against what the users would expect.
This inconsistency is not a fault of either the definition of "git diff"
nor the user's expectation. They are fundamentally different and the root
cause of it is that we support --no-index diff between randomly chosen two
files. I am not saying we should drop that feature, but it does not change
the fact that we had to add extra code in the output codepath only to
support this "outside git" use case to suppress rename information (and
probably other things I do not remember).

The _only_ use of --no-index that is in line with what "git diff" does is
to compare two directories as the "two collections of contents" above,
i.e.

	$ git diff --no-index old/ new/

and then support pathspecs, like this:

	$ git diff --no-index old/ new/ -- Makefile '*.c'

But I do not think the current implementation does not even support this
only sane usecase.
