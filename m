From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch.txt: Fix description of
 --commit-filter
Date: Fri, 30 May 2008 15:52:40 -0700
Message-ID: <7vlk1rh0av.fsf@gitster.siamese.dyndns.org>
References: <1212183820-40712-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat May 31 00:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2DU5-0003Zj-5P
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133AbYE3Ww7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756206AbYE3Ww6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:52:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbYE3Ww5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:52:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 787DB1CBB;
	Fri, 30 May 2008 18:52:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 96BFF1CBA; Fri, 30 May 2008 18:52:49 -0400 (EDT)
In-Reply-To: <1212183820-40712-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Fri, 30 May 2008 14:43:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 231AD954-2E9B-11DD-B70A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83352>

Kevin Ballard <kevin@sb.org> writes:

> The old description was misleading and logically impossible. It claimed that
> the ancestors of the original commit would be re-written to have the multiple
> emitted ids as parents. Not only would this modify existing objects, but it
> would create a cycle. What this actually does is pass the multiple emitted ids
> to the newly-created children to use as parents.
>
> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---
>  Documentation/git-filter-branch.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 506c37a..541bf23 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -113,8 +113,8 @@ OPTIONS
>  	stdin.  The commit id is expected on stdout.
>  +
>  As a special extension, the commit filter may emit multiple
> -commit ids; in that case, ancestors of the original commit will
> -have all of them as parents.
> +commit ids; in that case, the rewritten children of the original commit will
> +have all of them as parents. You probably don't want to do this.
>  +

Now I am _very_ confused.

The original description sounds as if:

        In this history, when rewriting commit C, if we emit A from the
        filter:

                     B
                      \
                ---A---C---D
               
        We will somehow make 'A' and 'B' have A as their parents.

which is wrong as you pointed out.

But I am also confused by the new description:

        In that history, we will make sure that rewritten D (original
        commit being C) have A as parent.  IOW, we will have

                --A'--C'  D'
                         /
                        A

which is not what happens.  What it does is that the commits in the output
from the filter (i.e. A) are first mapped to the corresponding commits in
the rewritten history (i.e. A'), and they will be used as the parents of
the rewritten commit, to form this history:

                --A'--C'

isn't it?

Also you did not defend why you added "You probably don't want to do this"
to the description.
