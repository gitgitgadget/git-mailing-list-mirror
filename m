Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFDC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 07:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbiA1Hy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 02:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiA1HyX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 02:54:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF1C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 23:54:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m4so13185117ejb.9
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 23:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/tDAlz5VAAyKs30Kb5l+sa6ocDovKcVTcyd+oheH4/8=;
        b=bCJkbCtzlz1EklPqdtKSSmEMEPtM9EtJOIR6P9XQC674THRAVh4ILcFqhEaDchmEBN
         66lv2NuabHZsjvwtGRnuUCOJWp8ZqRF+P9/eTJ8SLC2zWljJFkJ7CqesFgezBlpHS7r2
         LBOv3vEuH/iNBdxJ7tjBK2AowCpBZLEt1+zsQXtSTCrBdf7k8h0M/UAwkRH+elsxc8iA
         5K112w71IJ8a7AivQ9Du/uts2PMKVjR0oSK5AmjWPKTcqBSecMbK3Mo4OwybRdOjyRtP
         I0iBtZADDMI4mEGCSZmtcrg0ca1lj58awtWpC3GkhFDVr89n8OHKXbub/v0Oq3uQu+Tt
         hxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/tDAlz5VAAyKs30Kb5l+sa6ocDovKcVTcyd+oheH4/8=;
        b=1I4SihUZs8aphI1mfq76bdHg2/9SY8Og4+B3JswyW6fN9GhpKCv/0hfaDMC3Ad2KNI
         NHIRKCmYsPjHO1pAJvm4qHdixcgNJRm0jPwyQae7LoWcnZ9Tg+a9475FqrBc3jGtRxOp
         yvCcoAkXi3EAWUs9I6vDMer09tc7+IU6Ag7apj/SwkZMJd5b7Ikf0QVPq5tCDFKuwS98
         7gY5PoD6L+MBahIFAGr2VdhDWvf/a2RlI/9yQd3pJ6zZrkkDzBlaYllCkLqUSKqo103c
         /Xze8+qNRiKfyU+r9A+wgzwU9req+CaBEeOCEjQj3dPKgWLQ9uF3HpbF8VtVGgBCXjwg
         e9/A==
X-Gm-Message-State: AOAM532JULpv9p/XFomK+Ovq6yWamcZ4nJT29EIzzu7w49DCAcuaRQLE
        jSQg/Kp4xFMbbYTBq7qQqTWelhqtqny4Mw==
X-Google-Smtp-Source: ABdhPJwWZotmMsC/mD35qh0wsF8rD8jgMfULWocmSc5THy1Dgc+VmbqGrj0nh0HSKXWvjY34pF+Ffw==
X-Received: by 2002:a17:906:7315:: with SMTP id di21mr6020346ejc.515.1643356461469;
        Thu, 27 Jan 2022 23:54:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k7sm9552495eje.162.2022.01.27.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 23:54:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDM5L-003c4f-PM;
        Fri, 28 Jan 2022 08:54:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] repo-settings: fix checking for
 fetch.negotiationAlgorithm=default
Date:   Fri, 28 Jan 2022 08:25:10 +0100
References: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1131.git.1643334969216.gitgitgadget@gmail.com>
Message-ID: <220128.86ee4scn2s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> In commit 3050b6dfc75d (repo-settings.c: simplify the setup,
> 2021-09-21), the branch for handling fetch.negotiationAlgorithm=default
> was deleted.  Since this value is documented in
> Documentation/config/fetch.txt, restore the check for this value.
>
> Note that this change caused an observable bug: if someone sets
> feature.experimental=true in config, and then passes "-c
> fetch.negotiationAlgorithm=default" on the command line in an attempt to
> override the config, then the override is ignored.  Fix the bug by not
> ignoring the value of "default".

This fix looks good, thanks for fixing my mess.

> Technically, before commit 3050b6dfc75d, repo-settings would treat any
> fetch.negotiationAlgorithm value other than "skipping" or "noop" as a
> request for "default", but I think it probably makes more sense to
> ignore such broken requests and leave fetch.negotiationAlgorithm with
> the default value rather than the value of "default".  (If that sounds
> confusing, note that "default" is usually the default value, but when
> feature.experimental=true, "skipping" is the default value.)
>
> [...]
>     A long sidenote about naming things "default":
>     
>     Many years ago, in the Gnome community, there was a huge fight that
>     erupted, in part due to confusion over "default". There was a journalist
>     who had been a designer in a past life, who had a little friction with
>     the rest of the community, but intended well and generally improved
>     things. At some point, they suggested some changes to improve the
>     "default" theme (and they were a nice improvement), but not being a
>     developer the changes weren't communicated in the form of a patch. And
>     the changes accidentally got applied to the wrong theme: the default one
>     (yes, there was a theme named "default" which was not the default
>     theme). Now, basically no one used the default theme because it was so
>     hideously ugly. I think we suffered from a case of not being able to
>     change the default (again?) because no one could get an agreement on
>     what the default should be. Who did actually use the default theme,
>     though? The person writing the release notes (though they only used it
>     for taking screenshots to include in the release notes, and otherwise
>     used some other theme). So, with people under pressure for an imminent
>     release, there were screenshots that looked like garbage, and
>     investigation eventually uncovered that it was due to changes that were
>     meant for the "default" theme having accidentally been applied to the
>     default theme. It could have just been an amusing story if not for the
>     other unfortunate factors happening around the same time and the heated
>     and protracted flamewars that erupted.
>     
>     Don't name settings/themes/things "default" if it describes something
>     specific, since someone may come along and decide that something else
>     should be the default, and then you're stuck with a non-default
>     "default". Sadly, the name was already picked and documented so for
>     backward compatibility we need to support it...

Funny story, I think this is only going to bite us if we don't switch
the default over along with promoting this out of feature.experimental.

I.e. =default should always be equivalent to not declaring that config
at all anywhere, and not drift to being a reference to some name that
happens to be "default", as in the GNOME case.

In our case it's more of a story about the inconsistencies in our config
space, i.e. some values you can't reset at all, some take empty values
to do so, others "default" etc.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index f0dc4e69686..37958a376ca 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -928,6 +928,7 @@ test_expect_success 'fetching deepen' '
>  '
>  
>  test_expect_success 'use ref advertisement to prune "have" lines sent' '
> +	test_when_finished rm -rf clientv0 clientv2 &&
>  	rm -rf server client &&
>  	git init server &&
>  	test_commit -C server both_have_1 &&
> @@ -960,6 +961,45 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
>  	! grep "have $(git -C client rev-parse both_have_2^)" trace
>  '
>  
> +test_expect_success 'same as last but with config overrides' '

Since it's the same as the preceding test, maybe we can squash this in
to avoid the duplication? This works for me.

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 37958a376ca..3fb20eeec7e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -927,7 +927,7 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
-test_expect_success 'use ref advertisement to prune "have" lines sent' '
+test_negotiation_algorithm_default () {
 	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
 	git init server &&
@@ -946,7 +946,7 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 
 	rm -f trace &&
 	cp -r client clientv0 &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 $@ \
 		fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
@@ -954,50 +954,17 @@ test_expect_success 'use ref advertisement to prune "have" lines sent' '
 
 	rm -f trace &&
 	cp -r client clientv2 &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 $@ \
 		fetch origin server_has both_have_2 &&
 	grep "have $(git -C client rev-parse client_has)" trace &&
 	grep "have $(git -C client rev-parse both_have_2)" trace &&
 	! grep "have $(git -C client rev-parse both_have_2^)" trace
-'
-
-test_expect_success 'same as last but with config overrides' '
-	test_when_finished rm -rf clientv0 clientv2 &&
-	rm -rf server client &&
-	git init server &&
-	test_commit -C server both_have_1 &&
-	git -C server tag -d both_have_1 &&
-	test_commit -C server both_have_2 &&
-
-	git clone server client &&
-	test_commit -C server server_has &&
-	test_commit -C client client_has &&
-
-	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
-	# not sent as a "have" line. The client should know that the server has
-	# both_have_2, so it only needs to inform the server that it has
-	# both_have_2, and the server can infer the rest.
-
-	rm -f trace &&
-	rm -rf clientv0 &&
-	cp -r client clientv0 &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
-		-c feature.experimental=true \
-		-c fetch.negotiationAlgorithm=default \
-		fetch origin server_has both_have_2 &&
-	grep "have $(git -C client rev-parse client_has)" trace &&
-	grep "have $(git -C client rev-parse both_have_2)" trace &&
-	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
+}
 
-	rm -f trace &&
-	cp -r client clientv2 &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	test_negotiation_algorithm_default \
 		-c feature.experimental=true \
-		-c fetch.negotiationAlgorithm=default \
-		fetch origin server_has both_have_2 &&
-	grep "have $(git -C client rev-parse client_has)" trace &&
-	grep "have $(git -C client rev-parse both_have_2)" trace &&
-	! grep "have $(git -C client rev-parse both_have_2^)" trace
+		-c fetch.negotiationAlgorithm=default
 '
 
 test_expect_success 'filtering by size' '
