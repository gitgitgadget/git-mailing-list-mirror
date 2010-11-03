From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch -v not at all verbose?
Date: Wed, 03 Nov 2010 09:14:05 -0700
Message-ID: <7vwrouxu42.fsf@alter.siamese.dyndns.org>
References: <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
 <20100121224100.624c9c9d.rctay89@gmail.com>
 <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org>
 <20100121161016.GA16300@redhat.com> <20100121161858.GC19078@spearce.org>
 <20100121163518.GA16466@redhat.com> <20100121165737.GG19078@spearce.org>
 <7v8wbrtkvn.fsf@alter.siamese.dyndns.org> <20101103095249.GA9144@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 17:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDfyh-0005jk-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab0KCQOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:14:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab0KCQOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:14:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 981701566;
	Wed,  3 Nov 2010 12:14:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+BH9z0mYJDSP2iClugZ4mDrOL7E=; b=T2yjTu
	Qmqzny1YaefsW+iCmOIitv56xDlyAMl2jGwKe4ukVsPsyT4M6f7NNo8/mEgWCtWU
	A5EV4bfvYoJSHurnJ16nwzaqfM8VKz6hKlCQtU1HuJ32z4/kU+s0/9i63w3og3wb
	fq5Z7VtM5K7awQ0kDhfqtdjszL6+7IFLF3tg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJQ2JdgeS4OPF/0dgQfSHSstG6SfY0y4
	EQA/uL2torDLfEIGI16m0cv0TPWjLsb5ovbdDaCpfjQA6ZV3O6BpxPLgc0SKtcvo
	lzadqUpDmxHr9bxAgkeGsv0rGRgKi5a9Kar2WzuMGts0+BnSD234wwAzj9GEgADs
	K82UR0OQwq8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 670A91561;
	Wed,  3 Nov 2010 12:14:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BD6A155C; Wed,  3 Nov
 2010 12:14:07 -0400 (EDT)
In-Reply-To: <20101103095249.GA9144@redhat.com> (Michael S. Tsirkin's message
 of "Wed\, 3 Nov 2010 11\:52\:49 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 64D6F546-E765-11DF-95A6-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160606>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jan 21, 2010 at 09:42:36AM -0800, Junio C Hamano wrote:
> ...
>> There was a discussion about updating the commit walk exchange to bisect
>> the history (skip and try a much older one to see if it is reachable, but
>> to avoid overshooting, step back and see if a newer one is still common).
>> It would be a lot more work and needs to be implemented as a new protocol
>> capability, but I think it is the right way to go in the longer term.
>
> I thought about this some more: it seems that nothing in
> pack-protocol.txt dictates that client has to send have
> lines in order. The whole logic would be on client side.

The current protocol may not require any order for it to function
correctly in the sense that the sent pack will contain everything that is
necessary, but it does require that commits on a lineage to be sent from
near tip to near root if you want to have a _good_ common ancestor to be
found.

If the downloader sends older commits first without sending some new ones,
the uploader can say "Ok, I know about that old one you told me you have,
so we could use that as a common commit" [*1*].  But there is no way for
it to continue the sentence with "... but I cannot tell if other ones you
told me you have that I know nothing about are all directly connected to
that common one we just found (in which case that common one is the best
we can do), or you have newer ones than the common commit that I also have
but you omitted from the listing (in other words, if you didn't omit them,
we could have found a better common commit).  Could you please back up a
bit and let us see if we can do better with newer ones?" with the current
protocol exchange.

The downloader _could_, upon seeing an ACK to a commit that is an ancestor
of commits that it skipped, try sending these skipped commits, without
telling the uploader that it what it is doing.  But the uploader will
unilaterally decide when it thinks it has heard enough, after giving an
ACK back in the original protocol, or after finding enough common
ancestors to cover all the tips requested with WANTs, so I suspect that
you may not have a chance to play such a game without an explicit protocol
extension.


[Footnote]

*1* That is what an ACK means.  In an multi-ack exchange, it also tells
the downloader there is no point to give any ancestors of that commit, but
allows the downloader to continue sending commits from other lineage.
