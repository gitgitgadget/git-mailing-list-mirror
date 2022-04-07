Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CE4C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 09:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbiDGJbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbiDGJbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 05:31:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEECA2F02F
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 02:29:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w7so4905827pfu.11
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 02:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zcROTo3qGWpqQO6tBqF2ALehbF/CHdkEFm0iCkQ1Xg=;
        b=FD+WX1zTwsrMDzrIUTkveoLSuDBshIsOThVRL2epo5jTMRVU1PF9UfRUMjGDUKWB0Q
         ve1mE9Cqp3rdCZRotgN6As/ZyG7mHiWd24x298juVBx7UOMBSLl32/HcWN3s7Cw+Yr+R
         DQ7nSV7H2/BPcTW72HRMrromtRhFDx3+uqNPrrb6QZm/x29WTozYJ3NlImxCSjdBhwPf
         zvOudlAOyuWguo1LdlzGSpjgH631KzQvD/CTzsONsLUMpXjx9hNNjERgnCZvItQGg1Go
         awVKS60MsUfkSARl4CiX7g5p9U5slSSbFhNvOCdHqVoQIN7hG85EV0F/xSSkf6xpkZIY
         hT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zcROTo3qGWpqQO6tBqF2ALehbF/CHdkEFm0iCkQ1Xg=;
        b=mKIsoffZH9QF4s1lmB30X7WhdutQlZAVQVsixX2E/zcEdTzpipZtWJdulaohwSnX/T
         dEgGgE42uVotfPysJY45baDUNyL/pengxGUpUZ+eAQPv97bZ/l9Hnt9GLp23Xpq69Vmo
         Uy0bo9posOFsypkjm1WZpN/X+YRp7NQYgYQ3o0fwOtY/iYb7HzTGb2/IYJi7s7mmmQqk
         T0i+4msXH6xsL9TVuplY185tvrFbTVyFbpcp+EcpSb68Sp77B4QjFxmSdRjE3qYnfmey
         d46RhS/HOL6KBlYdxo0O1qRG5ktixu0EGljm1puvhnld04M9q9OJM7SSY/uCZRv1Rps3
         ZHXQ==
X-Gm-Message-State: AOAM532Grw4MYYm0MxgleXHUmVg40fE3ReTjAYHYdaji1eSBDXt0zc+C
        c3aPKH83kkIPktB6oaCKK6w=
X-Google-Smtp-Source: ABdhPJyBJhYCDB1xJunZKpuOK7ISCAlTctOM+Rq9pejiwwyGrHpy6XwgdURfN3NFV9YkR/6Fus5CJw==
X-Received: by 2002:a63:7e48:0:b0:398:5eed:a768 with SMTP id o8-20020a637e48000000b003985eeda768mr10453985pgn.519.1649323782362;
        Thu, 07 Apr 2022 02:29:42 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.35])
        by smtp.gmail.com with ESMTPSA id x18-20020a63b212000000b00398f0e07c91sm15704566pge.29.2022.04.07.02.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2022 02:29:42 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, peff@peff.net, steadmon@google.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2] ls-tree: fix --long implying -r regression in 9c4d58ff2c3
Date:   Thu,  7 Apr 2022 17:29:37 +0800
Message-Id: <20220407092937.66197-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.405.g55a96e933b.dirty
In-Reply-To: <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
References: <patch-v2-1.1-ed83b3b74ab-20220404T234507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue,  5 Apr 2022 01:45:30 +0200, Ævar Arnfjörð Bjarmason wrote:

> Indeed. I guess that makes this a proposed v2,
> 
> I refreshed my E-Mail when I was just about to submit this and spotted
> that you'd sent your fix in, but I came up with this (in retrospect a
> pretty obvious think-o) fix independently, sorry about the bug.
> 
> The tests took me a bit longer though...
> 
> Haing written them I guess we could do them post-release, since the
> important thing is to validate the changes. As noted in the commit
> message we're now testing all combinations of the "mode" and "format"
> options.


Thanks for the quickly fix.

> +    	       git ls-tree ${opt:+$opt }$opts $opt HEAD >actual &&

I think maybe the "$opt" here should be removed, because "${opt:+$opt }"
will not append it if "$opt" is null or unset, or will append "$opt ",
like:

diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 520b5a95c0..9d3ad0295e 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -31,7 +31,7 @@ test_ls_tree_format () {
        for opt in '' '-d' '-r' '-t'
        do
                test_expect_success "'ls-tree $opts${opt:+ $opt}' output" '
-                       git ls-tree ${opt:+$opt }$opts $opt HEAD >actual &&
+                       git ls-tree ${opt:+$opt }$opts HEAD >actual &&
                        test_cmp expect${opt:+.$opt} actual
                '
        done
--

But I'm not sure it's intentional or inadvertently design or maybe I misunderstood
it here.

Thanks.
