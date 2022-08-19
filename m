Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC05C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 02:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344472AbiHSCpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 22:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbiHSCpd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 22:45:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E24459BB
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 19:45:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so3695032wri.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 19:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Xs+1/Qdsy7T55uwRQlKYX8HZQDTatRoaR+FI3mTrBSo=;
        b=HNa/U5Etq/D5Xv9r7J/lprUuBdSCMuQx5qUncQQE2NYqbQdvPSZcbl0ISuF0GyDD3P
         iqmFoolN6HB1LY99ae1NfGf7wUiwmAACzxFN1Az4uyB68hhX+LYYaGKEENEC1liwiH9h
         w6FDqf1QF5iHUat3tiA/yX+SbSywq3ZBaULlFJgcyCPM4d4+Blj7F8eUewDJLvFYBN4L
         yeSjvjnSXzVXXjLLUWZfAZxXAOlMKYp+OObo1vKIF5whQl73Eb1cuRL8d43nG/8wN7r4
         t2sk4NhNKJbKHZzvwP/Farc7tK58xhkNyrgLdOQlIokUK0peYt1LLCkceYk4qklDoVjy
         ELOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Xs+1/Qdsy7T55uwRQlKYX8HZQDTatRoaR+FI3mTrBSo=;
        b=TXJPxvgyEo667/xNdHLSAzRZ8W0W7BIwlxNZaoV20Vx3Kd4cWa/B1gi92mmQzLdDoE
         6sDzaG443U0kVXgpT2rPfuoCCKmyGDUJC581hKCPurI3W2miP/PEg66sQzLxgN69AnAc
         L/Dy5zf6AwMpBRlozZvE37fht5IeOasPGIcZ8zsjSsvEFgcGPiJ1YdIzG2lRl/BaMspY
         DK3m+uPVzcGBasLd9D1Mc+rJuKOLjFHq/go6FIJg5biQJpWrmSK1O9bWJ4dE/3dy/9tD
         ivnRg4UU8MoPKR4ly3Tgzfyx0ff10vF6k00+MfCmkl7oIGYpEKU8vx/LpkIbkKcXcS5k
         B+JQ==
X-Gm-Message-State: ACgBeo1A2f4tPtHv4FkgyGP/dX1yKZNXwQz88j8Ob7vMMHbKOI0tUs1x
        81hFlYidai3npj3Z/JDTdjM=
X-Google-Smtp-Source: AA6agR4km/9nMczOksjY+/U1VgR3iDB26wa1psUWQQOJY221Ho+7ss42gLIC6Kaezpy5ETtNr4AnCg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr3077532wri.39.1660877130776;
        Thu, 18 Aug 2022 19:45:30 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id l28-20020a056000023c00b00225213fd4a9sm2726550wrz.33.2022.08.18.19.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 19:45:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oOs0l-000bGS-38;
        Fri, 19 Aug 2022 04:45:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
Date:   Fri, 19 Aug 2022 04:45:08 +0200
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
 <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
 <CABPp-BFOrKDEnq6R7k5+CxUKHObkfNWDGZghkqvkCnuXQC8rTg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CABPp-BFOrKDEnq6R7k5+CxUKHObkfNWDGZghkqvkCnuXQC8rTg@mail.gmail.com>
Message-ID: <220819.86a6817xyw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 18 2022, Elijah Newren wrote:

> On Thu, Aug 18, 2022 at 8:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> Also does the "compare rev" part of this want test_cmp_rev instead?
>
> Um, I don't see any "compare rev" part of this, or any revision
> comparing.  What are you referring to?

I just misread this part while skimming it, sorry.
