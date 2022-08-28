Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34252ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 05:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiH1FSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 01:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiH1FSD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 01:18:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D1531ED3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m16so6316736wru.9
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=vyo9ugy7OPthgk5zZsCYcEemshiaBaXeCZjFPu8N/kY=;
        b=hwVSI2hCGjrGVAPSPX7gMPgb19V0FKqFtGyRJRBR9FKB/Tvtkr2ynzZANtMIVDKMnM
         P1SDPf7GZYtsZbkVixg61jTSmCwMMB9a1KynHUZBGK1ADmhBvE58s4nnm1I0u0hgOdGX
         qX1RAPRDxEl3n6ABupxSg93p/e6IDtfetU+lnsrIM3PF1XXRUxCdmm0jU1P7V51cMuyF
         bd27BYts9blhY6N38kPSS+3mTU6kuABmcj/OxGuaqkYgj87yFo3lJlyMavRxkQp9/uOW
         1Zs6N1Ovq1xh9GqdN22G0kkrcPWUyxDfiu4MeWwTM2CRZ6RJK7cRcFvoDzK+vesviYSW
         ZxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=vyo9ugy7OPthgk5zZsCYcEemshiaBaXeCZjFPu8N/kY=;
        b=nFPzDAfYktgW9Atx6N4kEBKhNajMYVjFiOeERChCS4SkbQF/ZQdSvJ5EE8vkjBQIhJ
         hDO7FnU08lWK9M22Z5t0Z7DfkwhDH/6Y6Cq1KJO7W6CCp1QLkTj5uak3UbvTaNHxjxhL
         PIAfOZYI7sJfy21h9Ocn5GIAHTPUNLMTN38NMPZGqw7ybrlhNXtz9ZRPfd1IBgDES2WR
         NY9iEl3wbPjXBK9fLJt1fe9IhTTyBXp6/sxbDts2QvUZRzgP/KKBtTSrptIk9kjGNb5E
         ujhhqbQCWKquK62aMgxXiVeO+ucsvgIIp1yGELtMiRRvu+XIz8yCXqan948U9+1OS/+r
         s/3w==
X-Gm-Message-State: ACgBeo02FAY4alITrgLgisCA8n8eLm+0igtzlyZZVlMeUr3uKOHSEiAj
        YQ6kfEl1XeVAvqPILsF6RECSIuUe8Oc=
X-Google-Smtp-Source: AA6agR7qNLfGewySKy/KT1wK58oDRbMZFFQSbHBpFQngyekATerfXXUG23cA0T4eJNjJRVrwZY4WEQ==
X-Received: by 2002:a5d:4ecb:0:b0:225:25f7:191f with SMTP id s11-20020a5d4ecb000000b0022525f7191fmr3159115wrv.205.1661663881373;
        Sat, 27 Aug 2022 22:18:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a5bd9448e5sm4517200wmh.28.2022.08.27.22.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:18:00 -0700 (PDT)
Message-Id: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 05:17:56 +0000
Subject: [PATCH 0/3] fix failing t4301 test and &&-chain breakage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a failing test in t4301 due to 'sed' behavioral
differences between implementations. It also fixes a couple broken &&-chains
and adds missing explicit loop termination.

The third patch is entirely subjective and can be dropped if unwanted. I
spent more than a few minutes puzzling over the script's use of 'printf
"\\n"' rather than the more typical 'printf "\n"' or even a simple 'echo',
wondering if there was some subtlety I was missing or whether Elijah had
encountered an unusual situation in which '\\n' was needed over '\n'. The
third patch chooses to replace 'printf "\\n"' with 'echo' which I find more
idiomatic, but I can see value in using 'printf "\n"' as perhaps being
clearer that it is adding a newline where one is missing.

The series is built atop 'en/t4301-more-merge-tree-tests' which is already
in 'next'.

Eric Sunshine (3):
  t4301: account for behavior differences between sed implementations
  t4031: fix broken &&-chains and add missing loop termination
  t4301: emit blank line in more idiomatic fashion

 t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)


base-commit: 3c4dbf556f425d83f3fbb729dcbecdc719ee4099
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1339%2Fsunshineco%2Fanonhash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1339/sunshineco/anonhash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1339
-- 
gitgitgadget
