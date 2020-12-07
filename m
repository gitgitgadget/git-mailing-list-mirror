Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415BAC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE43238A0
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgLGT1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgLGT1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:27:02 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E7C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 11:26:21 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z9so10255410qtn.4
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IOLzNz1QaXpeC7xF+bsevMbzbtdaLe0sYQEOnEPaOrA=;
        b=JwsYScJf0wyLCoNKJv5MW1wKYNBHCPBVyTzKjZBMWS7u+9L9C3DHjPiMAMNjsa+yPV
         Cp+CWcw2LBd1G//IJ85IqNRiwgF1Kr+V2BvmeHvxphUMDj5+lBPstBVzTlvCT0USmlwJ
         J9pT+PPeRiGamyg2+HVs8LeM/xAc2B/zDTE7lQSuoyFK1ZhZgNqtJP0MV55sAeJhdpVC
         p9ORxyuPwPBMuTEjctCovtsuQ83AOHiU5nLvQaZ7v35wT5x/u3BlC6MYSl6E5llGt6QK
         8HR7ya9FC7WaK2G4ZhNRZyF6VL4PuXRoToPB42kVRQLeI0Tl37Mg8wlflb0Z8QS8S1+n
         u2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IOLzNz1QaXpeC7xF+bsevMbzbtdaLe0sYQEOnEPaOrA=;
        b=O4gZxUH2ivv8oeRoaMuvz5H1PR5MLCl7Z+0xXnikIQWC3l9Ny27Uwqlk6eGXwLC34Y
         r7kRTUlgtVSSxz6um6eFr2R1y3CUGMHasiGhTlXm8wKa0mfDQM0GJ9ye6KmhCo+wKy+S
         6+Qwu6dKE6Pz0QOrArXnfTyvFglmctnconnRXMqiSAIYewcRsDc+4ghjfeqjPgUdgmXr
         7mwjSPBzsIUsTG3viVAy9it/BW2rKhfH3lfyQ3vFP0oaJVEu33T9JmZo8bvV41iCjT/8
         E/mJGqJu5lNLthRe0TdGsF6/QLp92UfK+JsO8wmtvZIS1pg0d6W2uRoL0hnQQzgph/3B
         K4IA==
X-Gm-Message-State: AOAM530zjv9B1/3CXTubTJzjGNrWsIh6wyVsp9UI1sP1Xga1eLAPouDF
        kKzoTF8+eBVqjmgmajgbpB3ksWjCPudE5w==
X-Google-Smtp-Source: ABdhPJxihK9vAJPyLvhm54UxAKLzlhX0JwWR7N27zqKMwbr9N5Ihjbg+OsqmzPgaVPGX4tT3qkRJug==
X-Received: by 2002:ac8:2bd2:: with SMTP id n18mr23358058qtn.260.1607369181066;
        Mon, 07 Dec 2020 11:26:21 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02? ([2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02])
        by smtp.gmail.com with UTF8SMTPSA id q27sm3160617qkj.131.2020.12.07.11.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 11:26:20 -0800 (PST)
Subject: Re: [PATCH v2 0/9] misc commit-graph and oid-array cleanups
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <581165d3-1590-6a45-2a0e-94c0dfa5627f@gmail.com>
Date:   Mon, 7 Dec 2020 14:26:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X85+GbvmN4wIjsYY@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2020 2:10 PM, Jeff King wrote:
> Here's a re-roll of my series to clean up commit-graph and oid-array.
> The changes are all cosmetic: comments and commit messages (and most of
> those just in the for-loop patch). I recommend just reading the
> range-diff below, if you reviewed v1.

Range-diff LGTM. Thanks,
-Stolee
