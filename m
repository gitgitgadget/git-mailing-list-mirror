From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/5] reset: add option "--keep" to "git reset"
Date: Sat, 02 Jan 2010 11:50:59 -0800
Message-ID: <7viqbk8evw.fsf@alter.siamese.dyndns.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
 <20100102053934.30066.85625.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRA0Y-0007ou-J1
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 20:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab0ABTv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 14:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416Ab0ABTv0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 14:51:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0ABTvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 14:51:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 30686AC00B;
	Sat,  2 Jan 2010 14:51:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qsvQeI3OggxYV7ApPCV3p1kJ6FU=; b=U8uK2HexM//UXjf1h72o9GY
	I+IfHKPXeFPh54vvyRvo2bsSrW+ln8KVWABJSQIUWpa1hk/725bTJsm3X1JZxP4/
	TSXOfQ9ZoEmH5oVu6ohPpeatOcqZjfUDpSs7kxnFz7M+nqUSJhkMDYO3GlQjOuVn
	TcO01khXcHsihn5EZXtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=UxBLDzq8HU5F4v+HouKGaVQl+1RoaR1P+wFrcur7cCv812MKY
	vTlTFHYg/Hq6tsfb6MAZbPeCHaRMU4lEtvfoILByXuvXAlJG5sBdgsODE+qLedCO
	v6cEortBBPc296PhhYw4fE0aZp+VoC2dMn1PUuJ64g0L+xtSDPCtbTbbW8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 869EEAC009;
	Sat,  2 Jan 2010 14:51:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A0EBAC008; Sat,  2 Jan 2010
 14:51:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F384340-F7D8-11DE-87F6-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136043>

Christian Couder <chriscool@tuxfamily.org> writes:

> The purpose of this new option is to discard some of the last commits
> but to keep current changes in the work tree.
>
> The use case is when you work on something and commit that work. And
> then you work on something else that touches other files, but you don't
> commit it yet. Then you realize that what you commited when you worked
> on the first thing is not good or belongs to another branch.
>
> So you want to get rid of the previous commits (at least in the current
> branch) but you want to make sure that you keep the changes you have in
> the work tree. And you are pretty sure that your changes are independent
> from what you previously commited, so you don't want the reset to
> succeed if the previous commits changed a file that you also changed in
> your work tree.
>
> The table below shows what happens when running "git reset --option
> target" to reset the HEAD to another commit (as a special case "target"
> could be the same as HEAD) in the cases where "--merge" and "--keep"
> behave differently.

I think this new option is unrelated to "--merge"; iow, the only relation
to it is that it is an option to the same command "git reset", so it is
related but it is related the same way and to the degree as "--mixed" is.

Thinking about it even more, if the number of commits you are resetting
away is zero in your use case (i.e. target is HEAD), shouldn't this new
mode of operation degenerate to "--mixed"?  So in that sense, it might
make sense to contrast it with "--mixed".

But let's try not to contrast it with anything else, and see how well it
stands on its own.  The below is my attempt.

> working index HEAD target         working index HEAD
> ----------------------------------------------------
>   A      B     C     D   --keep    (disallowed)
>   A      B     C     C   --keep     A      C     C
>   B      B     C     D   --keep    (disallowed)
>   B      B     C     C   --keep     B      C     C

Let's give an explanation of the above in terms of what this means to the
end users.

    When you have changes to a path that the accumulated commits between
    target..HEAD touch, you don't want to discard them.  It doesn't matter
    if the changes in the work tree has been partially added (A != B) or
    fully added (A == B) to the index.  In both cases, the operation is
    disallowed, just like "checkout $another_branch" stops in such a case.

    But if you have local modifications based on one version and dropping
    the accumulated commits between target..HEAD does not involve that
    path, we can safely "transplant" that change to the target.

Presented this way, a future direction (iow, I am not suggesting you to do
this before the current series solidifies) might be to allow users to do
something similar to "checkout -m $the_other_branch".  IOW, instead of
disallowing "I have changed from C to B and switching to D" case, perform
a three-way merge to bring the work tree file to (D+(B-C)), transplanting
the local change you made on top of the target.

> The following table shows what happens on unmerged entries:
>
> working index HEAD target         working index HEAD
> ----------------------------------------------------
>  X       U     A    B     --keep  (disallowed)
>  X       U     A    A     --keep   X       A     A

In a sense, this is consistent with the above; the local change attempted
happens to be an unmerged result.

But it is inconsistent with the intended use case you presented, which
leaves no room for unmerged entries to enter in the index to begin with.
It might be safer to error out on any unmerged entry in the index.  I
dunno.
