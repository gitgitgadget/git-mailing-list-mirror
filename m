From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH B v4 5/5] git config: don't allow --get-color* and
 variable type
Date: Sun, 22 Feb 2009 08:48:49 -0800
Message-ID: <7vmyce2z9q.fsf@gitster.siamese.dyndns.org>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
 <1235177369-2727-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHXK-0004ky-Ut
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZBVQs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbZBVQs4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:48:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbZBVQsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:48:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB2BB2BB1C;
	Sun, 22 Feb 2009 11:48:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 19BA32BB1A; Sun,
 22 Feb 2009 11:48:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0FF0D98-0100-11DE-BD57-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111016>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Doing so would be incoherent since --get-color would pick a color slot
> and ignore the variable type option (e.g. --bool), and the type would
> require a variable name.
>
> Suggested by Junio C Hamano.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin-config.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-config.c b/builtin-config.c
> index 8045926..9930568 100644
> --- a/builtin-config.c
> +++ b/builtin-config.c
> @@ -359,6 +359,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
>  	if (get_colorbool_slot)
>  	    actions |= ACTION_GET_COLORBOOL;
>  
> +	if ((get_color_slot || get_colorbool_slot) && types) {
> +		error("--get-color and variable type are incoherent");
> +		usage_with_options(builtin_config_usage, builtin_config_options);
> +	}
> +

I do not think I suggested anything like this, so I'd decline to take
credit for this patch.

Strictly speaking, "--bool --get-colorbool diff.color 1" shouldn't error
out, don't you think?  And it certainly shouldn't say "--get-color".
