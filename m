From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Wed, 11 Apr 2012 09:52:21 -0700
Message-ID: <7v62d6mcsa.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
 <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
 <20120411004419.GA19616@neilslaptop.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0mc-0005pP-3c
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671Ab2DKQw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:52:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932418Ab2DKQwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE82C65A9;
	Wed, 11 Apr 2012 12:52:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=X+KcIDhefh53UZA3f6Pg+BAPxEE=; b=rQhv58+SRzPDet0ERi7v
	I2X3OwF9ftXsFtEViq38jqd/JZqkhUh16Ow/UPk5Mwi8h0qt8NQu4gxSHnl06PoJ
	ACdwc/GgpjkVr/YJXTSFZCHBMmdWM7FSve1ZPsAa2V/5LSBYPLGqkWvE/yNFII/M
	UuFKAjFbpkE4KC3InqiBA2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sU6lMDqAjqlzYUYlPMN3yfgYLUTnrwTDryXsQsX0qWRwHf
	OtWb8rALZzXKv9gBXWIa9TZz1WQ46I6uc0xVtTH4gxE/yXLc6y6rnGWmmSsJ/zg1
	f9Ko3ekd6/btki2qXLV+/F4fu2Wga2shbs/aKwKQekEG+a3g2P3mV58/9Xj/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E515265A8;
	Wed, 11 Apr 2012 12:52:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5545C65A7; Wed, 11 Apr 2012
 12:52:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5D41F4E-83F6-11E1-816E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195215>

Neil Horman <nhorman@tuxdriver.com> writes:

> No, you covered all the cases, but I disagree with your assertion that the advice
> is correct (or at least optimal) in any of these cases. If a cherry-pick without
> any options is preformed and the commit is empty (regardless of the reason), the
> advice given is that git commit --allow-empty should be used.  With the addition
> of these new options, thats not true any longer.  Instead of using git commit
> --allow-empty, you can use git cherry-pick --allow-empty.

Sorry, I am confused.  Do you mean that the sequence goes like this (with
concrete examples of command line args)?

	$ git cherry-pick nh/empty-rebase
        ... stops because "git show nh/empty-rebase" is empty
        $ git cherry-pick --allow-empty

But that cannot be correct, without --continue [*1*], i.e.

	$ git cherry-pick --allow-empty --continue

no?  I didn't check, but if the command without --continue in the above
sequence does not error out, I think it is a bug.

I am actually OK with suggesting "git cherry-pick --continue", but then
"cherry-pick --allow-empty" (or "--keep-unnecessary-commits") that punts
and gives the control back to the user should leave enough clue for a
later invocation of itself so that it can realize that the original
invocation was made with "--allow-empty".  In other words, I am OK if the
interaction goes like this:

	$ git cherry-pick --keep-unnecessary-commits nh/empty-rebase
        ... stops due to a conflict
        $ edit builtin/revert.c
        ... the result ends up being empty
        $ git add -u ;# resolved
        $ git cherry-pick --continue


[Side note]

*1* It was an original UI mistake to make the users conclude a "git merge"
that asked the user to help resolving the conflict with "git commit",
which was inherited by "git cherry-pick" and "git revert", especially when
these three commands are merely a special "possibly zero or one stoppage"
case of more general sequencing commands like "am" and "rebase" that can
stop zero or more times to ask the user for help and the way to resume
them is to re-run the same command with "--continue" option (and without
any other arguments), e.g.

	$ git am -3 ./+nh.mbox
        ... stops due to conflict and asks to resolve them
        $ edit builtin/revert.c
        $ git add builtin/revert.c
        $ git am --continue

and also discussed that in the longer-term it would be nice to teach the
oddball commands to honor "--continue".  "am" originally took "--resolved"
(and it still does, and it will do so in the future) for the same purpose,
and we taught it and "cherry-pick" and "revert" to honor "--continue".
Probably we should start teaching "merge" to honor it as well to complete
the vision.
