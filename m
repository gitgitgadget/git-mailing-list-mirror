From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I specify a revision for "git blame" by date?
Date: Fri, 15 Jun 2012 08:53:25 -0700
Message-ID: <7vsjdwbmh6.fsf@alter.siamese.dyndns.org>
References: <4fda029d.g99uVull9jgguc/Y%perryh@pluto.rain.com>
 <877gva1a4b.fsf@thomas.inf.ethz.ch>
 <4fdb326f.WB/xRjZx4pXtMhhZ%perryh@pluto.rain.com>
 <20120615150107.GA4572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: perryh@pluto.rain.com, trast@student.ethz.ch, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:53:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfYq4-0007OO-Vk
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 17:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334Ab2FOPx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 11:53:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932218Ab2FOPx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 11:53:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17D2190CD;
	Fri, 15 Jun 2012 11:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GZb48vyiKlxXofrKBuoN3FxMFQk=; b=OPvAwk
	H65J194OG49XgUMl/cn3jiBbWaY33bYF5QNo5bcq3zIchiXNw42qiollmbQqPGoV
	4+eAOCP59vwgk/TPKAioaqJ7zHxJrtEDd+m1+hr/qnOkRGOslfHTUQWKnRcRgOnI
	2AAf7R7RqWKZSDjIMWwVXEinZ9uuu2j4D29YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UEq675fW/jILImxL/DradjEpWr5ed+H5
	/b9B2aK1LsgvLgQQrJjOgaHDmEapwHeXcq+Swaiz7+FKsZIw5NN048PXaES1hjb/
	cI4qEG6Anjcp4IrvSBK7FERvOWN61pxs/EqCkVsJE8zMIFO3ZgSVF6+RK1qwyLh4
	ngmmNwqnpTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E8E190CC;
	Fri, 15 Jun 2012 11:53:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C27A090CB; Fri, 15 Jun 2012
 11:53:26 -0400 (EDT)
In-Reply-To: <20120615150107.GA4572@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 15 Jun 2012 11:01:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3EBAD60C-B702-11E1-93C4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200063>

Jeff King <peff@peff.net> writes:

> But that still doesn't address the issue that (a) is not well-defined.
> Imagine I have this history:
>
>   A--B--C---G--H
>    \       /
>     D--E--F
>
> that is, two lines of development splitting at A and merging at H. And
> imagine the commit timestamps are (let's just refer to them as integers
> for the sake of simplicity, but they are representing days or seconds or
> whatever):
>
>   A(1)--B(2)--C(3)--G(7)--H(8)
>    \               /
>     D(2)--E(4)--F(6)
>
> What does it mean to ask for the commit at time=5?
> ...
> Git-blame expects you to give it a well-defined point (as it must, since
> it is a backwards walk down history showing what led to a particular set
> of content; it wouldn't make sense to feed it multiple starting points).
> You could do so by asking rev-list to walk the graph according to your
> requirements and feeding the result to blame, like:
>
>   # most recent on any line of development that is merged to HEAD
>   git blame `git rev-list -1 --until=5 HEAD`
>
>   # most recent on any line of development in the whole repo
>   git blame `git rev-list -1 --until=5 --all`
>
>   # most recent version on the first-parent; if you follow a
>   # topic-branch workflow and always merge up into "master", then this
>   # will blame what was on master at time=5
>   git blame `git rev-list -1 --until=5 --first-parent HEAD`

Very well explained.  Thanks.

The short answer to the question on "Subject:" line is "You don't".
