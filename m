From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send: suppress warning about cleartext password
 with CRAM-MD5
Date: Sun, 28 Mar 2010 09:25:16 -0700
Message-ID: <7vbpe85s7n.fsf@alter.siamese.dyndns.org>
References: <1269702019-27063-1-git-send-email-chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:25:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvIu-00027K-Gs
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab0C1QZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:25:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab0C1QZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:25:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55918A6791;
	Sun, 28 Mar 2010 12:25:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QwD2oYj49UnzR0naQvPnBBlhHBE=; b=P1Sc43
	7Xxy/iCkzXtql7KdlIZGAgjaCesB5g4yHr72l28uBI3aIcx9hXqi7osDpcDWhh3X
	Rg0gbV0jYkt29ISoAjfBHtxsZ8Gt/Stilsa1QuC5+7NbWg8sjfQNEOfMKF0vuYWt
	Glo5RPurCBTe2OyQbnNYz7kbGKHlfLqqUzkeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I0UqhX3XeturID7pexLnsng5ONI7w2vd
	0jUxDlN0S4SdnJEYKwLSO235C6bJXW8wdrgx6NRWRAInUt1pYt/DPYJXWHeScGaG
	5fN55O19Z4b3+DUIxSQ/aY46std419ZOYQ2pErFnTDWEYumM8TF0WeWw6TSZSp0/
	M0ZgMXZETsw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A15A678F;
	Sun, 28 Mar 2010 12:25:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F66AA678E; Sun, 28 Mar
 2010 12:25:18 -0400 (EDT)
In-Reply-To: <1269702019-27063-1-git-send-email-chris@arachsys.com> (Chris
 Webb's message of "Sat\, 27 Mar 2010 15\:00\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 81BDD418-3A86-11DF-82B3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143396>

Chris Webb <chris@arachsys.com> writes:

> If a CRAM-MD5 challenge-response is used to authenticate to the IMAP server,
> git imap-send shouldn't warn about the password being sent in the clear.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---

Makes sense.  Thanks.

>  imap-send.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index aeb2985..7107923 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1226,9 +1226,6 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
>  			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
>  			goto bail;
>  		}
> -		if (!imap->buf.sock.ssl)
> -			imap_warn("*** IMAP Warning *** Password is being "
> -				  "sent in the clear\n");
>  
>  		if (srvc->auth_method) {
>  			struct imap_cmd_cb cb;
> @@ -1253,6 +1250,9 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
>  				goto bail;
>  			}
>  		} else {
> +			if (!imap->buf.sock.ssl)
> +				imap_warn("*** IMAP Warning *** Password is being "
> +					  "sent in the clear\n");
>  			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
>  				fprintf(stderr, "IMAP error: LOGIN failed\n");
>  				goto bail;
> -- 
> 1.7.0.1
