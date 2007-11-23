From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Converted git-merge-ours.sh -> builtin-merge-ours.c
Date: Fri, 23 Nov 2007 00:49:44 -0800
Message-ID: <7voddluz13.fsf@gitster.siamese.dyndns.org>
References: <4745E45C.7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, thomas.harning@trustbearer.com
To: Thomas Harning <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 09:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvUEi-0002WH-Vp
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 09:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXKWItv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 03:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbXKWItv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 03:49:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42658 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbXKWItv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 03:49:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4E2FA2EF;
	Fri, 23 Nov 2007 03:50:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A561597C74;
	Fri, 23 Nov 2007 03:50:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65876>

Thomas Harning <harningt@gmail.com> writes:

> Here's a simple patch to make git-merge-ours.sh into a builtin.
>
> I figure this would be a simple way of getting in the git-development flow.
>
> Signed-off-by: Thomas Harning Jr <harningt@gmail.com>

Have you tried to read this proposed commit log message in the
context of "git log", after applying it on top of 'master'?
"Here's a simple patch to" and "I figure ..." are of not much
use.

The patch looks good except for minor style nits.

> diff --git a/builtin-merge-ours.c b/builtin-merge-ours.c
> new file mode 100644
> index 0000000..fbfe183
> --- /dev/null
> +++ b/builtin-merge-ours.c
> @@ -0,0 +1,32 @@
> +/*
> + * Implementation of git-merge-ours.sh as builtin
> + * 

Traling whitespace.

> +int cmd_merge_ours(int argc, const char **argv, const char *prefix)
> +{
> +	const char *nargv[] = {
> +		"diff-index",
> +		"--quiet",
> +		"--cached",
> +		"HEAD",
> +		NULL
> +	};
> +	int i;
> +
> +	int ret = cmd_diff_index(4, nargv, prefix);
> +	printf("GOT: %i\n", ret);

Unused variable "i".

An unwanted blank line still in the sequence of variable
definitions, and a missing blank line after the definitions.

A leftover debug printf() is not very welcomed.

	[Not a nit but a comment]

        The call to cmd_diff_index() here raised my eyebrow a
	bit.  I would have skipped all the parameter parsing and
	arranged it to directly call into run_diff_index()
	instead.  

	As the result of literally translating the scripted
	version of git-merge-ours, the code inherits a
	corner-case bug.  Can you spot it?

> +	/* We need to exit with 2 if the index does not match our HEAD tree,
> +	 * because the current index is what we will be committing as the
> +	 * merge result.
> +	 */

We tend to format a multi-line comment block as:

	/*
         * We need to ...
         * ... merge result.
         */

> +	if(ret) ret = 2;

A SP between "if" and "("; put the body of the "if" on a
separate line.

Thanks.  No need to resend; all these minor nits can be fixed
here easily.
