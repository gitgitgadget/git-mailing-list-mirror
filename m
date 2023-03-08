Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F57C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCHXlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCHXlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:41:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD065C40
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:40:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so515286pjj.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678318821;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDc3+iN4j/ZCD5jl03oAkRZhfTrKG/RB16qTPCxTYws=;
        b=p7Ylq43DyQHDXWbORjYgd4XRoWQIIpO9j7/pN5Dqqv5OwjEgF7W7jtgI9M3Qd7A+Zm
         C1dGuhZbEu8v7qwN3qFc4YN33vL9PbGGo3tOpd8OGKvq/N6xiSGkOp6uDqaWRkCNaAq4
         o5jJa2N3j93E8gMd4eq9o7T8E9QnEufreBmneO+9x0GPaMHxeRHy/x2H/rNjg6S5TWo5
         6+6KSZOBHfycQDQggKH0puBO+3wkVjjgm7nI1ttd8rotAAKCBDRmP6ez8Q4wxCM3cMMF
         oPwOpl5EAEzsUVyFGbScHzTJuwT6QD6bCliRj5SRsWB34t/BcazKUXOX1HuDCFAjHNb3
         RpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318821;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HDc3+iN4j/ZCD5jl03oAkRZhfTrKG/RB16qTPCxTYws=;
        b=T65FfEIlr1ATIfZk+dmgn5IRkNFnHGXuQFtKUrVZ91ehTZPvsgfGopWav+JjztC6Ve
         HAYdo1FRy3X9iYhGo46IR2oK7CXR+uDpmdqhhtdRvjTdfsFQ7WHNsFsqJdwlky4AIsl/
         64XDnApMnO9bdwTMiAOspf16ucRb8xIXkAYQw23OHmL1g2I9c2LD3lM4XR30Ye0UjGZ+
         7iZB0TEEBD9/hlRz9GNOz1ib5OIjd8wC60IbT/1g4xg50Xx376+N5V3Ps6vS+MbcT31G
         yUbmKN6TEREcY3cf/cXL9hM0NU7f5EfQihapfBntz26adzOj/7yPyDzIk86U9nRF5yTq
         slWw==
X-Gm-Message-State: AO0yUKWG+IvOBteCaKCIz8/6iMWrevCZljRwE/PCdRwPuBt66HGfLGqy
        vXSoNMkjBMwjiBdBy2mLB68=
X-Google-Smtp-Source: AK7set95BUK5W0Jta+EgU2U3Um2z1iM6ANzNXmKF56ykK3EpJb2NLkLw4g7K/hhyf19cHrKvX0ncnA==
X-Received: by 2002:a17:90b:3143:b0:235:31e9:e792 with SMTP id ip3-20020a17090b314300b0023531e9e792mr20696182pjb.20.1678318821556;
        Wed, 08 Mar 2023 15:40:21 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ei18-20020a17090ae55200b0023371cb020csm280844pjb.34.2023.03.08.15.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:40:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: pass --no-write-fetch-head to subprocesses
References: <20230308100438.908471-1-e@80x24.org> <xmqqwn3rta2c.fsf@gitster.g>
        <20230308222205.M679514@dcvr> <xmqqttyurg4w.fsf@gitster.g>
Date:   Wed, 08 Mar 2023 15:40:20 -0800
In-Reply-To: <xmqqttyurg4w.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        08 Mar 2023 15:13:19 -0800")
Message-ID: <xmqqjzzqrevv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think we should instead enumerate submodule repositories, instead
> of enumerating existing .git/FETCH_HEAD files.

Perhaps something along this line?

 t/t5526-fetch-submodules.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git c/t/t5526-fetch-submodules.sh w/t/t5526-fetch-submodules.sh
index 8ffb300f2d..dcdbe26a08 100755
--- c/t/t5526-fetch-submodules.sh
+++ w/t/t5526-fetch-submodules.sh
@@ -170,13 +170,13 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 test_expect_success "fetch --recurse-submodules honors --no-write-fetch-head" '
 	(
 		cd downstream &&
-		fh=$(find . -name FETCH_HEAD -type f) &&
-		rm -f $fh &&
+		git submodule foreach --recursive \
+		sh -c "cd \"\$(git rev-parse --git-dir)\" && rm -f FETCH_HEAD" &&
+
 		git fetch --recurse-submodules --no-write-fetch-head &&
-		for f in $fh
-		do
-			test_path_is_missing $f || return 1
-		done
+
+		git submodule foreach --recursive \
+		sh -c "cd \"\$(git rev-parse --git-dir)\" && ! test -f FETCH_HEAD"
 	)
 '
 
