From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Have manpage reference new documentation on reverting
 merges.
Date: Sat, 20 Dec 2008 18:36:43 -0800
Message-ID: <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
References: <200812201832.48992.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 03:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEEDQ-0003FQ-PL
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 03:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbYLUCgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 21:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbYLUCgw
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 21:36:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYLUCgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 21:36:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE45C89105;
	Sat, 20 Dec 2008 21:36:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BC79D89104; Sat,
 20 Dec 2008 21:36:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38112DAA-CF08-11DD-94E2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103683>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
> ---
> An example addition to the manpage for revert that references Nanako
> Shiraishi's new documentation.
>
>  Documentation/git-revert.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index caa0729..ea36bdf 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -45,6 +45,10 @@ OPTIONS
>  	the mainline and allows revert to reverse the change
>  	relative to the specified parent.
>  
> +	Reverting a merge commit does not completely "undo" the effect of the
> +	merge and it may make future merges more difficult.  For more details,
> +	please read Documentation/howto/revert-a-faulty-merge.txt.
> +

I think these new lines need to be dedented, and the previous blank line
should be turned into a line with a single '+'.

I'd also suggest removing "does not ... merge and it" from the above
sentence to avoid confusing readers, because people who read only the
above and do not read the howto document may get a wrong impression that
the resulting tree may have some changes that came from the merge even
after the revert, which is not the case.  Revert will erase the effect the
merge had to your tree and that part is complete.

Linus's "does not completely undo" only refers to the history part of the
merge, and that only affects future re-merges from the same branch, which
the reader who is interested in doing a revert of a merge right now (that
is why s/he is reading this paragraph) may not yet care about.

An alternative is to give a complete but brief explanation.  Perhaps like
this:

    By reverting a merge, you are declaring that you will never want the
    changes that were brought in by that merge you are reverting in your
    tree.  If you do merge from the same branch again in the future after
    it is updated, git remembers your declaration, and only the changes on
    the branch that were made after the reverted merge will be brought in.
    This may or may not be what you want.  See 'revert-a-faulty-merge'
    HOWTO for more details.
