Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2380C47085
	for <git@archiver.kernel.org>; Tue, 25 May 2021 15:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4746141D
	for <git@archiver.kernel.org>; Tue, 25 May 2021 15:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhEYPMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 11:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEYPMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 11:12:30 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83CC061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 08:10:59 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c10so23324259qtx.10
        for <git@vger.kernel.org>; Tue, 25 May 2021 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXu/Y0WVhk+nLh7diJqfFfi1uTS19UypG9dPhL5nvG4=;
        b=o8pihcd6bpUAhKimB3tnIMLzwxkhkMcEtX5J2s1osa0seYjEXLYEeLfYoIrbB7UmWX
         UPJbO97BDu4gcbJSffrHeswEUN8iPl1ltgk39V1bh1qmLNfZdYYUliFjdhUeVwX+50Cd
         PeRbTbWXxf5BIaPrAa3BKDlivG8g16t8YkUdOEhqPK04TWIhDnmRSe08bAtLAL8D+qhA
         yEPzIF5ifIMsbbZAnseiQ3IB6ziyldDCHghOM5nHtG1uzOTHubb8IWlAOHmp6P00hUem
         LxE5pjVsuaPlpenzqcCZvBfnk0y2h+G7iXMMkgZ1v7tb8XYW5D04vNSHpJOZ8oGxZMy+
         /kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXu/Y0WVhk+nLh7diJqfFfi1uTS19UypG9dPhL5nvG4=;
        b=FBwgjZ7Cja0PbF4pHjgQtKYxh+qqK1jsnIBeN5cgNKir5wUPck6VqgWV63YhABJy7O
         pWpaPGQ+/5sOrdGZ5IcfUN0RFv3ZPkGbnyjCvRu4J+aY6Ts47CcstTOXuY7WfzozsOL9
         VB5zcCeLjbcZpCeD5/npQyasJ0X2KaQImJ/e7xkjsQd+fYU+EoAE5JDpMfQCxKPqrqqP
         7ado2YIJsMIc3Jg9TxRU05YHrxGrHond5bXTMF+bT3aHikC2BewFsWSPBIDdVUoqFmyC
         g98MejC3HULiV7LU9+cJDGsddoFmtk720fEiDuMyEhuOPfLb62mkqKIcyZ+fxR0Acaws
         DRVQ==
X-Gm-Message-State: AOAM530jazeGkYXzSN2k7NUFRvy5DkgScnO13kPtJtAfIo99D+g7/vdX
        m3OfdFeflHbNuBzBZOJrsIqsEw==
X-Google-Smtp-Source: ABdhPJxFTrR+PgINvJR427791bOf+5OyVA9n4NBTJafHqkRvrYSbBXoM3SCDlmWXbhQNyN2+Vzdqfg==
X-Received: by 2002:ac8:474d:: with SMTP id k13mr21916959qtp.229.1621955458852;
        Tue, 25 May 2021 08:10:58 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1c2e:9388:c87:38ef])
        by smtp.gmail.com with ESMTPSA id g6sm13186399qkm.120.2021.05.25.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 08:10:58 -0700 (PDT)
Date:   Tue, 25 May 2021 11:10:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Message-ID: <YK0TgfKFnqOSFKD8@nand.local>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local>
 <87fsybohy5.fsf@evledraar.gmail.com>
 <YKxBIP4lkoPeCYvb@nand.local>
 <xmqq1r9viku7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r9viku7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 25, 2021 at 11:54:56AM +0900, Junio C Hamano wrote:
> Stepping back a bit, this is an unattended test---why do we even see
> progress meters?  Are we forcing the output to tty somehow in our
> tests, or do some codepaths forget to ask isatty() when the command
> line does not say --progress or --no-progress?

I found this while responding to Randall (who is observing the same
problem in another thread):

  https://lore.kernel.org/git/YK0TKVZidW%2FG8XBr@nand.local/

Thanks,
Taylor
