Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41CC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C7061446
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbhDUJyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhDUJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 05:54:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30C8C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:53:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c17so28274515pfn.6
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=oIkpnUCmx5d9/lYZF0Rik9aMT4lGgzIPOmoG0+n/PrM=;
        b=eYpmLYTMvt3sGIwMDq3gSturFmnjliV9b/8e0NxwPhiVrReVKFIcNPWwLsphJBajfy
         aGxooXf3iwQKa4at91aT5KkkHBJWhT5+CCu2Khos9Fb7bDApNKs5+J2H198zRlrAWC1a
         BOobHhCaWjbFtbww00YJOor7ojOt+M+zpmasg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=oIkpnUCmx5d9/lYZF0Rik9aMT4lGgzIPOmoG0+n/PrM=;
        b=aCzyGTZwM95vXg64eT8+QpLuD3ygIcxkftJn7bJtJL0CEtOlfnqCeTORLyyyf9h5uI
         o6wnMWedrlJs/64wSUgU5Waoh/o7krdcUUsYj4xjChS5GaZqj2IHdR4TZqw09+iUNYs/
         zfzJXb0noZPtF1bQiVM+JuI0MXeOCRxW+EzdXLYE05ftlxlhg6tb2vmOm1RvbCdusEUQ
         pmStFmHkglmaCyoTO6VB7hwYQbAkg3uGmbVUhErdkN4XckvNsyx01UdZuvYLwsFvOlmt
         LGyzXKR87MB9738CuppnZyWjXBur5jaEDtAVDfsGR7pod58lxs5+fOGcnAoHOXzxOnBI
         bN6Q==
X-Gm-Message-State: AOAM532RUdpBIXSl0Tt+dbMs6bJOJpTDlsaAjCoWWG7GT5Tzay2CkKBs
        xZmMg4wRHIQvQ8sRV1KhUnNZkAxuJIwb4DIyJeU=
X-Google-Smtp-Source: ABdhPJzY9rwm048rsXTwwSjiPz2mlT6fMc5lv4ughbLarB9mRA/tyG1ZuzUTv9SdpNhZBGYKj3L3cg==
X-Received: by 2002:a62:3201:0:b029:211:3dcc:c9ca with SMTP id y1-20020a6232010000b02902113dccc9camr29007957pfy.46.1618998838155;
        Wed, 21 Apr 2021 02:53:58 -0700 (PDT)
Received: from [192.168.245.142] (cpc108961-cmbg20-2-0-cust748.5-4.cable.virginm.net. [80.5.130.237])
        by smtp.gmail.com with ESMTPSA id gj13sm1658467pjb.57.2021.04.21.02.53.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 02:53:57 -0700 (PDT)
To:     git <git@vger.kernel.org>
From:   Luke Diamand <luke@diamand.org>
Subject: Track changes across multiple branches, c.f. "p4 interchanges" ?
Message-ID: <d9022ce8-2752-db75-f4b7-d5188c41bd90@diamand.org>
Date:   Wed, 21 Apr 2021 09:54:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're moving over from Perforce to git.

In Perforce we can find out definitively if a given commit is on branchA 
but not on branchB.

It doesn't use textual comparisons (c.f. "git change-id") but tracks 
which changes are on which branches.

This is invaluable for managing rapidly evolving sets of release branches.

How do I go about doing this in git?

1. Cherry

"git cherry" - but surely once the change gets sufficiently mangled by 
conflicts, won't it end up being "lost" ? That has certainly been my 
experience in the past.

2. Merge

I could work on feature branches, and then "git merge --no-ff" the 
feature branch - but when I do that I end up pulling all the intervening 
history over. e.g.


                - X -         bugfix
              /       \
    A - B - C - D - E - M     main
     \
      R  relbranch

If I do "git merge bugfix" onto relbranch, then as well as getting X, I 
also get B and C, which I don't want.

3. Always start from a merge base

I could tell people that if they are making a bugfix that will need to 
go onto multiple branches, that they need to start from some common 
merge base, and then merge to the final target branches.

That's possible, but is quite a big change from the current workflow of 
working on main and then "p4 integrate" individual changes over.

And invariably people will start out thinking their change is not a 
bugfix, but a new feature, and then find that actually we need the new 
feature on the release branch.

4. Use gerrit change-ids

We could adopt gerrit change-ids. It feels like this is kind of a 
kludge, but perhaps it's the only thing that really works?

Is there something better?

Thanks!
Luke




