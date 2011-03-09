From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Wed, 09 Mar 2011 11:27:56 -0800
Message-ID: <7v7hc8aybn.fsf@alter.siamese.dyndns.org>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <m2r5aibpsl.fsf@igel.home>
 <b98e837f-a0ae-4061-aa09-b4d30e3b0522@b13g2000prf.googlegroups.com>
 <7vr5ahe7jc.fsf@alter.siamese.dyndns.org>
 <5aad866e-38e6-4f0e-a942-97cc174651bb@o14g2000prb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 20:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxP3P-0004Rd-FO
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 20:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1CIT2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 14:28:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1CIT2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 14:28:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C7ED353C;
	Wed,  9 Mar 2011 14:29:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TX6CqPj6m/2NtVhlvulVCrjAVjo=; b=OPXyed
	6OxYmucTBgM6ysZxooEOElnTLGSEjXHhQjjiLg04IHAANYhN+odnppzwSP3uXuHb
	I7ngtI+jS0Q7L/EPEaIZash1SLespJDjaYwHvJYTedMSkxS3lgCV7BjvA3JTdvn2
	qrQ8czkN/Qb1xovOCMXLKAuWL1uatpbmmXBCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nD+QNMDLD6yX4K0UKkMJNXOmN6OEXZq/
	KxPCE6olLs9JE7UDZl3uoG9SwROAZxMjwHbd+QYYU5og4wp9YbxPqoisxt8q4F5L
	5S0Fe9xQNiYP+Hwktdm8SIjSbk7grKgaAwDdYqWAEiiuqzt3FdVReDcXqpnjfuO6
	yDBLucRJ4fo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0500F353A;
	Wed,  9 Mar 2011 14:29:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA6603538; Wed,  9 Mar 2011
 14:29:26 -0500 (EST)
In-Reply-To: <5aad866e-38e6-4f0e-a942-97cc174651bb@o14g2000prb.googlegroups.com> (Dun
 Peal's message of "Wed, 9 Mar 2011 10:38:17 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DAF73B8-4A83-11E0-887F-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168746>

Dun Peal <dunpealer@gmail.com> writes:

> All of our branches right now are feature branches of master, whose
> short lives end with a single merge back. Thus, merging back as a
> single patch implementing that single feature is ideal: the branch was
> only created to implement the feature, so by definition all of its
> individual commits are intermediary, and once the final feature state
> is achieved, the incremental steps leading to it are not interesting
> at all - they're just noise!

You sounds as if none of your developers make mistakes and your reviewers
are always so perfect that you have absolute confidence that all the
possible bugs are killed in these feature branches before they are merged
to the master.

That does not sound like a real world to me, though.  When a fix or tweak
is needed for codepaths introduced by these feature branches after they
are merged to master, the cleanest thing to do is to queue the fix on top
of the branch that needs that fix or tweak, and merge that to master.

Of course, you can choose to abandon these feature branches that are
potentially buggy and fork a fix branch from the master branch that was
current when the bug happened to be discovered.  But that would make the
backporting bugfixes (or feature tweaks for that matter) to anything older
a lot harder.

> Why would John care that while implementing feature X, Jill committed
> her half-state Y so she can go home, or made and fixed typo Z ?  In
> fact, why would Jill care a day, let a lone a couple of months, after
> X was completed and merged to master?

Who is merging half-state to 'master' or merging 'master' back to the
feature branches?  I don't think any of the above relates to the topic of
'merge --squash' anyway...
