From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 15:46:50 -0800
Message-ID: <7vr5ps5jx1.fsf@alter.siamese.dyndns.org>
References: <op.u6g8jnixg402ra@nb-04>
 <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com>
 <20100114070316.GC1528@rm.endoftheinternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Rudolf Polzer <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 00:47:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZPH-0005zW-0x
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 00:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757771Ab0ANXrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 18:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757763Ab0ANXrH
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 18:47:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754Ab0ANXrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 18:47:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 513EA91115;
	Thu, 14 Jan 2010 18:46:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+UqeCBH8FwnyhQb0PQ48QlgH6w=; b=Mzqs/f
	irNgQ+5+zoL6hSQ0LuaOBCUvwxotsYfrXVqEZ5ac6cOox9xdMFzorb6DvuoOBo/f
	0xx5BpRulbwK88GqSfQruV0Tcl8OOcsdyWYtuBIWInY92wvuBzW2dQjyjofik2Fj
	8Hzq/pH9sMU2PGX4eM+iMGMdfmhNHu5z3wbXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b6gK+OIguMRSMeVulKn6IIDF2hRGr1EX
	3rCHnArRu175es6SEu3hyMRLO1nLhaZp+jtUPsDrpbG9V8k7zKPai5lhp1s/2Eh1
	R3M4ldo0VAp1PC3hCE7V/y+PFcT2QZid8TrBYpDJmzI2BTmjwtJCOdZ3ed10RFku
	a9EQXULKvnk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20B0D91114;
	Thu, 14 Jan 2010 18:46:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50DA691113; Thu, 14 Jan
 2010 18:46:52 -0500 (EST)
In-Reply-To: <20100114070316.GC1528@rm.endoftheinternet.org> (Rudolf Polzer's
 message of "Thu\, 14 Jan 2010 08\:03\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 193BD244-0167-11DF-9594-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137040>

Rudolf Polzer <divVerent@alientrap.org> writes:

> On Thu, Jan 14, 2010 at 09:27:26AM +0800, Tay Ray Chuan wrote:
>> before I put up my comments on the patch, I wonder if git-push is the
>> best place to add this feature, as git-push usually deals with
>> "pushing" data to another repo.
>> 
>> I think git-branch would be a better place to do this.
>
> I think git-branch can already do this: after pushing, you can do git
> branch -f --track origin/mybranch.
>
> But the goal of this is to postponing the decision to track to the push time,
> and adding as little as possible extra commands/options to do this.

Thinking about this again (when was the last time we discussed it?), I
like the "git branch -f" suggestion (modulo one small nit).  

Yes, "push --track" lets you postpone the decision; branching, working on
it, pushing it out _and_ _then_ using your "branch -f" trick will let you
postpone the decision even further.  And it doesn't add --track to the UI.

The small nit is that "branch -f --track me origin/me" will happily
overwrite "me", even when your "me" is not up to date with "origin/me",
losing commits.

Perhaps we could teach "branch --track me origin/me" (i.e. no "-f") not to
barf even when "me" exists, as long as "me" is a subset of "origin/me",
and treat it as a request to re-configure the upstream information for the
existing branch "me" and at the same time fast-forward it to "origin/me"?
