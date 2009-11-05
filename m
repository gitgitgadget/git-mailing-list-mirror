From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Automatically remote prune
Date: Wed, 04 Nov 2009 18:23:57 -0800
Message-ID: <7viqdpemki.fsf@alter.siamese.dyndns.org>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
 <7v639qi2un.fsf@alter.siamese.dyndns.org>
 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 03:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5s1F-0006Ak-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 03:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZKECYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 21:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbZKECYB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 21:24:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60066 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZKECYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 21:24:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3062492605;
	Wed,  4 Nov 2009 21:24:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5/8rolRV4U5JyEbIzc5L43ABhfY=; b=sQpMv5Vo4xMmwya3S8lqIej
	WOseF7jXAqe5FbktnUZWkwjt8PwIkskDOnjQ0XMvi4VrKBEUvXcnhWOFheUWibwd
	XlDnn7qJ2dUvZzNL6/QniBsFIF5ZXEulk42YSm6G42HG+PWYAECH4DkjyHzv3pAq
	iM5NOx1Pg37oAtpIaViw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mI/9ml84KLQ3Y0IZ85r0OMfkYR40Ko3LPwCbVoPDnnzXITUtA
	m6baf/X9DWCD3pctaNscH1IfuhmEHW2/v7Lt1iWsn/oCu30u9Mo4qj9e5FXqJSMO
	z99rCkJCFIwDUbVgWeI35O3AXjh2VmJJxlPtW7HFbnOryniA/ait7FdI3c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 11FED925FE;
	Wed,  4 Nov 2009 21:24:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 588A2925FB; Wed,  4 Nov 2009
 21:23:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 48CAA388-C9B2-11DE-A56D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132192>

John Tapsell <johnflux@gmail.com> writes:

> 2009/11/5 Junio C Hamano <gitster@pobox.com>:
>> John Tapsell <johnflux@gmail.com> writes:
>
>> You could store necessary information somewhere else when you contacted
>> the remote the last time, but we need to consider what the benefits are to
>> give this information in the first place.
>
> We already get all this information on a "git fetch", no?

"what the benefits are to give this information _in the 'branch' output_"
was what I meant.  From the part you omitted from my message:

    The [Deleted] mark in your suggestion tells the user:

        This is already removed in the remote, and this tracking copy is the
        only way for you to view it ever again.  Do not run 'remote prune
        origin' blindly otherwise you will lose it.

There are two reasons I could think of that the user might want to know
this.

 (1) The user wants to keep the remotes/<origin>/* namespace clean (iow,
     the user does not care to keep old commits that were deemed bad by
     the remote side) by removing stale tracking refs.  But in this case,
     it is very unlikely that the user would use "git branch -d -r" to
     remove stale ones one-by-one after seeing '[Deleted]' label in the
     output from "git branch -r".  Rather he would run "git remote prune
     origin" to blindly remove them all.

 (2) The user does want to be careful not to lose commits that now only
     exists in his repository.  Perhaps he saw something worthwhile to
     base his topic later on.  But these stale remote tracking refs are
     not removed until the user runs "git remote prune origin".  As long
     as we give him a way to check what will be pruned before running "git
     remote prune", there is not much point in showing that information in
     output of "git branch -r".  There is no need to keep extra info by
     creating a new file in .git by "fetch". Nor showing that to the user
     when he does "fetch" either, for that matter.

A better approach to please the first class of audience may be to
introduce an option that tells fetch to cull tracking refs that are stale.
Then "branch -r" output will not show stale refs and there is no place
(nor need) to show [Deleted] labels.

Such an option won't be very useful for the second class of audience,
though.  For them we would need something else, and it would likely be an
enhancement to "git remote".  It would ask the other side what refs are no
longer there, and then check our local refspace to see if there are local
topics based on them (which would mean the user is already in a trouble)
and which ones are not forked locally at all (which may mean "it wasn't
interesting to the user, and we can safely remove it" or "the user was
interested in it, but hasn't got around to forking from it yet, being busy
working on something else").  I am unsure what should be done in the
latter case (i.e. lost remote refs haven't been touched locally) but am
just thinking aloud.
