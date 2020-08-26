Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E9C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371E920678
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 23:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bYErvqOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHZXC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgHZXC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 19:02:56 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1756C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:02:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c8so3025843qtp.6
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 16:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TEWdHYQ/To0kbhUnEXY/t1vMxCohVgC39WNxZzhaNmQ=;
        b=bYErvqOWx68zozistQtwseu37G5IRNzi3IOAc4vCfkxE5CqAKDa10a3sBKDZ2mdbhq
         8eFRcCa1Ry/4Y1r27hc+0eE6nnNJZoeIwG5VuDriugvPr/EB8nnGMVh/qdhvGgjp/IXW
         lgVa2G7SQ0TjFvI8WNjU/wua+cD7xN/17RVGE+DDBvmZNaEUDB0W4MJ8PSotx4S/RuGR
         qkB3eCt8zuoBUXqVi+hHoHRplhNOGfuX+fL8OxDaFH1Zcg/KIXWHrPRHTBO7UaaRkZxG
         qiUIvw2sfVrRxBbq/JBqJ0B979wPTx31oGmQ1IRcFAM5VM9Jm3oh/SQaj8MZ2wQZO4xB
         3wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TEWdHYQ/To0kbhUnEXY/t1vMxCohVgC39WNxZzhaNmQ=;
        b=PLeC9tsfsriuF4saW4LCbAi5k7aPIlXXM1zWNsj2i4cLHmptDKuogp/lVwZBCW+htt
         TumaTt5LJXKpDYRv8/LI1WCLm9tg+J3+VrxQErVOVv82eawEtvdycXWqrBKwCoptHh5y
         0CSTC3kdViWDixlJBJ+y3CsceL9wLbk480vWYhxdaoHVgFL7g9dtnw3+Zumc8i14Ur7H
         yCmr9d2BaKoN1Qtp1ptusgPeWd9CNZwLIfJFUSCMXRl7dwPi2RAKCQk61wryuDfFxGWJ
         36Xe28WfC6oVGWATGTZ867bSr+ptIQBL47zkq7IUCHGWl9VQMQrbegdcx+ycfag0gIf5
         lrgw==
X-Gm-Message-State: AOAM532vyAAI9N0m/ckEXwSHJymdsU8jF5+gAHi/Jq98+O50Sr3m27QI
        e1LX/PGqyo2+1rrC/pP/yAvYR3N8fg4StYtDnxbr
X-Google-Smtp-Source: ABdhPJxzSeMdt+KmGigfSSQLKMXacCsVcvO17GtbG7A7xGwuu0QHYRjsHUCyRsjmxa1/IXv8zHJwKfh58+DbJLflzOPr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:11a8:: with SMTP id
 u8mr16373454qvv.88.1598482974089; Wed, 26 Aug 2020 16:02:54 -0700 (PDT)
Date:   Wed, 26 Aug 2020 16:02:52 -0700
In-Reply-To: <4c3115fe3522bee47ba1f8f5e847e99ad7e56d40.1598380427.git.gitgitgadget@gmail.com>
Message-Id: <20200826230252.1445841-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <4c3115fe3522bee47ba1f8f5e847e99ad7e56d40.1598380427.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH v3 10/11] maintenance: add auto condition for commit-graph task
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, derrickstolee@github.com,
        dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Instead of writing a new commit-graph in every 'git maintenance run
> --auto' process (when maintenance.commit-graph.enalbed is configured to
> be true), only write when there are "enough" commits not in a
> commit-graph file.
> 
> This count is controlled by the maintenance.commit-graph.auto config
> option.
> 
> To compute the count, use a depth-first search starting at each ref, and
> leaving markers using the PARENT1 flag. If this count reaches the limit,

PARENT1 -> SEEN

Other than that, all the 11 patches look good.
