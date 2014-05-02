From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 13:06:06 -0700
Message-ID: <xmqqtx989c9d.fsf@gitster.dls.corp.google.com>
References: <5363BB9F.40102@xiplink.com>
	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
	<5363edc954f8e_70ef0f30c24@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 22:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJiq-0001td-F6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 22:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbaEBUGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 16:06:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53129 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbaEBUGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 16:06:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3799812B77;
	Fri,  2 May 2014 16:06:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dvK1TavYAPbWdwCg66ooYJITypI=; b=YcYvQ2
	mI1BEslJzYj1pROOKKDm9t+Hln1S+AhpTtMVv4HpCWWBr3vUhspllMSU37JpC5bu
	DI3s6VwUwYZGQcWm6IbM6RZY+WwFSPgvbjgb7OAiskZ+BQ+oFadcplFUmwmkk6vr
	SHypmF45R406s9kItoHrZejQv5j4PBrlwrYbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RvpXDypHDmhoJuZU760IUWZk3b9MNuA1
	7xWUQh5siLsreKeGiKaH6g2ZTeLlE4ehE2jRSUp+c5FKU0zV+gInnmBfo3+yAcOV
	0DPnurvFiZOjj0/QiD1GPVbmOEvSzQC+RvstNX14MJ8KSqLyDsmMFjah+WJXvmcI
	qzWfZb9YBRA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2E64612B76;
	Fri,  2 May 2014 16:06:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4BC0F12B74;
	Fri,  2 May 2014 16:06:08 -0400 (EDT)
In-Reply-To: <5363edc954f8e_70ef0f30c24@nysa.notmuch> (Felipe Contreras's
	message of "Fri, 02 May 2014 14:11:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3312F438-D235-11E3-B480-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247966>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Stepping back even further, and thinking what is different between
>> these two pulls, we notice that the first one is pulling from the
>> place we push back to.  Perhaps a way to solve this issue, without
>> having to introduce a new 'git update' and updating the tutorials,
>> may be disallow fetch+merge by default only when pulling from the
>> place the result is going to be pushed back to?
>
> Which is basically essentially the same as not specifying anything, or
> rather, running `git pull` without arguments.

I cannot tell if you are agreeing or disagreeing, and with what.

Using the "special case 'git pull' without arguments" heuristics
would take us back to the old jc/pull-training-wheel patch

    http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=230856

which we agreed to drop in

    http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234365

to favor the old series you did with pull.mode, and we rejected that
patch in $gmane/230856 for a sound reason, I would think.

"You are pulling from the place the result is going to be pushed
back to" is different from "'git pull' was run without arguments".
In the "pumpking" example in the message you are responding to:

    When he becomes in charge of producing a new 'maint' (in his
    original, he says 'maintenance-branch'), he first does this:

        $ git checkout maint
        $ git pull --ff-only [ origin maint ]

the heuristics would trigger the safety only when the optional
"origin maint" are not given, but we do have enough information
to see "git pull origin maint" (with where from and what to pull
explicitly specified on the command line) falls into the case where
the user needs protection, don't we?

Also, with the triangular push configuration, "git pull" without
argument will fetch from one place that is different from where the
current branch is going to pushed to, so that heuristics would not
work at all.

So...
