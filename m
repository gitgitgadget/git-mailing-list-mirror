From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 09:42:22 -0800
Message-ID: <7vpqfrqcch.fsf@alter.siamese.dyndns.org>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 14 18:42:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rasqf-0005ly-UG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 18:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab1LNRma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 12:42:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757808Ab1LNRm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 12:42:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37CB3421E;
	Wed, 14 Dec 2011 12:42:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZernkNuJw1rg+hc3pqWjnFHiuck=; b=j2dvlo
	DYjJg4lK5yGwmqpG23aYPzTCPVZSs+g1Keub1KDz9OQqTeHzUIaG7hC70PQyvNzW
	9HBks23/au4ru/2l8X++Bxim79cZWy502rj/UzDtc4i43cXE1Wi5uk7xAh7WL16w
	Y6RgGfV3gh1vAgMxXEx7gp2KEevIfVTEJrIbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rRLz2+c1Fek0s/dEbbgCTE6RcTF8PjH3
	1gsbMD1fVdSE9m8fBYnz/Fq/vzeI420V+VoU9a7X+8aOiZKc/Rl5nEzUVzw2yiFm
	WYOtUF5mAz67GG3O3L0FYvGhZcClgIuyqJzq8yWrZIMUum04ZYraz5FclTfY0531
	JIsQtpFmMeI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3FB421D;
	Wed, 14 Dec 2011 12:42:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A66E2421B; Wed, 14 Dec 2011
 12:42:24 -0500 (EST)
In-Reply-To: <201112141717.15021.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 14 Dec 2011 17:17:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB9B43EC-267A-11E1-AD0C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187155>

Thomas Rast <trast@student.ethz.ch> writes:

> Jonathan Nieder wrote:
>> Junio C Hamano wrote:
>> > Will merge to 'next' after taking another look.
>> 
>> The middle commit looks good.  The bottom commit could be improved as
>> discussed at [1], but I guess that can happen in-tree.
>> 
>> However, the top commit ("test test-terminal's sanity") still does not
>> seem right to me.
>
> I wasn't under the impression that we were done with this, either :-)
>
>> It makes the same test run three times.  Probably I should send an
>> alternate patch to get that sanity-check to run once, but I am also
>> not convinced the sanity-check is needed at all --- wouldn't any test
>> that is relying on output from test_terminal act as a sanity check for
>> it already?
>
> It didn't.  Or more precisely, Michael Haggerty ran into the behavior
> of
>
>   git rev-parse ... | while read sha; do git checkout $sha; make test; done
>
> couldn't make any sense of it, and reported it on IRC.  So in some
> sense, it took infrequent circumstances and two developers' time; next
> time around I'd prefer it to be detected automatically.
>
>> As an aside, I also still believe that running "git shortlog" without
>> explicitly passing "HEAD" when testing how it reacts to [core] pager
>> configuration was a bug and a distraction, hence the patch at [2].
>
> Why not.  Some other test should verify how shortlog reacts to the
> tty-ness of stdin, but that's yet another direction.
>
>> I also find Jeff's patch [3] appealing.
>
> Me too, though wonder whether feeding a file full of garbage wouldn't
> be better, so as to trip up commands that try to read only from a
> non-tty stdin.

Well, I guess I was too quick to pull the trigger after sending the
"What's cooking" out. Sorry about that.

On the other hand, I think these require relatively low impact changes
that can be handled in-tree and the downsides of the series like running
prerequisite tests more than once are not serious show stoppers, so it
isn't a disaster ;-)

Thanks both for noticing and commenting. Very much appreciated.
