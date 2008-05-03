From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add merge.renamelimit config option
Date: Sat, 03 May 2008 13:15:06 -0700
Message-ID: <7viqxvta9h.fsf@gitster.siamese.dyndns.org>
References: <20080430172136.GA22601@sigill.intra.peff.net>
 <20080430172354.GA23747@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 03 22:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsO9N-00052T-D3
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 22:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYECUPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 16:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYECUPQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 16:15:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYECUPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 16:15:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B3AD83129;
	Sat,  3 May 2008 16:15:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0785D3127; Sat,  3 May 2008 16:15:08 -0400 (EDT)
In-Reply-To: <20080430172354.GA23747@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Apr 2008 13:23:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A37FE958-194D-11DD-A2AF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81115>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
> index 910c0d2..1293e3d 100644
> --- a/builtin-merge-recursive.c
> +++ b/builtin-merge-recursive.c
> @@ -361,7 +362,9 @@ static struct path_list *get_renames(struct tree *tree,
>  	diff_setup(&opts);
>  	DIFF_OPT_SET(&opts, RECURSIVE);
>  	opts.detect_rename = DIFF_DETECT_RENAME;
> -	opts.rename_limit = rename_limit;
> +	opts.rename_limit = merge_rename_limit >= 0 ? merge_rename_limit :
> +			    diff_rename_limit >= 0 ? diff_rename_limit :
> +			    100;
>  	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
>  	if (diff_setup_done(&opts) < 0)
>  		die("diff setup failed");

Makes one wonder where the magic 100 comes from.  Wouldn't this

	opts.rename_limit = (merge_rename_limit >= 0)
        		  ? merge_rename_limit
                          : diff_rename_limit;

be easier to maintain, with the same semantics?
