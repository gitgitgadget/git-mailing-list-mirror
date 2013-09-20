From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print in-body "From" only when needed
Date: Fri, 20 Sep 2013 14:06:11 -0700
Message-ID: <xmqqr4cjp5j0.fsf@gitster.dls.corp.google.com>
References: <20130920101626.GA21684@sigill.intra.peff.net>
	<xmqq61tvqrw6.fsf@gitster.dls.corp.google.com>
	<20130920191226.GB31170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 23:06:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN7u7-0004K4-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 23:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab3ITVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 17:06:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41763 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab3ITVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 17:06:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747F743562;
	Fri, 20 Sep 2013 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AJ8JWmUBQiCgt1xLwaXcgeAiK1Y=; b=VydV9g
	gnFO8QMEvpEs31wOxVdKU0ViDx54p148B1jt86synMPlwrEQvgaS9RK0ONNmg3cv
	rNhfY9VW50o7DU1twnZR7DhMItabLtpfXFjoI0obsrLQnE4Gx0Xut4pJPNC+Pjq7
	1KEAduVkjOJtY0A5zT7w2YQH9kD7wBmKudwas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPMKDt5Y9gd8nOKPIZ1TfkGtcTS3XoM3
	C6XIo+C7nqBLwXV5v11mROPZgGUK4uJAhUmsvhpUDbWMb3XGgLSV6vUCw04BC4Iz
	vJmBIDfgO9GzdLbK0Ln2FdCf9+Y37WGUVCS/2ovI3LlTYNBShymMFkS3KlwASS5N
	TrAnmjQ1vHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 650734355E;
	Fri, 20 Sep 2013 21:06:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDF7B4355A;
	Fri, 20 Sep 2013 21:06:13 +0000 (UTC)
In-Reply-To: <20130920191226.GB31170@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Sep 2013 15:12:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7B912ADE-2238-11E3-A544-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235081>

Jeff King <peff@peff.net> writes:

> So I think it should be possible to fix our internal consumers 
> ... I'm a little wary
> of external consumers that might get confused by it.

Yeah, thanks for a good summary of analysis.  I agree that it would
be doable, but it is dubious if it is worth it.

>
> ---
> diff --git a/builtin/log.c b/builtin/log.c
> index 77d0f5f..77564fd 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1235,6 +1235,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		rev.no_inline = 1;
>  	}
>  
> +	from = xstrdup(git_committer_info(IDENT_NO_DATE));
> +
>  	/*
>  	 * Parse the arguments before setup_revisions(), or something
>  	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
