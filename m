From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-reset.c: Extend hard reset error message when
 using paths.
Date: Mon, 13 Apr 2009 12:51:21 -0700
Message-ID: <7vr5zwe3ie.fsf@gitster.siamese.dyndns.org>
References: <1239646444-11653-1-git-send-email-tim@retout.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Retout <tim@retout.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 13 21:53:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtSDH-00070Y-Gq
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 21:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZDMTv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbZDMTv2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 15:51:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbZDMTv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 15:51:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BB5DAAA5B;
	Mon, 13 Apr 2009 15:51:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D986EAAA5A; Mon,
 13 Apr 2009 15:51:22 -0400 (EDT)
In-Reply-To: <1239646444-11653-1-git-send-email-tim@retout.co.uk> (Tim
 Retout's message of "Mon, 13 Apr 2009 19:14:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 79462A40-2864-11DE-B81E-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116479>

Tim Retout <tim@retout.co.uk> writes:

> Users who invoke 'git reset --hard <paths>' are probably trying to
> update paths in their working directory.  The error message should
> point them in the direction of git-checkout(1).

That is one possibility.  Another is:

    git reset --hard mester

(and you have ./mester file in the work tree) and in that case the user
definitely didn't want to do any checkout.

I wonder if you can tell these cases apart, and also if this (not just
telling these apart, but what your patch adds) is worth additional
cluttering in the running program.  I certainly wouldn't mind addition to
git-reset manual page if new people are often confused between "checking
out paths from the index or from the named commit" and "resetting the HEAD
to a different commit while nuking the index and the work tree state",
though.

> Signed-off-by: Tim Retout <tim@retout.co.uk>
> ---
>  builtin-reset.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-reset.c b/builtin-reset.c
> index c0cb915..885ca9a 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -257,6 +257,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (i < argc) {
>  		if (reset_type == MIXED)
>  			warning("--mixed option is deprecated with paths.");
> +		else if (reset_type == HARD)
> +			die("Cannot do %s reset with paths.\n"
> +			    "See git-checkout(1) to update paths in the working tree.",
> +					reset_type_names[reset_type]);
>  		else if (reset_type != NONE)
>  			die("Cannot do %s reset with paths.",
>  					reset_type_names[reset_type]);
> -- 
> 1.6.2.2
