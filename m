Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6FC433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 08:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiCLJAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 04:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiCLJAS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 04:00:18 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7342325C5
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 00:59:09 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KFxYj5sP8z5tl9;
        Sat, 12 Mar 2022 09:59:05 +0100 (CET)
Message-ID: <1f10cfa1-83b8-49b1-f4df-829cada788bd@kdbg.org>
Date:   Sat, 12 Mar 2022 09:59:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     Jaydeep P Das <jaydeepjd.8914@gmail.com>
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220312044832.718356-1-jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20220312044832.718356-1-jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.22 um 05:48 schrieb Jaydeep P Das:
> The xfuncname pattern finds func/class declarations
> in diffs to display as a hunk header. The word_regex
> pattern finds individual tokens in Kotlin code to generate
> appropriate diffs.
> 
> This patch adds xfuncname regex and word_regex for Kotlin
> language.
> 
> Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>

This round looks good. Thank you for your perseverance.

Acked-by: Johannes Sixt <j6t@kdbg.org>

> ---
>  Documentation/gitattributes.txt |  2 ++
>  t/t4018/kotlin-class            |  5 ++++
>  t/t4018/kotlin-enum-class       |  5 ++++
>  t/t4018/kotlin-fun              |  5 ++++
>  t/t4018/kotlin-inheritace-class |  5 ++++
>  t/t4018/kotlin-inline-class     |  5 ++++
>  t/t4018/kotlin-interface        |  5 ++++
>  t/t4018/kotlin-nested-fun       |  9 +++++++
>  t/t4018/kotlin-public-class     |  5 ++++
>  t/t4018/kotlin-sealed-class     |  5 ++++
>  t/t4034-diff-words.sh           |  1 +
>  t/t4034/kotlin/expect           | 43 +++++++++++++++++++++++++++++++++
>  t/t4034/kotlin/post             | 30 +++++++++++++++++++++++
>  t/t4034/kotlin/pre              | 30 +++++++++++++++++++++++
>  userdiff.c                      | 12 +++++++++
>  15 files changed, 167 insertions(+)
>  create mode 100644 t/t4018/kotlin-class
>  create mode 100644 t/t4018/kotlin-enum-class
>  create mode 100644 t/t4018/kotlin-fun
>  create mode 100644 t/t4018/kotlin-inheritace-class
>  create mode 100644 t/t4018/kotlin-inline-class
>  create mode 100644 t/t4018/kotlin-interface
>  create mode 100644 t/t4018/kotlin-nested-fun
>  create mode 100644 t/t4018/kotlin-public-class
>  create mode 100644 t/t4018/kotlin-sealed-class
>  create mode 100644 t/t4034/kotlin/expect
>  create mode 100644 t/t4034/kotlin/post
>  create mode 100644 t/t4034/kotlin/pre
> 
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index a71dad2674..4b36d51beb 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -829,6 +829,8 @@ patterns are available:
>  
>  - `java` suitable for source code in the Java language.
>  
> +- `kotlin` suitable for source code in the Kotlin language.
> +
>  - `markdown` suitable for Markdown documents.
>  
>  - `matlab` suitable for source code in the MATLAB and Octave languages.
> diff --git a/t/t4018/kotlin-class b/t/t4018/kotlin-class
> new file mode 100644
> index 0000000000..bb864f22e6
> --- /dev/null
> +++ b/t/t4018/kotlin-class
> @@ -0,0 +1,5 @@
> +class RIGHT {
> +	//comment
> +	//comment
> +	return ChangeMe
> +}
> diff --git a/t/t4018/kotlin-enum-class b/t/t4018/kotlin-enum-class
> new file mode 100644
> index 0000000000..8885f908fd
> --- /dev/null
> +++ b/t/t4018/kotlin-enum-class
> @@ -0,0 +1,5 @@
> +enum class RIGHT{
> +	// Left
> +	// a comment
> +	ChangeMe
> +}
> diff --git a/t/t4018/kotlin-fun b/t/t4018/kotlin-fun
> new file mode 100644
> index 0000000000..2a60280256
> --- /dev/null
> +++ b/t/t4018/kotlin-fun
> @@ -0,0 +1,5 @@
> +fun RIGHT(){
> +	//a comment
> +	//b comment
> +    return ChangeMe()
> +}
> diff --git a/t/t4018/kotlin-inheritace-class b/t/t4018/kotlin-inheritace-class
> new file mode 100644
> index 0000000000..77376c1f05
> --- /dev/null
> +++ b/t/t4018/kotlin-inheritace-class
> @@ -0,0 +1,5 @@
> +open class RIGHT{
> +	// a comment
> +	// b comment
> +	// ChangeMe
> +}
> diff --git a/t/t4018/kotlin-inline-class b/t/t4018/kotlin-inline-class
> new file mode 100644
> index 0000000000..7bf46dd8d4
> --- /dev/null
> +++ b/t/t4018/kotlin-inline-class
> @@ -0,0 +1,5 @@
> +value class RIGHT(Args){
> +	// a comment
> +	// b comment
> +	ChangeMe
> +}
> diff --git a/t/t4018/kotlin-interface b/t/t4018/kotlin-interface
> new file mode 100644
> index 0000000000..f686ba7770
> --- /dev/null
> +++ b/t/t4018/kotlin-interface
> @@ -0,0 +1,5 @@
> +interface RIGHT{
> +	//another comment
> +	//another comment
> +	//ChangeMe
> +}
> diff --git a/t/t4018/kotlin-nested-fun b/t/t4018/kotlin-nested-fun
> new file mode 100644
> index 0000000000..12186858cb
> --- /dev/null
> +++ b/t/t4018/kotlin-nested-fun
> @@ -0,0 +1,9 @@
> +class LEFT{
> +	class CENTER{
> +		fun RIGHT(  a:Int){
> +			//comment
> +			//comment
> +			ChangeMe
> +		}
> +	}
> +}
> diff --git a/t/t4018/kotlin-public-class b/t/t4018/kotlin-public-class
> new file mode 100644
> index 0000000000..9433fcc226
> --- /dev/null
> +++ b/t/t4018/kotlin-public-class
> @@ -0,0 +1,5 @@
> +public class RIGHT{
> +	//comment1
> +	//comment2
> +	ChangeMe
> +}
> diff --git a/t/t4018/kotlin-sealed-class b/t/t4018/kotlin-sealed-class
> new file mode 100644
> index 0000000000..0efa4a4eaf
> --- /dev/null
> +++ b/t/t4018/kotlin-sealed-class
> @@ -0,0 +1,5 @@
> +sealed class RIGHT {
> +	// a comment
> +	// b comment
> +	ChangeMe
> +}
> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index d5abcf4b4c..15764ee9ac 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -324,6 +324,7 @@ test_language_driver dts
>  test_language_driver fortran
>  test_language_driver html
>  test_language_driver java
> +test_language_driver kotlin
>  test_language_driver matlab
>  test_language_driver objc
>  test_language_driver pascal
> diff --git a/t/t4034/kotlin/expect b/t/t4034/kotlin/expect
> new file mode 100644
> index 0000000000..7f76f7540d
> --- /dev/null
> +++ b/t/t4034/kotlin/expect
> @@ -0,0 +1,43 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 11ea3de..2e1df4c 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,30 +1,30 @@<RESET>
> +println("Hello World<RED>!\n<RESET><GREEN>?<RESET>")
> +<GREEN>(<RESET>1<GREEN>) (<RESET>-1e10<GREEN>) (<RESET>0xabcdef<GREEN>)<RESET> '<RED>x<RESET><GREEN>y<RESET>'
> +[<RED>a<RESET><GREEN>x<RESET>] <RED>a<RESET><GREEN>x<RESET>-><RED>b a<RESET><GREEN>y x<RESET>.<RED>b<RESET><GREEN>y<RESET>
> +!<RED>a a<RESET><GREEN>x x<RESET>.inv() <RED>a<RESET><GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>&<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b a<RESET><GREEN>y x<RESET>%<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET><GREEN>y<RESET>
> +a <RED>shr<RESET><GREEN>shl<RESET> b
> +<RED>a<RESET><GREEN>x<RESET><<RED>b a<RESET><GREEN>y x<RESET><=<RED>b a<RESET><GREEN>y x<RESET>><RED>b a<RESET><GREEN>y x<RESET>>=<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>==<RED>b a<RESET><GREEN>y x<RESET>!=<RED>b a<RESET><GREEN>y x<RESET>===<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> and <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>^<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET> or <RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>&&<RED>b a<RESET><GREEN>y x<RESET>||<RED>b<RESET>
> +<RED>a<RESET><GREEN>y<RESET>
> +<GREEN>x<RESET>=<RED>b a<RESET><GREEN>y x<RESET>+=<RED>b a<RESET><GREEN>y x<RESET>-=<RED>b a<RESET><GREEN>y x<RESET>*=<RED>b a<RESET><GREEN>y x<RESET>/=<RED>b a<RESET><GREEN>y x<RESET>%=<RED>b a<RESET><GREEN>y x<RESET><<=<RED>b a<RESET><GREEN>y x<RESET>>>=<RED>b a<RESET><GREEN>y x<RESET>&=<RED>b a<RESET><GREEN>y x<RESET>^=<RED>b a<RESET><GREEN>y x<RESET>|=<RED>b<RESET><GREEN>y<RESET>
> +a<RED>=<RESET><GREEN>+=<RESET>b c<RED>+=<RESET><GREEN>=<RESET>d e<RED>-=<RESET><GREEN><=<RESET>f g<RED>*=<RESET><GREEN>>=<RESET>h i<RED>/=<RESET><GREEN>/<RESET>j k<RED>%=<RESET><GREEN>%<RESET>l m<RED><<=<RESET><GREEN><<<RESET>n o<RED>>>=<RESET><GREEN>>><RESET>p q<RED>&=<RESET><GREEN>&<RESET>r s<RED>^=<RESET><GREEN>^<RESET>t u<RED>|=<RESET><GREEN>|<RESET>v
> +a<RED><<=<RESET><GREEN><=<RESET>b
> +a<RED>||<RESET><GREEN>|<RESET>b a<RED>&&<RESET><GREEN>&<RESET>b
> +<RED>a<RESET><GREEN>x<RESET>,y
> +--a<RED>==<RESET><GREEN>!=<RESET>--b
> +a++<RED>==<RESET><GREEN>!=<RESET>++b
> +<RED>0xFF_EC_DE_5E 0b100_000 100_000<RESET><GREEN>0xFF_E1_DE_5E 0b100_100 200_000<RESET>
> +a<RED>==<RESET><GREEN>===<RESET>b
> +a<RED>!!<RESET><GREEN>!=<RESET>b
> +<RED>_32<RESET><GREEN>_33<RESET>.find(arr)
> +X.<RED>fill<RESET><GREEN>find<RESET>()
> +X.<RED>u<RESET><GREEN>f<RESET>+1
> +X.u<RED>-<RESET><GREEN>+<RESET>2
> +a<RED>.<RESET><GREEN>..<RESET>b
> +a<RED>?.<RESET><GREEN>?:<RESET>b
> +<RED>.32_00_456<RESET><GREEN>.32_00_446<RESET>
> diff --git a/t/t4034/kotlin/post b/t/t4034/kotlin/post
> new file mode 100644
> index 0000000000..2e1df4c6d5
> --- /dev/null
> +++ b/t/t4034/kotlin/post
> @@ -0,0 +1,30 @@
> +println("Hello World?")
> +(1) (-1e10) (0xabcdef) 'y'
> +[x] x->y x.y
> +!x x.inv() x*y x&y
> +x*y x/y x%y
> +x+y x-y
> +a shl b
> +x<y x<=y x>y x>=y
> +x==y x!=y x===y
> +x and y
> +x^y
> +x or y
> +x&&y x||y
> +x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
> +a+=b c=d e<=f g>=h i/j k%l m<<n o>>p q&r s^t u|v
> +a<=b
> +a|b a&b
> +x,y
> +--a!=--b
> +a++!=++b
> +0xFF_E1_DE_5E 0b100_100 200_000
> +a===b
> +a!=b
> +_33.find(arr)
> +X.find()
> +X.f+1
> +X.u+2
> +a..b
> +a?:b
> +.32_00_446
> diff --git a/t/t4034/kotlin/pre b/t/t4034/kotlin/pre
> new file mode 100644
> index 0000000000..11ea3de665
> --- /dev/null
> +++ b/t/t4034/kotlin/pre
> @@ -0,0 +1,30 @@
> +println("Hello World!\n")
> +1 -1e10 0xabcdef 'x'
> +[a] a->b a.b
> +!a a.inv() a*b a&b
> +a*b a/b a%b
> +a+b a-b
> +a shr b
> +a<b a<=b a>b a>=b
> +a==b a!=b a===b
> +a and b
> +a^b
> +a or b
> +a&&b a||b
> +a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
> +a=b c+=d e-=f g*=h i/=j k%=l m<<=n o>>=p q&=r s^=t u|=v
> +a<<=b
> +a||b a&&b
> +a,y
> +--a==--b
> +a++==++b
> +0xFF_EC_DE_5E 0b100_000 100_000
> +a==b
> +a!!b
> +_32.find(arr)
> +X.fill()
> +X.u+1
> +X.u-2
> +a.b
> +a?.b
> +.32_00_456
> diff --git a/userdiff.c b/userdiff.c
> index 8578cb0d12..0f6c14659b 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -168,6 +168,18 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> +PATTERNS("kotlin",
> +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* hexadecimal and binary numbers */
> +	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> +	 /* integers and floats */
> +	 "|[0-9][0-9_]*([.][0-9_]*)?([Ee][-+]?[0-9]+)?[fFlLuU]*"
> +	 /* floating point numbers beginning with decimal point */
> +	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
> +	 /* unary and binary operators */
> +	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

