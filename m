Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F892C433E8
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EF52078E
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+pzcKiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbgG0S1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgG0S1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 14:27:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCBAC061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:27:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so16169338qkk.7
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tdXMCe8darIe7Bb1O4QXrMXX4p0mW44lfbBNOnA6rck=;
        b=N+pzcKiYX/EzRLqkRQ8E35idXz8nu6CugRahmCWgAFkANgLtY905zzJ0gpFcBsoQak
         WY8zevBH9e14hRQSM8EJxHjS7nd2QwLXubofCpzX9w2E2Htp7ddkpiRsZ+711TOwnth6
         URVY35BiApKNhkR8GSVHDlSB0lY2BoD0BG08d2Dip4PqxHoqv21eRbmq1Anzj/zHBFza
         e+3OOgnBhyUKQlrxT99MPShcyWmmbA6FFvv0wNQnMIiRqRXdN/q1Beq6hRGqBA9nOvrH
         Ha1WmiTwfRev8C9O9Ac8WF86twNAdj83VdDHz3Gdkv5ZMc99dYn0wM3O2JTbEaNQ7Zk+
         YtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdXMCe8darIe7Bb1O4QXrMXX4p0mW44lfbBNOnA6rck=;
        b=kRRoZ5kY9IOXv5EiXxaq4o6qhD6HKuh299nUUFCWARp1TiHp/voYveLFjkfHDm5Bw2
         4PfGvZfoTrO72Rwmdi3/Kph9TdHA+LNfYyRatnUcgb/kv5aAVAkeflc42pwB1QVOLEu+
         jHizfY1JAo+3fnSLEfUMn/vk79OBjJbGQtGHjYwYRHOy6km9awDz2C7p3PVEL73Wif5m
         D7szIQf48k1IL8mO1W90DgALzGKzOUDwW3SYrK8XbpvsyMw4B4hdCVAcPfcg/mZfmjp1
         WATZOHotmutUscYej18RX8v/qA4J0dkIalhRa0jlGvoLICxMv96HTh0dDzxQ14zoIZpk
         oWuA==
X-Gm-Message-State: AOAM530N5UDsmxFKrveX5Sl5IcqE3E4O0FYGI2IW+6VihzGhZXPvW1Ww
        daBtkh2xW7Puvb8jg7WsmHY=
X-Google-Smtp-Source: ABdhPJxgOTj3+vwaOybxgrSJRop9XiLDzzGRVWPGx6f93Eytvxc4s2OLn8XVrSnIwtgRQnQoJ7qgBA==
X-Received: by 2002:a37:8047:: with SMTP id b68mr7723719qkd.299.1595874440421;
        Mon, 27 Jul 2020 11:27:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d015:5ac6:e959:4f4? ([2600:1700:e72:80a0:d015:5ac6:e959:4f4])
        by smtp.gmail.com with ESMTPSA id c70sm17630076qke.109.2020.07.27.11.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:27:19 -0700 (PDT)
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
 <20200725013715.GA2436@danh.dev> <xmqqv9icicvd.fsf@gitster.c.googlers.com>
 <421cb856-24fc-6aa0-6ab0-f513d34ddd1a@gmail.com>
 <xmqqy2n5gcls.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f201690-b090-1716-b175-562801891ee6@gmail.com>
Date:   Mon, 27 Jul 2020 14:27:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2n5gcls.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2020 12:13 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I'll rebase onto jc/no-update-fetch-head for the next version, since
>> that branch is based on v2.28.0-rc0, which is recent enough.
> 
> I do not think it is wise to base a work on top of unfinished "you
> could do it this way, perhaps?" demonstration patch the original
> author does not have much inclination to finish, though.
> 
> When I am really bored, I may go back to the topic to finish it, but
> I wouldn't mind if you took ownership of it at all.

Ah. I didn't understand the status of that branch. I'll pull it in
to this topic.

Thanks,
-Stolee

