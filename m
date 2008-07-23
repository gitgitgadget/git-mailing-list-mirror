From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Wed, 23 Jul 2008 16:41:02 -0700
Message-ID: <7vmyk888z5.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnyF-0008UT-Et
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789AbYGWXlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbYGWXlK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:41:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbYGWXlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:41:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B70B384B8;
	Wed, 23 Jul 2008 19:41:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 60A61384B7; Wed, 23 Jul 2008 19:41:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807222235520.8986@racer> (Johannes
 Schindelin's message of "Tue, 22 Jul 2008 22:36:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D21B2AF4-5910-11DD-A1C3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89808>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If the user called "rebase -i", marked a commit as "edit", "rebase
> --continue" would automatically amend the commit when there were
> staged changes.
>
> However, this is actively wrong when the current commit is not the
> one marked with "edit".  So guard against this.

At what point in what valid workflow sequence does HEAD become different
from dotest/amend?

> @@ -419,7 +419,9 @@ do
>  		else
>  			. "$DOTEST"/author-script ||
>  				die "Cannot find the author identity"
> -			if test -f "$DOTEST"/amend
> +			if test -f "$DOTEST"/amend &&
> +				test $(git rev-parse HEAD) = \
> +					$(cat "$DOTEST"/amend)
>  			then
>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"

In what way is this "guarding against it"?  It goes on and makes an
unrelated commit without erroring out nor giving indication to the user
what is going on, doesn't it?

I am sure you meant well and the code is good, but I find that the
explanation is a bit lacking...
