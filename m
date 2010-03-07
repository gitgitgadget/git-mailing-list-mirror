From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/3] grep: Colorize filename, line number, and
 separator
Date: Sun, 07 Mar 2010 11:02:02 -0800
Message-ID: <7v1vfwrm51.fsf@alter.siamese.dyndns.org>
References: <1267980767-12617-1-git-send-email-lodatom@gmail.com>
 <1267980767-12617-3-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 20:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoLk0-0004ab-T0
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 20:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab0CGTCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 14:02:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab0CGTCL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 14:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6349E1A7;
	Sun,  7 Mar 2010 14:02:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VKTmYnz6igA3qcF+GBecDywIVMo=; b=gN9icZ
	b+tFcgsDaSJ0/Y+ngYGFidCQdBdiUY1amkwnLrTDdScEWAqB9eg7txWU0BCZHCwW
	0LfrsK1yC/8L8QhAvEsV2qzKvsyJhEXg3PuNV/JLmIaLjW5YebgJ70PheeuO0l0o
	Xzpi0ZIIgBJIHILDKonwPG+oya6K3O0NUP/y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLhoRcehJcVe8m8JtVNVplJBCLwmGLEM
	ZNvlh5qhiS+K+AcYC6ge/kpokXOYQaEBxJ++Uc4qJALFzSxPNwAEGJLh3L6ChlVy
	M+DHdaXDoCOIYxmQuKEXnTWo2saz7E7EhBCjvR3zLkdgbt3M4IrWFwHqVwTi28cP
	XACqyfnVlw0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 669F59E1A0;
	Sun,  7 Mar 2010 14:02:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE5639E192; Sun,  7 Mar
 2010 14:02:03 -0500 (EST)
In-Reply-To: <1267980767-12617-3-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Sun\,  7 Mar 2010 11\:52\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC6F97C2-2A1B-11DF-B38B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141724>

Mark Lodato <lodatom@gmail.com> writes:

> +	if (color) {
>  		if (!value)
>  			return config_error_nonbool(var);
> -		color_parse(value, var, opt->color_match);
> -		return 0;
> +		color_parse(value, var, color);
> +		if (!strcmp(color, GIT_COLOR_RESET))
> +			color[0] = '\0';

I don't know this "optimization" is warranted.  I can understand that you
are trying to help the user to save a handful of useless bytes per line of
output in the normal case, but doesn't "color.cmd.foo = normal" set the
value to an empty string already if that is what the user wants?

The user may know about his contents better than this code does; perhaps
the payload sometimes has funny ANSI sequence in it and the user may be
trying to explicitly reset at the beginning of the line for the "plain"
part of the output by saying "reset".  Wouldn't this make it impossible to
do so?
