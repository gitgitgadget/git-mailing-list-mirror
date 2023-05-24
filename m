Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7929C7EE23
	for <git@archiver.kernel.org>; Wed, 24 May 2023 14:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjEXOrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjEXOrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 10:47:20 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A91B197
        for <git@vger.kernel.org>; Wed, 24 May 2023 07:47:16 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561deaad117so14701097b3.0
        for <git@vger.kernel.org>; Wed, 24 May 2023 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684939635; x=1687531635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHwdXlnbKJwZcJI6Y46Z3b+bFcYSayCUqDIO09+Bras=;
        b=JJ7IRRw6fpkvU77sT3DgnGctIeG4n1Z3AfaqhMGisAm5vEvnR5yroHLMSvy1tFzzkL
         mESOO81xTPjGH6uZFG/IwMHEeHXtOiJTdsL4Y6eumwi4my4Su2x9/ARRROVm2lx7c51K
         RIzcH8QkkE2iwn57o6ZyBkVARltjG5fFf5VsJvMI8xOrPiQMdqy4ZQB+8/2mWAX2nbpJ
         yO0LCzLBEu75aK5FRRc4KWYrnHZOlo965170gV+R581JIrRX2bTiOg908Axq/xbhvOtj
         kzqhCcS4c8Nz7rnA2nRmWtR3RnwTeX84OZpvi7bzDjtaC7IZ+yWcEYmi0dnEFcaBE6D5
         2tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939635; x=1687531635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHwdXlnbKJwZcJI6Y46Z3b+bFcYSayCUqDIO09+Bras=;
        b=LlibY9XEakUT1otxN64ahc99R1G12ptWiPRZR0I3KWWH/aYK5v/6jxsYJHiUQEjpt+
         7BJb86KA/o59iost29jsOgYw693deq5+9+8oF5iPr4uBhvjvEs0QIUWHwMu32HhVfdOb
         Z5bfpA3nLEz4cvwyk/qBdU7hPlx6qrfAozTFVEvvWR99HYsh9LFaMtep/IEB8NlvlQ/P
         XWm4a/xHZvcxr6Koez8pWOTUsEqpuuj3YKNTaGsc9iguvc6euZbGW9NtkkJ8LDjdIXf1
         IVj59q652pWMJrtydK+HV20GTlFzmASdVp61G/yYq0PAKvfNbt4zbnY6ILWyTje6jNvy
         R6VA==
X-Gm-Message-State: AC+VfDz8HlL3RGXephSS1Dg1xTupAeGmpoDzjmoR9azPyH36wLxXZXc0
        ZVDB97EastWFjYg/Eot76mTzbZqW+0HIA7o0AHcgjg==
X-Google-Smtp-Source: ACHHUZ4nl/FktYcYK2FdoQwA5OLSchi3Ur+7AfSg+i50wlJdLJKVBWTcqNbY1pRsNgpLE6pLXe/Lhw==
X-Received: by 2002:a81:8a01:0:b0:561:b5cc:e10a with SMTP id a1-20020a818a01000000b00561b5cce10amr16641097ywg.6.1684939635245;
        Wed, 24 May 2023 07:47:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u132-20020a0deb8a000000b0054f83731ad2sm3791641ywe.0.2023.05.24.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:47:14 -0700 (PDT)
Date:   Wed, 24 May 2023 10:47:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Tribo Dar <3bodar@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Segmentation fault in git v2.41.0.rc1
Message-ID: <ZG4jcceXn2G6Xic0@nand.local>
References: <CACJVABb8tvgXAowgtHLrC6Uau8Q03VRFu1m7K91SJwjvufqXYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACJVABb8tvgXAowgtHLrC6Uau8Q03VRFu1m7K91SJwjvufqXYw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tribo,

On Wed, May 24, 2023 at 06:59:55AM +0000, Tribo Dar wrote:
> Running `git submodule update` after commenting out the url setting in both
> .gitmodules and the corresponding section for the submodule in .git/config
> results in a segmentation fault instead of a suitable error message.

Thanks for reporting. I was able to bisect this with the following
bisection script:

--- >8 ---
#!/bin/sh

rm -fr clone

if ! test -d repo
then
    git init repo
    (
        cd repo

        git submodule add git@github.com:ttaylorr/dotfiles.git
        git add --all .
        git commit -m "initial commit"
    )
fi

git.compile clone repo clone
(
    cd clone

    git submodule init
    sed -ie 's/\turl = git@/#\0/g' .gitmodules .git/config

    git.compile submodule update
    test $? -gt 128 && exit 1

    exit 0
)
--- 8< ---

which points to e0a862fdaf (submodule helper: convert relative URL to
absolute URL if needed, 2018-10-16) as the culprit. The fix appears to
be something like:

--- 8< ---
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bf8d666ce..98ee7697f3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2024,8 +2024,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
-		if (starts_with_dot_slash(sub->url) ||
-		    starts_with_dot_dot_slash(sub->url)) {
+		if (sub && sub->url &&
+		    (starts_with_dot_slash(sub->url) ||
+		     starts_with_dot_dot_slash(sub->url))) {
 			url = resolve_relative_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3..c97c543dd8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1351,6 +1351,22 @@ test_expect_success 'clone active submodule without submodule url set' '
 	)
 '

+test_expect_success 'update submodules without url set in .gitconfig' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone file://"$pwd"/multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init &&
+	for s in sub0 sub1 sub2 sub3
+	do
+		key=submodule.$s.url &&
+		git -C multisuper_clone config --local --unset $key &&
+		git -C multisuper_clone config --file .gitmodules --unset $key || return 1
+	done &&
+
+	test_must_fail git -C multisuper_clone submodule update 2>err &&
+	grep "option .url. requires a value" err
+'
+
 test_expect_success 'clone --recurse-submodules with a pathspec works' '
 	test_when_finished "rm -rf multisuper_clone" &&
 	cat >expected <<-\EOF &&
--- >8 ---

I'll clean it up and submit it as a patch shortly.

Thanks,
Taylor
