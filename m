Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC3C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CE761AAB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355416AbhJARat (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354178AbhJARas (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 13:30:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF3C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 10:29:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso14537071ybn.2
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qXRVsjkvh9/zaml9uWA7yJHdHwBThojO3QkgPd6eqXo=;
        b=K4gS1qon+sxo5XLv7+qRvGpfG8Lac8Bh9iRmSSXoCDo3qN6NfjyQA2LuwMAc31GHzd
         mp71JuORddrh2/RiZCphtnvt1JHfWjBiFjzub/Dtne1PNEPngcndO2Az0D1WPbux9xmL
         4pJ1QSf+GsOzfzxHOEzrA3GUybh8xBZK0QjnFLUmR4brRR1vNvIuVcYd9+RGLmsIMrDb
         UntB6FSA5RfCJHEVbYuTaM0c0cXR/U1ptTP849eVhmywzkNTmU2mUBBApDZGQHlDJeoe
         coXbKuu93tYW6Wmd7MyQOIgMKXkoif/ZYepzL9rX+5vW3yLdHuqRzkOpuKqLIfdnI5O8
         kJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qXRVsjkvh9/zaml9uWA7yJHdHwBThojO3QkgPd6eqXo=;
        b=7xNwEva1GsgXfFuDRuhbrG/emUzbUHL+Ke6koJWC3Ww0vLAfm4SN2f+SOr0aquM0W3
         5SXTfedWD38OxwYmqev+tNcFUeEbA30JmlYcU/35YFAYXMsrMzyCY81pZYs4QnT4RDCs
         3wGt9Ao0VuF7+UMntPMQzG2xaRqaFSAdj6Qpd7xtAGuLgUDKvDpoo2BkUfseFmRvwXiq
         4SNOX/Ssp1DyfcR2dKLl2wy38AqGyNqM10GR1OgtKqxWRCHcUMW3RNjcyv7MA54ckeu+
         GxcVsNxXn5s2Mf3RCx2iHNTNkKcm3xJTdbmeco5L08nWoBbfqpVnfdOYDvBNRF257HTW
         vqow==
X-Gm-Message-State: AOAM5323fJuh2wNT29ErGn/+M/9TPFbJv2eK9JoTMNWpsftyGz7dwzKc
        v5fj9xtJvofs1wYXbMh0LCkoXakPXRfmTQ==
X-Google-Smtp-Source: ABdhPJwf/QYWfL3nwUqPEdXl/7X2bAKGm43aqQ4T3BbMqiqBm3z+VFb8sVj63WTv1EfFC1Nt1g3mxeDSxfosKA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:cf8f:: with SMTP id
 f137mr621868ybg.338.1633109343445; Fri, 01 Oct 2021 10:29:03 -0700 (PDT)
Date:   Fri, 01 Oct 2021 10:28:55 -0700
In-Reply-To: <CAPig+cSTEwObVOajvtVA0BQo0vB74BDN4-f6Gi1tYrEt-BzceQ@mail.gmail.com>
Message-Id: <kl6lpmsoac2w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913181221.42635-1-chooglen@google.com> <20210917225459.68086-1-chooglen@google.com>
 <20210917225459.68086-2-chooglen@google.com> <e1447d0e-091d-c659-b702-c5b33fffdb59@sunshineco.com>
 <kl6lmtnu7xle.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lk0ix9aju.fsf@chooglen-macbookpro.roam.corp.google.com> <CAPig+cSTEwObVOajvtVA0BQo0vB74BDN4-f6Gi1tYrEt-BzceQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fsck: verify commit graph when implicitly enabled
From:   Glen Choo <chooglen@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> That was my thought, as well. (I wasn't quite sure why Taylor
> recommended test_config() over `-c` which you used originally. It may
> just be his personal preference. Perhaps he can chime in?)

I'd also appreciate thoughts on test_config() over `-c` :). I won't
re-roll this series yet in case there's more to the test_config() story,
but I've included a patch that shows the `-c` work that we discussed.

---
 t/t5318-commit-graph.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 42e785cb6e..4fcfc2ebbc 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -680,7 +680,7 @@ test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
 	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
-	test_must_fail git fsck
+	test_must_fail git -c core.commitGraph=true fsck
 '
 
 test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
@@ -689,14 +689,13 @@ test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
 	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
-	test_config core.commitGraph false &&
-	git fsck
+	git -c core.commitGraph=false fsck
 '
 
 test_expect_success 'git fsck (checks commit-graph when config unset)' '
+	cd "$TRASH_DIRECTORY/full" &&
 	test_when_finished "git config core.commitGraph true" &&
 
-	cd "$TRASH_DIRECTORY/full" &&
 	git fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
 		"incorrect checksum" &&
-- 
2.33.0.800.g4c38ced690-goog

