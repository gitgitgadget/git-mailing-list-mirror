From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3]More diffs for commit/status
Date: Thu, 05 Mar 2015 12:15:16 -0800
Message-ID: <xmqqlhjb2obv.fsf@gitster.dls.corp.google.com>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
	<cover.1425564336.git.git@drmicha.warpmail.net>
	<xmqqtwxz2qmb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:15:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTcB8-0002qo-2J
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 21:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757082AbbCEUPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 15:15:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55643 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbbCEUPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 15:15:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57DF03E437;
	Thu,  5 Mar 2015 15:15:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DD5zrew34MJPcYCzAbguYrtzNSE=; b=XU9Syh
	zPgU093ox7ADGGXQpoFCgAeFn+mKJGH7P8rgLx51C4kIC9aYPwJrDWl+uNJJFFWX
	FXAsepo2oMCEhvZnhGua2a5a/KHmluGsSgwUS9mNJrbJtN96Csg6gHDAAFdjncSh
	RF2srSfKxGiOM1riUqSocgWnSFXFH8itETBzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jebtXn8G3Pwao+7iDBJeML4AAX5A9gP3
	yqXh1O3QO33i5eZnV1YFQlA9m766Z0nPmD4945FP6pFLmHLJ40JarhzEe2iBAHJF
	WADDS6qLqGYvNZLztJriR4Dsle8SF7sb7yJaSEDf+q/nqsYVPPml2WugSpr3SX0A
	FRpLvBEqRu8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DE093E435;
	Thu,  5 Mar 2015 15:15:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9E3A3E434;
	Thu,  5 Mar 2015 15:15:17 -0500 (EST)
In-Reply-To: <xmqqtwxz2qmb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 05 Mar 2015 11:25:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 576DF900-C374-11E4-8FFE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264863>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> - Do we want the header line also for "status -v"? (I would say yes, but that
>>   would be a change to current behaviour.)
>
> I would not object to it very strongly, but I do not see a point in
> changing the behaviour.
>
> And I do not see why a new user would want it anyway.  There is no
> need to differenciate the changes to be committed from the changes
> left in the working tree when the latter is not even shown.

Extending this line of thought further.

If I am reading your patch 3/3 right, "status -v -v" shows the
header when there are patches to be shown for the category.  I am
not sure if that is the most helpful way for the users, when either
c/i xor i/w diffs is missing.

There are four cases, obviously ;-)

1. When there are changes to be committed:

 a) When there is no change left in the working tree, the proposed
    output would be the same as the more familiar "status -v"
    output.  Showing changes to be committed header would of course
    help.

    I wondered if the proposed behaviour hurts the user by hiding
    the header for changes to be left out, though.  By seeing that
    the second header alone and no diff, the user will be assured
    that there is no changes left in the working tree, forgotten to
    be added.  But this point is minor.  As the users get used to
    the behaviour of "-v -v", they will learn to read the emptyness
    and find its proper meaning that there is no change left out.
    So I think the proposed behaviour would be OK in this case.  In
    fact, not showing the second header when there is no change left
    in the working tree will help potential issues with case 2-b).

 b) When there is change left in the working tree, the proposed
    output is fine.  Two headers are shown to indicate what the
    following diff is about and cleanly shows where the boundary of
    the two classes are (especially if you resurrect the -{50}
    separator line I suggested, at least for the second header).


2. When there is no change to be committed:

 a) When there is no change left in the working tree, the proposed
    output is fine.  There is no output (no header, no diff), and
    the user immediately knows that the working tree and the index
    are clean.

 b) When there are changes left in the working tree, the user sees
    one header followed by a diff in the proposed output.  Visually,
    the single line heading (even with the separateor line) may be
    so small in the context of the whole output, and the user needs
    to READ it to notice that the diff being shown are not what is
    going to be committed.  In other words, it is too similar to the
    proposed output in case 1-a).

    If we show the "to be committed" header followed by no diff, and
    then the second header followed by diff, it would be crystial
    clear to the user, because it looks unusual, that what is shown
    is different from case 1-a).  This would especially be true if
    you resurrected -{50} separator line after the heading.


So, my recommendation for "status -v -v" would be:

    if (there are changes to be committed, or
	there are changes left in the working tree) {
	show "to be committed" with -{50};
        show c/i diff;
    }
    if (there are changes left in the working tree) {
	show "left in the working tree" with -{50};
        show i/w diff;
    }
