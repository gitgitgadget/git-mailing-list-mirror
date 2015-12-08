From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] dir: add remove_untracked_cache()
Date: Tue, 08 Dec 2015 11:15:23 -0800
Message-ID: <xmqqwpsokb04.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-7-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:15:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Nja-0002Fd-2F
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 20:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbLHTP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 14:15:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854AbbLHTP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 14:15:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FF1730955;
	Tue,  8 Dec 2015 14:15:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slZbquKJJwt/lClXvgNMJkHZqMw=; b=fVsUIX
	ZtPeoV8/f6di5C6RVCaDy3JtumKW2yIrmZ1fh2AnKWJDhNn3rKQJs3w5dTthtWL7
	OzNuba6YczOVluYlHeXTe1f8KQr64z3V1TVlTXT+jslKHug/jVRvoSSILIOH3tGi
	PLh8LXpdMQPrNpTD9Y4Vmb6r9hjMNOvFGzLzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lmvvXW4pA8oRqSlRXFZTCzjwXPyo3rZE
	3KVVc5PTJk5uAcDhQwxC44eJN297F/5gf+94J6v1Gk3vHC7cchUK7QquvGdFRhAn
	qTcGmHC49W0HWx7wHRv1JE/t0fjZVt5crNwcopYu1kRuHd+gA3CH+flSJcuviPFE
	axjYUwPMK9U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 475A730954;
	Tue,  8 Dec 2015 14:15:25 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B9EFF30953;
	Tue,  8 Dec 2015 14:15:24 -0500 (EST)
In-Reply-To: <1449594916-21167-7-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 8 Dec 2015 18:15:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08ACEA00-9DE0-11E5-9F03-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282174>

Christian Couder <christian.couder@gmail.com> writes:

> This new function will be used in a later patch.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Up to this step I looked at and they made sense (I am not saying the
remainder of the series do not make sense).

I however wonder where the memory used for untracked cache goes when
this is called?

>  builtin/update-index.c | 3 +--
>  dir.c                  | 6 ++++++
>  dir.h                  | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 40530b0..e427657 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1126,8 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		add_untracked_cache();
>  		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
>  	} else if (untracked_cache == NO_UC && the_index.untracked) {
> -		the_index.untracked = NULL;
> -		the_index.cache_changed |= UNTRACKED_CHANGED;
> +		remove_untracked_cache();
>  		fprintf(stderr, _("Untracked cache disabled\n"));
>  	}
>  
> diff --git a/dir.c b/dir.c
> index 0f7e293..ffc0286 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1952,6 +1952,12 @@ void add_untracked_cache(void)
>  	the_index.cache_changed |= UNTRACKED_CHANGED;
>  }
>  
> +void remove_untracked_cache(void)
> +{
> +	the_index.untracked = NULL;
> +	the_index.cache_changed |= UNTRACKED_CHANGED;
> +}
> +
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
>  						      int base_len,
>  						      const struct pathspec *pathspec)
> diff --git a/dir.h b/dir.h
> index ee94c76..3e5114d 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
>  void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
>  void add_untracked_ident(struct untracked_cache *);
>  void add_untracked_cache(void);
> +void remove_untracked_cache(void);
>  #endif
