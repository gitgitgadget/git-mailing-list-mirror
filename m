Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58419EED3
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770709485; cv=none; b=eqtYxnn7CsHAJ6N+tfOpt9ziNdR9V332rW5+Ba55TyZhZAXX7Df/Hq19v1xwy1Xe/MIoLr4/6i1PpaLDcQRsR+lo8RtuiP7PsXU06ksWekCuAuYVd99r3WEeSWUSSL7Ma8TUxdbx0kM7Hm5rxEr88qkgENZmy5eVPjXlhQgwJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770709485; c=relaxed/simple;
	bh=lHXTqgtPGn+YGMxmBFwloBWnfEaeywI1eIkEJ4oMDtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uo3yg98w+/lWNTBLCRZFuNXSnOhAtKQXD75vuggZ3YUpsOxVoZX9pHtjTKMDAgSnEbNH5bDxxFn80ht26IJKMyno2TFw1niLQ7G21wycqhJ1t81vF7R7dP3raqCO2vJTPQcRkSXlKRWfrUkwRUeWvqzwxnjKZitaMxl+YTgSkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fjggU1Sr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fjggU1Sr"
Received: (qmail 353568 invoked by uid 109); 10 Feb 2026 07:44:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=lHXTqgtPGn+YGMxmBFwloBWnfEaeywI1eIkEJ4oMDtM=; b=fjggU1Sr94w7G15lzXNi5SDPadeIaADQmGSazmlMNpCwkT2HvqXqgOb9T07pPVnAouFvdat2ovrpGZ1V6OZHa/HmLXfwlHJxz8vFVqmbC2b73ZUF/uscvJQb9i35aaYZEYpwOi+IUHyFv6TdnrRmTl4Rp69GANH4x9gYIR++txva6bmntEsfLMKEWbBREMosZ96nh+e8hTd/0UJu4UVihHwmu26D0uuL+wDf2WqFjg+u5sRdXKDdlwp32/W+ZfT51cmK6wq5+RnE0bllNYiExaQDlN1TavcwgBPhudwjyUixq5qLQxHEs2rGHhFEhOjYDU6zkk9bJXTPv0pgm918Ow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 07:44:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 698382 invoked by uid 111); 10 Feb 2026 07:44:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 02:44:46 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 02:44:41 -0500
From: Jeff King <peff@peff.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v1] alias: support UTF-8 characters via subsection syntax
Message-ID: <20260210074441.GE1756549@coredump.intra.peff.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260209220115.461109-1-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260209220115.461109-1-jonatan@jontes.page>

On Mon, Feb 09, 2026 at 11:01:15PM +0100, Jonatan Holmgren wrote:

> Git aliases are currently restricted to ASCII characters due to
> config key syntax limitations. This prevents non-English speakers
> from creating aliases in their native languages.
> 
> Add support for UTF-8 alias names using config subsections:
> 
>     [alias "förgrena"]
>         command = branch
> 
> The subsection name is matched verbatim (case-sensitive), while the
> existing flat syntax (alias.name) remains case-insensitive for
> backward compatibility. This approach uses existing config
> infrastructure and avoids complex Unicode normalization.

Thanks, this mostly looks quite good. I have a few comments below that
range from a few small bugs to project-specific gotchas to
style/readability suggestions.

> diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
> [...]

Usually patches do not fill out their own release notes, as it would
create many conflicts when merging topics in arbitrary order. Instead,
the maintainer generally writes up a blurb that goes in the merge
commits and is eventually placed in the release notes by script.
Suggesting a blurb does save work for the maintainer, but it should go
in the cover letter (so for a single patch, after the "---" lines).

There's a bit on this in Documentation/SubmittingPatches, under the
section "the-topic-summary".

> diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
> index 80ce17d2de..feba1e2022 100644
> --- a/Documentation/config/alias.adoc
> +++ b/Documentation/config/alias.adoca

Yay, I was happy to see nice comprehensive documentation here. And you
do not seem to have gotten caught by any of the (many) formatting
gotchas.

> +After defining these, you can run `git co`, `git hämta`, `git gömma`,
> +and `git "my alias with whitespace"` (note the quotes for aliases with spaces).

The use of literal backticks here makes sense, and if you haven't disabled it
with a build-time knob, they should be shown in bold. Curiously in my
build of the docs this doesn't quite work, and I get "git h" in bold,
but "ämta" unbolded. Weird, and presumably a bug in asciidoc (the
generated docbook xml shows the same thing, as does html). I get the
same with asciidoctor, too. I'm not sure if it is worth working around
it (or even how we would do so).

> diff --git a/alias.c b/alias.c
> index 1a1a141a0a..f0c5f12fdd 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -17,19 +17,45 @@ static int config_alias_cb(const char *key, const char *value,
>  			   const struct config_context *ctx UNUSED, void *d)
>  {
>  	struct config_alias_data *data = d;
> -	const char *p;
> +	const char *cmd, *subkey;
> +	size_t cmd_len;
> +	int is_subsection;
>  
> -	if (!skip_prefix(key, "alias.", &p))
> +	/* Use parse_config_key() to handle both 2-level and 3-level keys */
> +	if (parse_config_key(key, "alias", &cmd, &cmd_len, &subkey) < 0)
>  		return 0;
>  
> +	/*
> +	 * Support two syntaxes:
> +	 * 1. alias.name = value (simple, 2-level key)
> +	 * 2. [alias "name"] command = value (new, 3-level key)
> +	 */
> +	if (cmd) {
> +		if (strcmp(subkey, "command"))
> +			return 0;
> +		is_subsection = 1;
> +	} else {
> +		cmd = subkey;
> +		cmd_len = strlen(cmd);
> +		is_subsection = 0;
> +	}

OK, so versus what I showed earlier, we are keeping an is_subsection
flag in order to differentiate the cases. And then we use that below...

>  	if (data->alias) {
> -		if (!strcasecmp(p, data->alias)) {
> +		int match;
> +		if (is_subsection) {
> +			match = (strlen(data->alias) == cmd_len &&
> +				 !strncmp(data->alias, cmd, cmd_len));
> +		} else {
> +			match = (strlen(data->alias) == cmd_len &&
> +				 !strncasecmp(data->alias, cmd, cmd_len));
> +		}

...to decide whether to be case-insensitive or not. Makes sense.

I was going to suggest some simplifications here: if is_subsection is
false, then we know that cmd is a NUL-terminated string, and we could
just use strcasecmp() as before. And in fact, with that conditional we
do not need the "cmd" aliasing at all. Which also means we don't need a
separate flag to distinguish the cases.

You could just write:

  if (cmd) {
	match = (strlen(data->alias) == cmd_len &&
	         !strncmp(data->alias, cmd, cmd_len));
  } else {
	match = !strcasecmp(data->alias, subkey);
  }

But I guess we do use the redirection in the listing path later anyway:

>  	} else if (data->list) {
> -		string_list_append(data->list, p);
> +		string_list_append_nodup(data->list, xmemdupz(cmd, cmd_len));
>  	}

So maybe it is better as-is. I dunno. I have a feeling this would all
need even more refactoring even if we ever added any more alias.foo.*
config entries. So we can probably just leave it until then for more
rearranging.


One thing I did find a little funny is the use of the word "subkey" for
one variable. Usually we just call this the "key", but that name is
annoyingly already taken by the function parameter (well before your
patch). Usually we call that "var" instead. I don't know if it's worth
changing or not. It's probably only confusing to me because I've stared
at so many other Git config callback functions.

> diff --git a/t/t0014-alias-utf8.sh b/t/t0014-alias-utf8.sh

Is there any reason to add a new script here, and not just put these in
the existing t0014? If you were bailing from the script when the prereq
was not met, we'd need a separate script. But since you are using
per-test prereqs, they can just exist alongside the other alias tests.

And also, you can't have two scripts with the same number. ;) Running
"make test" should complain about that (I'll assume you ran your tests,
but manually as ./t0014).

> +# Skip if filesystem/locale doesn't support UTF-8
> +test_lazy_prereq UTF8_LOCALE '
> +	test_have_prereq !MINGW &&
> +	test_set_prereq UTF8_LOCALE
> +'

This is a slight mis-use of set_prereq. You should just need to return
success from the lazy-prereq function, and it will be set automatically.
So more like:

  test_lazy_prereq UTF8_LOCALE '
	test_have_prereq !MINGW
  '

At which point I wonder if there is much value in having UTF8_LOCALE at
all, and not just putting "!MINGW" in each of the tests.

Beyond that, my larger question is: what are we asking of the platform
and why does MINGW not work? We do not care about actual utf8 filesystem
support, since these are just aliases. As long as the config file can
store them and we can pass them on the command-line, that should be
enough.

> +test_expect_success UTF8_LOCALE 'setup UTF-8 aliases' '
> +	git config alias."förgrena".command branch &&
> +	git config alias."分支".command "branch --list" &&
> +	git config alias."test name".command status
> +'

Usually we'd just define these in the tests that use them, which keeps
each individual test a bit more self-contained. So more like:

  test_expect_success 'UTF-8 alias with Swedish characters' '
	test_config alias."förgrena".command branch &&
	git förgrena >output &&
	...
  '

But we use them in the listing test, too, so they are each used twice. I
dunno. It might make sense for the listing test to just define its own
expected set.

> +test_expect_success UTF8_LOCALE 'UTF-8 alias with Swedish characters' '
> +	git förgrena >output &&
> +	test_grep -E "^(\* )?(main|master)" output
> +'

So I see we're aliasing "branch" here, which gives us this complicated
regex for checking the output. Would something like "!echo ran my alias"
make the test easier to understand?

> +test_expect_success 'list UTF-8 aliases' '
> +	git config --get-regexp "^alias\\..*\\.command" >output &&
> +	test_line_count -ge 3 output
> +'

This one needs the UTF8_LOCALE prereq, too (since we'd only have set up
those aliases if we had it).

Is doing --get-regexp here all that interesting? It's not testing your
new code at all, and would have passed already. I expected us to look at
the output of "git help -a" to see that the entries are listed.

And trying that with your patch:

  ./git -c alias.föo.command=branch help -a

shows some possible issues:

  - we show it as "föo.command"

  - the alignment with other aliases is not quite right. Probably it is
    using a byte-count instead of utf8_strwidth()

I was puzzled that we would not parse it as föo correctly, since your
patch modified the listing code. It looks like help.c has its own
separate parser for this. Yuck. :( I think this also means that "git
help föo" will fail.

So probably we want a preparatory patch to teach help.c to rely on
list_aliases() and alias_lookup() from alias.[ch].

> +test_expect_success 'flat syntax still works' '
> +	git config alias.testlegacy status &&
> +	git testlegacy >output &&
> +	test_grep "On branch" output
> +'

This probably is covered elsewhere already, but OK. :)

> +test_expect_success 'new subsection syntax works' '
> +	git config alias.testnew.command status &&
> +	git testnew >output &&
> +	test_grep "On branch" output
> +'

Nice basic test without utf8. Good.

> +test_expect_success 'subsection syntax only accepts command key' '
> +	git config alias.invalid.notcommand "value" &&
> +	test_must_fail git invalid 2>error &&
> +	test_grep -i "not a git command" error
> +'

Good thinking.

> +test_expect_success 'simple syntax is case-insensitive' '
> +	git config alias.LegacyCase status &&
> +	git legacycase >output 2>&1 &&
> +	test_grep "On branch" output
> +'
> +
> +test_expect_success 'subsection syntax is case-sensitive' '
> +	test_commit case-test &&
> +	git config alias.SubCase.command "log --oneline" &&
> +	git config alias.subcase.command status &&
> +	git SubCase >upper.out 2>&1 &&
> +	git subcase >lower.out 2>&1 &&
> +	! test_cmp upper.out lower.out
> +'

And these are both very nice to see.

-Peff
