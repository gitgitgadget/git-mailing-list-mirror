From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Tue, 24 May 2016 12:06:16 -0700
Message-ID: <xmqqmvnf46on.fsf@gitster.mtv.corp.google.com>
References: <20160520132829.7937-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 21:06:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Hes-0003er-9d
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbcEXTGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:06:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752304AbcEXTGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:06:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E4581C0C3;
	Tue, 24 May 2016 15:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xyMVfQwlJrAh4cjDOVFo9XnrUUU=; b=twBlIr
	tfvwhLEj2o8/BiSTMuNbz/nzNNjksb8cBIjAdF/nXkxOyIu1HgTqIUg1SvIpM4Kd
	t0i2E8U5cDST3osuTONh83M0R0PvV6rAeFLOOunJg1rDlLnTwJDI+a0dMmWNfAdx
	cMBC5eGmK4ssW27cScLh4nVgbMXnc/1vWByP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6umDXjbmfpcMQzB+nbMykl2zsomxxu6
	C9F0/yej2rkhdlYnAyYYlWq7edWogqSVi9ZWLj/5urxgeCHsc6RhjgzHnROIJ2qS
	onFA1fz1pQ/gT3UibGIkhtH9fu/hVgP2I44dqwI8Jp5cKhmTNQeLa4EexLY3Xizd
	gfB3OxHjm3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5559B1C0C2;
	Tue, 24 May 2016 15:06:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B373E1C0C1;
	Tue, 24 May 2016 15:06:18 -0400 (EDT)
In-Reply-To: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
	(William Duclot's message of "Tue, 24 May 2016 16:25:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 989CF2F0-21E2-11E6-82E9-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295521>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:

> CSS is widely used, motivating it being included as a built-in pattern.
>
> It must be noted that the word_regex for CSS (i.e. the regex defining
> what is a word in the language) does not consider '.' and '#' characters
> (in CSS selectors) to be part of the word. This behavior is documented
> by the test t/t4018/css-rule.
> The logic behind this behavior is the following: identifiers in CSS
> selectors are identifiers in a HTML/XML document. Therefore, the '.'/'#'
> character are not part of the identifier, but an indicator of the nature
> of the identifier in HTML/XML (class or id). Diffing ".class1" and
> ".class2" must show that the class name is changed, but we still are
> selecting a class.
>
> Signed-off-by: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> changes since v1:
> Fix a typo in the word_regex ("A-F" => "A-Z").
> Clearer comment about ISO 10646 characters.

It is not a big deal for a small single-patch topic like this, but
it often is hard to reviewers if you do not respond to comments you
received and instead just send a new version of the patch with
"changes since..." comment.  Please make it a habit to do both.

I can see in the above "changes since v1" comment, you took the
A-F/A-Z thing, but I cannot tell if you thought about PATTERNS vs
IPATTERN and rejected IPATTERN with a good reason or if you simply
missed it when reading the review comments you received, for
example.

Three remaining issues are:

 - Have you considered using IPATTERN()?  PATTERNS() that defaults
   case sensitive match is suitable for real languages with fixed
   case keywords, but the pattern you are defining for CSS does not
   do anything special for any set of fixed-case built-in keywords,
   and appears to be better served by IPATTERN().

 - In our codebase, we format multi-line comments in a particular
   way, namely

	/*
         * A multi-line comment begins with slash asterisk
         * on its own line, and its closing asterisk slash
         * also is on its own line.
         */

 - Try not to write overlong lines.  If your expression needs to
   become long and there is no good place to fold lines, that is one
   thing, but an overlong comment is unexcuable, as you can fold
   lines anywhere between words.

Thanks.

> diff --git a/userdiff.c b/userdiff.c
> index 6bf2505..9273969 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -148,6 +148,14 @@ PATTERNS("csharp",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"),
> +PATTERNS("css",
> +	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",
> +	 /* -- */
> +	 /* This regex comes from W3C CSS specs. Should theoretically also allow ISO 10646 characters U+00A0 and higher,
> +	  * but they are not handled with this regex. */
> +	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
> +	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
> +),
>  { "default", NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
