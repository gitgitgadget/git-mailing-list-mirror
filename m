From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] reset: do not accept a mixed reset in a .git dir
Date: Tue, 15 Dec 2009 12:17:42 -0800
Message-ID: <7vskbcyot5.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.98779.chriscool@tuxfamily.org>
 <7vtyvvn9wx.fsf@alter.siamese.dyndns.org>
 <200912152041.36194.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 21:18:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKdqb-000392-Qq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 21:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbZLOUSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 15:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbZLOUSL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 15:18:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933190AbZLOUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 15:18:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E0DBA710E;
	Tue, 15 Dec 2009 15:18:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yzrQfvHIH3I1qYr0QV0zNar5WPQ=; b=QFLPIH
	aeRCLSmye5OLTp0vhA9jGc+khL4nU/PW5OqkoLd4PdLCuJvoScg2RYfBv3RKxjfr
	om22gMQ/fJnYMoHvljhhH/zc36LXYAhQia0F8vpeMehkVaR8LlciR/Yig5ZgYFdn
	NfohBB9qoPiOirdxhc6IJ4MVlzOhoSSye+JfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhXLvmdYxE9MdjLxCkQyVFRGbPQLfJbm
	5LraYx0/rBnfYf9IRYL5+NXvHNqR9NNoyzbiYb0Dh+TIp8gYb9BKN6vbfgBcvbq+
	ku1YLoxY/F/aVaVA6icevedMxl4Ece4My5BKoPN7e4GmKVrK9fNE/DcVCwji/CCx
	U9d1E025yHQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AEBCA7104;
	Tue, 15 Dec 2009 15:17:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 447E9A70FA; Tue, 15 Dec 2009
 15:17:44 -0500 (EST)
In-Reply-To: <200912152041.36194.chriscool@tuxfamily.org> (Christian Couder's
 message of "Tue\, 15 Dec 2009 20\:41\:35 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF4F090A-E9B6-11DE-84C7-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135297>

Christian Couder <chriscool@tuxfamily.org> writes:

>     This patch is also needed to speed up "git reset" by using
>     unpack_tree() directly (instead of execing "git read-tree"). A
>     following patch will do just that.

This still doesn't seem to explain anything that the part you added after
your patch.

>     While at it, instead of disallowing "git reset --option" outside
>     a work tree only when option is "hard" or "merge", we now disallow
>     it except when option is "soft" or "mixed", as it is safer if we
>     ever add options to "git reset".

I fail to see any sane logic behind this reasoning; you cannot decide if
you need to allow or disallow the new --option with unspecified semantics
until you have that --option, and you are saying 

Hmm, "reset --option" that does not work when it should work is a bug,
just like "reset --option" that does not refuse to work when it should
refuse is, and you cannot decide if you should allow a new --option until
you have it.  Your "disallowing everything the code does not know about by
default" doesn't particularly sound safer to me.  I'd suggest dropping it
from this patch.

It is perfectly fine to have a change like that, if it makes the logic
easier to follow with the updated repertoire when a new --option is added,
but not before.

>> An honest justification might have been "This change to disallow a mixed
>> reset in $GIT_DIR of a repository with a work tree will break existing
>> scripts, but I think it is not widely used _for such and such reasons_,
>> and can easily be worked around.  On the other hand, this change vastly
>> simplifies the reimplementation of 'reset' _because X and Y and Z_".
>
> My opinion is that it works this way just by accident not by design (that's 
> why I said "fragile").

And do you still think it is accident after I explained the difference
between the two for you (or perhaps you didn't read it)?

>> > This patch is also needed to speed up "git reset" by using
>> > unpack_tree() directly (instead of execing "git read-tree").
>>
>> It is very unclear _why_ it is "needed" from this description.
>
> The reason is that after the next patch, it will not fail in a bare 
> repository,...

That sounds as if you want to change the definition of what the expected
behaviour is early, because you want to claim a regression you will later
introduce is not a regression.  I hope that is not the case.
