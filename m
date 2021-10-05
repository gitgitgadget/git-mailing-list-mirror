Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347F0C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078FC60FD8
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 16:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbhJEQsx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhJEQsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 12:48:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED5C061753
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 09:47:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so1256031edt.7
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XW4Lxfqj0PYtl8E8vvGHJG/YmoSZoAI2IFjcOlFCBE0=;
        b=oCym4tcUYcROLsBLfYS2a0YbOUkspXXWmxqx6Wf+OKivZLQY1UUD9zIKNgKaVw7kWj
         xX7iMnRjHfuwOzMoaaeC8qBhORVhu0Ed/GwyugIaCLqsX0MJtOsNVxy2psKUtARcosfT
         TPBl25KD99xn+zn7E9Ls3LlEcgoaH23KDYB1F9SHDucrL1xHwlzfyfSJ6OPY81R5PPJV
         /Q/iYaGgezXuhYuUO80WmVRbtenrF5snxWnb+gpgmp1u8X03agUqnvojFHyRgee+XMm2
         7fHbiI2XxBxvPL9ne/15yUoKxKaUcEY1mrZhq25rx/hnRQEFDHS5hqVLI9bJ/S+lIbIa
         2ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XW4Lxfqj0PYtl8E8vvGHJG/YmoSZoAI2IFjcOlFCBE0=;
        b=1diplV1GNtCEcMJiN/DzYFho1eq+gSwaLrr1EKogfQNa/2iRq22ZyONktZq2XUCfOW
         9PI4fKokDG6seQH9dogfV5M+swT3CoKBaFegWnsMxvK09la0dvudedlZdEO7lDNPhnQ/
         EA8KO6lclbMPABJgIJheVDuuU1c94XwkO6dBbGiB7ObBlbvXcogg14dznrL/hRcaAaV5
         XntjUzk/rfCqyXwOq5+L20JbO9nH3fDx8cYxQw5WPGzd2zGgB+a8YhR0SqpA4A9u1rFW
         3mb7Qla7zD6v9lVVwCrXlVK6xI70GFlJUfX6B+dOHQ1O7Jgw9r1MWJt+3Wm+aK2etUjZ
         lG4w==
X-Gm-Message-State: AOAM530TWJQM+Rijf60n+hk16jjCiidi2YUnZ7E//rZEs8vBZ14rTTpL
        D2+UYzT0RiXdQKFeWisY7hH6sPOHu9I=
X-Google-Smtp-Source: ABdhPJxEcv+4CTj1LG8P1VG4jSAbxMsWDpAmoxy+D8VV70a2OmDxAYosW72mAEJ1rRaa1i3CLAVP7Q==
X-Received: by 2002:a05:6402:5203:: with SMTP id s3mr478626edd.250.1633452420866;
        Tue, 05 Oct 2021 09:47:00 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m23sm85251eja.6.2021.10.05.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:47:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/2] pretty: colorize pattern matches in commit
 messages
Date:   Tue, 05 Oct 2021 18:29:21 +0200
References: <20210929115716.10364-1-someguy@effective-light.com>
 <20210929115716.10364-2-someguy@effective-light.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210929115716.10364-2-someguy@effective-light.com>
Message-ID: <87v92bju64.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 29 2021, Hamza Mahfooz wrote:

> The "git log" command limits its output to the commits that contain strin=
gs
> matched by a pattern when the "--grep=3D<pattern>" option is used, but un=
like
> output from "git grep -e <pattern>", the matches are not highlighted,
> making them harder to spot.
>
> Teach the pretty-printer code to highlight matches from the
> "--grep=3D<pattern>", "--author=3D<pattern>" and "--committer=3D<pattern>"
> options (to view the last one, you may have to ask for --pretty=3Dfuller).
>
> Also, it must be noted that we are effectively greping the content twice,
> however it only slows down "git log --author=3D^H" on this repository by
> around 1-2% (compared to v2.33.0), so it should be a small enough slow
> down to justify the addition of the feature.

I tested the performance of this, that part looks good. Just for future
reference, is the running it twice just because it's a hassle to pass up
the match data or do the equivalent of a /g match on the first pass, and
doing this purely in the output emitter is easier?

There's a bug in how this highlighter handles UTF-8. I.e. with "grep" in
general we don't turn on UTF-8 unless the pattern itself is
UTF-8. Leading to this edge case:
=20=20=20=20
    $ git grep =C3=86var -- CODE_OF_CONDUCT.md
    CODE_OF_CONDUCT.md:  - =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com>
    $ git grep .var -- CODE_OF_CONDUCT.md
    CODE_OF_CONDUCT.md:  - <C3><86>var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>

See 95ca1f987ed (grep/pcre2: better support invalid UTF-8 haystacks,
2021-01-24) for the rabbit hole of why we can't just turn that on. We
need to be able to grep arbitrary binary crap by default.

But for "log" we can be much stricter with encodings, and we've got both
i18n.commitEncoding and i18n.logOutputEncoding in play. This should pay
attention to those.

In theory any such bugs pre-date this series, but in practice they
don't. We'd match in non-UTF8 PCRE mode before, which has some edge
cases, but since we're not highlighting anything not knowing character
boundaries usually doesn't matter.

But with this we've got the same edge case in the log options now:
=20=20=20=20
    $ ~/g/git/git log --color --author=3D'.var.*=C3=B6.*Bjar' -1 origin/mas=
ter  | grep ^Author
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    $ ~/g/git/git log --color --author=3D'.var.*Bjar' -1 origin/master  | g=
rep ^Author
    grep: (standard input): binary file matches

I think just something like the below should fix this all up. It passes
all tests, although more would need to be added showing how this new
coloring mode handles utf8/non-utf8, and in combination with
e.g. i18n.commitEncoding=3Dlatin1 (which will emit "binary", at least
according to my otherwise UTF-8 GNU grep):

If we skip that "!has_non_ascii(p->pattern)' check one test fails, but
maybe that test is just stupid and we should die on that input
anyway. I.e. if we've said we're emitting UTF-8 shouldn't we be
validating/converting that somewhere before we feed it to PCRE and
friends? Maybe there's a good reason not to (and as I type this I
realize performance might suck, although "is ascii?" is fairly cheap,
and you'd only need to do it on !ASCII data).

diff --git a/grep.c b/grep.c
index fe847a0111a..ff09fbdd6cf 100644
--- a/grep.c
+++ b/grep.c
@@ -382,8 +382,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, c=
onst struct grep_opt *opt
 		}
 		options |=3D PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) =
&&
-	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
+	if ((opt->utf8_all_the_things && !has_non_ascii(p->pattern) ) ||
+	    (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern)=
 &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed))))
 		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
=20
 #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
diff --git a/grep.h b/grep.h
index 808ad76f0c5..c9ddd637d18 100644
--- a/grep.h
+++ b/grep.h
@@ -167,6 +167,7 @@ struct grep_opt {
 	int extended_regexp_option;
 	int pattern_type_option;
 	int ignore_locale;
+	int utf8_all_the_things;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
 	unsigned post_context;
diff --git a/revision.c b/revision.c
index 0dabb5a0bcf..0d751dceb7e 100644
--- a/revision.c
+++ b/revision.c
@@ -2874,6 +2874,8 @@ int setup_revisions(int argc, const char **argv, stru=
ct rev_info *revs, struct s
 				 &revs->grep_filter);
 	if (!is_encoding_utf8(get_log_output_encoding()))
 		revs->grep_filter.ignore_locale =3D 1;
+	else
+		revs->grep_filter.utf8_all_the_things =3D 1;
 	compile_grep_patterns(&revs->grep_filter);
=20
 	if (revs->reverse && revs->reflog_info)
