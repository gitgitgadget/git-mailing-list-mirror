Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1E9C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2730B61042
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFOSH6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhFOSH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:07:57 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23704C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:05:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so15218508otl.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ycZLTKTGYGEjDzUUWc3wOcIUZwc9Ff3PqAUMFVkQPr0=;
        b=RbD7/ENeyLANKK89MVetuvq9jSQA0JHJqsHWWBGRWB5R8jZp7GZXxNWxJjkm1YaqLI
         ih7Q6w5pExdeMcAEmPyVHj38HjAzQuXUumiWD9UV5KU69INs6e7hH7AH/WFMRW0ekp7d
         m7FYRPyUDBrLdED97VDmvxH1FMMNbQW4GENzUMrwAA57ELfVhO4vj8cwyWHrCYheWLsI
         HNHy6sTpWigBCyy+BLmvqJgBU7M1sg71ZuJ9IjEtuv8LOVlfL6hr0k8IQ+5N9Zqnyhdq
         sIZA1iJgQTlNv6Q6Y7SwftgvDbB4+gBVFnQ4bw48Eae0Vwsd3J0bl767m2kfuP8Y2we3
         9KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ycZLTKTGYGEjDzUUWc3wOcIUZwc9Ff3PqAUMFVkQPr0=;
        b=Ex/QXdzsiPs8NHBwWY4ncnIz6HprRrv352KNIJPts5Yf96aOjZ5jxK4DYM6KcImAqN
         fnvxXG9A3zv0vT0q2cl48Ngwv5j5puwvkBmSlBRH3s36Qdp+YMWacPlCI8Ojig0GF2I4
         Paij2m+GOoIPslccN3hO3VRGs3Kb6vkznBOp33PTYiQnZ7SyyIkXBrj68+Ghnf+OyPaU
         q9NYx5mGZBTjEmrTkXh7zQ/TTDVaKQ+lIttVId+4AEP2Jgo+34LTqJLn5z+Y+jsXLQeA
         VQ07SyJKSAIBzVpGCt8zc6464VVxHIQY0MiJK1w8s/Z3XhBi0yApvQc+dmN7nltYy21B
         HqDg==
X-Gm-Message-State: AOAM531ESNggU6mL67CK3GgDgmEkSqa0xsnn7oP1eyLBSaey5d5oHuao
        tNLfzx186d0exI/zvy83FLw=
X-Google-Smtp-Source: ABdhPJwdWpLdDYobBy9zdCu3Qbc0uCMNx86OlMFLZAgBWrqGMetD65ukerDGVvN4GHcREubZP+uGZQ==
X-Received: by 2002:a9d:3e5:: with SMTP id f92mr393209otf.181.1623780352555;
        Tue, 15 Jun 2021 11:05:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p7sm3973087otq.9.2021.06.15.11.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 11:05:52 -0700 (PDT)
Date:   Tue, 15 Jun 2021 13:05:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60c8ebfeb5779_1928f208f8@natae.notmuch>
In-Reply-To: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210614T104351Z-avarab@gmail.com>
Subject: RE: [PATCH 0/8] test-lib tests: split off subtest code in t0000 into
 lib-subtest.sh
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> There's a conflict here with Felipe's proposed
> http://lore.kernel.org/git/20210609170520.67014-1-felipe.contreras@gmai=
l.com,
> but it's just a matter of moving the fix around and solving a trivial
> conflict. I thought it was better to submit this now anyway, while
> this code is fresh in people's minds.
> =

> I'm hoping Felipe will take some variant of my
> http://lore.kernel.org/git/8735tk22if.fsf@evledraar.gmail.com and
> perhaps review this series & base his patch on top of these changes,
> but alternatively they can go in independently with Junio solving the
> conflict.

I have no problem rebasing my patch on top of your series, but my
current v2 doesn't touch _run_sub_test_lib_test_common at all, and I'm
not sure your proposal of TEST_NO_RESULTS_OUTPUT is the way to go, so
perhaps there's no need to rebase at all.

Unless there's something on this series that would help
TEST_OUTPUT_DIRECTORY, which at a quick glance doesn't seem to be the
case.

Cheers.

-- =

Felipe Contreras=
