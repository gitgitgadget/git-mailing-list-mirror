From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Documentation: warn prominently against merging
 with dirty trees
Date: Sat, 09 Jan 2010 22:31:36 -0800
Message-ID: <7vskaefp2v.fsf@alter.siamese.dyndns.org>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch> <20100110044949.GA8974@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 07:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTrLG-0002Xm-9W
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 07:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab0AJGbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 01:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035Ab0AJGbu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 01:31:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0AJGbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 01:31:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 786778F38F;
	Sun, 10 Jan 2010 01:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Q5wty19v7DkOT8ub/ym8bR4A0Kw=; b=vHCd+g5bA1RYMeECGiF+58c
	oj5XEmxZCZRKHlkK9vDlKpf0P0i1CKqy5i0HsiTpH0/N2k9q8Hru8Yc7ZPLjHodn
	c6shmpmjtTL6KHS21PoDEauJaAkITJ1qYt4pBCqlxDYw0UC0pHyrZQ1ZpssTevWh
	N6Ju1/DvheABdmd0XYeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Hhi2M20z6Y/7ZC+zY0u+nBsDaQylXWK5S3EGxmpgC4tuwiF6g
	XVVCWOG/ytYxodSAzUEnBRgXlnnADcZ7i9YDWxqkv3vL/OPenpA+buNSyPLYJf2S
	emcYxn9a6hk8rtuqNxYXdgoyTbKkWzRVZNt6vk61RJZVhhAGOIpX0nIXSs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EB718F387;
	Sun, 10 Jan 2010 01:31:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61D558F385; Sun, 10 Jan
 2010 01:31:38 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D16BC7AC-FDB1-11DE-A709-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136557>

Jonathan Nieder <jrnieder@gmail.com> writes:

> |     1. Even if you may have local modifications in your working tree, you
> |     can safely say "git pull" when you know that the change in the other
> |     branch does not overlap with them.
> |     2. After inspecting the result of the merge, you may find that the
> |     change in the other branch is unsatisfactory. Running "git reset
> |     --hard ORIG_HEAD" will let you go back to where you were, but it will
> |     discard your local changes, which you do not want. "git reset --merge"
> |     keeps your local changes.
>
>> while possible, it leaves you in a state that is hard to
>> +back out of in the case of a conflict.
>> +
>
> Oh, that is a problem.  Maybe 'git merge' should refuse to merge
> unless told otherwise, if there is a dirty index and there might be
> conflicts.

"git reset --merge" will keep your local changes after such a merge, and
"mergy" operations (not just "merge" but also "revert", "am -3", etc)
won't get you into a situation where you cannot, by refusing to do
anything when e.g. your index is dirty.  Especially when Christian's
"reset --merge" update becomes solid, "... is hard to back out of" will
become a false statement.

Of course, the user needs to understand what he or she is doing (see
http://thread.gmane.org/gmane.comp.version-control.git/136166/focus=136171
for example).  And that is one reason we (at least I) try to teach new
people to start working from a clean tree, until they get comfortable
working with mergy operations.
