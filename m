From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Editing the root commit
Date: Fri, 22 Jun 2012 15:50:01 -0700
Message-ID: <7vhau3m06e.fsf@alter.siamese.dyndns.org>
References: <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com> <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com>
 <7vobobm3mi.fsf@alter.siamese.dyndns.org>
 <20120622220231.GG25478@arachsys.com> <20120622222633.GH25478@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:50:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiCgK-0001rB-In
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab2FVWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 18:50:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754395Ab2FVWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 18:50:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 770939836;
	Fri, 22 Jun 2012 18:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kzJlXDR344xsexTSgt2yMeWPCAw=; b=qZr/Sf
	5WmW1vnukxkFL0WPTmox60+Jd/PJ3CTa695y2iGC/tN55wR9Eq4ZsmegicEPotHY
	581uVc6/V+bmWFbnE39P4CR2uO3P3m/ZUoDDDdjOX9K9A+NHva0gJRkKixTsbQbH
	hylQbv4gE2UGHbUBEJn/x7dmXsZDZKbFdNUgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hG42WBQ8RGRhSvrYiwo5AjrlePbClZnm
	UefWVN2yB3199dQhPWNKZ2tYAGMuw5uTFUa8l8ZEc6kZV+0jrd0adaW/lE5hd8/u
	RVHbmCDKOteV5F3tXlv16MHCPgzVxc6OJo4nSbFPGR+dDZWQbymFBnUUyk/Uz/U3
	mSS1xVoudeQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6865F9835;
	Fri, 22 Jun 2012 18:50:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2C869834; Fri, 22 Jun 2012
 18:50:02 -0400 (EDT)
In-Reply-To: <20120622222633.GH25478@arachsys.com> (Chris Webb's message of
 "Fri, 22 Jun 2012 23:26:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A7024C4-BCBC-11E1-BA0A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200484>

Chris Webb <chris@arachsys.com> writes:

> Ignoring the implementation, I think the nastiest bit here is what happens
> for the user if there's a conflict, as Peff pointed out. Ideally, we want to
> checkout a state we're going to replay the patch onto, so that if we drop
> out because there's conflict (e.g. the patch modifies a file which doesn't
> exist yet), git diff and git diff --cached do something sensible.

Step back a bit.

If you are doing "rebase -i --root", what does it _mean_ to reorder
commits and move the root commit to somewhere else, or insert
something else that is _not_ the root to the beginning of the
sequence?

It does not make _any_ sense to me.  For one thing, the root commit
is to replay "addition of all these paths" to void (if you were doing
"rebase -i --root --onto $there", then $there may not be a void, but
it needs not to have overlapping paths for the result to make any
sense), and moving it to somewhere _other than_ the root location
does not make much sense.  For another, a non-root commit is mostly
replay "these changes to these existing paths", and replaying such a
change to a void does not make any sense either.

So in that sense, perhaps

	rebase -i --root

in a history

	A---B---C

should behave as if you did

	rebase -i A

got an insn sheet that looked like

	pick B
        pick C

and then you made it to look like

	exec false
        pick B
        pick C

to get the control back when the HEAD is detached at A, in order for
you to muck with the tree and "git commit --amend" to reword the
message.
