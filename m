From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] rev-parse --parseopt: allow [*=?!] in argument hints
Date: Mon, 13 Jul 2015 14:55:27 -0700
Message-ID: <xmqqlhejyb74.fsf@gitster.dls.corp.google.com>
References: <1436693990-2908-1-git-send-email-ilya.bobyr@gmail.com>
	<1436782355-3576-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Philip Oakley <philipoakley@iee.org>
To: ilya.bobyr@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 13 23:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZElhF-0003ZA-A0
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 23:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbbGMVz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 17:55:29 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36156 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbGMVz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 17:55:29 -0400
Received: by igbij6 with SMTP id ij6so32594626igb.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Zrn7FUcLdKaFUVNbgirsnkdvcAz2erhtnZOXJXEgMsA=;
        b=wMnI5qLIlIPxK74iKMGsR166QeBPqq1id0buNoYsv+vDMgyRJu1Fr7FUtnpKnoUffQ
         iHmbw96sfgn+0Y81DNcHyn1mY3MOobobr2MlU1G2CN0lyqY9ghsQbM+Wta3t5XJaRsQH
         ukdYEJwJYdE1B84F3wpDe8M86ny3SoNulKMkHXNz+cYl+WbsoX+nwHvKUM2KiYyZef6m
         blSFefW4LxURiarYyhNXGht8YqrnLsYcK1vnQobUyU/RCD247/pkolMjyzbgaCLcPK05
         FfmiI6ntSFvEAGX3l4LFya8Ng+eYfzPNGk0ustQCbREkV/KfjCATb3a20zfSeAxYEamD
         IKOQ==
X-Received: by 10.107.162.142 with SMTP id l136mr19247086ioe.166.1436824528363;
        Mon, 13 Jul 2015 14:55:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4d10:ec6a:e89:91cb])
        by smtp.gmail.com with ESMTPSA id o66sm13409111ioo.5.2015.07.13.14.55.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jul 2015 14:55:27 -0700 (PDT)
In-Reply-To: <1436782355-3576-1-git-send-email-ilya.bobyr@gmail.com> (ilya
	bobyr's message of "Mon, 13 Jul 2015 03:12:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273932>

ilya.bobyr@gmail.com writes:

> Junio, thank you very much for all the comments.  I hope I have included
> all of the suggestions you made.  Please, let me know if I have missed
> anything or if there is something else you think should be improved.

There were a few that still remained, which I locally amended.
Please check what is queued on 'pu'.

> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index c483100..2ea169d 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -311,8 +311,8 @@ Each line of options has this format:
>  `<opt-spec>`::
>  	its format is the short option character, then the long option name
>  	separated by a comma. Both parts are not required, though at least one
> -	is necessary. `h,help`, `dry-run` and `f` are all three correct
> -	`<opt-spec>`.
> +	is necessary. May not contain any of the `<flags>` characters.
> +	`h,help`, `dry-run` and `f` are all three correct `<opt-spec>`.

"are examples of correct <opt-spec>"?

>  
>  `<flags>`::
>  	`<flags>` are of `*`, `=`, `?` or `!`.
> @@ -331,8 +331,9 @@ Each line of options has this format:
>  `<arg-hint>`::
>  	`<arg-hint>`, if specified, is used as a name of the argument in the
>  	help output, for options that take arguments. `<arg-hint>` is
> -	terminated by the first whitespace.  It is customary to use a
> -	dash to separate words in a multi-word argument hint.
> +	terminated by the first whitespace.  It may contain any of the
> +	`<flags>` characters after the first character. It is customary to
> +	use a dash to separate words in a multi-word argument hint.

I think no change in this hunk is necessary for two reasons:

 - You already said in <opt-spec> that any letters used for flags
   cannot be used there, implying that the way rules are described
   in the document around here is that anything is allowed unless
   explicitly prohibited, which makes "It may contain..."
   unnecessary.

 - It may be worth saying "It may not contains any whitespace", but
   that is already implied with the existing "is terminated by the
   first whitespace".

> +		if (s - sb.buf == 1) /* short option only */
> +			o->short_name = *sb.buf;
> +		else if (sb.buf[1] != ',') /* long option only */
> +			o->long_name = xmemdupz(sb.buf, s - sb.buf);
> +		else {
> +			o->short_name = *sb.buf;
> +			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
> +		}
> +
> +		/* type */

s/type/flags/?

> +		while (s < help) {
> +			switch (*s++) {
>  			case '=':
>  				o->flags &= ~PARSE_OPT_NOARG;
> -				break;
> +				continue;
>  			case '?':
>  				o->flags &= ~PARSE_OPT_NOARG;
>  				o->flags |= PARSE_OPT_OPTARG;
> -				break;
> +				continue;

The updated code was a lot more pleasant read compared to the
original (and the v1 patch).

Thanks.
