From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Thu, 30 Aug 2012 08:59:52 -0700
Message-ID: <7vfw74tlon.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
 <20120830033611.GA32268@sigill.intra.peff.net>
 <7vharlujaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:00:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T77A2-0007Q0-G6
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 18:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab2H3P74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 11:59:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab2H3P7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 11:59:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99C2777EA;
	Thu, 30 Aug 2012 11:59:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kgrqdXnSKfGQpIm/QQN5TRi/wbo=; b=NNu9/q
	sZwbBLBNVlWRNVKk9OI5LjJGFxeg/AKbqK5HwzhYdR5PPbvZ9CtPfQJ1EMSIMmxs
	q/Jr1/yJiflNl6yQ0SSiKc4YHkKrdICbZ/X3Fm+Vz4RxCUxY5apAjC70Drl7I/Ud
	J+5LgRSHZlCSHijTnWoUgZzwxYeXpRQPjmqDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mlo8dLM4dGlxqc7IHJ+pI+bhHYQOxXqM
	D6vdp7QFTjrvCnTrBwf3rypenWnIiwjc6Iz2QtQBbYq0okNqwU+N8m8+EADzmI1/
	4G/PLJvyuv452iOnJRpzXcVnCjpKzrhG3QUOAYxgCAB9lF0I9C4a1qo6vR6witXz
	7JkywyL5Bos=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8683C77E9;
	Thu, 30 Aug 2012 11:59:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FF377E8; Thu, 30 Aug 2012
 11:59:53 -0400 (EDT)
In-Reply-To: <7vharlujaq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 29 Aug 2012 20:53:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCDFEDB6-F2BB-11E1-AF8A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204543>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I wonder if you can
>> define the weight as a recursive function of the parents.
>
> I do not think we can.  A merge Z between X (that has N commits
> behind it) and Y (that has M commits behind it) has at most N+M+1
> commits behind it (counting itself), but we cannot tell how many
> among these N and M are shared.

You can theoretically take all the merge bases between X and Y,
magically come up with the "weight" of a fictitious merge across
these merge bases, and subtract that number from N+M to arrive at
the weight of Z, I suppose, but it is not clear what an efficient
implementation of that "magically" part looks like.  I think that is
where we stopped when we tried to optimize the "rev-list --bisect"
node weighting logic; it punts handling the merges, and only
optimizes single strand of pearls on top of a merge with a known
weight.
