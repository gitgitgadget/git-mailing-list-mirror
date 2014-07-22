From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore and git stash -u
Date: Tue, 22 Jul 2014 14:22:29 -0700
Message-ID: <xmqqd2cxf5re.fsf@gitster.dls.corp.google.com>
References: <CAH4Lw1p4UUAH5LcrVEcXtr75Jdfp8osYN2vUk=nkAttosOOjDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeffry Johnston <jeff@kidsquid.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hWD-0000M2-EV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbaGVVWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:22:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54781 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbaGVVWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:22:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A32972C51C;
	Tue, 22 Jul 2014 17:22:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D2YwVkIlDXarWQbRd7wYARojrHw=; b=izDEVS
	TCAsmcypOtYD/q4TsNJyiyyR2V7mEQ+Wm+9d01VzJY92o5xzBGWZB2y0fbTPcgdj
	Vh0Co3AU2Izos+5LzHpjIZ5UmnvIE1RtUFjWORZrt1so39kwMsk4QZo0MvOpj0ra
	u/bkbjNMv29Q0KOfcPBXTLV5by19u81rpe914=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FL7Ub/7U2a6j65/D/NE7XMKX5lhIHyaZ
	0f8Fu7fAGgM4hjG+qW4o0S9oQk/82y3hxLOwUTBYV242+pPiVB8b8csdxqCBC+C2
	VetuCZ5Xnc4htVsej128VQRMk1sgXtpfSrPyKieDFeTm83w1FcK41g7kCJ0hqmkz
	hIGqtD5Q9HM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B24C2C51B;
	Tue, 22 Jul 2014 17:22:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B61632C516;
	Tue, 22 Jul 2014 17:22:30 -0400 (EDT)
In-Reply-To: <CAH4Lw1p4UUAH5LcrVEcXtr75Jdfp8osYN2vUk=nkAttosOOjDw@mail.gmail.com>
	(Jeffry Johnston's message of "Tue, 22 Jul 2014 13:55:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 49E0BF1A-11E6-11E4-91C7-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254041>

Jeffry Johnston <jeff@kidsquid.com> writes:

> We had been experiencing "random" deletions of files and directories,
> and we finally figured out what they were: git stash -u.  A coworker
> happened upon a webpage (after losing a weeks worth of experimental
> work, back to his last backup), which described our problems exactly:
>
> http://blog.icefusion.co.uk/git-stash-can-delete-ignored-files-git-stash-u/
>
> The command git stash -u deletes ignored files from the hard drive..
> very dangerous!

Although I never use "stash --include-untracked" myself, I think it
is deliberate that the command removes all the untracked files.  The
author of that "feature" explains its use this way:

commit 787513027a7d0af3c2cd2f04b85bc7136d580586
Author: David Caldwell <david@porkrind.org>
Date:   Fri Jun 24 17:56:06 2011 -0700

    stash: Add --include-untracked option to stash and remove all untracked files
    
    The --include-untracked option acts like the normal "git stash save" but
    also adds all untracked files in the working directory to the stash and then
    calls "git clean --force --quiet" to restore the working directory to a
    pristine state.
    
    This is useful for projects that need to run release scripts. With this
    option, the release scripts can be from the main working directory so one
    does not have to maintain a "clean" directory in parallel just for
    releasing. Basically the work-flow becomes:
    
       $ git tag release-1.0
       $ git stash --include-untracked
       $ make release
       $ git clean -f
       $ git stash pop
    
    "git stash" alone is not enough in this case--it leaves untracked files
    lying around that might mess up a release process that expects everything to
    be very clean or might let a release succeed that should actually fail (due
    to a new source file being created that hasn't been committed yet).
    
    Signed-off-by: David Caldwell <david@porkrind.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
