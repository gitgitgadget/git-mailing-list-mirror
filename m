From: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] userdiff: add built-in pattern for CSS
Date: Fri, 27 May 2016 09:48:17 +0200 (CEST)
Message-ID: <2067613701.116691.1464335297679.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <352724780.115915.1464334324896.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	gitster@pobox.com, Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri May 27 09:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6COW-0008M2-BJ
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 09:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbcE0HlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 03:41:12 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:60894 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752103AbcE0HlL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2016 03:41:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 140C5256C;
	Fri, 27 May 2016 09:41:08 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zd-Albk-NxLD; Fri, 27 May 2016 09:41:08 +0200 (CEST)
Received: from zm-int-mbx5.grenet.fr (zm-int-mbx5.grenet.fr [130.190.242.144])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 03A702560;
	Fri, 27 May 2016 09:41:08 +0200 (CEST)
In-Reply-To: <5747669C.9020807@kdbg.org>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: userdiff: add built-in pattern for CSS
Thread-Index: +EMfGpJGMcCwynvcmW7qHaXpx2ofeg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295741>

Junio C Hamano <gitster@pobox.com> writes:
> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
>
>> As the CSS pattern
>> does not deal with letters at all it seemed sensible to me to follow
>> the example of the HTML pattern, which use PATTERNS().
> 
> Did you notice that HTML pattern has to do an [Hh] that would be
> unnecessary if it chose to use IPATTTERN()?
> 
> You do not have to ask a person, but instead ask the history.
> IPATTERN() was added at 909a5494 (userdiff.c: add builtin fortran
> regex patterns, 2010-09-10) when adding fortran support.  Anything
> that existed before, including HTML, did [A-Za-z] when they could
> have done [a-z] if IPATTERN() existed back then.

I hadn't noticed that the HTML pattern was older, indeed

>>>  - In our codebase, we format multi-line comments in a particular
>>>    way, namely
>>> 
>>> 	   /*
>>>          * A multi-line comment begins with slash asterisk
>>>          * on its own line, and its closing asterisk slash
>>>          * also is on its own line.
>>>          */
>>
>> I take good note of that. I took example on the fortran pattern
>> comment, should I fix it too while I'm at it?
> 
> Not "while you are at it".
> 
> Making existing things better is welcome but such a change shouldn't
> be mixed with addition of new things.  You can do it as a separate
> patch, probably as a preliminary clean-up before your change, if you
> want to.

OK !


Johannes Sixt <j6t@kdbg.org> writes:
> Am 24.05.2016 um 16:25 schrieb William Duclot:
>> +PATTERNS("css",
>> +	 "^([^,{}]+)((,[^}]*\\{)|([ \t]*\\{))$",
> 
> This hunk header pattern is a bit too restrictive for my taste. Find
> below a few more test cases that you should squash in. One case fails
> because only the first CSS selector is picked up, for which I do not
> see a reason.
> 
> Another case fails because the opening brace is not on the line with
> the CSS selectors.

Yes, it seems you're right !

> I think what the hunk header pattern should do is:
> 
> 1. reject lines containing a colon (because that are properties)
> 2. if a line begins with a name in column 1, pick the whole line
> 
> See the cpp patterns: a pattern beginning with ! is a "reject" pattern.

That may be a good idea, I will look into that

> diff --git a/t/t4018/css-brace-in-col-1 b/t/t4018/css-brace-in-col-1
> new file mode 100644
> index 0000000..7831577
> --- /dev/null
> +++ b/t/t4018/css-brace-in-col-1
> @@ -0,0 +1,5 @@
> +RIGHT label.control-label
> +{
> +    margin-top: 10px!important;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-rule b/t/t4018/css-common
> similarity index 100%
> rename from t/t4018/css-rule
> rename to t/t4018/css-common
> diff --git a/t/t4018/css-long-selector-list b/t/t4018/css-long-selector-list
> new file mode 100644
> index 0000000..7ccd25d
> --- /dev/null
> +++ b/t/t4018/css-long-selector-list
> @@ -0,0 +1,6 @@
> +p.header,
> +label.control-label,
> +div ul#RIGHT {
> +    margin-top: 10px!important;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-prop-sans-indent b/t/t4018/css-prop-sans-indent
> new file mode 100644
> index 0000000..a9e3c86
> --- /dev/null
> +++ b/t/t4018/css-prop-sans-indent
> @@ -0,0 +1,5 @@
> +RIGHT, label.control-label {
> +margin-top: 10px!important;
> +padding: 0;
> +border : 10px ChangeMe #C6C6C6;
> +}
> diff --git a/t/t4018/css-short-selector-list
> b/t/t4018/css-short-selector-list
> new file mode 100644
> index 0000000..6a0bdee
> --- /dev/null
> +++ b/t/t4018/css-short-selector-list
> @@ -0,0 +1,4 @@
> +label.control, div ul#RIGHT {
> +    margin-top: 10px!important;
> +    border : 10px ChangeMe #C6C6C6;
> +}
> --
> 2.9.0.rc0.40.gb3c1388

Thanks for the test cases, I'll look into that as soon as I have time
