From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-imap-send: Convert LF to CRLF before storing
 patch to draft box
Date: Thu, 11 Feb 2010 12:48:08 -0800
Message-ID: <7viqa31otz.fsf@alter.siamese.dyndns.org>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1265899135-11488-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nffxh-0000H4-1Q
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 21:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab0BKUs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 15:48:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab0BKUs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 15:48:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1551F98969;
	Thu, 11 Feb 2010 15:48:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4XPNHdvxjqPeVUAgO5E5IjFZjZ4=; b=hJ8pMV
	qWRRhjZPEowIs1AWvJzz/R81whqhy+Ld4W8ILhJS9dkS2TmyaNlHxecwnl64Jo1g
	osjrBuOQAFguDi8HEFKrJOSw/I0ErKP4n45RgwIxBLOafETcEN1lFW0GLJcdsirJ
	KYhyWjllIN8syGftqkJgvpxm1x8GI0zocRHCU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=simRpyC2y1Drx059Xb5gCy6XNjgYP+YB
	Mr/DA17JoI5UIHkbxa6N3o7bMtsq+iUJcl3llBMVdz5cvaWtbKJEf1rqwkcD5753
	KfzCOSfbiBGTcRDPWPno9n4zBy3wQR2i3im/ingWUM3UDO4/+ydGbcoWkLgasHLQ
	dgM/22WEzdA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 976AA98961;
	Thu, 11 Feb 2010 15:48:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EE8198951; Thu, 11 Feb
 2010 15:48:10 -0500 (EST)
In-Reply-To: <1265899135-11488-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
 (Hitoshi Mitake's message of "Thu\, 11 Feb 2010 23\:38\:55 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8AA302A-174E-11DF-814F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139623>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

> According to RFC of IMAP, all messages must not have "bare newlines ('\n')".
> '\n' should be converted to "\r\n" before storing messages to IMAP's mailbox.
> This patch implements the converting function to git-imap-send.
>
> Cc: Erik Faye-Lund <kusmabite@googlemail.com>
> Cc: Jakub Narebski <jnareb@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Jeff King <peff@peff.org>
> Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
> ---
>  imap-send.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index dcd8a2a..dbc72ca 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1279,6 +1279,30 @@ static int imap_make_flags(int flags, char *buf)
>  	return d;
>  }
>  
> +static void lf_to_crlf(struct msg_data *msg)
> +{
> +	char *new;
> +	int i, j, lfnum = 0;
> +
> +	for (i = 0; i < msg->len; i++) {
> +		if (msg->data[i] == '\n')
> +			lfnum++;
> +	}
> +	new = xcalloc(msg->len + lfnum, sizeof(char));
> +	for (i = 0, j = 0; i < msg->len; i++) {
> +		if (msg->data[i] != '\n') {
> +			new[j++] = msg->data[i];
> +			continue;
> +		}
> +		new[j++] = '\r';
> +		new[j++] = '\n';
> +	}
> +	msg->len += lfnum;
> +	free(msg->data);
> +	msg->data = new;
> +	msg->crlf = 1;
> +}

Thanks.

Two questions:

 - "msg->crlf" -- what is it used for?  Do we need to maintain it?

 - Can the incoming payload already be CRLF terminated?  If so, do we want
   to convert it into CRCRLF?
