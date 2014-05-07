From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Wed, 07 May 2014 11:42:00 -0700
Message-ID: <xmqqzjita0sn.fsf@gitster.dls.corp.google.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
	<20140501024042.GX9218@google.com>
	<CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
	<xmqqa9aug4my.fsf@gitster.dls.corp.google.com>
	<CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
	<xmqqbnvaehm3.fsf@gitster.dls.corp.google.com>
	<CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nathan Collins <nathan.collins@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 20:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi6nF-0006wK-8z
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 20:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbaEGSmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 14:42:10 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64036 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaEGSmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 14:42:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04373168B2;
	Wed,  7 May 2014 14:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hcq+KeCzY7eSprytEMGiamhPq5Y=; b=QVg4xg
	zua5vyor+P6cKAHcyNlge1c0h4AoX5daL9Dp7IQFPkbURWNYyD7U7J8jcTx4i3Px
	F3lYhq2IGrU/FkyGghg5pQsIdtY9pFD/9yKBldemI5GXJiwhcgCEjJH+qmiDCRpY
	m0+A4DrX1tm8zbFlRJ5Akit1n96VhsjBrEM7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uuXMRH3n8eesXcsugyc9W07pdV1CJsjV
	UoGdHKJd/B0unz/AGMAllXvi/eF7AiBN1D2F1r5d2UlAt3adwmWBGiTUG7KdDaGu
	E6/ho0VJbENj5nLtMbfHLIvuPDEPG6mbW5JFMq8md/IHCzoQDQAjUM2DeZsxnoOr
	iOUPJujSTLg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEE51168B1;
	Wed,  7 May 2014 14:42:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CE7C168AD;
	Wed,  7 May 2014 14:42:02 -0400 (EDT)
In-Reply-To: <CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
	(Nathan Collins's message of "Tue, 6 May 2014 18:16:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 476A1250-D617-11E3-AE26-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248344>

Nathan Collins <nathan.collins@gmail.com> writes:

> More concretely, what I had in mind was that if 'diff.noprefix=true'
> is set in the user's config, and the patch is in '-p0' format, then
> Git could suggest to the user that the 'diff.noprefix' setting *might*
> be causing them to generate '-p0' patches. If the user had in fact not
> generated the patch themselves, then they could safely ignore the
> suggestion.

Issuing a suggestion that can be ignored too often sounds like
crying wolf to train users to ignore all other more useful
suggestions, so I would advise to be very cautious before doing so.
If you cannot come up with a way to make the heuristics very sure
and foolproof, I do not think it would help more than it hurt.

One possibility I considered briefly before discarding it was to see
if the input is coming from a pipe *and* these configuration is set.

> But this may just be an overcomplicated solution to my and others'
> misuse of the 'diff.noprefix' option; see below.
>
>> So that is not workable.

Yes.

>> However, Before issuing this error message
>>
>>>   git -c diff.noprefix=true diff HEAD~ | git apply --reverse
>>>   error: Data/Function/Decorator/Memoizer/Unsafe.hs: No such file or directory
>>
>> we _could_ check that there is Data/ directory in the target tree
>> the patch is being applied and suggest to:
>
> To clarify, the actual path was
>
>   src/Data/Function/Decorator/Memoizer/Unsafe.hs

Yeah, and I meant to suggest checking that path is plausible.  It
would not help when adding a new file, but we can issue the original
error message and that is perfectly readable, so catching only paths
that are modified or deleted and suggesting -p$n is still making
things better.

> 1. 'git apply' doesn't give a very helpful error message when the
> patch does not apply due to not being in '-p1' format.

That "Data/Function/..." path in the error message is helpful
enough, once you learn that -p$n strips the leading directory and
that -p1 is the default.  For new people, however, -p1 being the
default might be unexpected, but the learning curve is not that
steep, I would think.  So this is a one-time thing.

> 2. the 'diff.noprefix=true' option is used for two unrelated things in
> practice. One of them is related to diffing -- namely, making Git
> generate '-p0' patches -- and the other is unrelated to diffing --
> namely, users want file names that can be easily copied with
> double-click.

I do not share this observation, as I never double-click.  I let my
shell to complete instead ;-)

> For (2), the solution may be to add a separate
> 'diff.add-clickable-paths' option (probably there is a better name?
> 'diff.add-copyable-paths'? ...),...
> ...
> Concretely, if 'diff.add-clickable-paths' is set, then instead of e.g.
>
>   diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
> b/src/Data/Function/Decorator/Memoizer
>   index 3ef17da..a0586d3 100644
>   --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>   +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs

If you do something along that line, perhaps

	Index: src/Data/Function/Decorator/Memoizer/Unsafe.hs
        diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs ...
        index 3ef17da..a0586d3 100644
        --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
        +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs

to imitate what "cvs diff" does may be more familar to people.

What would you propose to make clickable in a renaming diff, though?

        
