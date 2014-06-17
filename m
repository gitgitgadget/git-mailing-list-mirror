From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our merge bases sometimes suck
Date: Tue, 17 Jun 2014 08:08:17 -0700
Message-ID: <xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>
References: <539A25BF.4060501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 17 17:08:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwuzs-0003GN-5c
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933045AbaFQPIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:08:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53181 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933031AbaFQPIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:08:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DAC6F1FE1E;
	Tue, 17 Jun 2014 11:08:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4yyuWEuwdAPKEnBj2Xqx+kShc6w=; b=LuTeLr
	CnO1MuOSuNC9kJo80MUsnVz4BbwqME4zS32UjrWSzrSbw0HafXBFoDH/hPtGW0dX
	4bQiHAqt3OXauPR1U81MGMGC/vm/fBHvur0ZyYmzhWMTaU12cpRiUdoKe98aiaPI
	z3aHKOrSPDEn8O8xKKHKy06v4xY09lp7YPxkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xjxqf4hfH9vaLvPzlo247OSClBiYoooF
	Wm6ru1t/ydEnruLY7TUoxfAVKpwnst4JU3LJJpvIFY1PZA3fo63LGjwcPdAcoV4z
	LMVgHhOrZfO+Hl7xduRkJYNdt64zR+PhlaBVChmxiFdmz/YXKs5jpF6L0yX0zUIU
	ehktEdLOyEg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0F371FE1D;
	Tue, 17 Jun 2014 11:08:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 90F8A1FE18;
	Tue, 17 Jun 2014 11:08:16 -0400 (EDT)
In-Reply-To: <539A25BF.4060501@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 13 Jun 2014 00:12:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 35B36482-F631-11E3-B0CC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251863>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The "best" merge base
> =====================
>
> But not all merge bases are created equal.  It is possible to define a
> "best" merge base that has some nice properties.
>
> Let's focus on the command
>
>     git diff $master...$branch
>
> which is equivalent to
>
>     git diff $(git merge-base $master $branch)..$branch
> ...
> I propose that the best merge base is the merge base "candidate" that
> minimizes the number of non-merge commits that are in
>
>     git rev-list --no-merges $candidate..$branch
>
> but are already in master:
>
>     git rev-list --no-merges $master

I welcome this line of thought very much.

There is one niggle I find somewhat curious but am either too lazy
or too stupid to think it through myself ;-)

The "merge-base" is a symmetric operation, because the three-way
merge, which is the primary customer of its result, fundamentally
is.  From your description, it sounds like the "best" merge base
however may not be symmetric at all.  The merge-base between A and B
that makes "git diff A...B" the easiest to read by minimizing the
distance between it and B may be different from the merge-base
between A and B that makes the other diff "git diff B...A" the
easiest to read.

Or it may not be assymmetric---that is why I said I didn't think it
through.  I am not saying that it is bad if the "best" merge-base is
an asymmetric concept; I am curious if it is asymmetric, and if so
if that is fundamental.
