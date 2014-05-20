From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 10:53:11 -0700
Message-ID: <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
	<1400572806-21092-2-git-send-email-jmmahler@gmail.com>
	<20140520082740.GB27590@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 20 19:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmoEI-0007ZK-SG
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbaETRxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:53:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64582 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaETRxa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:53:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9B75918521;
	Tue, 20 May 2014 13:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmCGRM42vHZYYm8dDk5bK0BljfU=; b=dD/xln
	ODLUi3s1jQ5ru0H+5ifb7+h/M6S7DquKzt8expQV8zI19jnUWyCjPaDEubmN+jvY
	fFOp1d4nDyPAohC1MbwP0/MwNlw89mnaHiS1aAu3HaCVWXHM81zNuEEmvMt4ZBpv
	oAENL0yG6HhRg4qinbHnKZYTEVrckU/hIsqkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iCaJlLHQ1Tvv6q6c8MaHElbjKnbd6/iE
	Ck+AJqtFp+NZezXg4trWeuwRxqJAcit+Hpn7i5leiVwVLoRh7NWuA4Eyk6iEoZ7N
	eK9cOOV7d0Zeg+Eho+qy54L5X4aDddl90jIY+p3xNzEBqqkzE2KFpxaYDjl9++9Z
	f7kFdZLcEv8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FEFB1851F;
	Tue, 20 May 2014 13:53:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1F6418518;
	Tue, 20 May 2014 13:53:13 -0400 (EDT)
In-Reply-To: <20140520082740.GB27590@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 May 2014 04:27:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D49999A-E047-11E3-A29D-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249711>

Jeff King <peff@peff.net> writes:

> But one could easily specify a longer, multi-line signature,
> like:
>
>   git format-patch --signature='
>   this is my long signature
>
>   it has multiple lines
>   ' ...
>
> We should notice that it already has its own trailing
> newline, and suppress one of ours.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> In the example above, there's also a newline before the signature
> starts. Should we suppress the first one, too?
>
> Also, I'm not clear on the purpose of the extra trailing line in the
> first place. Emails now end with (">" added to show blanks):
>
>   > -- 
>   > 2.0.0-rc3...
>   >
>
> Is there are a reason for that final blank line?

I actually think these "supress extra LFs" trying to be overly smart
and inviting unnecessary surprises.  Unlike log messages people type
(in which we do squash runs of blank lines and other prettifying),
mail-signature string is not something people keep typing, and it
would be better to keep it simple and consistent, i.e. we can
declare that the users who use non-default mail-signature can and
should learn to:

    --signature='this is the first line of my long sig

    with a blank line and then it ends here'

and be done with it, I think.

The trailing blank after the mail-signature is a different issue.  I
think it is safe to remove it and I also think the result may look
better, but at the same time, it is very close to the "if we were
writing format-patch today, then we would..." category, I would say.

>  builtin/log.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 39e8836..5acc048 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
>  
>  static void print_signature(void)
>  {
> -	if (signature && *signature)
> -		printf("-- \n%s\n\n", signature);
> +	if (!signature || !*signature)
> +		return;
> +
> +	printf("-- \n%s", signature);
> +	if (signature[strlen(signature)-1] != '\n')
> +		putchar('\n');
> +	putchar('\n');
>  }
>  
>  static void add_branch_description(struct strbuf *buf, const char *branch_name)
