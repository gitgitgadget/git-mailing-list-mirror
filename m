Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07CC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76485610CB
	for <git@archiver.kernel.org>; Thu, 27 May 2021 11:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhE0LyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhE0LyM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 07:54:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D8C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:52:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so241243pjg.1
        for <git@vger.kernel.org>; Thu, 27 May 2021 04:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8AbcLoGBXLs3k9IV5SgF1ayzE6qNA/tkrUyH53syes=;
        b=VW630wOZnEm49RrNy42g0B64Rzc35mdcvrxfiqfYLujUwsXI/Q71wQQNoeyKsab4zI
         b6wulgVqmCbULTpSrjdLBZxkf2GO/YC9TIuMDlOxo0CJYfkUSsq++9GUfCtlGTQWzULR
         BWhKFhszCYi4A38ufvR5++7dHdpzHExvYOAz+ni/epsYybi+ZvB7xxoooUaqH+2PUHkR
         SuiZZZ7XFB+11IDEdzC0IO/0CL7QSZGEWy9POcu1F4N2CpSskB9ATHp6Lln0G+bo32iP
         emcArBeYbAulFJzt1h7TJ2gCLEeCybA2ayvhdlUiKGGfgJUDHomJkmM0UqIkRz61e4vH
         EP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8AbcLoGBXLs3k9IV5SgF1ayzE6qNA/tkrUyH53syes=;
        b=deDv1HLyaAwWDN2Sc0G+PhGo2DyyyPkiWgxJ2tCMMKn5w+nxR4mxA5kjM/6Nyc3Sq8
         z0wPcoGE95pjQ+WKDHWprexlniba9cnqZcF+UvKV364Q2VHeJikA8jlusLxBWRrzjtDr
         YOf//tAisbWw6IbXjLOMln0hd8mhPSynFiEfMGUiFaV2DZJNrsmaRRArLa6I896nxx/9
         Q1F7GxcEKoZ2+YafMD4DbDF43IBPYUjKbZgIpfbOrAxgjYnkjgzTExyWNMKEtea6Wd0B
         FV0X8aJ9nuZeHZsNtrPoaIUKf5qaymAJuBlQg04Nop9DIKYATCSDEQtJ8Co/LFtO92PL
         8UfQ==
X-Gm-Message-State: AOAM532EDJfUim+oLatNlPiLH9ZEJ4dThtrv0/iGH6itv0v1MrjfTNKg
        szISX5IlGDQsz0I/yQsQr8Vdy4roumQr6A==
X-Google-Smtp-Source: ABdhPJzqaRUlimYyLz/Y3JtZGROeH7SLaPZfCkoimyrbNZl6pmywp2zRY95V5vdtcWFjYQvcdSgbSQ==
X-Received: by 2002:a17:90a:7f85:: with SMTP id m5mr3389675pjl.128.1622116357834;
        Thu, 27 May 2021 04:52:37 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.104])
        by smtp.gmail.com with ESMTPSA id b23sm1812128pft.162.2021.05.27.04.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 04:52:37 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re: [PATCH v6 1/3] test: add helper functions for git-bundle")
Date:   Thu, 27 May 2021 19:52:26 +0800
Message-Id: <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <87bl8xmipo.fsf@evledraar.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> 于2021年5月27日周四
上午2:51写道：
>
>
> On Mon, Jan 11 2021, Jiang Xin wrote:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Move git-bundle related functions from t5510 to a library, and this
> > lib
> > will be shared with a new testcase t6020 which finds a known
> > breakage of
> > "git-bundle".
> > [...]
> > +
> > +# Format the output of git commands to make a user-friendly and
> > stable
> > +# text.  We can easily prepare the expect text without having to
> > worry
> > +# about future changes of the commit ID and spaces of the output.
> > +make_user_friendly_and_stable_output () {
> > +     sed \
> > +             -e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
> > +             -e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
> > +             -e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
> > +             -e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
> > +             -e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
> > +             -e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
> > +             -e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
> > +             -e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
> > +             -e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
> > +             -e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
> > +             -e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
> > +             -e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
> > +             -e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
> > +             -e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
> > +             -e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
> > +             -e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
> > +             -e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
> > +             -e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
> > +             -e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
> > +             -e "s/ *\$//"
> > +}
>
> On one of the gcc farm boxes, a i386 box (gcc45) this fails because
> sed
> gets killed after >500MB of memory use (I was just eyeballing it in
> htop) on the "reate bundle from special rev: main^!" test. This with
> GNU
> sed 4.2.2.
>
> I suspect this regex pattern creates some runaway behavior in sed
> that's
> since been fixed (or maybe it's the glibc regex engine?). The glibc is
> 2.19-18+deb8u10:
>
>     + git bundle list-heads special-rev.bdl
>     + make_user_friendly_and_stable_output
>     + sed -e s/[0-9a-f]*/<COMMIT-A>/g -e s/[0-9a-f]*/<COMMIT-B>/g -e
> s/[0-9a-f]*/<COMMIT-C>/g -e s/[0-9a-f]*/<COMMIT-D>/g -e
> s/[0-9a-f]*/<COMMIT-E>/g -e s/[0-9a-f]*/<COMMIT-F>/g -e
> s/[0-9a-f]*/<COMMIT-G>/g -e s/[0-9a-f]*/<COMMIT-H>/g -e
> s/[0-9a-f]*/<COMMIT-I>/g -e s/[0-9a-f]*/<COMMIT-J>/g -e
> s/[0-9a-f]*/<COMMIT-K>/g -e s/[0-9a-f]*/<COMMIT-L>/g -e
> s/[0-9a-f]*/<COMMIT-M>/g -e s/[0-9a-f]*/<COMMIT-N>/g -e
> s/[0-9a-f]*/<COMMIT-O>/g -e s/[0-9a-f]*/<COMMIT-P>/g -e
> s/[0-9a-f]*/<TAG-1>/g -e s/[0-9a-f]*/<TAG-2>/g -e
> s/[0-9a-f]*/<TAG-3>/g -e s/ *$//
>     sed: couldn't re-allocate memory

I wrote a program on macOS to check memory footprint for sed and perl.
See:

    https://github.com/jiangxin/compare-sed-perl

Test result:

    $ go build && ./compare-sed-perl
    Command: sed  ..., MaxRSS: 901120
    Command: gsed ..., MaxRSS: 2056192
    Command: perl ..., MaxRSS: 2269184

It seems that sed (both the builtin version on macOS and GNU sed v4.8)
has less memory consumed than perl.

Can you run this program on the i386 box (gcc45) to check memory consumed
by sed and perl?

If this issue can be resolved by replacing sed with perl, the following
patch may help:

--- >8 ---
From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Date: Thu, 27 May 2021 14:31:49 +0800
Subject: [PATCH] test: use perl for complex text replacement

Ævar reported that the function `make_user_friendly_and_stable_output()`
failed on a i386 box (gcc45) in the gcc farm boxes with error:

    sed: couldn't re-allocate memory

It seems that sed (GNU sed 4.2.2) gets killed after >500MB of memory
use on the "create bundle from special rev: main^!" test.

Call perl instead of sed for complex text replacement.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5411/common-functions.sh | 27 ++++++++++++------------
 t/t5548-push-porcelain.sh   | 20 +++++++++---------
 t/t6020-bundle-misc.sh      | 42 ++++++++++++++++++-------------------
 3 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
index 6694858e18..b6d33bdfdc 100644
--- a/t/t5411/common-functions.sh
+++ b/t/t5411/common-functions.sh
@@ -39,19 +39,20 @@ create_commits_in () {
 # remove some locale error messages. The emitted human-readable errors are
 # redundant to the more machine-readable output the tests already assert.
 make_user_friendly_and_stable_output () {
-	sed \
-		-e "s/  *\$//" \
-		-e "s/  */ /g" \
-		-e "s/'/\"/g" \
-		-e "s/	/    /g" \
-		-e "s/$A/<COMMIT-A>/g" \
-		-e "s/$B/<COMMIT-B>/g" \
-		-e "s/$TAG/<TAG-v123>/g" \
-		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
-		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#" \
-		-e "/^error: / d"
+	perl -ne "
+		s/  *\$//;
+		s/  */ /g;
+		s/'/\"/g;
+		s/	/    /g;
+		s/$A/<COMMIT-A>/g;
+		s/$B/<COMMIT-B>/g;
+		s/$TAG/<TAG-v123>/g;
+		s/$ZERO_OID/<ZERO-OID>/g;
+		s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g;
+		s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g;
+		s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#;
+		next if /^error: .*$/;
+		print"
 }
 
 filter_out_user_friendly_and_stable_output () {
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 5a761f3642..95e216973d 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -44,16 +44,16 @@ create_commits_in () {
 # without having to worry about future changes of the commit ID and spaces
 # of the output.
 make_user_friendly_and_stable_output () {
-	sed \
-		-e "s/  *\$//" \
-		-e "s/   */ /g" \
-		-e "s/	/    /g" \
-		-e "s/$A/<COMMIT-A>/g" \
-		-e "s/$B/<COMMIT-B>/g" \
-		-e "s/$ZERO_OID/<ZERO-OID>/g" \
-		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
-		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
-		-e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
+	perl -pe "
+		s/  *\$//;
+		s/   */ /g;
+		s/	/    /g;
+		s/$A/<COMMIT-A>/g;
+		s/$B/<COMMIT-B>/g;
+		s/$ZERO_OID/<ZERO-OID>/g;
+		s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g;
+		s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g;
+		s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git>#"
 }
 
 setup_upstream_and_workbench () {
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 881f72fd44..f284be820f 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -84,27 +84,27 @@ test_commit_setvar () {
 # text.  We can easily prepare the expect text without having to worry
 # about future changes of the commit ID and spaces of the output.
 make_user_friendly_and_stable_output () {
-	sed \
-		-e "s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g" \
-		-e "s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g" \
-		-e "s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g" \
-		-e "s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g" \
-		-e "s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g" \
-		-e "s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g" \
-		-e "s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g" \
-		-e "s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g" \
-		-e "s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g" \
-		-e "s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g" \
-		-e "s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g" \
-		-e "s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g" \
-		-e "s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g" \
-		-e "s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g" \
-		-e "s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g" \
-		-e "s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g" \
-		-e "s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g" \
-		-e "s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g" \
-		-e "s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g" \
-		-e "s/ *\$//"
+	perl -pe "
+		s/${A%${A#???????}}[0-9a-f]*/<COMMIT-A>/g;
+		s/${B%${B#???????}}[0-9a-f]*/<COMMIT-B>/g;
+		s/${C%${C#???????}}[0-9a-f]*/<COMMIT-C>/g;
+		s/${D%${D#???????}}[0-9a-f]*/<COMMIT-D>/g;
+		s/${E%${E#???????}}[0-9a-f]*/<COMMIT-E>/g;
+		s/${F%${F#???????}}[0-9a-f]*/<COMMIT-F>/g;
+		s/${G%${G#???????}}[0-9a-f]*/<COMMIT-G>/g;
+		s/${H%${H#???????}}[0-9a-f]*/<COMMIT-H>/g;
+		s/${I%${I#???????}}[0-9a-f]*/<COMMIT-I>/g;
+		s/${J%${J#???????}}[0-9a-f]*/<COMMIT-J>/g;
+		s/${K%${K#???????}}[0-9a-f]*/<COMMIT-K>/g;
+		s/${L%${L#???????}}[0-9a-f]*/<COMMIT-L>/g;
+		s/${M%${M#???????}}[0-9a-f]*/<COMMIT-M>/g;
+		s/${N%${N#???????}}[0-9a-f]*/<COMMIT-N>/g;
+		s/${O%${O#???????}}[0-9a-f]*/<COMMIT-O>/g;
+		s/${P%${P#???????}}[0-9a-f]*/<COMMIT-P>/g;
+		s/${TAG1%${TAG1#???????}}[0-9a-f]*/<TAG-1>/g;
+		s/${TAG2%${TAG2#???????}}[0-9a-f]*/<TAG-2>/g;
+		s/${TAG3%${TAG3#???????}}[0-9a-f]*/<TAG-3>/g;
+		s/ *\$//"
 }
 
 #            (C)   (D, pull/1/head, topic/1)
-- 
2.32.0.rc0

