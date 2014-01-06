From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Mon, 06 Jan 2014 08:56:22 -0800
Message-ID: <xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
	<d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
	<CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
	<20140106144708.GC27265@t2784.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francesco Pretto <ceztko@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0DTg-0002FK-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbaAFQ4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:56:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755775AbaAFQ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:56:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D58E5D041;
	Mon,  6 Jan 2014 11:56:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G5PBL4WRMUGZJB2o2nkLeO2bJiw=; b=F2YHaI
	ql8VkzFydpySagzr7qAN7YWDqGl0ObNYOmzHf7Ca9BRLAArLKOdPD2m+G8gL5rJt
	oQcqdX7hoxTVzOsE8yqBIfIK8zkNV0Fv0wKm0A+Dts5eB/4Nv79Akw3PS0Sue6D5
	9qAcG25i1zUveM/CLGrbReh21kdjMfmSU/Ik8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iX6ir49IUEzdATR36O+KIXh3GyaVChI5
	rBxZIZouz5qjeWQnsw+Kz+kTwp2tM+hP9IsjO0iRlgUFOeJ5MNBU1OB+KfA0HY5d
	ayAA+2q3oJyxYQg5HGczFkVlZLeWHHceqUpwfGiV45+Yr5rZYwNgax+RJ8BdEy9j
	blDzZP7WM7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01FEA5D03F;
	Mon,  6 Jan 2014 11:56:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 509AE5D03D;
	Mon,  6 Jan 2014 11:56:26 -0500 (EST)
In-Reply-To: <20140106144708.GC27265@t2784.greatnet.de> (Heiko Voigt's message
	of "Mon, 6 Jan 2014 15:47:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B03EDDA-76F3-11E3-9A54-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240026>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Sun, Jan 05, 2014 at 10:27:19PM +0100, Francesco Pretto wrote:
>> 2014/1/5 W. Trevor King <wking@tremily.us>:
>> > On Sun, Jan 05, 2014 at 04:53:12AM +0100, Francesco Pretto wrote:
>> >> Also it could break some users that rely on the current behavior.
>> >
>> > The current code always has a detached HEAD after an initial-clone
>> > update, regardless of submodule.<name>.update, which doesn't match
>> > those docs either.
>> 
>> I perfectly agree with you that the documentation is a bit
>> contradictory with regard to "update" command and detached HEAD.
>> That's why it's so hard to add a feature and keep the same spirit of
>> those that coded submodules at first. Also, I think that submodules
>> didn't get much feedback with regards to these pitfalls because many
>> people try to setup them, they see that "update" detaches the HEAD and
>> they think "hmmm, maybe submodules are not what I was looking for".
>
> I am not so sure about that. Why should detached HEAD make you think
> like that? For us at $dayjob we have a pre-commit hook that denies you
> to commit on a detached HEAD and asks you to create a branch first.

Perception is irrational ;-)

We long-timers think detached is a perfect starting point for both
users of submodule who merely want to use the specified commit and
developers who want to work on the submodule to match the need of
the superproject.  The former do not have to do anything, and the
latter will have to chdir to the submodule working tree and create a
branch (or update the branch with rebase or pull on top of the
specified commit) as the first thing before doing anything.

Not everybody is a long-timer, but the saving grace is that nobody
stays a newcomer.

BUT.

>> - developers checkout that commit and don't pull (you can't do "git
>> pull" in a detached HEAD);
>
> Exactly. We consider pull evil ;-) Seriously: To update we only do fast
> forward merges of local stable branches. 
> ...
> Yes, why would you do a git pull in a submodule? Don't you want to do
> something like
>
> 	git checkout -t -b dev/my-topic origin/master
>
> to start your development?

As long as origin/master contains the commit specified by the
superproject, that would work, but it may be a good thing to use a
mode of submodule.*.update that does not have to drop the user into
a detached state in the first place.  I somehow thought that was
what rebase (or merge) was about, that is, starting from the state
where a branch is checked out in the submodule working tree, an
update in the superproject would cause that branch checked out in
the submodule brought up to date with respect to the commit
specified in the superproject tree.  If that is not how it is
supposed to work, please correct me---and we may have to add another
mode that does so (or even make rebase/merge do so as a bugfix).

And wouldn't it make it unnecessary to have a new "re-attach" option
if such a mode that never have to detach is used?
