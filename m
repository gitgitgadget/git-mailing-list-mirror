From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Disappearing change on pull rebase
Date: Fri, 11 Nov 2011 08:31:49 -0800
Message-ID: <7vzkg2r56y.fsf@alter.siamese.dyndns.org>
References: <3FF1328CB05DB74898F769F1BA17812C3E49B74671@GVW1348EXA.americas.hpqcorp.net>
 <B5934593-5EE9-4A9F-96D5-0E36B696EFBD@jetbrains.com>
 <3FF1328CB05DB74898F769F1BA17812C3E49B74699@GVW1348EXA.americas.hpqcorp.net>
 <4EBCC71D.6000505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Pitucha\, Stanislaw Izaak" <stanislaw.pitucha@hp.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 17:32:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROu1G-0001MX-Sz
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 17:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab1KKQbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 11:31:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab1KKQbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 11:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D31E5833;
	Fri, 11 Nov 2011 11:31:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2uNqGTyRO4BkbBgfqVQ+95F13M=; b=g4VEWa
	4fWlfRwEJ4Xxir7HhyGSlbnwR/xC0iPHi/J/X+BStNpZ3ss7TRDylUoSEdbhYUs+
	tSyweTlXLVOgKbIa/QUkq9evZWg1XgoM6tCie8Qdb/7VsjBKD7djhUBk0iCLUWtF
	i/0lXe+FQUV7NlbeT/Ms9JKVjT8V86BLlCvjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hwaQ+oPP4J8jybN4sWVdDTnrtip3vu1R
	r4RA2O6cbVJHze9I9kXjGPUJde18dcZQleUQ14eaAOvJBlgQOqSFM5ucYS5J6SDX
	pEA0yIelB3IjLvoSNeo9qcrY5sxNDTeyGroGP7+rn9HDGJUPeoW+3uIsYbFSRNZ8
	sAFCtDCQTEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7457E5832;
	Fri, 11 Nov 2011 11:31:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBDBA5831; Fri, 11 Nov 2011
 11:31:50 -0500 (EST)
In-Reply-To: <4EBCC71D.6000505@viscovery.net> (Johannes Sixt's message of
 "Fri, 11 Nov 2011 07:56:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A87B63DE-0C82-11E1-88EC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185273>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 11/10/2011 14:35, schrieb Pitucha, Stanislaw Izaak:
>> As mentioned in the original mail - the merge commit did have changes.
>> Here's the log of reproducing it. The line containing "2" in changelog
>> is gone from master after pull --rebase.
>> ...
>> disappearing_commit$ git merge --no-ff --no-commit some-branch
>> Automatic merge went well; stopped before committing as requested
>> disappearing_commit$ echo 2 >> changelog 
>> disappearing_commit$ git add changelog
>> disappearing_commit$ git commit
>> [master e41e4c9] Merge branch 'some-branch'
>
> This is by design. Rebase does not rebase merge commits because it is
> assumed that merge commits only do what their name implies - to merge
> branches of a forked history. As such, they do not introduce their own
> changes. Follow this rule, i.e., make your change in a separate non-merge
> commit, and you are fine.

While that may be technically correct, I wonder if we can be a bit more
helpful to the users in such a case (upfront I admit that I have a strong
suspicion that this is a hard problem in general). One typical use of
"rebase" is to linearize a history that has unfortunate merges that did
not have to be there, so refusing "git rebase A..B" when there is a merge
in "git rev-list --merges A..B" is not a solution. But would it help if we
warned about the merges when we find that there is something _interesting_
going on in them, e.g. an evil merge that adds material that did not exist
in any of the parents [*1*]? The warning message may diagnose "you asked
me to linearize the history by picking commits on the non-merge segments
and replaying them, but there may be changes made in this merge commit,
and it does this interesting thing: $(git show -c $that_merge_commit)" and
may further suggest "if you do not want to linearize but just transplant
the history, perhaps you want to run the command with the '-m' option?".

[Footnote]

*1* This is a hard problem and not just the matter of looking at "show -c"
output. A "-s ours" merge would appear empty in "show -c" but it _is_ an
interesting event that makes the result of linearizing non-merge segments
vastly different from the original. Also material that did not exist in
any of the parents is not necessarily evil (e.g. the side branch may have
added one parameter to a function and updated its call sites, while our
branch may have added a different parameter to the same function. The
update to the call sites in the merge result should pass two more parameters
from the common ancestor, and different from either of the parents).
