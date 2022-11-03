Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB878C43217
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKCJfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCJfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:35:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7C2AD4
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:35:40 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 78so1154311pgb.13
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rc0o4mTeM950thkGCwG3QRD4dABImXRVrpT0j5yiLpM=;
        b=VRMhS+cKDCy4cQeJycTgah3ACwY+MTaBLZZheky2DtNpTq2ZoDOke38kI4FEmN+cfp
         WZdTUJ0tuNS7vYTdlUCdKX4SPHRV0ycbGTTe4hT8LCuIEgkTcuwhFVpyQatvfjePgX2Z
         DFV3Ds+Z7BbH9i/Y73QSJHlKpi+tLbMLA78o/lt7Jr08Ly1MNkh1caJRUHjfdpeHSUwv
         5rxGyNUTd2EC5WIIYOXJ2DZkrHcv8QxkyJIjmcd2Ewb067V9umcMWGDmmRYAZ7TrxxzO
         MsaQdEwunS0CNOTWo7RIfjeDgX8lyw0XW6RNmQ2Zvz9MHQdlMRSIi62/NgpuaXdo/JXd
         /yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rc0o4mTeM950thkGCwG3QRD4dABImXRVrpT0j5yiLpM=;
        b=Rsv2REA65TKO5LGrviIaEuZ9cMZomUqzOuX0m+6mlvvUPzgtHohH2rGmArgw9MkGyI
         sE+CHjM2IB99zR6MyZldbqDmR2HLdkETQiGldUjyKIGp86OAvaF3GJEwttsNYWurKAxN
         5GKdh3GPyUT3wre1ELBaNox7nSXEmQYG/nu1G4/ArUeRE+Nibe40En+Sj9MOKCf9gubX
         6fpyOE4/yKyQek1OMyIfE3AXpPgAXCbgr2mbgSnYYeVdk9ZMjfOAXZSU4fBi5llLdq0W
         wWBb07Osy4tiW67e26aq4W1R65p7uJq7HuFc3+K5LXCYf1Hyy15R0yUcmqKHbVjrgqvS
         PPLA==
X-Gm-Message-State: ACrzQf2bpPRWOr6RkPSi0zN8+YA9Jbdx6td7LrHCooVr7Qo+uRfmBQnF
        545I87FilwzH3ptP2TF6/SPJxsKeAdtX4Gtg
X-Google-Smtp-Source: AMsMyM6Mva+99ID5N3S2kzDjFt8F4XwVk52lxSl4cgibj5HgXtHGCgzFyCfcvpW4YRUaI24/kl4Bmg==
X-Received: by 2002:a05:6a00:1ad2:b0:56d:ec92:9825 with SMTP id f18-20020a056a001ad200b0056dec929825mr9849903pfv.25.1667468139779;
        Thu, 03 Nov 2022 02:35:39 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d15200b00186f608c543sm72668plt.304.2022.11.03.02.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 02:35:38 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, moweng.xx@antgroup.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Thu,  3 Nov 2022 17:35:32 +0800
Message-Id: <20221103093532.40511-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g374bfe65850
In-Reply-To: <Y2MWeE2f/P1iXPCY@nand.local>
References: <Y2MWeE2f/P1iXPCY@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> OK... here we're getting rid of the user-visible warning, which makes
> sense and is the point of this patch.

Yes, my point is to avoid exposing some sensitive informations to end- users.

> But we replace it with a trace2_data_string() that only includes the
> basename? I'd think that the point of moving this warning into
> trace2-land is that we could emit the full path without worrying about
> who sees it, since trace2 data is typically not plumbed through to
> end-users.

I'm not sure if trace2 data will be given to end-users, at least as I understand
it as you, it's not. If so, your opinion is very reasonable.

So... maybe we could add a new configuration like "core.hideSensitive", and
there are some supported values , "loose", "normal " and "strict":

    loose: plumbing full information in trace2, even warning.
    normal: plumbing full information in trace2, but not warning.
    strict: plumbing part of information in trace2, but not warning

But it looks like heavy, maybe not worthy... So, currently I will remove
basename and print the pack with path if there are no new inputs here.

Thanks.

> If we get later bitmap-related information in the trace2 stream, we know
> that we opened a bitmap. And at the moment we read a bitmap, there is
> only one such bitmap in the repository.
>
> I suppose that this is race-proof in the sense that if the bitmaps
> change after reading, we can still usefully debug the trace2 stream
> after the fact.
>
> So even though my first reaction was that this was unnecessary, on
> balance I do find it useful.

Yes... I think it's useful as least for me to do some bitmap tests and
I think print a bit more related information in trace2 data might be OK.

> > -test_expect_success 'complains about multiple pack bitmaps' '
> > +test_expect_success 'complains about multiple pack bitmaps when debugging by trace2' '
> >  	rm -fr repo &&
> >  	git init repo &&
> >  	test_when_finished "rm -fr repo" &&
> > @@ -420,8 +420,13 @@ test_expect_success 'complains about multiple pack bitmaps' '
> >  		test_line_count = 2 packs &&
> >  		test_line_count = 2 bitmaps &&
> >
> > -		git rev-list --use-bitmap-index HEAD 2>err &&
> > -		grep "ignoring extra bitmap file" err
> > +		ls -tr .git/objects/pack | grep -e "^pack-.*\.pack$" > sorted-packs &&
> > +		ignored_pack="$(cat sorted-packs | awk 'NR==1{print}')" &&
> > +		open_pack="$(cat sorted-packs | awk 'NR==2{print}')" &&
>
> Hmmph. This test only passes if 'ls -tr' gives us the packs in order
> that they are read by readdir(), which doesn't seem all that portable to
> me. At the very least, it is tightly coupled to the implementation of
> open_pack_bitmap() and friends.

Yes, because the _order_ matters here I think originally. May you explain a
little more about _portable_ problem please?

> Do we necessarily care about which .bitmap is read and which isn't? The
> existing test doesn't look too closely, which I think is fine (though as
> the author of that test, I might be biased ;-)).
>
> I would be equally happy to write:
>
> > +		GIT_TRACE2_PERF=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
> > +		grep "opened bitmap" trace2.txt &&
> > +		grep "ignoring extra bitmap" trace2.txt

Orz. Actually, I wrote it on the same way, but I think it maybe not so
sufficient for my patch. So...

But I think you are right afterI look other test cases, will fix.

Thanks.
