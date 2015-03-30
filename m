From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 12:58:52 -0700
Message-ID: <xmqqtwx2w937.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<5519178A.6080408@gmail.com>
	<xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>
	<CAHGBnuP0mRYWyJiLvWHuqsVxMRPPtvu-QuWmcD8xXeVOXhwSDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 21:59:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycfpw-0008Is-16
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbbC3T64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 15:58:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752851AbbC3T6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 15:58:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FAE945303;
	Mon, 30 Mar 2015 15:58:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MpYwaUyxo9FcjjIKMBoV1Z0g8dQ=; b=ETJihz
	c5sidQagS42AptvvJAt+pEMBEfF0E+f4c8s1k/eY0X9mbneST0ofHajseRwjhYHn
	XUlaixPakoK4UVcc2vTSxZYTdrM2JsuGzR72fEPzaTEVsKGhl+9G8d/Q7JBwZM85
	aWyHwbqwshYnoU9DB8Dun1msXq05MAknm4LCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngGEpzy3ws6HxDWGTTSlyMwMu3MsqqK6
	AVgjcNFvA3Ymo4ydFbffxZ5OeLoisZgTLXtBayipfZJqVZLouna+xcb+EQTMQLZY
	vYJacBeQJ5AuVIgU15exmXbxADYcifRklLhkmUUPafq7g6ZQmQv0nF3cCqNJEhIE
	SErqbMvXzSo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7864B45302;
	Mon, 30 Mar 2015 15:58:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAE9045300;
	Mon, 30 Mar 2015 15:58:53 -0400 (EDT)
In-Reply-To: <CAHGBnuP0mRYWyJiLvWHuqsVxMRPPtvu-QuWmcD8xXeVOXhwSDA@mail.gmail.com>
	(Sebastian Schuberth's message of "Mon, 30 Mar 2015 21:42:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3153FCA4-D717-11E4-A21F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266471>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> That is, at least to me,
>>
>>          D---E---F
>>         /         \
>>     ---A---B---C---G---H
>>
>> the former, i.e. "the changes the merge G introdues", is "diff C G",
>
> To me, too. In other words, this is the combined diff of all commits
> reachable from all parents of the merge (other than the first parent).
> In your example, that would be the combined diff of D, E and F, which
> equals "git diff C G".
>
>> while "merge commit was skipped" would mean a history like this:
>>
>>     ---A---B---C---D'--E'--F'--H'
>>
>
> This is where your interpretation differs.

I know.  If I am rebasing this whole graph on top of somewhere while
ignoring merge G:

>>          D---E---F
>>         /         \
>>     ---A---B---C---G---H

I'll expect changes made by A, B, C, D, E, F and H appear as
different commits in the result.  That is what "ignore G" means to
me.

But it is pointless for you to say "Your attempt to misunderstand
the current and proposed text is flawed".  People are flawed and I
am merely pointing out that what you wrote can be read by people
other than you in a way you did not mean to.

And my response was an attempt to offer a suggestion to make it
harder to be misread by anybody.

> Ignoring a merge sounds like dropping the merge commit and all side
> branches it merges from history.

... Yes to _some_ people (including you, but not me).  And that is
why we are trying to improve the text in the documentation, no?
