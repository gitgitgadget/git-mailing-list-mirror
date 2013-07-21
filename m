From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "compat/unsetenv.c: Fix a sparse warning"
Date: Sun, 21 Jul 2013 15:09:44 -0700
Message-ID: <7v38r7sgyf.fsf@alter.siamese.dyndns.org>
References: <1374387454-27800-1-git-send-email-tsunanet@gmail.com>
	<1374436448-8199-1-git-send-email-tsunanet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Benoit Sigoure <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 00:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V11pC-0000S9-4c
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 00:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3GUWJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 18:09:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906Ab3GUWJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 18:09:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BAB232407;
	Sun, 21 Jul 2013 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y8Ouxid9XLh4QVvM13sXeRMab5U=; b=Jk35A3
	L5xlXWrWHW4GP7jHCR2JqAaNjJFyCKSAdqhHbjdlBS9aYkBxwaD39izcdg+sAEpp
	rm9nNwOfW4C8GmWqiXrXAtD9hmM9ZFdeY5XfH+85E6795R7xz7opOvipoJGO6CFY
	eYHwLcy+gbdpa5wMon0pQLtJFBDG5S0EVklOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kkJofFCugV15AjQMJXeFK6ykGImNsLmF
	1f3sOQ2+gl4lAhxTWxi7kIOy1KXSPB2ykO/trsecXcvnYPzQx0BGnbg6aCkMcO3S
	P/tB0dQ4JR/5qh9IDcgN8KJKy7BPfH6hV6zWUA+EmlVjA9j3HXB31tT6M4W6qgAD
	asGN06NaP7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F2EC32404;
	Sun, 21 Jul 2013 22:09:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 727DF32403;
	Sun, 21 Jul 2013 22:09:45 +0000 (UTC)
In-Reply-To: <1374436448-8199-1-git-send-email-tsunanet@gmail.com> (Benoit
	Sigoure's message of "Sun, 21 Jul 2013 12:54:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4050198C-F252-11E2-947B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230946>

Benoit Sigoure <tsunanet@gmail.com> writes:

> This reverts commit ec535cc27e6c4f5e0b1d157e04f5511f166ecd9d.
>
> POSIX explicitly states "the [environ] variable, which
> must be declared by the user if it is to be used directly".
> Not declaring it causes compilation to fail on OS X.
>
> Instead don't declare the variable on MinGW, as it causes
> a spurious warning there.
>
> Signed-off-by: Benoit Sigoure <tsunanet@gmail.com>

Thanks, will queue.

> ---
>
> Resending as I forgot to Sign-off the previous patch.
>
>  compat/unsetenv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/compat/unsetenv.c b/compat/unsetenv.c
> index 4ea1856..bf5fd70 100644
> --- a/compat/unsetenv.c
> +++ b/compat/unsetenv.c
> @@ -2,6 +2,9 @@
>  
>  void gitunsetenv (const char *name)
>  {
> +#if !defined(__MINGW32__)
> +     extern char **environ;
> +#endif
>       int src, dst;
>       size_t nmln;
