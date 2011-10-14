From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 13:24:07 -0700
Message-ID: <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 22:24:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REoIr-0003o3-2P
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 22:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab1JNUYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 16:24:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933194Ab1JNUYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 16:24:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 997A74319;
	Fri, 14 Oct 2011 16:24:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWSBWzfmCOoTebjm5ZDY1yU2iyw=; b=PV/5O4
	Yg1h7wwU2PMwo6JGZGj90Ts30IFeMUlYuvwGzTnx9JC91r3reVgxRhWfj6AD/MSn
	LNRpsVRBqdf+heNBsw9YKbYCFj+z59YI3hufBTmdjy0xFgzB/QdYn8TmAVkLQp7u
	ZEfH0p+RWm+7o+Inn3omQe4P0GpKZkv+HT3Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WjptBV5hJQ4l6LRwfmI6gt7vsst0j9S5
	7Zc5bUVdpQNdXnuK7oATY+VX26mee6S62sZLSbsqthlZqWw0PUpLyySbYaQMGQKy
	dFt8m9tRefaaL1DHlWk2GwdL4ZBhU6qdVC68S/8gWj/lBv3wgUKpifAiZmtnIOAl
	s+f7ySr7aNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FF9B4318;
	Fri, 14 Oct 2011 16:24:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7FE74317; Fri, 14 Oct 2011
 16:24:08 -0400 (EDT)
In-Reply-To: <20111014192741.GA13029@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 14 Oct 2011 15:27:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 789A5C6A-F6A2-11E0-ADC2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183605>

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] daemon: turn on informative errors by default
>
> These are only a problem if you have a bunch of inaccessible
> repositories served from the same root as your regular
> exported repositories, and you are sensitive about people
> learning about the existence of those repositories.
>
> Git is foremost an open system, and our defaults should
> reflect that.
>
> Signed-off-by: Jeff King <peff@peff.net>

I think the logic in the last paragraph is flawed.

There is a difference between Git being an open system, and installations
and users of Git being primarily people who work on open projects.

Even though personally I wish there weren't.

> But since it is a potential security issue, it does seem kind of mean to
> closed sites to just flip the switch on them.

It would have been a better split to have the 1/2 patch to support both
informative and uninformative errors, with the default to say "access
denied", and 2/2 to flip the default to be more open.

Will queue as-is, though.

>  Documentation/git-daemon.txt |    6 +++---
>  daemon.c                     |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index ac57c6d..2b17175 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -161,12 +161,12 @@ the facility of inet daemon to achieve the same before spawning
>  	repository configuration.  By default, all the services
>  	are overridable.
>  
> ---informative-errors::
> -	Return more verbose errors to the client, differentiating
> +--no-informative-errors::
> +	By default, we return verbose errors to the client, differentiating
>  	conditions like "no such repository" from "repository not
>  	exported". This is more convenient for clients, but may leak
>  	information about the existence of unexported repositories.
> -	Without this option, all errors report "access denied" to the
> +	With this option, all errors report "access denied" to the
>  	client.
