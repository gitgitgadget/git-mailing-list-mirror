From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revision walking documentation: document most important
 functions
Date: Thu, 29 May 2008 17:29:18 -0700
Message-ID: <7vej7kocrl.fsf@gitster.siamese.dyndns.org>
References: <1212098185-8437-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri May 30 02:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1sVi-0000TR-NS
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 02:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYE3A3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753067AbYE3A3b
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 20:29:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYE3A3b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 20:29:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F2532183D;
	Thu, 29 May 2008 20:29:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E49EA183B; Thu, 29 May 2008 20:29:23 -0400 (EDT)
In-Reply-To: <1212098185-8437-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Thu, 29 May 2008 23:56:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7714673A-2DDF-11DD-9326-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83259>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Unfortunately the list is not complete, but includes the essential ones.
> ...
> Here is a start. To be honest I never used the functions I did not
> document, so I don't have too much idea what they do (not counting
> reading the source ;-) ), so I thought it's better if I leave them
> excluded from the list.

It's a good start.  Thanks.

>  revision walking API
>  ====================
>  
> +The revision walking API offers functions to build a list of revisions
> +and then iterate over that list.

> +The walking API has a given calling sequence: first you need to
> +initialize a rev_info structure, then add revisions to control what kind
> +of revision list do you want to get, finally you can iterate over the
> +revision list.

I think this paragraph is easier to read if it is in its own subsection
"Calling Sequence" (see api-diff.txt for an example).

> +Functions
> +---------
> +
> +`init_revisions`::
> +
> +	Initialize a rev_info structure with default values. The second
> +	parameter may be NULL or can be prefix path, and then the `.prefix`
> +	variable will be set to it. This is typically the first function you
> +	want to call when you want to deal with a revision list. After calling
> +	this function, you are free to customize options, like set
> +	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
> +	`revision.h` for a complete list of available options.

Traversal options are numerous and complex, so I agree that it makes sense
to refer the reader elsewhere.  We can start with "revision.h", and extend
this documentation by adding a separate section on it.

> +`add_pending_object`::
> +
> +	This function can be used if you want to add commit objects as revision
> +	information. You can use the `UNINTERESTING` object flag to indicate if
> +	you want to include or exclude the given commit (and commits reachable
> +	from the given commit) from the revision list.
> ++
> +NOTE: If you have the commits as a string list then you probably want to
> +use setup_revisions(), instead of parsing each string and using this
> +function.
> +
> +`setup_revisions`::
> +
> +	Parse revision information, filling in the `rev_info` structure, and
> +	removing the used arguments from the argument list. Returns the number
> +	of arguments left that weren't recognized, which are also moved to the
> +	head of the argument list. The last parameter is used in case no
> +	parameter given by the first two arguments.
> +
> +`prepare_revision_walk`::
> +
> +	Prepares the rev_info structure for a walk. You should check if it
> +	returns any error (positive return code) and if it does not, you can

s/positive/non-zero/;
