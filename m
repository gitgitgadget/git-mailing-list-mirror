From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 3 Jun 2016 07:52:45 +0200
Message-ID: <57511B2D.7040501@kdbg.org>
References: <20160524142537.19324-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 03 07:53:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8i2T-0008C0-MR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 07:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbcFCFwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 01:52:50 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:50829 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbcFCFwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 01:52:50 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rLYCg0n1Jz5tlM;
	Fri,  3 Jun 2016 07:52:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 02C8A5247;
	Fri,  3 Jun 2016 07:52:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160602224809.5167-1-william.duclot@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296266>

Am 03.06.2016 um 00:48 schrieb William Duclot:
> Logic behind the "pattern" regex is:

The name of the macro parameter is "pattern", but the actual meaning is 
"function name" regex.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index e3b1de8..81f60ad 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -525,6 +525,8 @@ patterns are available:
>
>   - `csharp` suitable for source code in the C# language.
>
> +- `css` suitable for source code in the CSS language.

CSS is not so much source code. How about "suitable for cascaded style 
sheets"?

> diff --git a/t/t4018/css-common b/t/t4018/css-common
> new file mode 100644
> index 0000000..84ed754
> --- /dev/null
> +++ b/t/t4018/css-common
> @@ -0,0 +1,4 @@
> +RIGHT label.control-label {
> +    margin-top: 10px!important;
> +    border : 10px ChangeMe #C6C6C6;
> +}

> diff --git a/t/t4018/css-rule b/t/t4018/css-rule
> new file mode 100644
> index 0000000..84ed754
> --- /dev/null
> +++ b/t/t4018/css-rule
> @@ -0,0 +1,4 @@
> +RIGHT label.control-label {
> +    margin-top: 10px!important;
> +    border : 10px ChangeMe #C6C6C6;
> +}

These two are the same. Please pick only one. I propose the name 
"common" because it is how CSS rules are written most commonly.

> +IPATTERN("css",
> +	 "!^.*;\n"

Is there a difference between this and "!;\n"? Is it necessary to anchor 
the pattern at the beginning of the line?

In the commit message you talk about colon (':'), but you actually use a 
semicolon (';'). Thinking a bit more about it, rejecting lines with 
either one would be even better. Consider this case (without the 
indentation):

    h1 {
    color:
    red;
    }

(New test case, hint, hint!) Therefore, it could be: "![:;]\n".

> +	 "^[_a-z0-9].*$",
> +	 /* -- */
> +	 /*
> +	  * This regex comes from W3C CSS specs. Should theoretically also
> +	  * allow ISO 10646 characters U+00A0 and higher,
> +	  * but they are not handled in this regex.
> +	  */
> +	 "-?[_a-zA-F][-_a-zA-F0-9]*" /* identifiers */

Drop A-F.

> +	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */

Here, too: it is an IPATTERN.

-- Hannes
