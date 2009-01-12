From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v6 1/3] lstat_cache(): more cache effective
 symlink/directory detection
Date: Sun, 11 Jan 2009 20:05:45 -0800
Message-ID: <7vbpudkw2u.fsf@gitster.siamese.dyndns.org>
References: <1231680542-17315-1-git-send-email-barvik@broadpark.no>
 <1231680542-17315-2-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Mon Jan 12 05:07:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LME57-0000yu-8o
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 05:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZALEFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 23:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbZALEFy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 23:05:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZALEFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 23:05:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7F928F763;
	Sun, 11 Jan 2009 23:05:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D7C288F761; Sun,
 11 Jan 2009 23:05:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DE4E484-E05E-11DD-B6A3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105288>

Kjetil Barvik <barvik@broadpark.no> writes:

> -static inline void set_pathname(int len, const char *name, struct pathname *match)
> +static inline void reset_lstat_cache(void)
>  {
> -	if (len < PATH_MAX) {
> -		match->len = len;
> -		memcpy(match->path, name, len);
> -		match->path[len] = 0;
> -	}
> +	cache.path[0] = '\0';
> +	cache.len = 0;
> +	cache.flags = 0;
>  }

I see you made this internal to the caching code, but I suspect in the
long run there needs to be a way for callers that use the caching
mechanism to check and then create new paths in the work tree to
invalidate the cached code (namely, builtin-apply.c::write_out_results()
and entry.c::checkout_entry() codepaths).

I'll queue this round to 'pu' anyway, though.

Thanks.
