From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 00:16:58 -0700
Message-ID: <7vljjf226t.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910122340.13366.trast@student.ethz.ch>
 <7vr5t89qiw.fsf@alter.siamese.dyndns.org>
 <200910130836.57011.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxbg4-0001jz-5z
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 09:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933605AbZJMHSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 03:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbZJMHSD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 03:18:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933287AbZJMHSC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 03:18:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8A7F5623A;
	Tue, 13 Oct 2009 03:17:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cl97gtiIImVae3HfaNgaRSh+8mI=; b=mb0G0/
	duA8SVCw8B1bpWpvZicSVkcHzxPaurWZf4jo9Hg3f6BqHCUIb38BDf1M6RQPdDeZ
	EWXaOt6Nrx1/FWLrJlr+qVMn4DC7/eARGQIkfwfx2Kz70/LiHW58W3ydPbssg41P
	dHRBeIQv14MIS/hftKp0UrcYOMU0zxUTwOZ8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uRso/mUcZFtQFRcmWdDj7mOOhZ/TE12w
	PatK31xEmML/f2Dr8POOMHW2Bog3/XwzO8/JcTPwzTMJnBNOR5kqHDH2TZTXtnhP
	XanZJjliFpGyTzuBHdYd0sz5C9b5ONnZGedExz7IbwOMHjPx55tz7IJOfZl6jg8/
	UV1EXGOFC9c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B6956239;
	Tue, 13 Oct 2009 03:17:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A77A56237; Tue, 13 Oct
 2009 03:17:00 -0400 (EDT)
In-Reply-To: <200910130836.57011.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 13 Oct 2009 08\:36\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B9C568C-B7C8-11DE-83A3-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130136>

Thomas Rast <trast@student.ethz.ch> writes:

>> Or can't you go the other way, say
>> 
>> 	git checkout -t $remote_tracking
>> 
>> to create a local branch forking from the named remote tracking branch?
>
> Sure, but we already have that and we still failed to fix the users,
> so FWIW, I think Dscho's right and we should try fixing the UI next.

What it means is that -t was a broken attempt to help the users at the UI
level, and I can surely see that.

So we need the set of new rules, say, for 1.7.0 release.  A strawman?

Assume that these are the only refs that exist:

    refs/remotes/origin/{master,next,nitfol}
    refs/remotes/xyzzy/{frotz,nitfol}
    refs/heads/master
    refs/tags/v1.0.0

#0. These will stay as is:

 $ git checkout mine               ;# switches to the branch
 $ git checkout $any_committish^0  ;# detaches

#1. These used to detach, but will create a local branch

 $ git checkout origin/next        ;# as if with -t
 $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)

#2. These are allowed only when unambiguous and there is no local branch yet.

 $ git checkout next               ;# ok
 $ git checkout frotz              ;# ok (origin is not special)
 $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)

#3. These used to detach, but what should we do?

 $ git checkout v1.0.0             ;# detach, or refuse???
 $ git checkout origin/master      ;# detach, or refuse???

I can buy 0, 1, and 2, and I think it is a minor inconvenience if we
started refusing to detach in case #3, as people who want to detach can
always suffix ^0 or ~0 to make it a general committish.

Did I cover all cases?
