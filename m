From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] commit: check committer identity more strictly
Date: Mon, 23 Jul 2012 13:51:25 -0700
Message-ID: <7vvchejj5e.fsf@alter.siamese.dyndns.org>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185035.GB27588@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:51:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StPbJ-0004M3-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 22:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab2GWUv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 16:51:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50173 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832Ab2GWUv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 16:51:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA26F7998;
	Mon, 23 Jul 2012 16:51:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rtnmfWc5NM9RhboG4FqKNj8jzag=; b=rFbf2j
	mEpAXeMu8pMxGU31JiNANbMZKCZpbVDgwT+pbMO8sd6+S1t2D0HFrU1n5nOskn69
	UgSlVPfX0hMt/XvnnyVrKObcrHYnqDi9NSGmKpE9ohgAQ7f4846+5P0MHY8x+3d8
	Iedtq3r6qsbzZRD/oNxeM/emX5AivcMViY2H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGojbt01DGGEvxscQnNCyTLsqdV7PKZ0
	3PhhcaozOjtUr1EFWr6XRJPgRA4TsZpczYCaDCUBXMmmJmTQPkx5HOUKegWd4UJF
	ScJSwhT9GQys8pdE+yIQ+d0f8P8zwZuR30Ejnnz2bylrq8U4jwK9m06UpOi7z5qa
	8pnxOeriS7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8D817997;
	Mon, 23 Jul 2012 16:51:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 112457996; Mon, 23 Jul 2012
 16:51:26 -0400 (EDT)
In-Reply-To: <20120723185035.GB27588@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jul 2012 14:50:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BE5F77C-D508-11E1-A5F9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201979>

Jeff King <peff@peff.net> writes:

> Incidentally, this bug was masked prior to 060d4bb, as the
> initial loose call would taint the later strict call. So the
> commit would succeed (albeit with a bogus committer line in
> the commit object), and nobody noticed that our early check
> did not match the later one.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 95eeab1..20cef95 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -725,7 +725,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	strbuf_release(&sb);
>  
>  	/* This checks if committer ident is explicitly given */
> -	strbuf_addstr(&committer_ident, git_committer_info(0));
> +	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
>  	if (use_editor && include_status) {
>  		char *ai_tmp, *ci_tmp;
>  		if (whence != FROM_COMMIT)

Looks sensible.  Is this something we can detect in automated tests,
or is it too cumbersome to set up?
