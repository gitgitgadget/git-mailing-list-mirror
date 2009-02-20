From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff --no-index'
Date: Fri, 20 Feb 2009 08:34:15 -0800
Message-ID: <7v1vttt6d4.fsf@gitster.siamese.dyndns.org>
References: <499E92FD.8000900@alum.mit.edu>
 <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYM2-00076o-M5
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZBTQea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZBTQe3
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:34:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbZBTQe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:34:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B51C32B8DE;
	Fri, 20 Feb 2009 11:34:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9765D2B8C6; Fri,
 20 Feb 2009 11:34:17 -0500 (EST)
In-Reply-To: <cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Fri, 20 Feb 2009 15:12:28 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54EB8832-FF6C-11DD-8CF1-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110859>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> With this patch, it is possible to exclude files based on basename
> patterns.  Example:
>
> 	$ git diff --no-index -x Makefile -x Makefile.in a/ b/
>
> In this example, the recursive diff between a/ and b/ will be shown
> modulo changes in files named 'Makefile' or 'Makefile.in'.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Michael wrote:
>
> 	> I can't think offhand of a more portable tool that could replace 
> 	> "diff -r -x" here (suggestions, anyone?).
>
> 	Maybe something like this?

I agree that diff_options is the logical way to hook this information and
diff_opt_parse() is the right place to add this, but why isn't this done
at diff_{addremove,change,unmerge}() layer?  That way you should be able
to cover both no-index special case and the normal diffs, no?
