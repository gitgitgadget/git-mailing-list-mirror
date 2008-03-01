From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rename: warn user when we have turned off rename
 detection
Date: Fri, 29 Feb 2008 23:35:00 -0800
Message-ID: <7vtzjq6gnv.fsf@gitster.siamese.dyndns.org>
References: <20080301061431.GA27301@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMG7-00047u-KD
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbYCAHfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYCAHfP
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:35:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbYCAHfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:35:14 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A30CF22FE;
	Sat,  1 Mar 2008 02:35:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CD6D922FD; Sat,  1 Mar 2008 02:35:07 -0500 (EST)
In-Reply-To: <20080301061431.GA27301@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 01:14:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75631>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was another patch from late in the freeze period. It was in
> response to a user getting confused about why rename detection wasn't
> happening in a large merge. Is it appropriate to print this for every
> rename we try? Or should it just be for merges?
>
> Perhaps we should also bump the default limit from 100, which I think
> was just arbitrarily chosen.
> ...
> +	if ((num_create > rename_limit && num_src > rename_limit) ||
> +	    (num_create * num_src > rename_limit * rename_limit)) {
> +		warning("too many files, skipping inexact rename detection");
>  		goto cleanup;
> +	}
> 
>  	mx = xmalloc(sizeof(*mx) * num_create * num_src);
>  	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {

This reminds me of the 6d24ad9 (Optimize rename detection for a huge diff)
topic that reduces the above allocation greatly.  Some benching with the
patch may prove useful to establish much higher limits, I suspect.
