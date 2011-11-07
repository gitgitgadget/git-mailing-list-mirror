From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling
 textconv_object(), again
Date: Mon, 07 Nov 2011 08:47:23 -0800
Message-ID: <7vy5vr282s.fsf@alter.siamese.dyndns.org>
References: <4EB7FEE6.9000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:47:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSMF-0005R7-K1
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791Ab1KGQr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 11:47:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932668Ab1KGQr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:47:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6B9B436F;
	Mon,  7 Nov 2011 11:47:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RA4jiPtCBQvlW/a9miEbnocgpGg=; b=JmZ0K1
	rgcPmbbi0S1NBSlnJ42m7TNLdZKgwRMsbGUZYFESzArKxaia0JbgA5lpWnUvIpbF
	fvUmM8c2jvPY/V6psajUxeN+zW2nkjEi6RHS0zwakftg3o8/PhgmCMyBK6Hjzw3b
	3Em/pHmRF+/gILmWPdf87MJsw11vtRJvcgIiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLH63hK3oMWIC3Q4qAZLCNbri6qrIwtI
	cgAxl7Px1AJjQ6GFMB8BDrDtLj+gfFcx6YUPIPZeqBS6v9SWP1K3Gd5F0ywujqmW
	syeeiof5X0vVLKr+tf+bwk8XLirhc8B7os++D1b3SDRSJwy839vchj23ke9mV9U4
	/lAGpHuo6EM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE747436D;
	Mon,  7 Nov 2011 11:47:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54427436C; Mon,  7 Nov 2011
 11:47:25 -0500 (EST)
In-Reply-To: <4EB7FEE6.9000609@gmail.com> (Sebastian Schuberth's message of
 "Mon, 07 Nov 2011 16:53:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BC35704-0960-11E1-ADE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184996>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> 2564aa4 started to initialize buf.alloc, but that should actually be one
> more byte than the string length due to the trailing \0.

Even when the conversion result is a zero-length string?

> ---

Sign-off?

>  builtin/blame.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 86c0537..45f0dcc 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2114,7 +2114,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		case S_IFREG:
>  			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
>  			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
> -				buf.alloc = buf_len;
> +				buf.alloc = buf_len + 1;
>  				buf.len = buf_len;
>  			}
>  			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
