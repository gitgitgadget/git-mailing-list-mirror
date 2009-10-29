From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 06/26] Add multi_ack_detailed capability to
 fetch-pack/upload-pack
Date: Wed, 28 Oct 2009 22:57:01 -0700
Message-ID: <7v4opibv4i.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-7-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 06:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3O0d-0006Xj-Kg
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 06:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbZJ2F5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 01:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756327AbZJ2F5I
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 01:57:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbZJ2F5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 01:57:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7257B8A09E;
	Thu, 29 Oct 2009 01:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AWO7fbPzsMTEKkDLoT/K2B5+jng=; b=pjcADI
	p1a6wxqNEUPUtKmFAxT+3ivVHvD6NYIk6hvMfp13ter4M4eN+Css39V+4i9J1SVe
	B+4tWygrqV7K0YbWIS66Pm7d6UzZob0/wEHqNa8LKjSEOePezp6QL96IWR38OJvk
	W9io0FBNp0SRUn3b6gRu0DIV68glYhp5uyI6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ECbEYxGDbOeI+oDON8aT5dsIC6KjU7D3
	jeQKA+ZI2peFz6V4UhGK07UR6py+AGrn8DORe+pcCjEcS5Js+T6DEcyYFP3TXF7n
	OjnQ2A9eFlJ/HnvWBovNqIkLmQGRT8F1x1vVjeUEaP7zJq+3OSY30+2hfNU/MIIK
	AAbojPufH28=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F40F8A09D;
	Thu, 29 Oct 2009 01:57:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 146D38A09C; Thu, 29 Oct 2009
 01:57:04 -0400 (EDT)
In-Reply-To: <1256774448-7625-7-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Wed\, 28 Oct 2009 17\:00\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E47E1EBC-C44F-11DE-B0D6-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131554>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> ACK %s
> -----------------------------------
>   * no multi_ack or multi_ack_detailed:
>
>     Sent in response to "have" when the object exists on the remote
>     side and is therefore an object in common between the peers.
>     The argument is the SHA-1 of the common object.

Do you mean by "exists" something a bit stronger than that, namely, it
exists and everything reachable from it also exists, right?

> ACK %s common
> -----------------------------------
>   * multi_ack_detailed only:
>
>     Sent in response to "have".  Both sides have this object.
>     Like with "ACK %s continue" above the client should stop
>     sending have lines reachable for objects from the argument.
>
> ACK %s ready
> -----------------------------------
>   * multi_ack_detailed only:
>
>     Sent in response to "have".
>
>     The client should stop transmitting objects which are reachable
>     from the argument, and send "done" soon to get the objects.
>
>     If the remote side has the specified object, it should
>     first send an "ACK %s common" message prior to sending
>     "ACK %s ready".
>
>     Clients may still submit additional "have" lines if there are
>     more side branches for the client to explore that might be added
>     to the common set and reduce the number of objects to transfer.

I do not understand this after reading it three times.  The remote side
says "ACK $it common", allow the requestor to feed more "have", then
eventually send an "ACK $it ready" for the same object it earlier sent
"common" for?  The first one tells the requestor not to go down the path
from $it further, so presumably all the "have"s that come after it will be
about different ancestry paths.

What is the advantage of using this?  In other words, how, in what
situation and why would the remote side choose to use "ready" --- it looks
to me that it could always say "common" whenever it hits a "have" that it
can determine to be common.
