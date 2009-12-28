From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Squash PATCH] fprintf(stderr, "Warning...") -> warning("...")
Date: Mon, 28 Dec 2009 01:24:05 -0800
Message-ID: <7vy6kntpsa.fsf@alter.siamese.dyndns.org>
References: <1261651279-29041-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon Dec 28 10:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPBq1-0005dO-SH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 10:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbZL1JYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 04:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbZL1JYO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 04:24:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZL1JYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 04:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE0098B484;
	Mon, 28 Dec 2009 04:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ahontgJrI5cuMPqFL3JLpgcT5Yk=; b=biOW97yVIhMPNNvZoxXc4BJ
	1emw322AllCW1Hokm4m/z26W95NYa85xtd0vKzSVYNH2sFny68QPds0J6CaHr0ZM
	dJvpXNt3/g5Yxf21qL6DSn7Rcgm7/ZP4/WqI77Snjds+zqbCNfLkjh4rwSll493K
	5c4dCM3hSxuNJOb8QiK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bHN8WBkyqRN4AZKz0nOpjwnc/UdiweE542OFY5uiOjIe48Pxr
	fLd3yCJoBdLunTC52JgKfmoZ3YD7bIOODBosurMGJDYcQOUtSO08pJpJRmCfxGmF
	F1B7o1LAeA13mPLB2R7LXbJdSpZdmQfP+CflWisYGMWJVrr/Y3CsRCkB7E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B51188B482;
	Mon, 28 Dec 2009 04:24:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14A028B481; Mon, 28 Dec
 2009 04:24:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C1091ED8-F392-11DE-A8DD-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135732>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
> ---
>  transport-helper.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> This fixes the small nit about fprintf(stderr, "Warning: ") by using
> warning() API. 
>
> It can be appiled on top of "Support remote helpers implementing smart
> transports" or squashed to it.

Thanks; will squash but with two minor touch-ups:

 - warning() adds its own terminating LF so we need to drop it from the caller;

 - being able to grep for an error/warning message is more important than
   keeping the source line strictly shorter than 80-columns.

> diff --git a/transport-helper.c b/transport-helper.c
> index 55427df..8c8ca8e 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -420,11 +420,10 @@ static int process_connect_service(struct transport *transport,
>  	if (strcmp(name, exec)) {
>  		r = set_helper_option(transport, "servpath", exec);
>  		if (r > 0)
> -			fprintf(stderr, "Warning: Setting remote service path "
> -				"not supported by protocol.\n");
> +			warning("Setting remote service path not supported "
> +				"by protocol.\n");
>  		else if (r < 0)
> -			fprintf(stderr, "Warning: Invalid remote service "
> -				"path.\n");
> +			warning("Invalid remote service path.\n");
>  	}
>  
>  	if (data->connect)
> -- 
> 1.6.6.3.gaa2e1
