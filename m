From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] silence git gc --auto --quiet output
Date: Mon, 24 Sep 2012 15:42:14 -0700
Message-ID: <7v3927xcu1.fsf@alter.siamese.dyndns.org>
References: <20120924024024.GA12700@tin.tmux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tobias Ulmer <tobiasu@tmux.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 00:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGHMD-0007Ie-61
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 00:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab2IXWmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 18:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab2IXWmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 18:42:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711BF86AE;
	Mon, 24 Sep 2012 18:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hYvRcObmwGmsYsgo0FcGX+Nlv9w=; b=T/j21H
	gvCokCnnzPK1eH0vw5MD0MpIKi5++8adk2iOZP/ND/uDya8SB7Yt27TNxF+k6aqk
	FTJpdhj7SI0ochsSW88XQgGFdXN5Fe1fMFbiAQK0Dzf3F1pHopHfds2fMyZ0b9a/
	E1Iki5I5X3hb7bBv7uUPici6teCNWjOV2whyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDFMgwwVov2Do/8t+ldUcVk4bVTW0z+1
	1sH6/qaBh7rYcKKz5A8xxj/CRKzxHW6srhY9J8quxCnDzmJswMDL9Qzbl6f2+1qM
	kCXh3SZ59juuUdGCPXHPgTiD7qydZ9w2lPcMkUGAl75oiJ8UFkJqXZm5DxEbDe3B
	9R3Aa4Gglwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E41C86AD;
	Mon, 24 Sep 2012 18:42:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D118886AC; Mon, 24 Sep 2012
 18:42:15 -0400 (EDT)
In-Reply-To: <20120924024024.GA12700@tin.tmux.org> (Tobias Ulmer's message of
 "Mon, 24 Sep 2012 04:40:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 16E88340-0699-11E2-B687-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206332>

Tobias Ulmer <tobiasu@tmux.org> writes:

> When --quiet is requested, gc --auto should not display messages unless
> there is an error.
>
> Signed-off-by: Tobias Ulmer <tobiasu@tmux.org>
> ---
>  builtin/gc.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6d46608..6be6c8d 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -217,9 +217,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		 */
>  		if (!need_to_gc())
>  			return 0;
> -		if (quiet)
> -			fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
> -		else
> +		if (!quiet)
>  			fprintf(stderr,
>  					_("Auto packing the repository for optimum performance. You may also\n"
>  					"run \"git gc\" manually. See "

This patch will break t5400; the test needs to be updated in the
same patch to check auto-gc kicks in when it should in some other
way.  The test currently _relies_ on this message to see the gc is
triggered.
