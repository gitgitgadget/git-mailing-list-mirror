From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-name-rev: allow --name-only in combination with
 --stdin
Date: Fri, 01 Aug 2008 00:23:27 -0700
Message-ID: <7vtze5td00.fsf@gitster.siamese.dyndns.org>
References: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOp0I-0007R3-I8
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758033AbYHAHXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 03:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758028AbYHAHXg
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:23:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963AbYHAHXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 03:23:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B40CC45512;
	Fri,  1 Aug 2008 03:23:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B2CA745510; Fri,  1 Aug 2008 03:23:29 -0400 (EDT)
In-Reply-To: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Thu, 31 Jul 2008 15:20:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BFBAB7F4-5F9A-11DD-BD05-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91035>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
> ---
>
> 	Or was there a specific reason not to allow this?

I'll let Dscho answer that one.

> diff --git a/builtin-name-rev.c b/builtin-name-rev.c
> index 85612c4..0536af4 100644
> --- a/builtin-name-rev.c
> +++ b/builtin-name-rev.c
> @@ -266,8 +266,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  					if (!name)
>  						continue;
>  
> -					fwrite(p_start, p - p_start + 1, 1, stdout);
> -					printf(" (%s)", name);
> +					if (data.name_only) {
> +						fwrite(p_start, p - p_start + 1 - 40, 1, stdout);
> +						printf(name);
> +					}
> +					else {
> +						fwrite(p_start, p - p_start + 1, 1, stdout);
> +						printf(" (%s)", name);
> +					}
>  					p_start = p + 1;
>  				}
>  			}

Is it just me to find that this part is getting indented too deeply to be
readable?
