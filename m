From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git version statistics
Date: Thu, 31 May 2012 12:35:20 -0700
Message-ID: <7v396g6t53.fsf@alter.siamese.dyndns.org>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <20120531120018.GA24986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 21:35:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaB9b-0006gI-LA
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 21:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172Ab2EaTfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 15:35:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933148Ab2EaTfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 15:35:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 088C68B2D;
	Thu, 31 May 2012 15:35:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Mh6YN79GpeF01AlHKn3xXPnSKC0=; b=iPEU01
	5o8HxjGSuFN2R29pDWmt6wiyispx3IFFensj333QNLNieXXAu4Gb7klLiquePXtx
	xNcQ5JwDEdjTfFMkb091hg8adzUAMptdz9EOnxQjuJtDp7qRQ3py64hsw8rrjzV8
	x+0AY5raqTaGcJJovfs41JZktxNmwC/yIgKYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BFCTHprBcOgm6Y+WVVFauxMEZu4JMFXX
	18pHaapROqTPWy0LuZ8wx9gQAfrRwxcGHekgRzCR9ASBFUyd5lZJOOobbPOWSOCA
	MInXMLXxmQF0ovqzY4l2vbilrRbk03AYsh/KOe/eEw4M5wAhgufUtY7FjRcDx4P6
	ZV0WzvOUKp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F413D8B2C;
	Thu, 31 May 2012 15:35:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8897E8B2A; Thu, 31 May 2012
 15:35:21 -0400 (EDT)
In-Reply-To: <20120531120018.GA24986@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 31 May 2012 08:00:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2C0172A-AB57-11E1-A971-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198942>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 149db88..f3b8422 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -327,6 +327,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
>  			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
>  			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
>  			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
> +			strbuf_addf(&c, " agent=git/%s", git_version_string);
>  			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
>  			strbuf_release(&c);

Even though the version string GIT-VERSION-GEN script deduces from
the repository version is designed to be safe, in general "version"
file can contain a string with whitespaces.  You may want to be
careful about that in the above.

Do we want a similar identifier string on the other side of the
connection?
