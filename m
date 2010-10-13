From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v7 3/3] git-remote-ext
Date: Wed, 13 Oct 2010 16:32:38 -0700
Message-ID: <7v7hhlhdnt.fsf@alter.siamese.dyndns.org>
References: <1286901583-30088-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1286901583-30088-4-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Oct 14 01:37:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6AsW-0005e5-23
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632Ab0JMXcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 19:32:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab0JMXcq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 19:32:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16A38DE70E;
	Wed, 13 Oct 2010 19:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pSi6ukz2dXUjdHaDqz/6rQuigGA=; b=SYSIJP
	6BSO2NHQSYZycuzsqY7hVzDjVVbZyDd0/hvnHjMHeIIUDgsRz/8Z7ucJVYrNAnjw
	wiIu9VnY4Fdg89k/DT5Hb6IWGBzt9E590u9omTarb1rNbFecbLNyUbAXKJIX7GuG
	vg+lt2JrNK7yrQG+36lA3sSHRbCbD83BuTZAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Egg9zHRRxB2chTJro0caqYuT1ezEqmBh
	nuC01nVP4D3AE/YDMohYuF5NVMhKBIDEOSuYhQothuGNfaa4xtY9rSis8fr6wpNY
	LPAhWk298p+71UKYGo9XFJOxCe2Ro67xVvWSnv7THOy+ejnPG8tr/jRSucezOL4r
	kkMkiq/th/Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E73C1DE70D;
	Wed, 13 Oct 2010 19:32:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF73DE70C; Wed, 13 Oct
 2010 19:32:40 -0400 (EDT)
In-Reply-To: <1286901583-30088-4-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Tue\, 12 Oct 2010 19\:39\:43 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D0EA4EA-D722-11DF-8461-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159006>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:


> +'%G<repository>' (as argument)::
> +	This argument will not be passed to 'program'. Instead, it
> +	will cause helper to start by sending git:// service request to
> +	remote side with service field set to approiate value and
> +	repository field set to <repository>. Default is not to send
> +	such request.
> ++
> +This is useful if remote side is git:// server accessed over
> +some tunnel.
> +
> +'%V<host>' (as argument)::
> +	This argument will not be passed to 'program'. Instead it sets
> +	the vhost field in git:// service request. Default is not to
> +	send vhost in such request (if sent).

The above does not say anything about being the first 'character' in an
argument, like the in-code comment does.  Is that intended?

> +static const char **parse_argv(const char *arg, const char *service)
> +{
> +	int arguments = 0;
> +	int i;
> +	const char **ret;
> +	char *temparray[MAXARGUMENTS + 1];
> +
> +	while (*arg) {
> +		char *expanded;
> +		if (arguments == MAXARGUMENTS)
> +			die("remote-ext command has too many arguments");
> +		expanded = strip_escapes(arg, service, &arg);
> +		if (expanded)
> +			temparray[arguments++] = expanded;
> +	}
> +
> +	ret = xmalloc((arguments + 1) * sizeof(char *));
> +	for (i = 0; i < arguments; i++)
> +		ret[i] = temparray[i];
> +	ret[arguments] = NULL;
> +	return (const char **)ret;
> +}

Isn't "ret" declared to be of that type?
