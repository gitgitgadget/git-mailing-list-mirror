Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F6C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 16:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEAQqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEAQqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 12:46:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC510C2
        for <git@vger.kernel.org>; Mon,  1 May 2023 09:46:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-528cdc9576cso1652231a12.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682959611; x=1685551611;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKZD3BeydF0qK2W5fDKVuWr2+W0Ijhew/zsxOmA0hpM=;
        b=FQN/h5OQbFeYrW+kC/xffMZ1ESrVuxfguzhGHtSNac5K23cyYHocCOHeA8Z85JI5qJ
         KAV3+IXDSc/4oEzlhnTbBKI9e54zGZqVrq5Afqk609G6QYf5zndT9Vpu6GyV+s1TLled
         Is0p05NUe7TSdiRRQ0pqJfNkZIfa4QNdbYZWYIw7FS6GjmH/gUIBzvHHPbrrriyvNT4G
         ikqs5IqzwBtmgfW4NgzkNeyggq5Ec+uDoirLlSCCiP1uYyY+/CCgWMDWS++3VfNu00qM
         dBQQnkFf//XEg2ckCRzk8bKn3biofjfrKidXrtifU4aFveFh7bLHFG29WT9rBfzn+2vK
         awvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682959611; x=1685551611;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKZD3BeydF0qK2W5fDKVuWr2+W0Ijhew/zsxOmA0hpM=;
        b=V77kn4dIpP2KaiwfPhdI7w7MrjTue61TLcYBSRg5758QBShrQ+6aTjtfOxJkql0ZL4
         RS5oxVbEJCZ5DZrRjhMulC9HpUCd+ZpFPgBbq8AZ3wKNCILtBAwKA6/UpYZBWN8uuJLb
         IMiwigvM5hBGWJcfxWaouN6J38CKa6p1ShUy4U34jnh9bc26VNRmRwjAr4Pw2DCpJD2+
         AstUmsojLkNP7EyoEiXfaJI+AlXmTMa4FJFvnr/VPT4M9HfDJ7q3tGanmSb3mZtNNrlB
         wARkd1VrfQM7+rqGNFTDt8p/SEPGwxXGqywIUIsSayQVTGptqJ8LcyG1paT4uVYkzpgL
         9DxQ==
X-Gm-Message-State: AC+VfDydzuEfVEZD6+NeZpTKk+zojurv74W0KDy41QTA9pbP0CjsFZUI
        jdkszbXrLUMCcJWqxdeU8jQ=
X-Google-Smtp-Source: ACHHUZ69WZ6/4/bre1sI3QokRUQm4ucbs++stSjBuBLWkg1+a1n4yiuAUuqXlQzlO+zqPE7+AH6RIQ==
X-Received: by 2002:a17:902:e748:b0:1aa:cddd:57f2 with SMTP id p8-20020a170902e74800b001aacddd57f2mr10611073plf.25.1682959611227;
        Mon, 01 May 2023 09:46:51 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001aaf2e7b06csm2461610pls.132.2023.05.01.09.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 09:46:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define
 from cache.h
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
        <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
        <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 May 2023 09:46:50 -0700
In-Reply-To: <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 May 2023 18:33:58 +0200")
Message-ID: <xmqqzg6o579h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> +#define S_DIFFTREE_IFXMIN_NEQ	0x80000000
>> +
>>  /*
>>   * internal mode marker, saying a tree entry != entry of tp[imin]
>>   * (see ll_diff_tree_paths for what it means there)
>
> As it's only used in tree-diff.c, should this change not be instead
> changing how we define S_IFXMIN_NEQ itself, and combining the two
> comments seen here (the latter only partially, in the context).

Yup, the end result should look cleaner with this extra bit of
tweak.  Thanks for carefully reading the patch.

