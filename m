Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1AC05027
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 20:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjA2URY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 15:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjA2URX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 15:17:23 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703461C586
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 12:17:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id be8so9629535plb.7
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 12:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxcDW/Ok7C0PSpmB4bfOmdbhJ/r6w8gjRCtYuhOB/As=;
        b=cQsGSCIqv0t3AZ5jaeN51Eaas9PNH13qf3kR3JPHKwPDj3OsrM06lCCHFyQ/RZvVct
         KBcGpSF7wSM+QksMwI2dtzVFeyy/SCIRHYzLs9JhQBWSG3Y6kLnzXOBgnKZk+bdsvol5
         RDxBIi7DMm6QDuhcswb36gqLaQxkHrZCIoHM8gfAnKKeSNxW/p4r36wLp0vd2Sxij07p
         o8hSKxFUQLcIpmZt297bebyDv6NYoyevSWg4E8tl21X7d7+3I9eqhW8qNe9AgLJ97AU6
         pg62xhUCC9muRJ3A/H/Ym6p0uofsCox3nYmunIENcrYbmi8v7LHrCQwH7u+Opzp4RGXL
         h4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxcDW/Ok7C0PSpmB4bfOmdbhJ/r6w8gjRCtYuhOB/As=;
        b=dR/qfT7DFUxDjlVNPzjXAkEoHH9LRNLLjRWvJCivgAa3h6LCscZI+nAFO7AczkgJtf
         QeojdANkhjbVneereDAuUG9NjP+RCiqnbQImPaRfqOlz4G9Qw1xBzx6gEboYfm3j0gF6
         R5GViObTqRc+QzKiPPr9+VbdHOxpezAg8a1WID6gJuXcGDKBNaX/ZGChDuOTYwMB29dW
         WUuQDzBrK2ukoLDqZMuugMKPBadJMgGYZK7tJldnBIaRYqS/2qilOWIL6Gx87Mktd6IU
         VvW/Dk7pZfnRARWflIcw2spARt1BbQInQhAbgMwwpyw+0IjVbta0xOtMLwienwZ63rkz
         iNFA==
X-Gm-Message-State: AFqh2krLNw2vucauZL0502FVcBukq64kJYqSnvyKieu2piaR+SqH3Vrk
        rHYmV7OvjxVXaXLY32nH5Go=
X-Google-Smtp-Source: AMrXdXsrkA42M/7rLR1GcKOUy7pCVIUySTL/itU78CSJ0gGmOsRVYeKAaEd6omyswR6xtzsRLcAknw==
X-Received: by 2002:a17:902:f60f:b0:186:e434:6265 with SMTP id n15-20020a170902f60f00b00186e4346265mr50581939plg.2.1675023441708;
        Sun, 29 Jan 2023 12:17:21 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902778900b00186b69157ecsm6244378pll.202.2023.01.29.12.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 12:17:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential: new attribute password_expiry_utc
References: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
Date:   Sun, 29 Jan 2023 12:17:20 -0800
In-Reply-To: <pull.1443.git.git.1674914650588.gitgitgadget@gmail.com>
        (M. Hickford via GitGitGadget's message of "Sat, 28 Jan 2023 14:04:10
        +0000")
Message-ID: <xmqqpmax5c4v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"M Hickford via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: M Hickford <mirth.hickford@gmail.com>
>
> If password has expired, credential fill no longer returns early,
> so later helpers can generate a fresh credential. This is backwards
> compatible -- no change in behaviour with helpers that discard the
> expiry attribute. The expiry logic is entirely in the git credential
> layer; compatible helpers simply store and return the expiry
> attribute verbatim.
>
> Store new attribute in cache.

It is unclear what you are describing in the above.  The current
behaviour without the patch?  The behaviour of the code if this
patch gets applied?  Write it in such a way that it is clear why
the patch is a good idea, not just "this would not hurt because it
is backwards compatible".

The usual way to do so is to sell your change in this order:

 - Give background information to help readers understand what you
   are going to write in the following explanation.

 - Describe the current behaviour without any change to the code;

 - Present a situation where the current code results in an
   undesirable outcome. What exactly happens, what visible effect it
   has to the user, how the code could do better to help the user?

 - Propose an updated behaviour that would behave better in the
   above sample situation presented.

Curiously, what you wrote below the "---" line, that will not be
part of the log message, looks to be organized better than the
above.  The first paragraph (except for the "Add ...") prepares the
readers, It is still unclear if the second paragraph "when expired"
describes what happens with the current code (i.e. highlighting why
a change is needed) or what you want to happen with the patch, but
the paragraph should first explain the problem in the current
behaviour to motivate readers to learn why the updated code would
lead to a better world.  And follow that with the behaviour of the
updated code and its effect (e.g. "without first trying a credential
that is stale and see it fail before asking to reauthenticate, such
a known-to-be-stale credential gets discarded automatically").


> +`password_expiry_utc`::
> +
> +	If password is a personal access token or OAuth access token, it may have an expiry date. When getting credentials from a helper, `git credential fill` ignores the password attribute if the expiry date has passed. Storage helpers should store this attribute if possible. Helpers should not implement expiry logic themselves. Represented as Unix time UTC, seconds since 1970.
> +

A overly long line.  Please follow Documentation/CodingGuidelines
and Documentation/SubmittingPatches

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index f3c89831d4a..5cb8a186b45 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -127,6 +127,9 @@ static void serve_one_client(FILE *in, FILE *out)
>  		if (e) {
>  			fprintf(out, "username=%s\n", e->item.username);
>  			fprintf(out, "password=%s\n", e->item.password);
> +			if (e->item.password_expiry_utc != 0) {
> +				fprintf(out, "password_expiry_utc=%ld\n", e->item.password_expiry_utc);
> +			}

Style (multiple issues, check CodingGuidelines):

		if (e->item.password_expiry_utc)
			fprintf(out, "... overly long format template ...",
				e->item.password_expiry_utc);

 * Using integral value or pointer value as a truth value does not
   require an explicit comparison with 0;

 * A single-statement block does not need {} around it;

 * Overly long line should be folded, with properly indented.

> diff --git a/credential.c b/credential.c
> index f6389a50684..0a3a9cbf0a2 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -7,6 +7,7 @@
>  #include "prompt.h"
>  #include "sigchain.h"
>  #include "urlmatch.h"
> +#include <time.h>

Don't include system headers directly; often git-compat-util.h
already has it, and if not, we need to find the right place to have
it in git-compat-util.h file, as there are platforms that are
finicky in inclusion order of the header files and definition of
feature macros.

> @@ -21,6 +22,7 @@ void credential_clear(struct credential *c)
>  	free(c->path);
>  	free(c->username);
>  	free(c->password);
> +	c->password_expiry_utc = 0;

Not a huge deal, but if the rule is "an credential with expiry
timestamp that is too old behaves as if it no longer exists or is
valid", then a large integer, not zero, may serve as a better
sentinel value for "this entry never expires".  Instead of having to
do

	if (expiry && expiry < time()) {
		... expired ...
	}

you can just do

	if (expiry < time()) {
		... expired ...
	}

and that would be simpler to understand for human readers, too.

> @@ -234,11 +236,23 @@ int credential_read(struct credential *c, FILE *fp)
>  		} else if (!strcmp(key, "path")) {
>  			free(c->path);
>  			c->path = xstrdup(value);
> +		} else if (!strcmp(key, "password_expiry_utc")) {
> +			// TODO: ignore if can't parse integer

Do not use // comment.  /* Our single-liner comment reads like this */

> +			c->password_expiry_utc = atoi(value);

Don't use atoi(); make sure value is not followed by a non-number,
e.g.

	const char *value = "43q";
	printf("%d<%s>\n", atoi(value), value);

would give you 43<43q>, but you want to reject and silently ignore
such an expiry timestamp.

> +		// if expiry date has passed, ignore password and expiry fields

Ditto, but if you used a large value as sentinel for "never expires"
and wrote it like this

		if (c->password_expiry_utc < time(NULL)) {

then it is clear enough that you do not even need such a comment.
The expression itself makes it clear what is going on (i.e. the
current time comes later than the expiry_utc value on the number
line hence it appears on the right to it, clearly showing that it
has passed the threshold).

> +		if (c->password_expiry_utc != 0 && time(NULL) > c->password_expiry_utc) {
> +			trace_printf(_("Password has expired.\n"));
> +			FREE_AND_NULL(c->username);
> +			FREE_AND_NULL(c->password);
> +			c->password_expiry_utc = 0;
> +		}
> +
