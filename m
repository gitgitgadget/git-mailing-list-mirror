From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Reduce the number of connects when fetching
Date: Mon, 04 Feb 2008 19:09:45 -0800
Message-ID: <7v8x20gkue.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802041323450.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 04:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMECm-0000mI-Jm
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 04:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbYBEDKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 22:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYBEDKI
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 22:10:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYBEDKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 22:10:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BAD4440B1;
	Mon,  4 Feb 2008 22:10:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D68E40B0;
	Mon,  4 Feb 2008 22:10:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72617>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This shares the connection between getting the remote ref list and
> getting objects in the first batch. (A second connection is still used
> to follow tags)
> ---

No signoff.

> There's a bug here, fixed in the next patch, but it's just cosmetic (we 
> hang up on the remote end unexpectedly if we turn out not to need 
> anything), and I think reorganizing changes to not do that makes the 
> changes harder to follow.

> @@ -706,9 +703,34 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  	if (!dest)
>  		usage(fetch_pack_usage);
>  
> -	ref = fetch_pack(&args, dest, nr_heads, heads, NULL);
> +	int fd[2];
> +	struct child_process *conn = git_connect(fd, (char *)dest, args.uploadpack,
> +                          args.verbose ? CONNECT_VERBOSE : 0);

Decl after statement.

But other than that, good job.  I did not realize it would be
doable this cleanly.

Will squash all three and queue for 'next'.
