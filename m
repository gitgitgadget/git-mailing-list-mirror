Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D3C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7A61214
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhIOLXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhIOLXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 07:23:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4E1C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 04:22:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b21-20020a1c8015000000b003049690d882so4494422wmd.5
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Fqh25/6cUwnbkUyAMw9pztWkyqDdih2+idBcP1t+5s=;
        b=eiTRduig3NEHUtAH9NaSH5puvOfOgTFQSj7sam3oNGerh7JXrMts5ncIBCb1N5PMx6
         9LWM9cj1/bqJUbndm2wRb9VYnYZ16ls7kATqgGRayTpskNja50KbbTrOHao2G7RhP/2n
         J38LGd+bqX8rxEjPCxgW2eTPvHape1lBp+zD6cChfk9BSksLw2wXCqdrVqK8vJS/RqXL
         iSaM7JRnkwjQVtAX67sHvAC19OJBUProO7qpfAB0qEsgQW+LgE0MZOJYhW+AteX0Ybm6
         Q0UiMd/EcDExKOTLDeX6gdvqx0EyPSaxTchyhDOfx+nDWgFZlQGnQk6ZdrYLlEqM9cyU
         Is3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9Fqh25/6cUwnbkUyAMw9pztWkyqDdih2+idBcP1t+5s=;
        b=OtjozIvtPfWq41F6TIhniF11iyFg4Psy+QKBi3Qjt5IHWL/LcMoPJoA3aRdnPJv+Ei
         ZGRzDzZ39yqttOSOaMFLsMiNkKxo5oAlmiqe6L5IvkuoG5UXo4JRD6uT4qh8eUWckquq
         SnGeGJgXmZTrSX7UaqzH9sNHWWJLJvrTMGga5bwQhjOvM1YIglOMbSIJUpNDe/StWO9I
         6mcfVhYRUemVStPKY8OAFgYd9andzMfSFwgflDyrDUroQQspM4IUAPCVV0e+wcfT8VVa
         xVPUrPVglQBDYRsThLKJh197iqpeNWm1E5hRQ1ApfTD2tqZqvHKfrW4LRR8U1U0MI4/t
         eUyg==
X-Gm-Message-State: AOAM532jyUc4eVkxh8fEx/CiD9uvLZCmKtj1ubXJTaSD4HA5WivTnfsV
        UXIGLSy/erkO2D5P8cWbcc4=
X-Google-Smtp-Source: ABdhPJwYr4lpVd50wXck6kmwx5izZPiq3qru/s1bLf3btC24zyuUTZ7oenNxJD1+6pcpDjDTVIrQ8A==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr3952829wmc.63.1631704921470;
        Wed, 15 Sep 2021 04:22:01 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id z7sm16667158wre.72.2021.09.15.04.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 04:22:00 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
 <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
 <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
Message-ID: <2290b657-3c67-0ab8-5c25-cc57feac301c@gmail.com>
Date:   Wed, 15 Sep 2021 12:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/09/2021 11:25, Phillip Wood wrote:
> I do wonder (though a brief try failed to trigger it) if there are cases 
> where the diff algorithm does something "clever" which means it does not 
> treat a common prefix or suffix as unchanged (see d2f82950a9 
> ("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We 
> could just trim the common prefix and suffix from the two sides 
> ourselves using xdl_recmatch().

Here is an evil test case that shows this problem (diff on top of your patch)


diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index de9c6190b9..836843c6b0 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -219,8 +219,9 @@ test_setup_zdiff3 () {
                 test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
                 test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
                 test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
+               test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
  
-               git add basic middle-common &&
+               git add basic middle-common interesting evil &&
                 git commit -m base &&
  
                 git branch left &&
@@ -230,19 +231,21 @@ test_setup_zdiff3 () {
                 test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
                 test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
                 test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
+               test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
                 git add -u &&
                 git commit -m letters &&
  
                 git checkout right &&
                 test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
                 test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
                 test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
+               test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
                 git add -u &&
                 git commit -m permuted
         )
  }
  
-test_expect_failure 'check zdiff3 markers' '
+test_expect_success 'check zdiff3 markers' '
         test_setup_zdiff3 &&
         (
                 cd zdiff3 &&
@@ -251,6 +254,14 @@ test_expect_failure 'check zdiff3 markers' '
  
                 test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
  
+               test_write_lines \
+                       1 2 3 4 \
+                       "<<<<<<< HEAD" X A \
+                       "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= \
+                       Y A B C ">>>>>>> right^0" \
+                       B C 7 8 9 >expect &&
+               test_cmp expect evil &&
+
                 test_write_lines 1 2 3 4 A "<<<<<<< HEAD" B C D "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= X C Y ">>>>>>> right^0" E 7 8 9 >expect &&
                 test_cmp expect basic &&
  
