From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 09:10:55 +0200
Message-ID: <535B5BFF.40002@kdbg.org>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Marius Ungureanu <marius.ungureanu@xamarin.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 09:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdwm0-0002e4-UH
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 09:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbaDZHLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 03:11:00 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:38808 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750715AbaDZHK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 03:10:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EC26FCDF84;
	Sat, 26 Apr 2014 09:10:56 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 106D719F3FF;
	Sat, 26 Apr 2014 09:10:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247146>

Am 26.04.2014 01:25, schrieb Marius Ungureanu:
> New keywords: foreach, break, in, try, finally, as, is, typeof, var,
> default, fixed, checked, unchecked, this, lock, readonly, unsafe,
> ref, out, base, null, delegate, continue.
> 
> Removed keywords: instanceof. It's only in Java.
> Moved keywords to happen before modifier parsing, as matching a keyword
> will stop modifiers from being matched.
> 
> Added method modifiers: extern, abstract.
> 
> Added properties modifiers: abstract.
> 
> Added parsing of events and delegates, which are like properties, but
> take an extra keyword.
> 
> The reasoning behind adding unsafe to keywords is being also a
> statement that can happen inline in code to mention blocks which are
> unsafe. Also, delegates are not necessarily declared in class bodies,
> but can also happen inline in other functions.
> 
> Keywords are based on MSDN docs.
> 
> Signed-off-by: Marius Ungureanu <marius.ungureanu@xamarin.com>

Thanks for your contribution.

Please write the commit message in imperative mood, and use full
sentences, not just fragments and avoid contractions ("it's"). Also,
don't capitalize the subject line and drop the full-stop:

   update C# userdiff patterns

   Add new keywords: foreach, break, ...

   Remove keyword instanceof because it is only in Java. ...

BTW, it is now dead easy to add test cases for userdiff patterns. Just
drop files with content like this into t/t4018:

---- t/t4018/csharp-ignore-statement-keywords -----
class Foo {
	public int RIGHT()
	{
		if (x)
		else
		try
		catch (y)
		...

		ChangeMe;
	}
}
-----------------------------------------

(This I just invented, I don't do C#.) See the README file in that
directory.

> ---
>  userdiff.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..7612c5d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -133,14 +133,14 @@ PATTERNS("cpp",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lLuU]*"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
>  PATTERNS("csharp",
> -	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
>  	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> -	 /* Properties */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
> +	 "^[ \t]*(((abstract|extern|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +	 /* Properties, events, delegates */
> +	 "^[ \t]*(((abstract|internal|new|override|private|protected|public|sealed|static|unsafe|virtual)[ \t]+)*((delegate|event)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
>  	 /* Type definitions */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
> +	 "^[ \t]*(((abstract|internal|new|override|partial|private|protected|public|sealed|static|unsafe)[ \t]+)*(class|enum|interface|struct)[ \t]+.*)$\n"
> +	 /* Keywords */
> +	 "!^[ \t]*(as|base|break|case|catch|checked|continue|default|delegate|do|else|finally|fixed|for|foreach|if|in|is|lock|new|null|out|readonly|ref|return|switch|this|throw|try|typeof|unchecked|unsafe|using|var|while)\n"
>  	 /* Namespace */
>  	 "^[ \t]*(namespace[ \t]+.*)$",
>  	 /* -- */

Here, you are moving keywords down, but in the commit message you say
that you "moved keywords to happen before modifier parsing". Aren't you
moving keywords *after* something? (Where the "modifiers" are here is
not obvious, but that can be attributed to that I don't do C#.)

BTW, I appreciate that you re-arrange keywords alphabetically. Could you
do that in the commit message, too?

-- Hannes
