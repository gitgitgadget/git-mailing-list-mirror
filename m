Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B2BC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKDB0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKDB0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:26:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E861C430
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:26:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k8so5154772wrh.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqlHpSNXzCVhdIn2pTu0nW86I1AeBXcoBVeJ0eiyRIA=;
        b=Z/rsilEnNMnX6HZR45W1pflc295WADg2jjt0M0eK+UfpJHO5lLkUC55ZBOXVaKoACB
         cEJTeu07pfQdrvh6W0XoNvyUyeVMsaYKfQEcGKCCBoHaOjAg6Q+ZDaVvbiwLDrN9y0yP
         BncY6oGFs/JXaFFw/9Yfq/4znGP3pqP/OOclSGxQiSS4Ady8ykFGTULjnIE24v/fQ9QH
         GZgxBnQmsOvAhFJeKZXo/DywjDWfTk3tioS/EjTbdhyjb9oHw2fzUpkBcdfwtosaM0o1
         P3AeieIZ6FrETHryvg7YVUjwjNfB7zsE3yPFIIYdlrDs2XGDT3I9DmEoc6xAYnYKFHJ6
         8Njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqlHpSNXzCVhdIn2pTu0nW86I1AeBXcoBVeJ0eiyRIA=;
        b=5vzldmia8JwSjV4EB9aheGn93AuV33kc7RBl+LGrCwjE83fl67nC4O/12CieNMVoVy
         wKMq4JAsYY6E4XB2TZUT/LdpLPcoEtl22NWtVpuR4JUPHGpcuYRrwtc/C+HYr2MzBB3C
         kfNyzaUf9v2u2BsMQWGDTIRHynV+EHzkJi+UEE6W/ZkJBgeBBD0kTGd7QMRpTvazn9sw
         0D+xLiqaSURJaP9Of0veznHfktz0CzuMic7DkolD3Rf8Z93CQohcFASNt8SPecDfRVWY
         qeL5aaAL392C6ClpgESg15LmqDkWad+TfSOEKmTot/MxhUK1Cik05MYZF2zhCmlkn5uO
         PRwg==
X-Gm-Message-State: ACrzQf2/fOWCJIjdRk0jhy6bSzgaGGN+sWPk4R2kQz53ys768fKe2CZm
        s0yLH2XeKHihIDTbc/PhNT5h4m2Adro=
X-Google-Smtp-Source: AMsMyM6gmFHemreFFVtp2TuRl+AaVRRtj/XBU6ZnEkyDozzfzg1U4+TDugYpyIbvG/cAYYUWNXQOmg==
X-Received: by 2002:adf:dd4d:0:b0:236:6e72:be17 with SMTP id u13-20020adfdd4d000000b002366e72be17mr19717348wrm.460.1667525167446;
        Thu, 03 Nov 2022 18:26:07 -0700 (PDT)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003c6edc05159sm1409405wmm.1.2022.11.03.18.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 18:26:06 -0700 (PDT)
Subject: Re: [PATCH v2] branch: gracefully handle '-d' on orphan HEAD
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Martin von Zweigbergk <martinvonz@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <Y2F9lkCWf/2rjT2E@nand.local>
 <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
 <Y2H/1S3G+KeeEN/l@coredump.intra.peff.net>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <f21bf37f-4efe-326c-0090-d13ed54696b9@gmail.com>
Date:   Fri, 4 Nov 2022 02:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Y2H/1S3G+KeeEN/l@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/11/22 6:27, Jeff King wrote:

> We can fix both by removing the die() in delete_branches() completely,
> leaving head_rev NULL in this case. It's tempting to stop there, as it
> appears at first glance that the rest of the code does the right thing
> with a NULL. But sadly, it's not quite true.
> 
> We end up feeding the NULL to repo_is_descendant_of(). In the
> traditional code path there, we call repo_in_merge_bases_many(). It
> feeds the NULL to repo_parse_commit(), which is smart enough to return
> an error, and we immediately return "no, it's not a descendant".
> 
> But there's an alternate code path: if we have a commit graph with
> generation numbers, we end up in can_all_from_reach(), which does
> eventually try to set a flag on the NULL commit and segfaults.
> 
> So instead, we'll teach the local branch_merged() helper to treat a NULL
> as "not merged". This would be a little more elegant in in_merge_bases()
> itself, but that function is called in a lot of places, and it's not
> clear that quietly returning "not merged" is the right thing everywhere
> (I'd expect in many cases, feeding a NULL is a sign of a bug).
> 
> There are four tests here:
> ...
I've reviewed the change and looks fine to me.  Fixes the issue with the
deletion and avoids the segfault you discovered.

But the last paragraph in your message, before describing the tests, makes me
scratch my head.

Certainly there are a few dozen places where we have direct calls to
in_merge_bases.  I haven't found any (beyond the modified in this patch) where
a NULL commit can be used in the call.  All I have reviewed have a
check_for_null protection before calling, mainly to show an error message.  And
this makes me think about, what almost happened here, leaving that uncovered
left us open to a change where the error condition (NULL commit) doesn't matter
(just the not_merged), and/or does not have a proper test with generation
numbers.

The segfault possibility was introduced in 6cc017431 (commit-reach: use
can_all_from_reach, 2018-07-20).  Before that, NULL was tolerated by
is_descendant_of (and indirectly by in_merge_bases) and returned, still today
(as you described in your message) as 1.  So IMHO we can safely put a check for
NULL there and return 1, as a fix (or protection) for this segfault.  Something
like:

diff --git a/commit-reach.c b/commit-reach.c
index c226ee3da4..246eaf093d 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -445,7 +445,7 @@ int repo_is_descendant_of(struct repository *r,
                          struct commit *commit,
                          struct commit_list *with_commit)
 {
-       if (!with_commit)
+       if (!with_commit || !commit)
                return 1;
 
        if (generation_numbers_enabled(the_repository)) {

and leave the checks for NULL in branch.c, as optimizations.

I've cc Derrick, maybe he can give us an opinion on this.


This patch also /fixes/ the error message when:

	$ git init -b initial
	$ git branch -d initial
	fatal: Couldn't look up commit object for HEAD

Now we get the much clear:

	error: Cannot delete branch 'initial' checked out at ...

A nice patch.
Thank you.
