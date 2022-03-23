Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0733C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiCWSoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCWSoO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:44:14 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 11:42:43 PDT
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E95A153
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1648060961;
        bh=hMFJ8UI0N7EGrViDQmGAd4YewE4TTCg3i+NqYZsOsv0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qwBWqqxq/0sOp/rSxUupfRnPNsQsZlMbbxALZvep8RIC9svGym1CuaLqkopNsAdYh
         hF//WvsmdrnVwA1kKTZS73TN+jM21qUg4nyQYIQjJTxV2yTLN1S2zA+2GNT1hPUR5b
         j6YZjo0VhgRDV4lBP2MyAMdhrUr+PZPkewh+Nvmc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.74]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1nJsRP388u-00DEUL; Wed, 23
 Mar 2022 19:37:23 +0100
Message-ID: <1187feda-c14a-f75c-6e09-4df101f00056@web.de>
Date:   Wed, 23 Mar 2022 19:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: improve performance of PCRE2 bug 2642 bug workaround
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     Paul Eggert <eggert@cs.ucla.edu>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <bd751d5c-2f8b-4c52-72ec-f2b7268a30a8@cs.ucla.edu>
 <99b0adb6-26ba-293c-3a8f-679f59e7cb4d@web.de>
 <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220323010931.jzf7op7hdusdty33@carlos-mbp.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROU6rss+HrdST6oDDC7blpzPfVpjqzS8OUnTGlaXCFTNSh990Kx
 +nIA+jnqz2+CbeRVCSOoGW5Iy2pQDV/AOz6CdvDOKZCY2PcJA3L7/5nLtWOYIp+D1231v6H
 Fyu+shyr3PNE5/LotHzOqnOAFLvj3gr4X+HKhRzgOZrsyaC3KrwlfRWy417k2QzQmcqujqT
 a3vkUv96alXPlEsigirOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:znhTecQHSZE=:tIBc+UEVS2res0gyzu4rjg
 pOBkdK7TDtCK5weqjUoSL67QCTgWwdrj+YOjwLO7kRyuuDFrNoPdyB+e+KPE/jxrg6ubJdagv
 n7P+qh8J5ZtQLOi7u6d+gQAaG/wAtQ1x+VvWKD1jTsLcbYv9gY+mPK55nNckf+tCyVc4wjPg4
 HabN7kS382USfAh34ketDC8JZbVuV/8Fl4amqFQlAUYuaRGYgU1NXBLjWqzf1vj3psJR7g2o8
 70JtolR35OtIAmUHpv6Uo9myIyou6O3cXR4UWMGX9VRLVcLs96hqTT67Yg+D8YJaw/eQoQrBa
 O6PG9plLah7OnnddcIoT4N3F6yivxJmKY0RhIeE5z7FZsrL14PLlDSaoNzgaqWPoEqzxp0aIF
 GpFfNdIusDWrvvw7Qf3A6okiI7J7GIi2fsQn78EtrET9WDs3Cw/iTCq9idFqZPeNqUpfegYKx
 Tv9G+xqJYy6vihzUfjioaP6PM6b3z4lt7HtJQu5hwlwIta4BkcBTe8u3bDbzVY6oevMdZN4FJ
 ZAbwIRg1U5TNfLfoHiiwQwo5r+vs0LTJdlD5kKMRwfBUeTFZOP8qsrgBPID+9xCK8GRWtp/Nb
 Bf+NGkWEvDeRrsTYemcsAAMu4dXGLhoelDJxfmx6RvgN5DVslq4udKFnDq6oys7pzd9caxMr+
 tc7iXSA6O/bbVu9p3kYBfRd3cnyBaDZmXQmnuA18w8a6SY9kEXmJIaz8t+Mp9Y/aNs35PhoqR
 abnLDtfWRIOaBQmFlPVBrSbku3xsbCeZ/9Ag1fflgI3NyNEUFeBd5H1+kXJSOCvAeo4YyB6m+
 Y5U+F+8osS1UO5mmfbYpldLw0BsFHMtcGD4XvtOGqIagjMkhNypijIbXrnLc6IOaTuwT03h3y
 dVR+vMYvDL5XqLd2tA+2evew9KG7tAELCFMcdx7NBu8xAGEMLT1sz1+GYz4K8Yue7cRL8n1k3
 eg7UCmVgayjMOGLVXKtVNhJQcCY3evJGbC0yw3E+Epa4Lt2OgrFAxXnI8j/Mus8cqTrtbgLbp
 PjdGdvC3ywyVecOljX/Tvvk8VkkiQyPmRPS4x9Wy853nMQHd3KPniSXsmx/Ik2WNJw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.22 um 02:09 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> On Tue, Mar 22, 2022 at 09:26:10PM +0100, Ren=C3=A9 Scharfe wrote:
>> Am 22.03.22 um 17:38 schrieb Paul Eggert:
>>> Today, Carlo Arenas pointed out[1] that GNU grep didn't work around
>>> PCRE2 bug 2642, which Git grep has a workaround for. While installing
>>> a GNU grep patch to fix this[2] I noticed that Git's workaround
>>> appears to be too pessimistic: on older PCRE2 libraries Git grep sets
>>> PCRE2_NO_START_OPTIMIZE even when PCRE2_CASELESS is not set.
>>
>> Interesting.  So you say bug 2642 [3] requires the flag PCRE2_CASELESS
>> (i.e. --ignore-case) to be triggered.  (That's probably documented in
>> Bugzilla, but I'm not authorized to access it.)
>
> AFAIK the contents of the bugzilla are no longer accessible to anyone
> (lost in the migration of PCRE2 to github), but the use of
> PCRE2_CASELESS introduced in 95ca1f987e (grep/pcre2: better support
> invalid UTF-8 haystacks, 2021-01-24) might had been a mistake all
> along.

Ah, OK.

> the bug will trigger when both PCRE2_UTF and PCRE2_MULTILINE are set
> (as shown in the PCRE2 regression added), with the later set by
> default in git and NEVER set in GNU grep, hence why I later
> retracted[6] my suggestion to add the workaround to grep, and suggest
> updating git with the following
> Carlo
>
> [6] https://lists.gnu.org/r/grep-devel/2022-03/msg00006.html
> --- >8 ---
> Subject: [PATCH] grep: remove check for case sensitivity in workaround f=
or
>  PCRE's bug2642
>
> 95ca1f987e (grep/pcre2: better support invalid UTF-8 haystacks, 2021-01-=
24)
> add a workaround to an old PCRE2 bug, but includes in the logic a partia=
l
> check for case sensitivity without explanation.
>
> Remove it so that the workaround (and its performance impact) will be on=
ly
> triggered when needed (both PCRE2_MULTILINE and PCRE2_UTF and JIT is use=
d)
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 82eb7da102..d910836569 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -296,8 +296,8 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>
>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
> -	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in 1=
0.36 */
> -	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
> +	/* Work around PCRE2 bug2642 fixed in 10.36 */
> +	if (SUPPORT_JIT && PCRE2_MATCH_INVALID_UTF && (options & PCRE2_UTF))

SUPPORT_JIT can be undefined and then this won't compile.

And if I turn it into an "#ifdef SUPPORT_JIT", t7812.16 fails with PCRE2
versions 10.34 and 10.35.

SUPPORT_JIT is defined in PCRE2's config.h and not baked into any of its
public headers, so it never will be set in grep.c, right?  Perhaps just
drop this condition?

The patch below adds a test that fails even with a PCRE2 configured with
=2D-disable-git.  Current main passes this test even with PCRE2 versions
10.34 and 10.35.

"PCRE2_MATCH_INVALID_UTF && (options & PCRE2_UTF)" can be simplified to
"options & PCRE2_MATCH_INVALID_UTF".

>  		options |=3D PCRE2_NO_START_OPTIMIZE;
>  #endif
>

=2D-- >8 ---
Subject: [PATCH] t7812: test PCRE2 whitespace bug

Check if git grep works around the PCRE2 big fixed by their e0c6029
(Fix inifinite loop when a single byte newline is searched in JIT.,
2020-05-29), which affects version 10.35 and earlier.

Searching for leading whitespace also triggers the endless loop.
Set a one-second alarm to abort in case we do get hit by the bug, to
avoid having to wait forever for the test result.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t7812-grep-icase-non-ascii.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asci=
i.sh
index 9047d665a1..ac7be54714 100755
=2D-- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -4,6 +4,10 @@ test_description=3D'grep icase on non-English locales'

 . ./lib-gettext.sh

+doalarm () {
+	perl -e 'alarm shift; exec @ARGV' -- "$@"
+}
+
 test_expect_success GETTEXT_LOCALE 'setup' '
 	test_write_lines "TILRAUN: Hall=C3=B3 Heimur!" >file &&
 	git add file &&
@@ -139,4 +143,10 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2:=
 grep non-literal ASCII fro
 	test_cmp expected actual
 '

+test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep avoid endless =
loop bug' '
+	echo " Hall=C3=B3" >leading-whitespace &&
+	git add leading-whitespace &&
+	doalarm 1 git grep --perl-regexp "^\s" leading-whitespace
+'
+
 test_done
=2D-
2.35.1
