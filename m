From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "builtin-*" references to be "builtin/*"
Date: Tue, 18 Jun 2013 10:06:28 -0700
Message-ID: <7vd2rj5ox7.fsf@alter.siamese.dyndns.org>
References: <1371571166-6481-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:06:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozMa-0000HD-BS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116Ab3FRRGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:06:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860Ab3FRRGb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:06:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92793285CB;
	Tue, 18 Jun 2013 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EHk12jkB6/DDHnmfA9Fq+9AI/HY=; b=s9k1WV
	tqohajI7kf5WLJwX+3Rngrg41/8KR7XKed/uiVeSbDC1i/wyPlEqv6c7zn+dOro7
	Ss7guriX9oCzevFht/4esOSgDLu7Z3d5+YOZcg5mE103+XbinP9XWCBW2uDEBga4
	k4b7HjkANnOgKckYGaBgTeVzCJ0chqBGGwfKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8285nMWLhoiHg6Q+qCk0i8WE01HM5km
	oYg8JM2ewyY66gwmG96o8iD78YNvytEY1eai7OhqdkQAOYEBP4zsfsHYCiPL/Rfq
	vBvKVfRWFz8R8WGp2jiIHFP4CkIt2nJr5/wD1bfGBakOzhiOwwURJhAM0GjfCzEG
	QmIoW9g+kCM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85FA2285CA;
	Tue, 18 Jun 2013 17:06:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFB25285C8;
	Tue, 18 Jun 2013 17:06:29 +0000 (UTC)
In-Reply-To: <1371571166-6481-1-git-send-email-hordp@cisco.com> (Phil Hord's
	message of "Tue, 18 Jun 2013 11:59:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B49E70E-D839-11E2-A7BF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228277>

Phil Hord <hordp@cisco.com> writes:

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index e831cc2..2483700 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -4256,7 +4256,7 @@ no longer need to call `setup_pager()` directly).
>  Nowadays, `git log` is a builtin, which means that it is _contained_ in the
>  command `git`.  The source side of a builtin is
>  
> -- a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c`,
> +- a function called `cmd_<bla>`, typically defined in `builtin/<bla>.c`,
>    and declared in `builtin.h`,

If we were to do this, we would need to update the "1.5.3 or newer"
comment at the top of this file to "1.7.1 or newer" ;-).

More seriously, it may be OK to say

	typically defined in `builtin/<bla.c>` (note that older
	versions of Git used to have it in `builtin-<bla>.c`
	instead), and declared in `builtin.h`.

only here, and then apply your s|builtin-|builtin/| changes to the
remainder of this file.

> diff --git a/builtin/help.c b/builtin/help.c
> index 062957f..ce7b889 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -1,5 +1,5 @@
>  /*
> - * builtin-help.c
> + * builtin/help.c
>   *
>   * Builtin help command
>   */

As Jonathan said, dropping this line (and the line after it) would
be a sane thing to do.

Other than that, the patch looked good.
