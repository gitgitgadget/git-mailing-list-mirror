From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 09:42:36 -0800
Message-ID: <7v8wbrtkvn.fsf@alter.siamese.dyndns.org>
References: <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
 <20100121155136.17b59e8f.rctay89@gmail.com>
 <20100121140054.GH18213@onerussian.com>
 <20100121224100.624c9c9d.rctay89@gmail.com>
 <20100121155637.GA19078@spearce.org> <20100121160707.GA31276@glandium.org>
 <20100121161016.GA16300@redhat.com> <20100121161858.GC19078@spearce.org>
 <20100121163518.GA16466@redhat.com> <20100121165737.GG19078@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:42:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY13Y-0002Fx-UG
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab0AURmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900Ab0AURmt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:42:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0AURms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:42:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4562693D5A;
	Thu, 21 Jan 2010 12:42:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m79k0qIkDmUhndWa1T33Hx8nf/k=; b=vWIL/S
	WpxRRA8ihiLC+Sx5M7n5z2c4pWjpKP78bdxwwUONcuP3H9MgaZRlO/OVl8NSqxhY
	wVB/SHbU3I+A8LgFHOcfAFjZrmqTmzaFr90FiU6lqEtBrmweV+NGGkiz6tS9/Bjh
	t80cQJCE2AQoMZAxUXHTphYrkd+Fn3KwGF7Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7ttYB/Wx+RaGAabOWnOrx9TiIQCh/W6
	hYQ6b1R+GzTErY6EKUUkeVedtHO6uOZOgVxsy6x7E6MNki+ohFgwv3E5ino1odgD
	6AiJo2GppdDDGWRZZRDV96OOzDzw4ZQTGH0bVBk16hVrPfeNWIOMDaZiPw1x47po
	pX36GKhYF6w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EFB693D58;
	Thu, 21 Jan 2010 12:42:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2235393D56; Thu, 21 Jan
 2010 12:42:37 -0500 (EST)
In-Reply-To: <20100121165737.GG19078@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 21 Jan 2010 08\:57\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6015CC22-06B4-11DF-9D0E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137676>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> > Are you fetching from a configured remote that has tracking branches,
>> > or are you fetching through a one-shot URL pasted onto the command
>> > line?
>> 
>> Configured remote.
>
> Hmm.  I wonder if we should try to shortcut the commit walking in
> a case like this and just feed the tracking branches we already have.

You mean that the main culprit is the presense of thousdands of commits
that fetcher has obtained through the other remotes (and his own) that the
uploader makes fetcher walk all the way, in the false hope that there
might be a commit among them that is closer to the commits being fetched
than the ones at the tip of tracking branch the fetcher has for this
uploader currently?

And the solution might be to tell only about the tips of remote tracking
branches fetcher has obtained from this particular uploader, not about
other remote tracking bracnesh it got from others or his own local
branches (which may have merged from other remotes)?

It is a clever idea but I suspect it may not work well in practice.  For
example, suppose a project is two-tier, say, with top-level and subsystem
repositories, the former of which regularly merge from the latter, and you
are a participant primarily working on the subsystem.  You fetch daily
from the subsystem repository, but weekly from the top-level.

Now, when you fetch from the top-level, the remote tracking refs you have
for it are much more stale than your other refs.  The top-level would have
acquired a lot more commits from the same subsystem repository since you
fetched from there the last time, and you already have many of them
through your daily fetch from the subsystem repository.  To minimize the
transfer in such a case, the fetcher does want to tell the uploader that
it has those commits from the same subsystem repository, so that the
commit walker can stop at a recent merge into the top-level from the
subsystem repository.

There was a discussion about updating the commit walk exchange to bisect
the history (skip and try a much older one to see if it is reachable, but
to avoid overshooting, step back and see if a newer one is still common).
It would be a lot more work and needs to be implemented as a new protocol
capability, but I think it is the right way to go in the longer term.
