Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D0C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF8A22285
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 13:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbhALNdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 08:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbhALNdY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 08:33:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51C5C061794
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 05:32:43 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id lt17so3567218ejb.3
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EnIo5esE37W6S9SYICP3hUVCZBpwHE4qKxgruqvFhGI=;
        b=MxRofpkyNTwzT7FbBGvsmggqJSKWO6lDA58/AAuHr8mjwMnx9BqLcUoaPoQPSM9El6
         MV6Nn38+7kFbrDe/0huVuh1oXJUliMjPssxCeyCHZ6ThUtwHVNZukrMn9WlietUWcGJM
         OzNTlGDOOjI9MSjqgWLV5+GIzRERCVScjxMeQgNffwxkQY63TUDKCroPLY9x+l/Dp25q
         wG8AJ8uX0ugEKp+yTQ+KLoOAcsJ4QBbMkKgr/VWNigwp1nbczaWBM/GDJbtlZpN1g++e
         /BCFUdPDZw0fB3hHWqk9+THPoN8+nlL0YuiU6xCJAcGZV2pEgoU5qybIMbAn2aCtXEXG
         ECQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=EnIo5esE37W6S9SYICP3hUVCZBpwHE4qKxgruqvFhGI=;
        b=uPt92nN2/nRUC3gRO7EKW/kxPV16qDaHCeB7pEYifuqR2NNfEjEhv2G6xOsTW7eup8
         7YKZr5dVNlwrzZWLftanT2V27xrDq6Wo7uagVxCQSLHO/Hs4M0EayqpRDoFKufXVi5w8
         zkPDw+srwdgGMGtZ+qlYTiLdn8kDKOwpXuqRvAwk3AcqCeaN9Bkm1f14DWuqoPy7NiV8
         dZoToIdJAVAaeK9E8tY7KnX98vTDHreEaEjSiAEQzneLom1d3CDm37J2E21vNdCw5mOP
         9FM6UarJoDhV+0pn5PC02JMD+xbTu1XkGpsS3mawZbIsuSaTW6PUBMg1CfTsyy6BhGPc
         XEtQ==
X-Gm-Message-State: AOAM531t7TuejjKLoNbrIk4qXmNL/vvHcgyFMJOLN4hiNJyLq9B3hhOj
        vInT19WtrBJ1BtZRAnZ7OOceK598nlxrwg==
X-Google-Smtp-Source: ABdhPJzplmcWcFVXGIkixsR/Zcuq1/FcroKRAWBBZR71aMVaBGRMqfrSM2zaLjVeSB/eg3x0/kFMyg==
X-Received: by 2002:a17:906:7f91:: with SMTP id f17mr3150470ejr.81.1610458362161;
        Tue, 12 Jan 2021 05:32:42 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id s1sm1244605ejx.25.2021.01.12.05.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:32:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] [RFH] Introduce support for GETTEXT_POISON=rot13
References: <pull.836.git.1610441262.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <pull.836.git.1610441262.gitgitgadget@gmail.com>
Date:   Tue, 12 Jan 2021 14:32:40 +0100
Message-ID: <87mtxe5lhj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 12 2021, Johannes Schindelin via GitGitGadget wrote:

> This patch series is incomplete because I lack the time to finish it, and=
 I
> hope that there are interested developers who can help with it.
>
> In https://lore.kernel.org/git/20181022153633.31757-1-pclouds@gmail.com/,
> Duy proposed introducing a fake language they called "Ook" to be able to
> test translations better. "Ook" would "translate" messages without any
> printf format specifiers to "Eek", otherwise convert all upper-case lette=
rs
> to "Ook" and lower-case letters to "ook".
>
> G=C3=A1bor replied with a different proposal that has the advantage of be=
ing
> bijective, i.e. it is possible to reconstruct the untranslated message fr=
om
> the translated one.
>
> =C3=86var suggested recently
> [https://lore.kernel.org/git/xmqqim836v6m.fsf@gitster.c.googlers.com/T/#m=
6fdc43d4f1eb3f20f841096c59e985b69c84875e]
> that this whole GETTEXT_POISON business is totally useless.

To clarify what I really mean, but admittedly am not always the best at
articulating: I do not think GETTEXT_POISON is useless, it's useful.

The interesting question is "useful enough to bother?", or in economics
terms "is this investment in time/money worth the opportunity cost?".

Any hoops we make people jump through when writing tests takes away time
and attention from other things.

My motivation here is that I feel this whole poison business is all my
fault. Every time some newbie submits a patch and needs to re-roll a v2
because they used "grep" instead of "test_i18ngrep" in a case that
clearly didn't involve a plumbing string I cringe a little about the
technical debt.

So while I still think my series (just nuke it) would be better overall,
I'm secretly rooting for yours. If the consensus is that this is worth
keeping and improving perhaps we haven't been mostly wasting our time :)

On to discussing this series:

> I do not believe that it is useless. To back up my belief with something
> tangible, I implemented a GETTEXT_POISON=3Drot13 mode and ran the test su=
ite
> to see whether we erroneously expect translated messages where they aren'=
t,
> and related problems.

I agree that rot13ing it makes it much more useful in the sense that
before we could over-tag things with test_i18n* and we'd just "return 0"
there in the poison mode, now we actually check if the string is
poisoned.

We could get most of the way there by checking e.g. if "GETTEXT POISON"
is in the output, but it wouldn't assert that the message is 100%
translated as this WIP series does.

In our off-list discussion you maintained that
"GIT_TEST_GETTEXT_POISON=3Dfalse <cmd>" was an anti-pattern. Was it
because you thought "test_i18n*" et al was actually doing some "is
poison?" comparison as we now do, or just because you didn't
conceptually like a pattern like:

    GIT_TEST_GETTEXT_POISON=3Dfalse git cmd >out &&
    grep string out

Being changed later to:

    GIT_TEST_GETTEXT_POISON=3Dfalse git cmd >out &&
    grep string out &&
    grep plumbing-string out

Or whatever, as opposed to:

    git cmd >out &&
    test_i18ngrep string out &&
    test_i18ngrep plumbing-string out

I get the aesthetic preference, I'm just wondering if I'm missing
something else about it...

> And the experiment delivered. It is just a demonstration (I only addresse=
d a
> handful of the test suite failures, 124 test scripts still need to be
> inspected to find out why they fail), of course. Yet I think that finding
> e.g. the missing translations of sha1dc-cb and parse-options show that it
> would be very useful to complete this patch series and then use the rot13
> mode in our CI jobs (instead of the current GETTEXT_POISON=3Dtrue mode, w=
hich
> really is less useful).

The following patch on top cuts down on the failures by more than half:

-----------------
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index 8eef60b43f..f9239d2917 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -17,7 +17,10 @@ export TEXTDOMAINDIR
=20
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=3Dfallthrough
-if test -n "$GIT_TEST_GETTEXT_POISON" &&
+if test -n "$GIT_TEST_GETTEXT_POISON" -a "$GIT_TEST_GETTEXT_POISON" =3D "r=
ot13"
+then
+	GIT_INTERNAL_GETTEXT_SH_SCHEME=3Drot13poison
+elif  test -n "$GIT_TEST_GETTEXT_POISON" &&
 	    git env--helper --type=3Dbool --default=3D0 --exit-code \
 		GIT_TEST_GETTEXT_POISON
 then
@@ -63,6 +66,21 @@ gettext_without_eval_gettext)
 		)
 	}
 	;;
+rot13poison)
+	# Emit garbage so that tests that incorrectly rely on translatable
+	# strings will fail.
+	gettext () {
+		printf "%s" "# SHELL GETTEXT POISON #"
+	}
+
+	eval_gettext () {
+		printf "%s" "# SHELL GETTEXT POISON #"
+	}
+
+	eval_ngettext () {
+		printf "%s" "# SHELL GETTEXT POISON #"
+	}
+	;;
 poison)
 	# Emit garbage so that tests that incorrectly rely on translatable
 	# strings will fail.
diff --git a/t/helper/test-i18n.c b/t/helper/test-i18n.c
index 82efc66f1f..1f0fa3d041 100644
--- a/t/helper/test-i18n.c
+++ b/t/helper/test-i18n.c
@@ -1,6 +1,8 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "grep.h"
+#include "config.h"
=20
 static const char *usage_msg =3D "\n"
 "  test-tool i18n cmp <file1> <file2>\n"
@@ -34,8 +36,12 @@ static size_t unrot13(char *buf)
=20
 		p +=3D strlen("<rot13>");
 		end =3D strstr(p, "</rot13>");
-		if (!end)
-			BUG("could not find </rot13> in\n%s", buf);
+		if (!end) {
+			if (git_env_bool("GIT_TEST_GETTEXT_POISON_PEDANTIC", 0))
+				BUG("could not find </rot13> in\n%s", buf);
+			else
+				break;
+		}
=20
 		while (p !=3D end)
 			*(q++) =3D do_rot13(*(p++));
@@ -67,8 +73,12 @@ static int i18n_cmp(const char **argv)
=20
 	if (strbuf_read_file(&a, path1, 0) < 0)
 		die_errno("could not read %s", path1);
+	if (strstr(a.buf, "# SHELL GETTEXT POISON #"))
+		return 0;
 	if (strbuf_read_file(&b, path2, 0) < 0)
 		die_errno("could not read %s", path2);
+	if (strstr(b.buf, "# SHELL GETTEXT POISON #"))
+		return 0;
 	unrot13_strbuf(&b);
=20
 	if (a.len !=3D b.len || memcmp(a.buf, b.buf, a.len))
@@ -79,7 +89,6 @@ static int i18n_cmp(const char **argv)
=20
 static int i18n_grep(const char **argv)
 {
-	int dont_match =3D 0;
 	const char *pattern, *path;
=20
 	struct grep_opt opt;
@@ -87,11 +96,6 @@ static int i18n_grep(const char **argv)
 	struct strbuf buf =3D STRBUF_INIT;
 	int hit;
=20
-	if (*argv && !strcmp("!", *argv)) {
-		dont_match =3D 1;
-		argv++;
-	}
-
 	pattern =3D *(argv++);
 	path =3D *(argv++);
=20
@@ -104,13 +108,15 @@ static int i18n_grep(const char **argv)
=20
 	if (strbuf_read_file(&buf, path, 0) < 0)
 		die_errno("could not read %s", path);
+	if (strstr(buf.buf, "# SHELL GETTEXT POISON #"))
+		return 0;
 	unrot13_strbuf(&buf);
 	grep_source_init(&source, GREP_SOURCE_BUF, path, path, path);
 	source.buf =3D buf.buf;
 	source.size =3D buf.len;
 	hit =3D grep_source(&opt, &source);
 	strbuf_release(&buf);
-	return dont_match ^ !hit;
+	return !hit;
 }
=20
 int cmd__i18n(int argc, const char **argv)
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 394fd2ef5b..6c580a3000 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1019,14 +1019,12 @@ test_i18ngrep () {
 		BUG "too few parameters to test_i18ngrep"
 	fi
=20
-	if test_have_prereq !C_LOCALE_OUTPUT
+	grep_cmd=3Dgrep
+	if test "$GIT_TEST_GETTEXT_POISON" =3D=3D "rot13"
+	then
+		grep_cmd=3D"test-tool i18n grep"
+	elif test_have_prereq !C_LOCALE_OUTPUT
 	then
-		if test rot13 =3D "$GIT_TEST_GETTEXT_POISON"
-		then
-			test-tool i18n grep "$@"
-			return $?
-		fi
-
 		# pretend success
 		return 0
 	fi
@@ -1034,13 +1032,13 @@ test_i18ngrep () {
 	if test "x!" =3D "x$1"
 	then
 		shift
-		! grep "$@" && return 0
+		! $grep_cmd "$@" && return 0
=20
-		echo >&4 "error: '! grep $@' did find a match in:"
+		echo >&4 "error: '! $grep_cmd $@' did find a match in:"
 	else
-		grep "$@" && return 0
+		$grep_cmd "$@" && return 0
=20
-		echo >&4 "error: 'grep $@' didn't find a match in:"
+		echo >&4 "error: '$grep_cmd $@' didn't find a match in:"
 	fi
=20
 	if test -s "$last_arg"
-----------------

I.e. most of this was because you didn't add any support for this to the
shellscript translations.

We still punt on that here, it should ideally preserve the shell
variables like the format specifiers, but I think that's not worth the
effort with us actively cutting down our shell code to nothing.

We still have failures e.g. due to "test_i18ngrep -F fixed file" not
being supported. Wouldn't a better/simpler approach be to just have a
light rot13 helper, and then call the actual "cmp"/"grep" with the
munged input/output?
