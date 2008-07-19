From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-clone: Use is_dir_sep() instead of '/'
Date: Fri, 18 Jul 2008 17:32:26 -0700
Message-ID: <7vk5fi67dx.fsf@gitster.siamese.dyndns.org>
References: <1216366485-12201-1-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-2-git-send-email-johannes.sixt@telecom.at>
 <1216366485-12201-3-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK0OG-0003qy-AD
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 02:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbYGSAch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 20:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYGSAch
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 20:32:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbYGSAcg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 20:32:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F63F32C18;
	Fri, 18 Jul 2008 20:32:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6303E32C0D; Fri, 18 Jul 2008 20:32:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DA5C87E-552A-11DD-BAEC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89091>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  builtin-clone.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 643c7d4..fddf47f 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -115,7 +115,7 @@ static char *guess_dir_name(const char *repo, int is_bundle)
>  			if (!after_slash_or_colon)
>  				end = p;
>  			p += 7;
> -		} else if (*p == '/' || *p == ':') {
> +		} else if (is_dir_sep(*p) || *p == ':') {
>  			if (end == limit)
>  				end = p;
>  			after_slash_or_colon = 1;

Ok, but the surrounding code in this function look very suspicious.

 * The variable "prefix" is actually about suffix.

 * "else if" for explicit ".bundle" case look redundant; it would never
   trigger, I suspect.

 * Values used to increment p for "prefix" case and ".bundle" case are
   inconsistent.  I think the redundant one increments by the right value
   (i.e. strlen(prefix)-1 is bogus).
