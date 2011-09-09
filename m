From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Fri, 09 Sep 2011 10:32:21 -0700
Message-ID: <7v8vpxvcyi.fsf@alter.siamese.dyndns.org>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
 <20110908193555.GC16064@sigill.intra.peff.net>
 <7vy5xywyk8.fsf@alter.siamese.dyndns.org>
 <20110908210217.GA32522@sigill.intra.peff.net>
 <7v7h5iwub9.fsf@alter.siamese.dyndns.org>
 <20110909153441.GB28480@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R24wO-0003Mk-Mn
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759338Ab1IIRcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:32:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672Ab1IIRcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:32:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9BD558CC;
	Fri,  9 Sep 2011 13:32:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YF7NZPS9YpHLYm3ZNwR+ilU85o=; b=G0Viol
	8NjTBlBC0Zu3kPQlpO0Oi6ST2OBHx+x6zCIHGyfxaaBZfjIttMFFF9Cl5qZHnyxC
	PGyDuLEhTLksBlhs8tM65mD6RKlmi4qVWqY2qn9R72cjC2QgME5fE02ixt498n6g
	bopag4eoyw95pwXTpSRbxJqtRVpBQNhQj84yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lNCXt5oAxooTAY5Ik4p4w8brZh65mj8K
	5W7l7oC+RZhUc8RgmOCNmotOaXCqiPaNLaDY2997NIiZzpiG9VsxGeToGj4sFn42
	qFd4jvtqFhe2PDpU+St/tVwCvoTQBK7RfLSoy49aF48qDuWRB1NSdmdC4pLLRB3+
	Kun8Jhrfql8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B15A958CA;
	Fri,  9 Sep 2011 13:32:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3400958C9; Fri,  9 Sep 2011
 13:32:23 -0400 (EDT)
In-Reply-To: <20110909153441.GB28480@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Sep 2011 11:34:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD7210C2-DB09-11E0-8079-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181095>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 08, 2011 at 03:19:54PM -0700, Junio C Hamano wrote:
>
>> My take on it is somewhat different. The only thing in the end result we
>> want to see is that the pushed commits are annotated with GPG signatures
>> in the notes tree, and there is no reason for us to cast in stone that
>> there has to be any significance in the commit history of the notes tree.
>
> Hmm. Is order really irrelevant? If you push a commit to master, moving
> it from X to Y, then push-rewind it back to X, then push a new commit Z,
> how do I cryptographically determine the correct final state of master?

You don't, as the certs are more about "up to this point, the pusher
trusts the history". I should have made it clearer in the cover letter to
the rerolled series, but the push certificate does not record the old
value of the ref in the reroll, because the point of signed-push is not
about signing the information that is equivalent to the server side
reflog.

You would have a signed push record that pushed Y, X and Z, and commit Z
sitting at the tip of 'master'. A few days may pass and then you run

    $ git log --show-notes=refs/notes/push-signature master

to find that the first commit with a push signature by somebody whose
judgement you trust is Z. Then you would need to inspect only commits that
are not ancestors of Z even if you suspect that some commits near the tip
of 'master' at the server side were tampered with.

You may at the same time find commits signed by the trusted people that
are meant for the same branch but are not contained in the history of
'master' (e.g. Y), which might indicate that the branch was rewound,
possibly by an intruder.

Another possible scenario. Later you and the pusher of Z may find that
when the pusher created Z, he merged something questionable and Z may now
have to be in "untrustable" set. You can dig further to find X at that
point.

> OK, I see. It is not "the server can do whatever it likes with the
> information" as much as "the server can do whatever it likes, but at the
> very least should eventually create a notes tree of a given form".

Yes, examples of things the server side might want to additionally do in
pre-receive-signature hook are to read the push certificate to implement
authorization (and it can be per-branch if you wanted to) and to forward
it immediately to offsite storage for safekeeping (the storage does not
have to use git notes to implement it).
