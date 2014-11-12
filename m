From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Wed, 12 Nov 2014 09:59:52 -0800
Message-ID: <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XocDA-00088Q-Ba
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 19:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbaKLSAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 13:00:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752993AbaKLSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 13:00:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DA041C723;
	Wed, 12 Nov 2014 12:59:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JaMeZ3RhM05jh4P0guhBXxYqwKk=; b=DguJNG
	CzdWh5o10uuMe24sfjTmEcdM+8MEyT+oV3ldvTpc2D9aN4DL1BL6arz4FKkEU42Z
	5MVZO0i9ALQUYSuH1LPu1qQ1YV+bhVe2NXeyreL3uAi3jUELWMAe4N1ONVMcHHDy
	LU5AhlXyDu86vHFwgP0faSxHH7WIDL061wqY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZRk16f01bSkm9SFphQCsiJBJLZiWktA
	aMIs9SV5Dzc0r+XF7IvR3Ff1G/5zxWD0nibDDS6Fmj4RW4kRghriikBReROEnGRk
	j1V7hrQZWO8es8LB5rcixoMJRizdKbT3pVi/QTffqX++qQfMcz2PGpLYUW+MA6MW
	c1BDTv5Sacg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 834511C722;
	Wed, 12 Nov 2014 12:59:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5F451C721;
	Wed, 12 Nov 2014 12:59:53 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Wed, 12 Nov 2014 12:09:14 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B47548E8-6A95-11E4-9BD1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 10 Nov 2014, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Dying when "update-index --refresh" signals a difference is an
>> > attempt to mimic #1, but it is in line with the spirit of the reason
>> > why a user would want to use updateInstead, I think.  The situation
>> > is more like the person who pushed into your repository from
>> > sideline did a "checkout -B $current_branch $new_commit" to update
>> > the HEAD, the index and the working tree, to let you pretend as if
>> > you based your work on the commit he pushed to you.
>> >
>> > While you still need to error out when your local work does not
>> > satisfy the cleanliness criteria #3 above, I do not think you would
>> > want to stop the operation when "checkout" would not fail, e.g. you
>> > have a local change that does not interfere with the update between
>> > the two commits, with this one:
>> >
>> > +	if (run_command(&child))
>> > +		die ("Could not refresh the index");
>> >
>> > When refreshed the index successfully, we signal that there were
>> > differences between the index and the working tree with a non-zero
>> > return value, so "Could not refresh" is not quite right, either.
>> 
>> Just to make sure.  I am *not* saying that you do not need to run
>> "update-index --refresh".  It is necessary before running read-tree
>> to avoid false dirtyness, so you do need to run it.
>> 
>> I am only saying that it is too strict to fail the operation when
>> the command reports that you have a local modification in the
>> working tree.
>
> Okay, now I am even more puzzled. I guess you actually meant to say that I
> need to convert the die() into a return? If so, I agree fully.

No.

"update-index --refresh" does two things.

 (a) For performance reasons, plumbing commands such as diff-files
     and read-tree do not refresh the stat bits in the index.  They
     expect to be run from scripted Porcelain commands, and expect
     that the caller would refresh the stat bits before they are
     called to prevent them from mistakingly seeing that an
     unmodified existing file, after "touch existing-file", as
     modified.

     And "update-index --refresh" is the way for the caller to do so.

 (b) "update-index --refresh" indicates with its exit status if the
     working tree files match what is recorded in the index.  This
     can be used to see if "diff-files" would report difference.

As you are going to run "read-tree -m -u", you need to refresh the
stat bits for purpose (a) above, i.e. to avoid "read-tree" from
failing due to a difference that does not exist.  Because I am
assuming that your "cleanliness" requirement to update the working
tree is criterion #3 in the previous message, I do not think you
would want to abort the update only because there are some
difference between the index and the working tree.  That means that
checking the exit status of "update-index --refresh" and dying (or
signaling the failure to the caller by returning a non-NULL string,
in the context of this call path) is not what you want.  You may
have a local change to Makefile in the working tree of the
repository that you are pushing into, and there may not be any
change to the Makefile between the original HEAD the working tree is
based on and the updated HEAD you are pushing into the repository.
"update-index --refresh" will say "You have a local change." and
exit with non-zero status, but just like "git checkout another" to
switch to another branch while you have some local change that does
not overlap with the difference between branches does not fail, you
would want to allow the update.

You may be trying to use a cleanliness requirement that is different
from criterion #3 in the previous message, but checking the exit
status from "update-index --refresh" does not make much sense in
that case either.  I do not think you want to have:

 * pushing into a repository that did "edit Makefile; git add Makefile"
   succeeds.

 * pushing into a repository that did "edit Makefile" without "git
   add Makefile" fails.

but that is what you will get, because "update-index --refresh"
would say "Your working tree matches the index" by exiting with 0 in
the former case, and you will end up running "read-tree -m -u".

Having said all that.

Instead of running "update-index --refresh; read-tree -m -u", using
"reset --keep" may be a better implementation of what you are trying
to do here.

I think a "checkout -B <current-branch> <new-commit>" is what you
want to run when a push attempts to update the current branch from
sideways with updateInstead, and "reset --keep <new-commit>" lets
you run an equivalent of the "checkout -B <current-branch>" but you
do not have to know the name of the <current-branch>.  Also by using
"reset --keep", you do not have to worry about refreshing the index.

Thanks.
