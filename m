From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] use skip_prefix to avoid magic numbers
Date: Mon, 23 Jun 2014 14:44:23 -0700
Message-ID: <xmqqa993b8so.fsf@gitster.dls.corp.google.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194750.GH22622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 23:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzC2V-0002tZ-3x
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 23:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaFWVob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 17:44:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53795 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbaFWVoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 17:44:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8364323A02;
	Mon, 23 Jun 2014 17:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9//D7lJIO+QB5yNr+9BmcSj6uoE=; b=uY1EFk
	9RVc+u6i37UwnIQ712jLk1GMQuB9PzjBtbWCUBZYYqNTonThEeUE6Mo8A6bsT1/3
	ER2a8B8Axt1xC+keq9QgGEg9pgRuc9UXLYC+ge5YfRMfcb7szH8v+bkK68nCs+Ki
	oXbSyvWUUKPs5VshXU2qeMq74oAoP0jFbwPqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTf6DUMaPiLS3oG1JTlMmTMg0K1YTzw1
	iFDn+JNn/X+9pubyWjMlXGbsLx6CehVyvcaRy8sfanS3mgB2o1beUJj4yrByiel0
	ZBqPEOzokLWTOAYZJzPNgQKx2MLKQDAIPo3CYWsKW3J+pDmcJ4rSXWQ4U4pWZ+OK
	jlCHCBtkjuQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7678C23A01;
	Mon, 23 Jun 2014 17:44:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7ECAF239FB;
	Mon, 23 Jun 2014 17:44:20 -0400 (EDT)
In-Reply-To: <20140618194750.GH22622@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jun 2014 15:47:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8895BAEA-FB1F-11E3-8143-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252372>

Jeff King <peff@peff.net> writes:

> diff --git a/connect.c b/connect.c
> index 94a6650..37ff018 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -140,12 +141,12 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  		if (!len)
>  			break;
>  
> -		if (len > 4 && starts_with(buffer, "ERR "))
> -			die("remote error: %s", buffer + 4);
> +		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
> +			die("remote error: %s", arg);

Makes one wonder if we should do something special to a line with
only "ERR " and nothing else on it, which the other end may have
meant us to give a blank line to make the output more readable.

A fix, if one turns out to be needed, is outside the scope of this
patch, though, I think.
