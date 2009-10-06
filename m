From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 06 Oct 2009 04:36:19 -0700
Message-ID: <7vvdis21qk.fsf@alter.siamese.dyndns.org>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
 <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de>
 <20091005225611.GB29335@coredump.intra.peff.net>
 <200910060932.24377.trast@student.ethz.ch>
 <alpine.DEB.1.00.0910061112570.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 13:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv8Vn-0005T4-Cg
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 13:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153AbZJFLjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 07:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757149AbZJFLjv
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 07:39:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757075AbZJFLjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 07:39:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBD2A6D1BA;
	Tue,  6 Oct 2009 07:39:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rIpdE2/XjuvSfEt0vqJ9+tyHfds=; b=hfWpRQpCNFSBlnHO0cAsGOP
	wRYe6pHRPveNt7rRuUiVDNlRcvYGPZrWLltcJL3kRzuip9w3QN3tDh12RGZxr6by
	+MmvZpmsT0qOsqR+WgSenkOn+OIL/RxA+Z2h2oa+BYoPGRSNazWgezJEuj6gd2uD
	yQfbNlrBjcWWQeCN/3Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=AyQLhUqwg4fdXrYn2Aghu6yV3Po40Q7ZrJFCRXKcxBbqFU1nT
	zxrpT//GxhcfXYkXM/B8aGCKyzfeXo/xnxJPj4QbBboF03P+BzzCdmTFNXQO6XAQ
	ToBZ3Ju6MXLpzP/Wz5vsypVhrjeCEIhqD7y81DaMQ0pPinjqMIeQGZ0tGI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA92E6D1B7;
	Tue,  6 Oct 2009 07:39:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DA3F6D185; Tue,  6 Oct 2009
 07:36:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D91E74A8-B26C-11DE-8189-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129623>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 4. Are there any (scripted?) use-cases where git-checkout should fail
>>    because it was given an invalid branch name?
>> 
>> The following gives a hint, though they could of course be fixed and
>> the ^0 case doesn't really count:
>> 
>>   $ git grep 'git checkout .*||' -- "*.sh"
>>   git-bisect.sh:        git checkout "$start_head" -- || exit
>>   git-rebase--interactive.sh:  output git checkout $first_parent 2> /dev/null ||
>>   git-rebase--interactive.sh:  output git checkout "$1" ||
>>   git-rebase.sh:git checkout -q "$onto^0" || die "could not detach HEAD"
>>   t/t2007-checkout-symlink.sh:git checkout -f master || exit
>
> Actually, in said cases (with exception of the test case, which should be 
> fine, however, having no remote branches), I would expect the user to be 
> grateful if the DWIMery would happen.

Did you check the context before making that assertion?

 - The one in git-bisect switches to (or detaches at) what was earlier
   written in BISECT_START, which is either a branch name or a commit
   object name, so the user definitely does not want DWIMery if it could
   check out something else --- I do not think DWIMery hurts as long as
   the user does not delete the original branch while bisecting, though.

 - The first one in "rebase -i" is always fed a commit object name;
   DWIMery is not needed (and it would not hurt).

 - The second one in "rebase -i" is about switching to the branch being
   rebased, and it has an explicit check to see if "$1" is a branch name;
   DWIMery is not needed (and it would not hurt because of the check
   before it).

 - The one in "rebase" proper, as Thomas pointed out, is an explicit
   request to detach, so DWIMery won't happen.

The first three cases that could trigger DWIMery fall into "DWIMery does
not hurt because it happens to be a no-op in the way it is used" category,
not "In this case, the users would actively appreciate DWIMery".  IOW,
this does not look particularly a good argument to support DWIMery to me.

About the second one in "rebase -i", and also the corresponding one in
"rebase", which is:

	test -z "$switch_to" || git checkout "$switch_to"

If the command did DWIM, you would fork a local branch from the remote and
immediately rebase it.  Any good git tutorial teaches not to rebase work
by others, and keeping the result of such a rebase on a local branch goes
directly against it [*1*]; the script needs to be updated to protect
itself from DWIMery if we were to change "checkout" in these cases.


[Footnote]

*1* It is quite useful to temporarily rebase others work, e.g. in order to
compare what got changed in the newer version of series, so I wouldn't
object if the user did

    git checkout origin/topic
    git rebase $(git merge-base origin/topic@{1} origin/topic)
    git show-branch origin/topic@{1} HEAD

but notice that it all happens on detached HEAD, not to be kept.
