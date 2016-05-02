From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Mon, 02 May 2016 12:15:46 -0700
Message-ID: <xmqqvb2ws23h.fsf@gitster.mtv.corp.google.com>
References: <20160502142813.50868-1-gitter.spiros@gmail.com>
	<20160502142813.50868-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 21:15:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJJy-0001li-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 21:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbcEBTPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 15:15:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58565 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754731AbcEBTPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 15:15:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C60F917348;
	Mon,  2 May 2016 15:15:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dGW0oV//djRq7Q56c76ozsz0AJw=; b=e3pXvF
	C5Pcc31HmFUtpkA9L71XtIJCeWoSJ5MCs8nXIPiWX0qW3QjXVLefFtHeAUNN0Z8Y
	TV6F+gO3GrVYPqGYGNc5RidgJ38Tv+pGUTYGKtvc7ZUh1oL7GCaBffplIMy4uSZG
	BZPQpklIm8VkO63+xFroYgaPjt106zAv05KOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eEOtndLpX3tDo20ZvwUEzKa6WvXfj8k8
	JP7S5gPv36gos9qTsRm/kq/j6oLcPy40P2RPDZxK8T3SFMrhLu5iNh6EMQpb69j6
	Y01iZ+927JFAdYUuMvkkWceQnWi05IerlpzGmrwWhhadoP5Q1cSgr0IULFgu3Dlb
	f73LcSSAgac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BDCC517347;
	Mon,  2 May 2016 15:15:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32AF017344;
	Mon,  2 May 2016 15:15:48 -0400 (EDT)
In-Reply-To: <20160502142813.50868-2-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Mon, 2 May 2016 14:28:12 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46EB1602-109A-11E6-9AD4-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293272>

Elia Pinto <gitter.spiros@gmail.com> writes:

> +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
> +{
> +	const char *text;
> +	(void)handle;		/* prevent compiler unused parameter warning if checked */
> +	(void)userp;		/* prevent compiler unused parameter warning if checked */
> +	int nopriv = 0;		/*

This decl-after-statment breaks our build.
