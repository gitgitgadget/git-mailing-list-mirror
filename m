Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C5C433FE
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 08:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiBOIye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 03:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiBOIyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:32 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF501114FEC
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:54:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m17so6036065edc.13
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9Ys/Nz3cgblY6R9CVA7a0sC3T+FBwkCpb9ejW5uM4zI=;
        b=nP0JgYxZxypzAEa+4cRlaFR6f+N53ql9vah3iHrsEzbWQ1hz23lch2BUovawnPkztn
         8pimCysUi1UktddBNAEDSGcq8uLd6EeTpmFb6AvQHC0xISmoF6Q0GZZF4dsbuFClSVVM
         srka42+iKmlUPiNfmtI4RcUu8nrbqJVqtHaXvg8mELLPqK9SPXRwdLsbooEsRc78mUWn
         MUL2yhLgp6Mrzu8cqZWgQnpzMb8PJpipsOo0G0vvrHbb5TvtEDKZ6AwjmIMRdLCHn644
         hKuPs6zvoGT1scH11K+qDz21+H6u6K5N/Jr0W6EaOqAYzQEjRAvlvRmUCFwbhLjUdhQ8
         QvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9Ys/Nz3cgblY6R9CVA7a0sC3T+FBwkCpb9ejW5uM4zI=;
        b=bEMln2DFee9m14do+GRzRbhBJOT8IcAsE6g+ji6pOsyZdfZPdRnAEFDlFrIou6M0zw
         q7rcIb+IlR9wcpHCSBNdWMmnE3qnu6KBNv4NvhZw8blrmysNirYHUj4kGAOgfmDAEI1p
         oX7D76U1Mzg+S2OvmzoWy61wfhRgosNtSbtyZhyewbjMVmhG1Klyr4uo0QO7FnG/0K38
         R8KOAPJC0mnQ6IckFdMP58nkfDoiUfn/fWb7emppaGAs4mZ8eneBvcfvu1z2uCnnR1nk
         bNV8jz3HNUP4FjKm6sHlTYDdZdR6nEpR9PV1sCtWl3askXwHVEF3SU0ASW1DovzTwU0I
         tqsg==
X-Gm-Message-State: AOAM533uRGXqcS5d2/2msvO6hlRyr4LMODNhQkf3dXTkQQs38psBr2kZ
        jMoPV/INw3R3jgq1cIiOzhn+sqnakv8=
X-Google-Smtp-Source: ABdhPJwmkDWtUj8fFd+tewOVeDPhnkVt6CZ4q1K7yUbA/Vbs1nXjW/J3Q+uSKfY3OWU8XPqEayt10A==
X-Received: by 2002:a05:6402:2987:: with SMTP id eq7mr2804612edb.330.1644915260198;
        Tue, 15 Feb 2022 00:54:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t12sm1802570ejd.27.2022.02.15.00.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 00:54:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nJtbG-002FH7-F4;
        Tue, 15 Feb 2022 09:54:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 04/12] merge-tree: implement real merges
Date:   Tue, 15 Feb 2022 09:46:54 +0100
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
 <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d7b51da94e65db79aa59ca331e178741d3c50bc2.1644698093.git.gitgitgadget@gmail.com>
Message-ID: <220215.864k50y0g5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 12 2022, Elijah Newren via GitGitGadget wrote:

> +# This test is ort-specific
> +if test "${GIT_TEST_MERGE_ALGORITHM}" != "ort"

Nit: Needless braces, left over from an earlier version where you used ${VAR:+...} ?

> +test_expect_success 'Clean merge' '
> +	git merge-tree --write-tree side1 side3 >RESULT &&
> +	q_to_tab <<-EOF >expect &&
> +	100644 blob $(git rev-parse side1:greeting)Qgreeting
> +	100644 blob $(git rev-parse side1:numbers)Qsequence
> +	100644 blob $(git rev-parse side1:whatever)Qwhatever
> +	EOF
> +
> +	git ls-tree $(cat RESULT) >actual &&

Nit: to avoid the "cat":

    oid=$(git merge-tree ...) &&
    [...]
    git ls-tree $oid [...]

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'Content merge and a few conflicts' '
> +	git checkout side1^0 &&
> +	test_must_fail git merge side2 &&
> +	expected_tree=$(cat .git/AUTO_MERGE) &&

Let's do "git rev-parse AUTO_MERGE", to avoid needing REFFILES here.

> [...]
> +	# greeting should have a merge conflict
> +	git show ${expected_tree}:greeting >tmp &&
> +	cat tmp | sed -e s/HEAD/side1/ >expect &&

Nit: More needless "cat", can just be: "sed ... <tmp >expect".
