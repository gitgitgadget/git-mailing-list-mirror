From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v8] Let core.attributesfile default to
 $XDG_CONFIG_HOME/git/ignore
Date: Mon, 25 Jun 2012 00:22:42 -0700
Message-ID: <7vlijbhn3x.fsf@alter.siamese.dyndns.org>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340355806-6894-4-git-send-email-Matthieu.Moy@imag.fr>
 <7v4nq3niwc.fsf@alter.siamese.dyndns.org> <vpqehp3j403.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 25 09:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj3dN-0003T3-95
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711Ab2FYHWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 03:22:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656Ab2FYHWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 03:22:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA9494D52;
	Mon, 25 Jun 2012 03:22:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WURiq6i5epb+YIEeZQPZyJGibu0=; b=G8N6X/
	6DWKrBynGm9mD0z8PWFFNyc1cBfWLPTLBSwAIxR4J0sJIdlJwV6wEHaAH4Spl7sy
	FcfRLugQa++G3fOV2kCLmDrPGyXJ4F7QOX0BjLYGW9cLW+gdlBzZJcuZIxXD28KL
	kRP7GNMDGMkAvtbA3aJhSVqQdmgdIbGMRwmxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n3BPVPrT5k81PV8r4WQ9d7PCsI6Wxd5D
	F1kw5q/N59I8eznv6MoFTD/kDibSI7eQ8wGEMER0nTpVkuDpvIwq2doZbwLxPiy1
	caqWF187QUR5r0MtZQbYU4UTdvhTW5N3dpdhYn2OkmR+GVNrq1RBLGzpHXAqGRVy
	IMMPpWhrIFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFE7D4D51;
	Mon, 25 Jun 2012 03:22:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B15D4D50; Mon, 25 Jun 2012
 03:22:44 -0400 (EDT)
In-Reply-To: <vpqehp3j403.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 25 Jun 2012 08:32:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E86AE9A-BE96-11E1-A4B5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200553>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, it would even make sense to reduce the number of occurences of
> "excludes" in the UI, e.g. support something like core.ignoresfile as an
> alias for core.excludesfile, along the lines of:
>
> --- a/config.c
> +++ b/config.c
> @@ -723,7 +723,7 @@ static int git_default_core_config(const char *var, const char *value)
>         if (!strcmp(var, "core.askpass"))
>                 return git_config_string(&askpass_program, var, value);
>  
> -       if (!strcmp(var, "core.excludesfile"))
> +       if (!strcmp(var, "core.excludesfile") || !strcmp(var, "core.ignoresfile"))
>                 return git_config_pathname(&excludes_file, var, value);

I somehow suspect this is going backwards.  ".gitignore" may have
been the original mistake; it is much more than ".cvsignore".

But I do not deeply care either way.  It just felt $path/git/ignore
was out of place given $path/.git/info/exclude has been with us
almost forever.
