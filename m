Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 08:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbiCBIBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbiCBIBV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 03:01:21 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A4B6D22
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 00:00:37 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4K7mkp3fw6z5tlD;
        Wed,  2 Mar 2022 09:00:34 +0100 (CET)
Message-ID: <34a2ad39-604c-4edd-ea1c-de1212fc506b@kdbg.org>
Date:   Wed, 2 Mar 2022 09:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-1-jaydeepjd.8914@gmail.com>
 <20220302064504.2651079-2-jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220302064504.2651079-2-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Added jc to Cc:.

Am 02.03.22 um 07:45 schrieb Jaydeep P Das:
> diff --git a/t/t4034/kotlin/expect b/t/t4034/kotlin/expect
> new file mode 100644
> index 0000000000..8acdc83bcc
> --- /dev/null
> +++ b/t/t4034/kotlin/expect
> @@ -0,0 +1,35 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 884560d..7e136e2 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,19 +1,19 @@<RESET>
> +println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
> +<RED>100000<RESET><GREEN>100_000<RESET>

This test does not demonstrates that numbers do not end at an '_',
because if it did end there, the change would be from the single token
100000 to two tokens 100 and _000, and the mark-up would look exactly
the same as we see here, and would remain undiagnosed.

Instead, write the pre-image as 100_000 and the post image as 200_000.
Then the correct mark-up would be

<RED>100_000<RESET><GREEN>200_000<RESET>

and a bogus markup (that the test wants to diagnose) would look like

<RED>100<RESET><GREEN>200<RESET>_000

> +[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
> +!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET><GREEN>y<RESET>
> +a<RED>+=<RESET><GREEN>-=<RESET>b

OK, so you decided to check operator += and -=. But what about all the
other multi-character operators?

> +<RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> shl <RED>b a<RESET><GREEN>y x<RESET> shr <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> and <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>^<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> or <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>&&<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>||<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET>

This line is the best candidate to check many multi-character operators.
For example, the pre-image could read

a=b c+=d e-=f g*=h i/=j k%=l m<<=n o>>=p q&=r s^=t u|=v

and the post-image

a+=b c=d e<=f g>=h i/j k%l m<<n o>>p q&r s^t u|v

but there are more operators to check.

Please either make these changes or drop this t4034 test case, because
in its current form it gives a false sense of security, IMHO.

> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>,y
> +-<RED>a<RESET><GREEN>x<RESET>+2

What do you want to demonstrate with this new test case? If you want to
show that the + in +2 is not part of the number, then you must change,
for example, "a+2" to "a+1". If you change only the a to x, then we do
not know whether the +2 was regarded as one token or two.

> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..b92572b582 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,14 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> +	 /* -- */
> +	 "[_]?[a-zA-Z][a-zA-Z0-9_]*"

An underscore followed by a digit is not an identifier, but a number,
right? Then this expression correctly does not match and the following
expression dedicated to numbers takes care of it. Good.

> +	 /*hexadecimal, integers and binary numbers*/
> +	 "|(0x0F|0b)?[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*"

What is this "0x0F"? Did you mean just "0x"? And what about prefixes 0X
and 0B? Are they not used as prefixes for hex and binary numbers?
Moreover, I do not see how a hex number 0xff would be matched as a
single token.

> +	 /*match unary and binary operators*/
> +	 "|[-+*/<>%&^|=!]*"),

Do not do this. There is an implicit single-character match that need
not be written down in the regex. List all multi-character operators
(but not the single-character operators) like you did in earlier rounds.
As written, the "++!=" in an expression such as "a++!=b++" (which is not
unlikely to be seen in real code) would be regarded as a single token.

The verb "match" in the comment does not match the style of the other
comments (drop the word), and please insert blanks between the comment
delimiters and the text.

>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

-- Hannes
