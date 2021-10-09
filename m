Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FFC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A5060F70
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhJIOfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbhJIOfe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 10:35:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16595C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 07:33:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y12so34565007eda.4
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=H0PLKci7M0+T204HK2QbKGNf0BLsW+oCUw7vKaxM3pI=;
        b=aUD0pV+thQuUWly/0vwqOMak/ERsRDc6Jmbhe7Ejs1SfAc8LeCTm15Q2eSDMQHsM2T
         DfH0rayaYvkP4jBwvx7LhZDJ8OXAkKv490+GrsQV6JvGpazaZZhaEasXUZoKeDHUzEnI
         DtGI+5Y+4wQj9S4fnrKa9HVOaHjZD74oAfptT2iqBPiJdHH3hZDcMcJiVkWyzXf6HK3z
         7SE6+Y/+qdJuA6lS4RBCCPMkjAZQ2sDHyny2CeWZunEtJVMBSQQGvWgIZJ3iP4wAPGkV
         fm8Zw82RqCHAPPsbLj0KluUFO7NoVqC3vGKq3Z0fhcWS6h8cX122CvD9uCylEvYT4689
         SeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=H0PLKci7M0+T204HK2QbKGNf0BLsW+oCUw7vKaxM3pI=;
        b=1SSpKaVy4svzXI2zxnHjt+W9dfFf/qxlMMXln0uBKkS2aPou7FizPLxcqVWbx4tM9Y
         p0UWajoU+Gf5EO0M7/tdJUSg8oEuQMtqpTeViXX4SQN3iGHAmBQqIIq56L3p38OrLZ+i
         BCmnBoxiDpz3Wi6VUT5eGhcz7DDELc2eywqPPGOEC42GFs8ppcXuJCSMfAPb/sUCMN7P
         L2oq280/JsZOci0Hbw4bFQ+riGLfyftpdoaR2xz582TniWTjLBX03OHM+9kbVct9ECgV
         Vjt6RMZY0GPySjS528rTp5uetRCfiBVIV29MH9aUWuS0Kb1wOq1NoEBY6z04M3nf1ozr
         5Waw==
X-Gm-Message-State: AOAM532Kh4qMWD6+2ou/of4Cjkp0dCGFiqKC3bT3fpu+/j1XnE6I0db7
        FGO0gPwbp2xJL5aSh5+JJ+vHt98l68temw==
X-Google-Smtp-Source: ABdhPJyif1HQ8tr8iwBQvQYeN5PHTywbjNRzdcnQa3d2y1+Pe9KZzqnHjLgdl4GlRn/Akkb9qYgyeQ==
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr16354109edd.101.1633790015475;
        Sat, 09 Oct 2021 07:33:35 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u16sm1054590ejy.14.2021.10.09.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 07:33:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechows?= =?utf-8?Q?ki?= 
        <giecrilj@stegny.2a.pl>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Date:   Sat, 09 Oct 2021 15:47:16 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
Message-ID: <871r4umfnm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Jeff King wrote:

> On Fri, Oct 08, 2021 at 10:36:02PM -0400, Jeff King wrote:
>
>> If that were coupled with, say, an advise() call to explain that output
>> and matching might be inaccurate (and show that _once_), that might
>> might it more clear what's going on.
>> 
>> Now I am sympathetic to flooding the user with too many messages, and
>> maybe reducing this to a single instance of "some commit messages could
>> not be re-encoded; output and matching might be inaccurate" is the right
>> thing. But in a sense, it's also working as designed: what you asked for
>> is producing wrong output over and over, and Git is saying so.
>
> The single-output version would perhaps be something like this:
>
> diff --git a/pretty.c b/pretty.c
> index 708b618cfe..c86f41bae7 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -606,6 +606,21 @@ static char *replace_encoding_header(char *buf, const char *encoding)
>  	return strbuf_detach(&tmp, NULL);
>  }
>  
> +static void show_encoding_warning(const char *output_encoding)
> +{
> +	static int seen_warning;
> +
> +	if (seen_warning)
> +		return;
> +
> +	seen_warning = 1;
> +	warning("one or more commits could not be re-encoded to '%s'",
> +		output_encoding);
> +	advise("When re-encoding fails, some output may be in an unexpected\n"
> +	       "encoding, and pattern matches against commit data may be\n"
> +	       "inaccurate.");
> +}
> +
>  const char *repo_logmsg_reencode(struct repository *r,
>  				 const struct commit *commit,
>  				 char **commit_encoding,
> @@ -673,7 +688,7 @@ const char *repo_logmsg_reencode(struct repository *r,
>  	 * case we just return the commit message verbatim.
>  	 */
>  	if (!out) {
> -		warning("unable to reencode commit to '%s'", output_encoding);
> +		show_encoding_warning(output_encoding);
>  		return msg;
>  	}
>  	return out;

I'm not categorically opposed to having this warning stay, because I can
imagine an implementation of it that isn't so overmatching, but I think
neither one of us is going to work on that, so ....

We have the exact same edge case in the grep-a-file code, and it's a
delibirate decision to stay quiet about it.

Let's assume your pattern contains non-ASCII, you've asked for
locale-aware grepping, you want \d+ to mean all sorts of Unicode
fuzzyness instead of just [0-9] etc. (not yet implemented, PCRE_UCP).

It would still be annoying to see a warning every time you grep without
providing a pathspec that blacklists say the 100 '*.png' files that are
in your tree.

And that's a case where we *could* say that the user should mark them
with .gitattributes or whatever, but making every git user go through
that would be annoying to them, so we just do our best and silently fall
back.

Similarly with this, let's say I'm on an OS that likes UTF-16 better, as
some of our users do, I have the relevant settings to re-encode git.git
or linux.git. Now run:

    git -c i18n.logOutputEncoding=utf16 log --author=foobarbaz

And it's 2 warnings in git.git, and 157 in linux.git. Anyway, your
commit above makes that 1 in both cases, which is certainly a *lot*
better.

But I think similar to the grep-a-file case it's still way to much, now
just because I've got some old badly encoded commits in my history I'll
see one warning every time a log revision walk/grep comes across those.

On the "not categorically opposed" I think that this sort of warning
/might/ be good if:

 * It weren't enabled by default, or at least as a transition had
   something like a advise() message pointing at a fsck.skipList-like
   (or other instructions, replace?) about how to quiet it.

 * We're realy dumb with how we chain data->iconv->PCRE here. I.e. we'll
   whine that we can't reencode just to match my "foobarbaz", but we
   could just keep walking past bad bytes. We should ideally say "we
   might have matched your data, but *because* of the encoding failure
   we couldn't.

   We can easily know with something like "foobarbaz" that that's not
   the case.

Anyway, I think all of that we can leave for the future, because I'd
simply assumed that this was based on some report that had to do with
someone not matching with --grep or whatever because of the details of
the encoding going wrong, e.g. a string that's later in a commit
message, but a misencoded character tripped it up.

But in this case this seems to have been because someone tried to feed
"HTML" to it, which is not an encoding, and something iconv_open() has
(I daresay) always and will always error on. It returns -1 and sets
errno=EINVAL.

So having a warning or other detection in the revision loop seems
backwards to me, surely we want something like the below instead?
I.e. die as close to bad option parsing as possible?

Note that this will now die if we have NO_ICONV=Y, even with your patch,
that seems like a feature. Now we'll silently ignore it. I.e. we'll warn
because we failed to re-encode, but we're using a stub function whose
body is:

    { if (e) *e = 0; return NULL; }

So ditto the garbage encoding name we should have died a lot earlier.

Aside from your warning test the below makes tests in t4201-shortlog.sh
fail, but those just seem broken to me. I.e. they seem to rely on git
staying quiet if i18n.commitencoding is set to garbage.

diff --git a/environment.c b/environment.c
index 43bb1b35ffe..c26b18f8e5c 100644
--- a/environment.c
+++ b/environment.c
@@ -357,8 +357,18 @@ void set_git_dir(const char *path, int make_realpath)
 
 const char *get_log_output_encoding(void)
 {
-	return git_log_output_encoding ? git_log_output_encoding
+	const char *encoding = git_log_output_encoding ? git_log_output_encoding
 		: get_commit_output_encoding();
+#ifndef NO_ICONV
+	iconv_t conv;
+	conv = iconv_open(encoding, "UTF-8");
+	if (conv == (iconv_t) -1 && errno == EINVAL)
+		die_errno("the '%s' encoding is not known to iconv", encoding);
+#else
+	if (strcmp(encoding, "UTF-8"))
+		die("compiled with NO_ICONV=Y, can't re-encode to '%s'", encoding);
+#endif
+	return encoding;
 }
 
 const char *get_commit_output_encoding(void)
