From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add an example how to add ACKs to a range
 of commits
Date: Mon, 17 Aug 2009 16:12:42 -0700
Message-ID: <7v8whim3v9.fsf@alter.siamese.dyndns.org>
References: <cover.1250541493u.git.johannes.schindelin@gmx.de>
 <34cc046b42b5a67bb1c926709bcd1163d1d2faf6.1250541493u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:13:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBNs-00012x-Pz
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758315AbZHQXMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758290AbZHQXMz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:12:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277AbZHQXMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:12:54 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5743EFC2;
	Mon, 17 Aug 2009 19:12:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16699EFBA; Mon, 17 Aug
 2009 19:12:43 -0400 (EDT)
In-Reply-To: <34cc046b42b5a67bb1c926709bcd1163d1d2faf6.1250541493u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Mon\, 17 Aug 2009 22\:38\:46 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D5395FA-8B83-11DE-AA78-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126316>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When you have to add certain lines like ACKs (or for that matter,
> Signed-off-by:s) to a range of commits starting with HEAD, you might
> be tempted to use 'git rebase -i -10', but that is a waste of your
> time.

Cute.

In a case like this, I tend to just do:

    git checkout $(git merge-base master js/series)

    git format-patch --stdout master..js/series | git am -s

    git diff js/series
    git branch --with js/series
    git branch -f js/series

as the first step (checking out the base, detaching HEAD) and the last
group of steps (verifying what improvements I made while on detached HEAD,
checking what _other_ branches may need to be rebuilt, and actually
updating the branch) are very common for my every-day branch whipping
workflow, and the second case being the full "format-patch | am" is just a
special case of what I do regularly, e.g. cherry-picking, manually
fixing-up, etc.

Rebase -i is very nice if you need to dig deep but the change you make is
actually very limited.  Filter-branch is too automated and requires an
enormous amount of effort to do anything flexible.  Often I find myself
wanting to do something in the middle, and I end up doing the "detach at
the base and rebuild" procedure.

Will apply.  The hint is useful nevertheless.
