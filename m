Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D901A9FAB
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259785; cv=none; b=eYIF3kl/B4w14gFrijdEsobcjXeatVhFeRkJE7EkonFOr8RHy8nSWe/zIVrOih0IoZ6WqT78T5svjx4S6a4z5hARFZxadbqDuJ7804T8QCtHcNMxz+pLkMCvKtHZDhH1GZvYRCMPi7nz7U9q1S1ENimuGp2++bRlTUAl8WARKf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259785; c=relaxed/simple;
	bh=G7mhe3R6+6cXeaa0oGTjgRJ9K1CstVOthiEE15Sjzc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdvdLhOXcEF5ORv08q/w2orR04mnoh5Aq6rG64cE0tzY6bWbp3U8fFGba49RpVnL0QiIRb1XSmRXCHNWVLdNBhzFOVEHKYBxCnR6QmmobEFm1/BVs1RNUXOAp+829XPV2vkS65jz+nYAm+0733qb5pDnN/6w9SZI3DxQgxlBPC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dHLwX4541zRnQP;
	Thu, 27 Nov 2025 17:09:32 +0100 (CET)
Message-ID: <b6656e6d-d1e8-4ebe-821f-9211643a71ab@kdbg.org>
Date: Thu, 27 Nov 2025 17:09:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] merge with Scheme regexp; fix bugs
Content-Language: en-US
To: "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Scott L. Burson" <Scott@sympoiesis.com>, git@vger.kernel.org
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
 <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <86315aa3e36afa1ee741a2c9b9e95a71ca569302.1764211096.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 27.11.25 um 03:38 schrieb Scott L. Burson via GitGitGadget:
> From: "Scott L. Burson" <Scott@sympoiesis.com>
> 
> This commit merges (by disjoining) the new generic Lisp regexp into
> the existing Scheme regexp.  It also fixes two bugs: the new regexp
> was unintentionally allowing tabs, and the matching of "(def" should
> be case-insensitive.
> 
> Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
> ---
>  userdiff.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index e127b4a1f1..b67dfddbef 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -249,14 +249,6 @@ PATTERNS("kotlin",
>  	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
>  	 /* unary and binary operators */
>  	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
> -PATTERNS("lisp",
> -	 /* Either an unindented left paren, or a slightly indented line
> -	  * starting with "(def" */
> -	 "^((\\(|:space:{1,2}\\(def).*)$",
> -	 /* Common Lisp symbol syntax allows arbitrary strings between vertical bars */
> -	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"
> -	 /* All other words are delimited by spaces or parentheses/brackets/braces */
> -	 "|([^][(){} \t])+"),
>  PATTERNS("markdown",
>  	 "^ {0,3}#{1,6}[ \t].*",
>  	 /* -- */

You made this commit a fixup commit of the commit from the first round.
This isn't desirable as long as the earlier patch has not been
integrated in "next", yet.

You should have squashed the commits into one. The cover letter gives a
really good justification for this change and should be the commit's
message (with its subject line, ie, the PR title). However, don't write
"This commit does X", but write "Do X" instead: you give someone an
order to change the code. (Also, after squashing there is no bug to fix
anymore, of course.)

> @@ -352,14 +344,21 @@ PATTERNS("rust",
>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>  	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>  PATTERNS("scheme",
> -	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
> +	 /* A possibly indented left paren followed by a Scheme keyword. */
> +	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$\n"

Mental note how this RE is nested:

	[\t ]*(
		\((
			(
				define|def(
					struct|syntax|class|method
					|rules|record|proto|alias
				)?
			)[-*/ \t]
			|
			(
				library|module|struct|class
			)[*+ \t]
		).*
	)$

> +	 /*
> +	  * For other Lisp dialects: either an unindented left paren, or a
> +	  * slightly indented line starting with "(def".
> +	  */
> +	 "^((\\(| {1,2}\\([Dd][Ee][Ff]).*)$",

Here you are adding a very generous new pattern, the opening parenthesis
without indentation. This will not only apply to "other Lisp dialects",
as the comment says, but also Scheme code and will produce new matches.
It does not change the test cases in t/t4018/scheme-*, because all have
additional matches later.

As such it would possibly be more honest to extract it out into its own
(first) pattern and marked as applying to all dialects:

	/*
	 * An unindented opening parenthesis identifies a top-level
         * structure in all Lisp dialects.
	 */
	"^(\\(.*)$\n",

Note that the Scheme pattern excludes the indentation from the capture.
You may want to do so here, too (and simplify "one or two spaces" like
this):

	"^  ?(\\([Dd][Ee][Ff].*)$",

Would it be possible to have test cases of Lisp code that is not covered
by the Scheme pattern?

>  	 /*
> -	  * R7RS valid identifiers include any sequence enclosed
> -	  * within vertical lines having no backslashes
> +	  * The union of R7RS and Common Lisp symbol syntax: allows arbitrary
> +	  * strings between vertical bars, including escaped backslashes and
> +	  * vertical bars.
>  	  */
> -	 "\\|([^\\\\]*)\\|"
> +	 "\\|([^\\\\]|\\\\\\\\|\\\\\\|)*\\|"

Without the C quoting we have

	\|([^\\]|\\\\|\\\|)*\|

So, this is everthing from | up to the next |, except that \| does not
stop scanning and \\ is also considered so that \\| is not regarded as \
followed by \|. Good.

>  	 /* All other words should be delimited by spaces or parentheses */
> -	 "|([^][)(}{[ \t])+"),
> +	 "|([^][)(}{ \t])+"),

Here we have a single bracket expression. The removed opening [ does not
begin a new one, but is a duplicated character. Good.

-- Hannes

