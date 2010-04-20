From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] reflog: make the 'show' subcommand really the
 default
Date: Mon, 19 Apr 2010 17:46:02 -0700
Message-ID: <7veiiblzn9.fsf@alter.siamese.dyndns.org>
References: <1271670750-30297-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 20 02:46:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O41bY-0002TI-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 02:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab0DTAqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 20:46:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39598 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0DTAqO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 20:46:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E577AC7ED;
	Mon, 19 Apr 2010 20:46:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aheYIwF7nNqQ
	a01/TVLHwCK1zqY=; b=fLCaJedpPE+j4WiV4/XMjU3VZRNOCP2ZmxpEFz3Y4/oH
	kFPLAocTwu5VFBWN3wyo7FUCoIfe03WQKs9GdDGHvpI4vR5jpg1o4WlKFzuz8j0H
	1fLpk1UrV42SvjDLlYu8PmilG/r0uj7H/s8BcEjykARV/P8kBo5XSTxj9jpLQZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WFDGTd
	2kVczN5Olka+ZrHr9sXGm6HNPrWsAhSG6uPodN/buKnW/eS4XaAza4rxUTcCtln9
	lSokxjE32fbeBn6Q69Sw9/T/NAAVqlQbWrqkYhkwI6KwShw01WhPS0cZBApJqLSC
	YgosqeLf1ezYPnQ/V9lm1wuCj1MzgRcXOW3ro=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E131BAC7EA;
	Mon, 19 Apr 2010 20:46:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9AD5AC7E6; Mon, 19 Apr
 2010 20:46:04 -0400 (EDT)
In-Reply-To: <1271670750-30297-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon\, 19 Apr 2010 11\:52\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1CB3A2AE-4C16-11DF-B95D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145346>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 64e45bd..d4d4409 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -712,6 +712,5 @@ int cmd_reflog(int argc, const char **argv, const=
 char *prefix)
>  	if (!strcmp(argv[1], "delete"))
>  		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
> =20
> -	/* Not a recognized reflog command..*/
> -	usage(reflog_usage);
> +	return cmd_log_reflog(argc, argv, prefix);

I am not convinced that this is a good change.

It may be that show/expire/delete happens to be the _only_ subcommands
today, but if we had this patch, the command will change the behaviour
when we add a new subcommand (the name of that subcommand may happen to=
 be
also a refname).

I'd rather see a fix for the documentation.

Your [PATCH 2/2] looks very sane, though.

Thanks.
