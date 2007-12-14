From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Unify whitespace checking
Date: Thu, 13 Dec 2007 16:03:15 -0800
Message-ID: <7vd4taywfw.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
	<1197552751-53480-2-git-send-email-win@wincent.com>
	<1197552751-53480-3-git-send-email-win@wincent.com>
	<1197552751-53480-4-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:04:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2y28-0005IX-Ax
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 01:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934706AbXLNADd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 19:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934662AbXLNAD3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 19:03:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35678 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934670AbXLNAD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 19:03:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DC7D587D3;
	Thu, 13 Dec 2007 19:03:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA1087D2;
	Thu, 13 Dec 2007 19:03:17 -0500 (EST)
In-Reply-To: <1197552751-53480-4-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Thu, 13 Dec 2007 14:32:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68202>

Wincent Colaiuta <win@wincent.com> writes:

> The new function is called check_and_emit_line() and it does two things:
> checks a line for whitespace errors and optionally emits it. The checking
> is based on lines of content rather than patch lines (in other words, the
> caller must strip the leading "+" or "-"); this was suggested by Junio on
> the mailing list to allow for a future extension to "git show" to display
> whitespace errors in blobs.

I do not think "git show" is a realistic "future extension", by the
way.  But at least from the interface-cleanliness point of view, I think
not passing the leading "+" to the function is a right thing to do.

> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index dc538b3..a0a47dd 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -121,7 +121,7 @@ test_expect_success 'check mixed spaces and tabs in indent' '
>  
>  	# This is indented with SP HT SP.
>  	echo " 	 foo();" > x &&
> -	git diff --check | grep "space before tab"
> +	git diff --check | grep "Space in indent is followed by a tab"
>  
>  '

Hmph.  I think with the multiple detection this rewording would make the
error message very long to read.  Was the rewording really necessary?

> +/* If stream is non-NULL, emits the line after checking. */
> +unsigned check_and_emit_line(const char *line, int len, unsigned ws_rule,
> +                             FILE *stream, const char *set,
> +                             const char *reset, const char *ws)
> +{

Honestly, I regretted suggesting this, fearing that it might make the
checking too costly, but the code is clean, readable, and does not look
costly at all.  Nice job.
