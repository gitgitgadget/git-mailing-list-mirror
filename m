Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EA01C6FE0
	for <git@vger.kernel.org>; Sat, 15 Feb 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630241; cv=none; b=ThlVpbXrxnHu9ldr4+bw0VZXkif/7YBrgwNjB/ez3pCil1zF/hyEgx7QUZ5tzE8robyBo7oAQJtTJmtujIubk2Gf680ZsAoDhmC7bM+fila4l4R7iuCFSeRUI0Ih5+tH4UezCb8v6uQdXzmPhA0cKzznEJ0DTVcefRj8kO9J11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630241; c=relaxed/simple;
	bh=+VzW4S45BRNer/iC9lo4yaPU8V3ShxcgBpTSHCmrDaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNzqKZtI+ci7v82ca1YDsIDiZbz11o/pncEvwW647otrv096MUDtOzaEFLiVtzuURyLQ7QtVmKyBHGb6H8cY1cgkhexQH4F/yv7vFnFLAmYcScA0VendZLMOIV6TKQL+ZTrpxNkxY0YJJJMlrfOYK/yrTXzI2JhWENNX2iXZtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4YwBMV27lBzRrb9;
	Sat, 15 Feb 2025 15:37:10 +0100 (CET)
Message-ID: <5c2abae6-f06d-4f42-a705-c02a9f0dd4f5@kdbg.org>
Date: Sat, 15 Feb 2025 15:37:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Added built in function recognition for shell
To: Moumita <dhar61595@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Atharva Raykar <raykar.ath@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
References: <20250211114611.9334-1-dhar61595@gmail.com>
 <20250211114611.9334-2-dhar61595@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250211114611.9334-2-dhar61595@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 11.02.25 um 12:46 schrieb Moumita:
> Introduced a built-in userdiff driver for shell scripts, enabling
> accurate function name recognition in `git diff` hunk headers.
> 
> Enhancements include:
> - Function name detection for both POSIX and Bash/Ksh-style functions:
>   - `function_name() { ... }`
>   - `function function_name { ... }`
> - Exclusion of shell keywords that can resemble function names,
>   preventing false matches (e.g., `if`, `for`, `while`, `return`, etc.).
> - Improved tokenization support for:
>   - Identifiers (variable and function names)
>   - Numeric constants (integers and decimals)
>   - Shell variables (`$VAR`, `${VAR}`)
>   - Logical (`&&`, `||`, `==`, `!=`, `<=`, `>=`) and arithmetic operators
>   - Assignment and redirection operators
>   - Brackets and grouping symbols
> 
> This update improves Git’s diff readability for shell scripts,
> bringing it in line with existing built-in userdiff drivers.

Please remove the marketing tone from the commit message.

 - "accurate function name recognition": Is not possible because the
tools (regular expressions) don't have sufficient context to allow it.

 - "Enhancements include": Either list *all* enhancements, or focus on
noteworthy ones, but don't make a long list that's still incomplete.

 - The word "improve" is never needed in the context that we see it
here, because you certainly don't want to worsen the code base.

Please study section "Describe your changes well" in
Documentation/SubmittingPatches on how to write the commit message.
(Describe the state before the change in present tense, and the changes
in imperative mood.)

An important point is *why* we want this change. In the case of a new
userdiff driver, however, the answer is usally simply "because we can",
and everybody knows it. Please don't write a long paragraph that dances
around this fact. Just don't write it; but if there are other reason,
please do say so.

> 
> Signed-off-by: Moumita <dhar61595@gmail.com>

The name given in Signed-off-by has legal meaning. If you have a given
name and a surname, please use both names here and then by extension
also as patch author.

> ---
>  userdiff.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..a8c14807c6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -334,6 +334,26 @@ PATTERNS("scheme",
>  	 "\\|([^\\\\]*)\\|"
>  	 /* All other words should be delimited by spaces or parentheses */
>  	 "|([^][)(}{[ \t])+"),
> +PATTERNS("shell",

Correctly sorted into the list. Good!

HOWEVER! We already have a diffdriver for bash. It would be better to
extend that one than to introduce a new driver.

> +	 /* Negate shell keywords that can look like functions */
> +	 "!^[ \t]*(if|elif|else|fi|for|while|until|case|esac|then|do|done|return|break|continue)\\b\n"

This list looks unnecessary. The userdiff driver can assume that it
operates on syntactically valid text.

   if () {
   }

isn't correct, and that's the case for all listed keywords.

> +	 /* POSIX-style shell functions: function_name() { ... } */
> +	 "^[ \t]*([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\(\\)[ \t]*\\{\n"

Two nitpicks:

- There can be whitespace between the parentheses.
- The function body can also be in parentheses.

   foo ( ) (
      echo
   )

would be a correct shell function definition. Its body always runs in a
sub-shell.

> +	 /* Bash/Ksh-style functions: function function_name { ... } */
> +	 "^[ \t]*function[ \t]+([a-zA-Z_][a-zA-Z0-9_]*)[ \t]*\\{\n",

Both here and above, just let the regular expression end before the
opening bracket. Then it would also recognize this oddity:

function x \
  { echo x; }

> +	 /* -- */
> +	 /* Identifiers: variable and function names */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* Numeric constants: integers and decimals */
> +	 "|[-+]?[0-9]+(\\.[0-9]*)?"

Typically, a - or + isn't part of the number, but a separate operator. I
suggest to drop the leading '[-+]?'. But see below.

> +	 /* Shell variables: $VAR and ${VAR} */
> +	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"

The uses of ${name} are rather exceptional. The cases where ${ is used
are the complex cases, for example:

    base=${fname##*/}
    base=${base%."$ext"}

In such cases, I would prefer that the constituents of the expression
are their own tokens and not lumped into a single "variable name" token.

> +	 /* Logical and comparison operators */
> +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
> +	 /* Assignment and arithmetic operators */
> +	 "|[-+*/%&|^!=<>]=?"

Which makes me think: Text in shell commands has only very little
restrictions. A typical case are command options starting with one or
two dashes. Do we want to separate the dash from the option name? This
regular expression would do so, and I would consider it a deficiency.

> +	 /* Brackets and grouping symbols */
> +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>  	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
>  { .name = "default", .binary = -1 },

It would be nice to have some tests. Have a look at t/t4018/bash-* and
t/t4034/* (no bash there, yet).

-- Hannes

