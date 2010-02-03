From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify git-mv behaviour wrt dirty files
Date: Wed, 03 Feb 2010 13:56:19 -0800
Message-ID: <7v3a1idlvg.fsf@alter.siamese.dyndns.org>
References: <ron1-A681F2.12340503022010@news.gmane.org>
 <c43166fa73391a40b43c27153ec142121fdb71d1.1265231310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Ron Garret <ron1@flownet.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Pete Harlan <pgit@pcharlan.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 03 22:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnDE-0007rL-QK
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 22:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881Ab0BCV4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 16:56:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657Ab0BCV4f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 16:56:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3F949676E;
	Wed,  3 Feb 2010 16:56:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9iv1n4578gRM0TkuOlmYFSBOHw8=; b=qV43Jx
	5UQiIqWiu1Yqd7G23aPif232ybKk8D38Aex4apE79QavCDinGgzo/BrW5QJA0jKx
	ubSS2R7dFamZHacRfMOAlpxbVoP7kMBvyjWN8Y/UmYiCDHEnLR2ET6Q+uV5nCs8D
	2a8Rs5ULBR42BDhPkhiMHwRQAKB3qIb5LEDUs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q5x9c0csyiXjxZnr7PET0D9I2YMd7NgI
	2QheOCYPcgrDGRAJIzDQcH/wo5ruQa05NlYbNIEt2edajD7QM9bkhHjNJOsBpkdc
	McQ7j57e4ipjn443LOB1ZuaYZb8wH1hmekfkbA8cnw11kkv6/dQU5eVitRczcKhJ
	1Ps+MClYoKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 714CC96766;
	Wed,  3 Feb 2010 16:56:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37D0F96759; Wed,  3 Feb
 2010 16:56:21 -0500 (EST)
In-Reply-To: <c43166fa73391a40b43c27153ec142121fdb71d1.1265231310.git.trast@student.ethz.ch> (Thomas Rast's message of "Wed\, 3 Feb 2010 22\:12\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA804724-110E-11DF-8557-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138905>

Thomas Rast <trast@student.ethz.ch> writes:

> Clearly point out that the rename happens separately for worktree and
> index.  This confused users, as they are apparently told that git-mv
> == git-rm && mv && git-add, which it is not.

I may be confused too as I had to read these three lines three times and I
do not think these two sentences mesh well together.

What happens with "git mv A B" is that it moves a work tree file A to B
and moves the index entry for A to B, hence all of:

 (1) the fact that you do not have A anymore;

 (2) the fact that you now have B instead; and

 (3) the fact that your work tree file B (which used to be A) has changes
     from its corresponding index entry

are _consistently_ kept between the work tree and the index.

I don't think "happens separately for" makes sense.  At best, it is an
implementation detail that doesn't help users understand what the command
does and what it is used for better.

Of course, it is different from

    "git rm -f --cached A && mv A B && git add B"

which would add changes that you were not prepared to add (i.e. you had
output from "git diff A" before you started).  I think that was a buggy
way old scripted version of "git mv" used to work, by the way.

> While there, move the synposis to the synopsis section, which so far
> was rather useless, and reword the first sentence to eliminate the
> mentions of 'script'.

That's a good change regardless.

> +For every renamed file or symlink, the worktree and index contents are
> +renamed separately, preserving both staged and unstaged changes....

I'd just say:

    While renaming paths, changes in the files in the work tree that you
    have not added are preserved.

> +....  You
> +will still have to commit the rename.

I don't understand why you want to say "You will still have to commit the
rename" here.  It is like saying in "git add" manpage that "You will still
have to commit the added contents" because "add" only affects the index
and does not make a commit.  Drop it.
