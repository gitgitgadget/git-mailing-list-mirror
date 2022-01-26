Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D865CC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 15:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiAZPGQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPGP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 10:06:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AFC06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:06:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id me13so39808002ejb.12
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 07:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=7LafpkUqDG7Xf9paaxZb6JLhyK15v1m8Qt8kwh0LTPY=;
        b=XAvPpWRzfAY12Ss2l4YMpmu/HlyBeljqe+DG1nqv7oS+jH9+C3f5Km7jg95nJ4K/hE
         JIPSr5g85vzn6+egTzjOEBjjiLsubWEM1YjvhdP2n7JN1ct26P2sqvl8/ubwUNkLzzgX
         tm/9dDTDMGUAMEfvx1W63Mptrx1rfRKB5ByPbWrmTboZ4VRX+P7p+yUFqMxdJp9xohHn
         gt+Qwa/hwhJIEtxwFSr2chNhVZjdRL5WhqiroBYvV93aib5LP/YGOMsvL3qE84DLlePC
         7501NRZfPUsz+KFZR/eEppUpsIWW2LnNAD8QtT8TQFnLZ5hooB0KmiAfULZKEGoVogAs
         g3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=7LafpkUqDG7Xf9paaxZb6JLhyK15v1m8Qt8kwh0LTPY=;
        b=hHsoQsdSuNB7Y6TMwExyvfD3l1Py3YbtFf0hUeK/lewH7D1eZ0rVbxYVFsyw7P5EmC
         IAlIcU63JQuXc/AS/JLGN8VYWxYhnm9uVFbqCDpM50sRMKaceXTFR/IwEzPTQLf962v8
         6Sd9C1ROZpmPRB4biJYDEe7ANRrpJRXMYUr+uyW9g8l8VDFruZr8d5B00weyBnWQcvv6
         QJu7KYe/AJb9vFUeXgRLgPd9RzJyB6FaR6kM5hWTtu7ZGLnFT6Qu58JoAgLWj/+NlqQv
         xcdT5wZ2JA5C3bRuYpC8oV+xYAhMR4ymjolchcd//oIs5xZ7YT8ex7LUknQ609fq7LGj
         f2/w==
X-Gm-Message-State: AOAM533dTskl9qc2zDrGLp1vBtfw49SP6RUeH0kO2JP5VcjL1dmMqoAq
        oiH8MSCLoyC1VCeXVmYMZKQ=
X-Google-Smtp-Source: ABdhPJwvjriqmSwSDMdAOaqFB951ycvuHORhtvM6MsAJip9crLAy/SU72zWXkJkIGGJUPo++JZ6SKg==
X-Received: by 2002:a17:906:3bd6:: with SMTP id v22mr20497999ejf.625.1643209573077;
        Wed, 26 Jan 2022 07:06:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mh20sm7551491ejb.175.2022.01.26.07.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:06:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nCjsC-003AH4-0b;
        Wed, 26 Jan 2022 16:06:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 5/9] t5326: extract `test_rev_exists`
Date:   Wed, 26 Jan 2022 16:04:37 +0100
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
 <b9c4ff863647c3719725b3ab290e055493b7d6af.1643150456.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b9c4ff863647c3719725b3ab290e055493b7d6af.1643150456.git.me@ttaylorr.com>
Message-ID: <220126.86tudqeduk.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 25 2022, Taylor Blau wrote:

I left a comment on 3/9, but re $subject: It really suggests we're just
refactoring some code to a function ("extract"...), but really we're
using the new trace2 event added earlier here to test things in a new
way.

Perhaps (if squashed): "midx + 5326: add trace2 evet to test revision
existence" ?
