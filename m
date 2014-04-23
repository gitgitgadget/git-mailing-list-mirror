From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 15:44:03 -0700
Message-ID: <xmqqoazrwtsc.fsf@gitster.dls.corp.google.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com> <53558f6269f91_640076f2f08f@nysa.notmuch>
	<857g6h5ssh.fsf@stephe-leake.org>
	<5356996d12ede_3e5aed7308e5@nysa.notmuch>
	<85mwfc4hab.fsf@stephe-leake.org>
	<535782d95bbed_24448772ec7a@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Leake <stephen_leake@stephe-leake.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 00:44:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd5tq-0007vC-Qc
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 00:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaDWWoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 18:44:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbaDWWoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 18:44:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF629801C4;
	Wed, 23 Apr 2014 18:44:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQKTuWBlxkV3PsvoU3LofUYR7sw=; b=obVLVt
	ysRiz3VDBI55dERcc6sMPu4Ty/3gh/jFV79dxfAMhLSc4blQETnHj0L4WrOo72rN
	qUxq9L6uONVZA4j5fW0T6Xvv0sonmVw0dke+PfqY0hMmCzGePjU7pHpIqgt8D3np
	Ca6CIFW9LbdGbbWc/0rm3vdoZTIgkrz8P4vzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aO3kzXipWEkLQ5sNnCjvnEiS+WGOLaxf
	YyvWHiPcongBJW2y6B5NtV1tcN45cCxGYwfZ4RU/OINdFdxRelvZIXs6c5ViGl/p
	Zh+VyhVHgAlocu7Ay4UWYxMmJBbYWrAv4xEqWAhw5t886cmHmz1nKdyJ1uCMqRBN
	mSVMoY/9CEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4E4D801C3;
	Wed, 23 Apr 2014 18:44:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB66801BF;
	Wed, 23 Apr 2014 18:44:06 -0400 (EDT)
In-Reply-To: <535782d95bbed_24448772ec7a@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 04:07:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C6AAE074-CB38-11E3-A885-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246909>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> >> I have a branch which should always be recompiled on update;
>> >> post-update-branch would be a good place for that.
>> >
>> > And why would pre-update-branch not serve that purpose?
>> 
>> Because the code that needs to be compiled is not yet in the workspace
>
> And it won't be in 'post-update-branch' either.
>
>  % git checkout master
>  % git branch feature-a stable
>  <- update-branch hook will be called here
>
> The hook will get 'feature-a' as the first argument, but the code in the
> workspace would correspond to 'master'; the checked out branch (pre or post).

The whole point of a pre- hook is to run _before_ the externally
observable state changes due to the operation.

If Stephen has a separate build-tree that fetches from the branch
every time the tip of the branch changes in this repository to
produce build artifacts for the branch to be shared in his network,
perhaps via NFS or something.  "git fetch" that will be run from
that build-tree repository will *not* see the tip of the branch, and
running such a hook will not be possible from a pre-update-branch
hook.

We can certainly argue that such a hook could instead push to the
build-tree repository using the commit object name, but I tend to
think such an argument is merely sidestepping the real issue.  Some
hooks do want to observe the state _after_ the operation [*1*],
while some hooks can do without seeing exactly the state after the
operation.

So while I am generally not very supportive towards post-anything
hook, I would reject a claim that says "pre-anything can be used
without inventing post-anything---do the same thing and allow the
operation and you are done".  That is not simply true.


[Footnote]

*1* A trivial example: send out an e-mail that contains the output
    from "git branch -l -v" or "git log --oneline --decorate --all"
    to a logger and expect to see the branch tip pointing at the
    commit _after_ the operation.
