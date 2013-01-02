From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Tue, 01 Jan 2013 17:06:29 -0800
Message-ID: <7v1ue475re.fsf@alter.siamese.dyndns.org>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org> <20130102003344.GA9651@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Jan 02 02:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqCpZ-0000Ze-Dq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 02:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425Ab3ABBGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 20:06:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403Ab3ABBGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 20:06:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B085BA09;
	Tue,  1 Jan 2013 20:06:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CdU3NZDqfAvjvCgWRVQRAzGDB/Q=; b=C5Pjq5
	Ji+kRAGu6XvYU49W9n467cl3m8apZTs/XIS98KSy8QIHzvnoQX8bmkx0mfm7vLgH
	HdGyyHBa2JI9+LOe8SzznsC8BQv3PHiwSe8Y9x1rTF7K/XGJoVfXy24PbZYOCo3J
	MZt6wY3PWdExMIC49VjYUoBQI+m7u0/hhNwSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f/YDdXL1H21OS74g05yyP4yKEgHL0UUV
	FxTWeWwwPf0WL2A+2fi7cGaW2n3dWSzBaWW/Ello34VLPh7VZ/0v5YWVn7g/k/Fw
	BMXNUjmtL0Rdr/mWok8C/s9w9VlgiRITwSuJS2Y6M0wl03gX51bb+ph2JBhwp6Fq
	3hyCcW4kgMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DFF5BA08;
	Tue,  1 Jan 2013 20:06:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 095A9BA07; Tue,  1 Jan 2013
 20:06:30 -0500 (EST)
In-Reply-To: <20130102003344.GA9651@thyrsus.com> (Eric S. Raymond's message
 of "Tue, 1 Jan 2013 19:33:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4B1C10A-5478-11E2-BD95-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212479>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Junio C Hamano <gitster@pobox.com>:
>> So..., is this a flag-day patch?
>> 
>> After this is merged, users who have been interoperating with CVS
>> repositories with the older cvsps have to install the updated cvsps
>> before using a new version of Git that ships with it?
>
> Yes, they must install an updated cvsps. But this is hardly a loss, as
> the old version was perilously broken.
>
> There was an error or typo in the branch-analysis code, dating from
> 2006 and possibly earlier, that meant that branch root points would
> almost always be attributed to parent patchsets one patchset earlier
> than they should have been.  Shocked me when I found it - how was this
> missed for six years?

Would it be that not many people use branchy history in CVS, as
merging there was soooo painful?

>> Or am I being too conservative?
>
> I think you are being too conservative.  This patch is *not* a mere
> feature upgrade. The branch-analysis bug I found three days ago is not
> a minor problem, it is a big ugly showstopper for any case beside the
> simplest linear histories.  Only linear histories will not break.

That is exactly my point.  It never worked in a branchy history, and
that is an indication that people who didn't complain and used the
old cvsimport with branch-incapable cvsps happily would have been
working with a linear history.  Either nobody uses cvsimport in the
daily work, in which case a flag-day is perfectly fine, or we will
have many people who are forced to update to unproven version for no
immediate upside because the upstream repositories they work with, or
options they use cvsimport, do not trigger the multi-branch bug.

I however do understand that updating is the only sensible thing to
do for them *in the longer term*, as older cvsimport and cvsps are
no longer maintained, and sooner they update the better the chance
the new cvsimport becomes perfect earlier.

> 'People with existing set-ups' should absolutely *not* 'keep using the
> old one'; we should yank that choice away from them and get the old
> cvsimport/cvsps pair out of use *as fast as possible*, because it
> silently mangles branchy imports.

I still am not convinced, especially without a "we make sure we do
not regress in linear histories" side-by-side test in place.  That
sounds irresponsible.

But others may disagree, and I'd have to sleep on it.

I'd prefer to hear from somebody who is *not* defending on his newer
implementation, but from somebody who is actively using cvsimport as
an end user.  On the end-users' side, there always is this anxiety
that a radical rewrite will always introduce new bugs, even when
they know the rewrite is done very competently.

> Here is what I have done to ease the transition:
>
> If you try to use old git-cvsimport with new cvsps, new cvsps will detect
> this and ship a message to stderr telling you to upgrade

Sounds sensible.

> If you try to use new git-cvsimport with old cvsps, old cvsps will complain
> of an invalid argument and git-cvsimport will quit.

With an error message that tells the user to update cvsps, this also
sounds sensible.
