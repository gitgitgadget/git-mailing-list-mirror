From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] zero-initialize object_info structs
Date: Sun, 07 Jul 2013 10:34:18 -0700
Message-ID: <7vy59i46lh.fsf@alter.siamese.dyndns.org>
References: <20130707100133.GA18717@sigill.intra.peff.net>
	<20130707100329.GA19143@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:34:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvsqv-0005Np-5w
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab3GGReV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:34:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab3GGReV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:34:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9132AF67;
	Sun,  7 Jul 2013 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aY8hixhuqgrm90Eo6/2d3OlvJnQ=; b=Qv7tni
	Lk6XJSfr4RKxUGZyFlJ8e3AjJxGVxveQbssysalrImk+xWD+iujkt0jFUGOWPbg6
	axUwjLPSdwcvMmO7LI39VvPFyA/OIK5HFFAFn4kcHzA/ozSIGwAbvW6zuArSBxzi
	LbOb0Cwsp+k2LnjWr0FIppzoaCaGOWaTogu3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rHE0RRFNF/86DiGQxfOq8SPmq9RCHPCA
	QVS2dMCKmyINWB1OXBREmGCn2BM2FZELMaWKo/T49Y6QPSTOG80ANSlfbGKRVeaM
	TvTNBsKeo0eUF0QmMlyeEDXtAq4l3gHygUT6fTXn6DFqQCy/P6qlDhwUZc+p2jPr
	SGfyPNOiKvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 913282AF65;
	Sun,  7 Jul 2013 17:34:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283812AF63;
	Sun,  7 Jul 2013 17:34:20 +0000 (UTC)
In-Reply-To: <20130707100329.GA19143@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 7 Jul 2013 06:03:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74ADEC90-E72B-11E2-99CD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229782>

Jeff King <peff@peff.net> writes:

> Obviously I plan to add a new query type in the next patch, but this
> initialization is probably a reasonable thing to be doing anyway.

Yes. Thanks.

>
>  sha1_file.c | 2 +-
>  streaming.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 0af19c0..de06a97 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2428,7 +2428,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  
>  int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  {
> -	struct object_info oi;
> +	struct object_info oi = {0};
>  
>  	oi.sizep = sizep;
>  	return sha1_object_info_extended(sha1, &oi);
> diff --git a/streaming.c b/streaming.c
> index cabcd9d..cac282f 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -135,7 +135,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
>  				 struct stream_filter *filter)
>  {
>  	struct git_istream *st;
> -	struct object_info oi;
> +	struct object_info oi = {0};
>  	const unsigned char *real = lookup_replace_object(sha1);
>  	enum input_source src = istream_source(real, type, &oi);
