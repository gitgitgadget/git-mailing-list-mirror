From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] pull.default
Date: Mon, 18 Mar 2013 11:57:35 -0700
Message-ID: <7vy5dkmt7k.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nT9hE_kRt3DLXfP45OwCSLurMOzuTqepxhkWjagbFDUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 19:58:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHfGB-0004zL-18
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 19:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab3CRS5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 14:57:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab3CRS5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 14:57:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C494BB52;
	Mon, 18 Mar 2013 14:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0FhF4l9oyBBnzmnENCMZkpVec0=; b=to2/Nu
	qBot+NP+vEmtdU7Y3HZbeh32QJRari2Jpxr8sHk5Gada9+PATML5+jlu6Zc6jkBh
	hG/YNNpcO7c/cPERz2iIHOYTftmhCQPyQwwhTq+jalwkOAssIankvH7YGEb3uy0a
	Gl9aQuf95JTGEg4aNEoWyyWCrJlgWkiszwJ8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ndmcmGbQL+IZvR4/MiIFtuWoch0T1onY
	pKqEHphg/fwAqX8MIzFeeW1QQGoYZ183opWIAeqima46jqSqBXCKwi2yvgSIWMIA
	bv8oQcpkZhoehHqIqhj6L11HJPM91Jw+H1IS0DafkDENgPNmcL0uFBGPi0MWbtFQ
	5p7QaEYczBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31B44BB51;
	Mon, 18 Mar 2013 14:57:37 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C2F7BB4B; Mon, 18 Mar 2013
 14:57:36 -0400 (EDT)
In-Reply-To: <CALkWK0nT9hE_kRt3DLXfP45OwCSLurMOzuTqepxhkWjagbFDUQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 19 Mar 2013 00:09:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2EDEB02-8FFD-11E2-B7D1-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218438>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I usually use `git fetch`, inspect state, and then merge/ rebase
> accordingly.  Unfortunately, this is very sub-optimal as I can
> automate this 80% of the time.  I want to be able to decide what to do
> on a repository-specific basis, and hence propose a pull.default which
> can be set to the following:
> 1. fetch.  Just fetch.  (I will set this as my default in ~/.gitconfig)
> 2. fast-forward.  Fetch.  If the FETCH_HEAD is directly ahead of HEAD,
> `stash`, merge, and stash apply.  Otherwise, do nothing.
> 3. rebase.  Fetch.  stash, rebase, stash apply. `git pull n` will do
> rebase --onto master HEAD~n instead of rebase.
> 4. reset.  Fetch, stash, reset --hard FETCH_HEAD, stash apply.
>
> Ofcourse, it should print a message saying what it did at the end.
>
> What do you think?

Many other possibilities are missing.  "fetch and merge", for
example.

You seem to be generalizing the "--rebase" and "--ff-only" options
of "git pull" with 2 and 3, which may (or may not) make sense.

I think you can shrink and enhance the above repertoire at the same
time by separating "do I want to have stash and stash pop around"
bit into an orthogonal axis.  The other orthogonal axes are "Under
what condition do I integrate the work from the upstream?" (e.g.
"only when I do not have anything, aka, ff-only") and "How would I
integrate the work from the upstream?" (e.g. "rebase my work" and
"discard anything I did aka reset --hard").

By the way, I do not think you should start your design from a
configuration (this is a general principle, not limited to this
case).  Think about what the smallest number of independent options
you need to add to express various workflows, and then turn them
into configuration variables that can set the default, all of which
have to be overridable from the command line.
