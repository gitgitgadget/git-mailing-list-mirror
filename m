Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D14C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 17:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbiCURlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 13:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349805AbiCURla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 13:41:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0051595
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:40:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r22so11280282ejs.11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/4NPJSCQXHcTg9dABcuBFEiwWIk9PESWcaAOqBGZ+Ls=;
        b=UgKlhF6azwZOtKgqXus+hAKg+i5YMCDMrxO9WvEAlUczEFiMUD1KRT+KadGQ27Z1ur
         cTzxBeCiUYgNfYHX4lBKjdlEFgga4pqbuarPT6C9eIbgo+3EGPQY+ZED/RqFNRnynJI6
         lFVtCLkWKOUlELP4lDw4ZLBlqAOF0VhMDh92EMBuccj2cykUA6GDG9c8a3yhF91Zxch3
         7HHGgTZmtnseYBRoBBadbfYb3Nd2ubQBunap8eoO3tpdotlUHIqJ03NBGciiYL/PXPaz
         HgPUJ3XfaxZpau+u1z3ca/ltXBL/fB+zx/erxYxG0RjC5bxo/CHWl4bavl3dsTeXUjsG
         8aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/4NPJSCQXHcTg9dABcuBFEiwWIk9PESWcaAOqBGZ+Ls=;
        b=qRLvCAnTzOBjcP3o+CGy56lBE9akQ8BKq8GhDNjbtGpIobulVL7D26N3lDOe28sckC
         tFiudkl8Clxz8B3Qpbn7kZR/WF5vjLC8QzItDcSLeaXUqq2nfklr+HYk2XCCAfmCKGBT
         hSv028s5k53rD6pf6qspcP6jRm8XSd8nTv9smBCunqkkoy5ew8oqgIUA+ef9/j+yD6vC
         VRO3+C5nvqgjQmIozVWMvVC4lHTQga4drH4gLprEooqPDBbCl1GAHK6J4KpWF+l4MBOC
         6++0Bp41QD1Xtyo2gIKLvhSjD/m24Sjh7RiQKeCKOC3BRSDQ62GauYwk0ARymfeQHqXD
         WYuw==
X-Gm-Message-State: AOAM533L8HuiW5Len6hp3asdnCkfOPb5y+T3+mQafJoxBEfoxPCfrb5d
        X0BTB4t5B94acZAkHOsHjqcxwgH/M8tbeA==
X-Google-Smtp-Source: ABdhPJzUSEgwEbYcqNOpmVuPrvQATEGYyd+gM2Z9dn722aITB6bcPh0YqF3+j/TEwRbJrq7hBVWAZA==
X-Received: by 2002:a17:907:3d87:b0:6e0:bef:c3cb with SMTP id he7-20020a1709073d8700b006e00befc3cbmr5990381ejc.503.1647884401736;
        Mon, 21 Mar 2022 10:40:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm6500435edu.73.2022.03.21.10.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 10:40:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWM0e-000eic-MP;
        Mon, 21 Mar 2022 18:40:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] for-each-ref: respect GIT_REF_PARANOIA setting
Date:   Mon, 21 Mar 2022 18:29:38 +0100
References: <7283f826198aaec94c847f0b26e228ace9a38433.1647880211.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <7283f826198aaec94c847f0b26e228ace9a38433.1647880211.git.me@ttaylorr.com>
Message-ID: <220321.86wngn8arz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Taylor Blau wrote:

> When setting GIT_REF_PARANOIA=1 (which became the default in 968f12fdac
> (refs: turn on GIT_REF_PARANOIA by default, 2021-09-24)), `git
> for-each-ref` will display a warning when it encounters a broken ref,
> but does not terminate the program.
>
> This can result in somewhat surprising behavior like:
>
>     $ echo bogus >.git/refs/heads/bogus
>     $ GIT_REF_PARANOIA=1 git for-each-ref; echo "==> $?"
>     warning: ignoring broken ref refs/heads/bogus
>     ==> 0
>
> This seems to be the case even before the introduction of the ref-filter
> code via 7ebc8cbedd (Merge branch 'kn/for-each-ref', 2015-08-03).
> Looking at 8afc493d11 (for-each-ref: report broken references correctly,
> 2015-06-02) when this was last addressed, the fix at the time was to
> report any broken references, but this warning did not affect the
> command's success.
>
> It seems that `git for-each-ref` should exit non-zero in the case of a
> broken reference when GIT_REF_PARANOIA is set to 1. This patch does
> that, but there are a couple of open questions (hence its status as an
> RFC):

I started playing with this fix-up:
	
	diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
	index e1937b7e53e..05b7c9b2a69 100644
	--- a/builtin/for-each-ref.c
	+++ b/builtin/for-each-ref.c
	@@ -78,8 +78,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
	 	filter.name_patterns = argv;
	 	filter.match_as_path = 1;
	 	ret = filter_refs(&array, &filter, FILTER_REFS_ALL);
	-	if (ret)
	-		goto cleanup;
	 	ref_array_sort(sorting, &array);
	 
	 	if (!maxcount || array.nr < maxcount)
	@@ -93,7 +91,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
	 		putchar('\n');
	 	}
	 
	-cleanup:
	 	strbuf_release(&err);
	 	strbuf_release(&output);
	 	ref_array_clear(&array);
	diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
	index 2a5895c124a..8a93685bb3e 100755
	--- a/t/t6301-for-each-ref-errors.sh
	+++ b/t/t6301-for-each-ref-errors.sh
	@@ -19,7 +19,8 @@ test_expect_success 'Broken refs are reported correctly' '
	 	: >.git/$r &&
	 	test_when_finished "rm -f .git/$r" &&
	 	echo "warning: ignoring broken ref $r" >broken-err &&
	-	test_must_fail git for-each-ref 2>err &&
	+	test_must_fail git for-each-ref >out 2>err &&
	+	test_must_be_empty out &&
	 	test_cmp broken-err err
	 '
	 
	@@ -31,7 +32,11 @@ test_expect_success 'NULL_SHA1 refs are reported correctly' '
	 	test_must_fail git for-each-ref 2>err &&
	 	test_cmp zeros-err err &&
	 	test_must_fail git for-each-ref --format="%(objectname) %(refname)" \
	-		2>brief-err &&
	+		>actual 2>brief-err &&
	+	cat >expect <<-EOF &&
	+	$(git rev-parse HEAD) $(git rev-parse --symbolic-full-name HEAD)
	+	EOF
	+	test_cmp expect actual &&
	 	test_cmp zeros-err brief-err
	 '

It seems to me you'd want at least the part of it where we retain a
test_cmp or similar for the "out", rather than removing it completely.

>   - First, there are a handful of other `filter_refs()` calls throughout
>     the builtin tree that lack similar error handling. I suspect that
>     these will need similar treatment, but I haven't looked at them
>     deeply yet.
>
>   - More pressing, though, is that there is some test fallout as a
>     result of this change. Namely, t6301 expects that `git for-each-ref`
>     should list out all of the non-broken references to stdout _even
>     when broken references exist_.
>
>     This patch changes that behavior and causes us to exit immediately,
>     without printing out any of the non-broken references (since we are
>     still building up the list of references to sort, and thus haven't
>     printed anything out by the time we're in the ref_filter_handler
>     callback).
>
>     The test fallout can be seen in the changes to t6301, namely that we
>     expect `for-each-ref` to fail in certain cases where it didn't
>     before, and that in those cases we no longer guarantee the contents
>     of stdout.
>
> The second point gives me serious pause about whether or not this change
> is the right one. So I'm curious if or how we should handle this case.

I think the right thing to do is to add a filter_refs() where we add
FILTER_REFS_WANT_REF_ISBROKEN and maybe FILTER_REFS_WANT_REF_BAD_NAME.

Then have in the for-each-ref.c loop check the "flags" on the ref item
for REF_ISBROKEN etc, and either have format_ref_array_item() format it,
or skip that and issue a warning() there manually.

That way API users can opt-in and detect these, but still be able to
print the rest, and it allows to make the more narrow change of amending
the exit code.

I'd think builtin/{tag,branch}.c would want similar treatment, ditto
fetch-pack.c.

But I really don't see why we'd want to abort the iteration early just
because we see one broken ref, that's after all per-ref issue, and we
don't need to abort the walk entirely to issue a warning() or to change
our exit code.

So that part of the patch really seems like it's in the wrong place to
me, and that we should always have for-each-ref try as hard as it can to
emit the output it can emit, even if we change the exit code due to a
broken ref.

