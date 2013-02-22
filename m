From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: populate the edit buffer with 2 blank lines
 before s-o-b
Date: Fri, 22 Feb 2013 10:35:04 -0800
Message-ID: <7vbobcdwo7.fsf@alter.siamese.dyndns.org>
References: <7vobfdtl1n.fsf@alter.siamese.dyndns.org>
 <1361525158-3648-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, jrnieder@gmail.com, john@keeping.me.uk,
	git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:35:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8xT5-0004uD-8G
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397Ab3BVSfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:35:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758225Ab3BVSfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:35:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DFE2B79A;
	Fri, 22 Feb 2013 13:35:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K5BpHs6RRWWLphFP79jJVe3fVx0=; b=C7J8tP
	7gaXLAUngA0BnvNXN2KX9I0JTfJ3yIv4HGV22C3FJ6teC2DA20DIS4elGOYdT7TW
	zftfLvUyFFZeO5LsQIaWpalrBrPxRfbbUaUyNRfIqkSoovCE92/maFudfE7Bsyjp
	oVAwp5tMhZC1Bh5rOpg6sH6m5rM2Su3SDYxuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vz+ovNEHpzKPXdiqVRbxQn8q8VVr2jek
	1ddm3RHKnG84DXgrknPx1kidbw0sqGimlRRdA1I6oEFAnj/4fj3toBAyc/exexN1
	D3lNUz4HQSroDsLwUBs5qSo0/RryCYu8CTNgSl2QrzbSN/YS/LEh3T/bbsKgM52L
	rkoORFyYhng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22F70B799;
	Fri, 22 Feb 2013 13:35:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76670B796; Fri, 22 Feb 2013
 13:35:05 -0500 (EST)
In-Reply-To: <1361525158-3648-1-git-send-email-drafnel@gmail.com> (Brandon
 Casey's message of "Fri, 22 Feb 2013 01:25:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93B1F586-7D1E-11E2-AF3C-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216851>

Brandon Casey <drafnel@gmail.com> writes:

> Before commit 33f2f9ab, 'commit -s' would populate the edit buffer with
> a blank line before the Signed-off-by line.  This provided a nice
> hint to the user that something should be filled in.  Let's restore that
> behavior, but now let's ensure that the Signed-off-by line is preceded
> by two blank lines to hint that something should be filled in, and that
> a blank line should separate it from the Signed-off-by line.
>
> Plus, add a test for this behavior.
>
> Reported-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>
> Ok.  Here's a patch on top of 959a2623 bc/append-signed-off-by.  It
> implements the "2 blank lines preceding sob" behavior.
>
> -Brandon
>
>  sequencer.c       |  5 +++--
>  t/t7502-commit.sh | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 53ee49a..2dac106 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1127,9 +1127,10 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  		const char *append_newlines = NULL;
>  		size_t len = msgbuf->len - ignore_footer;
>  
> -		if (len && msgbuf->buf[len - 1] != '\n')
> +		/* ensure a blank line precedes our signoff */
> +		if (!len || msgbuf->buf[len - 1] != '\n')
>  			append_newlines = "\n\n";
> -		else if (len > 1 && msgbuf->buf[len - 2] != '\n')
> +		else if (len == 1 || msgbuf->buf[len - 2] != '\n')
>  			append_newlines = "\n";

Maybe I am getting slower with age, but it took me 5 minutes of
staring the above to convince me that it is doing the right thing.
The if/elseif cascade is dealing with three separate things and the
logic is a bit dense:

 * Is the buffer completely empty?  We need to add two LFs to give a
   room for the title and body;

 * Otherwise:

   - Is the final line incomplete?  We need to add one LF to make it a
     complete line whatever we do.

   - Is the final line an empty line?  We need to add one more LF to
     make sure we have a blank line before we add S-o-b.

I wondered if we can rewrite it to make the logic clearer (that is
where I spent most of the 5 minutes), but I did not think of a
better way; probably the above is the best we could do.

Thanks.

By the way, I think we would want to introduce a symbolic constants
for the possible return values from has_conforming_footer().  The
check that appears after this hunk

	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
				sob.buf, sob.len);

is hard to grok without them.
