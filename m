Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7978C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF246112E
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhIOQoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOQoa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:44:30 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26352C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:43:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x10-20020a056830408a00b004f26cead745so4339946ott.10
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vvqmEren9dhWmdOMN7trY8qevMWrMKYpFFKPbUI1xXU=;
        b=Hko6SOHouQdEgMQQSm074nXijVZGhBORO0uIIPlZ26/++V9OPoUbXSfzaCS8RON19E
         Ak3++yH2TUB/NSwhJHYCfMoi9ulKAeVEScf7sWo9nh6OD1PritlPt2lFUciclN5Nj8n0
         +LQhpx7nBVC1lDz+/ejmYqa2pPESjudwgrDEZ8WRh52h4CCodYv/BmIGH66Itj4q00eL
         eRr5ipt5sz6vSpd+YvX7IC4aQnlP1kzF63VC8KNCXzICPhVlH50Zed9oTVtcvuyv73aC
         g3fchaa4PqbJcObKmhnwHxhfhr7zP8v4y6QGbpMi4tz1uyJihNftJDsA9vgQI/LHO52V
         jI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vvqmEren9dhWmdOMN7trY8qevMWrMKYpFFKPbUI1xXU=;
        b=u/jP1zhRiRFgJwOfgUOozZxBz/sNGuZ+6gIDW9LxKC4mJWm7LFG4vAbkhN+wjh6+vg
         zUhxlIkf5Ee8Q/qwkbTwfHOG2dFKoP4HuMO+pJmCvb5YqF57dVBLGq8Utrtikytf/A9z
         psLeJFV/U+zxPJEJs0BEL0g0ycAMbt6zYV7kzCgWeqqjnaiNMzM9mDqGDVuQL8GhLrPp
         hf5fVtaoWQnvse249NRBfbRyVC7EWEjRmt8FDma0Vlv2Z6C+LTSy63n49gCNqBYllP2S
         BeK0cOsHw0eCPLELRlvhy8IVPlNRIdJ08osU6C6cBcuMaQVIAXQ765M574mpS/iM/Yju
         QVHw==
X-Gm-Message-State: AOAM53000ZH1nZEmxWKw/CU+vedQf+gsUwJQxV1n4Y6O8ZuHMsY33cep
        jCuawTE/6Zg0wL4A5QQ2LHA=
X-Google-Smtp-Source: ABdhPJygZblYkeOysse24+XXW9zzVQqDILagAli+gk6/J4sAl3UD4AU8OkCDOZixk7qco5mgtS+m7A==
X-Received: by 2002:a05:6830:10d2:: with SMTP id z18mr790076oto.341.1631724190433;
        Wed, 15 Sep 2021 09:43:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8cdb:119:9f7e:3e24? ([2600:1700:e72:80a0:8cdb:119:9f7e:3e24])
        by smtp.gmail.com with ESMTPSA id x22sm133695oox.26.2021.09.15.09.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 09:43:10 -0700 (PDT)
Subject: Re: [PATCH v2 04/14] dir: select directories correctly
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
 <CABPp-BFitDu8UFkH5Syd3w7_e4sT5nJCJ_6N5sn3a+Acv6B4aQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3252cc19-46ec-bbbe-6a02-fe02cb767dff@gmail.com>
Date:   Wed, 15 Sep 2021 12:43:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFitDu8UFkH5Syd3w7_e4sT5nJCJ_6N5sn3a+Acv6B4aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2021 10:54 AM, Elijah Newren wrote:
>> +       /*
>> +        * Use 'alloc' as an indicator that the string has not been
>> +        * initialized, in case the parent is the root directory.
>> +        */
>> +       if (!path_parent->alloc) {
>> +               char *slash;
>> +               strbuf_addstr(path_parent, pathname);
>> +               slash = find_last_dir_sep(path_parent->buf);
>> +
>> +               if (slash)
>> +                       *slash = '\0';
> 
> Are you breaking strbuf invariants here?  path_parent->len will not be
> corrected by this string manipulation.  Perhaps replace this if-else
> block with
> 
>     strbuf_setlen(path_parent, slash ? slash - path_parent->buf : 0)

Yes, I am. I noticed and fixed this when I was rewriting this
patch for Ævar's feedback. Thanks for pointing it out.

Thanks,
-Stolee
