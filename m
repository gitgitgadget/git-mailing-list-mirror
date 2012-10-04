From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull takes ~8 seconds on up-to-date Linux git tree
Date: Thu, 04 Oct 2012 12:36:38 -0700
Message-ID: <7vy5jmxc55.fsf@alter.siamese.dyndns.org>
References: <20121004141454.GA246@x4>
 <20121004184314.GA15389@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:55:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtgS-00033L-6d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756617Ab2JDTgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 15:36:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756432Ab2JDTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 15:36:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A3BD8306;
	Thu,  4 Oct 2012 15:36:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kIXzsxLbtrr8S9TVZI/Iiey2/e0=; b=dmaUlD
	VcFOJ+PzUfI9jwh4rTTBYkg/bzDKWnjYmn92287QhYy3y0brjQ/XBC7cY/20ZDJU
	QVqjfuX368Nlutg98+Yjiv1WiFj4yxOF6o6mQg61g5WNxULqUpBx4XoIdFAV5ohx
	5UkvDZjxfW8+i4Lwkd9Mrf0E1/B9UbIr1zkj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBa4hiTPH9vp3NHybUCNR/OdlU6tSbO2
	lJdir2sKgpjpYPFil7pR3ObEzdwU468gGvzWLxPa6BC0E8jEcsoQOTRRTK26dgXw
	rGHP/cT4nih23LzHgBwy44QL108rmAN25d3q8rEWO9gIm/0fr8+AdZ4KcYfQ4UtI
	eLqF9bR/5AU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5378D8305;
	Thu,  4 Oct 2012 15:36:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C076E8303; Thu,  4 Oct 2012
 15:36:40 -0400 (EDT)
In-Reply-To: <20121004184314.GA15389@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Oct 2012 14:43:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2058678-0E5A-11E2-B5FD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207032>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 04, 2012 at 04:14:54PM +0200, Markus Trippelsdorf wrote:
>
>> with current trunk I get the following on an up-to-date Linux tree:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  7.84s user 0.26s system 92% cpu 8.743 total
>> 
>> git version 1.7.12 is much quicker:
>> 
>> markus@x4 linux % time git pull
>> Already up-to-date.
>> git pull  0.10s user 0.02s system 16% cpu 0.740 total
>
> Yikes. I can easily reproduce here. Bisecting between master and
> v1.7.12 gives a curious result: the slowdown first occurs with the merge
> commit 34f5130 (Merge branch 'jc/merge-bases', 2012-09-11). But neither
> of its parents is slow. I don't see anything obviously suspect in the
> merge, though.

Thanks; we probably should revert the merge before the final and
handle the fallout later, unless we know why the integrated whole is
slower than its parts.
