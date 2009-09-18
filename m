From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge ignores --no-commit in fast-forward case
Date: Fri, 18 Sep 2009 16:05:59 -0700
Message-ID: <7viqff97l4.fsf@alter.siamese.dyndns.org>
References: <20090918194717.GA18999@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 01:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MomWu-0006Rz-Vh
	for gcvg-git-2@lo.gmane.org; Sat, 19 Sep 2009 01:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843AbZIRXGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 19:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758496AbZIRXGF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 19:06:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791AbZIRXGE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 19:06:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ACB9056516;
	Fri, 18 Sep 2009 19:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3FAbYN232Nxv5pv1lxJHOyuXPdI=; b=Cl9X80
	IE4vKMQ6LpdQJn2ycaLbv6tDiB6Ra/jtab/lNlsh+1yAhLCICjT7LeSi0oz1yLvg
	R5IieUBmjhxCuNa5JC56pswgxDXyxim1mo6sDPOdgLs+RH/V7w8AypyKaac/q2wX
	t1ec9NaIOi+GbX9eGiqXYkRKzfl4IP9Ty3JlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lvA1iWBNtd80V1Tu8M340vBK4Draws7Z
	1PrgHUIVQ//A3YVOoopAWxtf/oUG4zvzUvhvNtYkLM0o9X7zoPYSJ23H0FAlvFSc
	aqL8OYES1YhWAzjABneXxYYok8Nu5S/w7Vmmv3k7fyWnBPBc17nqPc31BkfvPzSU
	AG+OE54MMBg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FBFD56515;
	Fri, 18 Sep 2009 19:06:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 52E6656514; Fri, 18 Sep 2009
 19:06:00 -0400 (EDT)
In-Reply-To: <20090918194717.GA18999@dr-wily.mit.edu> (Greg Price's message
 of "Fri\, 18 Sep 2009 15\:47\:18 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D73F3258-A4A7-11DE-B31D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128815>

Greg Price <price@ksplice.com> writes:

> Suppose we were to make such a change in 1.7.0 or a later version.
> What would the transition plan need to accomplish?  For instance,
> we could print a warning every time 'merge --no-commit' does a
> fast-forward, and make the change in a later version -- might that
> suffice?

I guess so, but right now I don't want to (nor have bandwidth to) think
about things beyond the release we are currently in pre-release freeze
for.  Helps from other people's braincells are very welcome.

> From: Greg Price <price@ksplice.com>
> Date: Fri, 18 Sep 2009 15:34:19 -0400
> Subject: [PATCH] Document behavior of --no-commit on fast forward.
>
> This behavior can be surprising, so document it.

If "surprising" is the problem (and it certainly is), perhaps it would be
better to rewrite it not to be so surprising, like:

        --no-commit::
                Do not create a new commit.  If your current branch
                fast-forwards to the branch you are merging, this option
                has no effect (use --no-ff for that).  Otherwise, a merge
                is done and the index and the work tree files are updated,
                but the command stops before creating a new commit that
                records the result, in order to give the user a chance to
                inspect and tweak the merge result before committing.

I dunno.

> Signed-off-by: Greg Price <price@ksplice.com>
> ---
>  Documentation/merge-options.txt |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/merge-options.txt
> b/Documentation/merge-options.txt
> index adadf8e..6015e5d 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -31,7 +31,10 @@
>  --no-commit::
>         Perform the merge but pretend the merge failed and do
>         not autocommit, to give the user a chance to inspect and
> -       further tweak the merge result before committing.
> +       further tweak the merge result before committing.  If the
> +       merge resolved as a fast-forward, the branch pointer will
> +       be updated as usual; --no-ff can be combined with this
> +       option to always preserve the branch pointer.
