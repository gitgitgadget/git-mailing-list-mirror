Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0356EC38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 00:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjA1AcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA1AcG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 19:32:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD631BE0
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 16:32:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so6176345pjg.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 16:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuHW0mRRPLlnd8hJHxkYEhoCwGuO4Eb7577ALITULwI=;
        b=TCphiSILPH8/R340R6cYhOQOSiu16/Qz5NgtfSGHXySxrqKBUoZ13G2+rr6SP4XPQL
         xl17QEnlAtn+Q9Fr/PKb7emQuqmHBCZSce4TZ/+J04hl+4ND3oNrRN8pT7nOT7tK7AfT
         OM2z05JRkzFeY2CVF+5N5WKNNMI8pkEf0Hr1eTA/wLplQXlNy6fhdDb9ePPG7lW2AEp2
         duqBazMleHfDvRtLvtzldM29fwKu3TsgeyWlu4rwKH4aMWKZ/byhkVnF5llfwzeeJFY5
         16D32E2Krc6wRh2eSeGBsLiE+h6q00tWT9sLZbtKReaume5U/h/s/oSPCMwloURSdEJT
         ycaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NuHW0mRRPLlnd8hJHxkYEhoCwGuO4Eb7577ALITULwI=;
        b=myHNQbRoeUkKVU3nVeftTkT7ZtbIjwYU4INd9O1Wok4pgfBcq5AqgJXG+oCY1KOPMH
         iDgUGDOTRXbpObuAPML67UC728tEXxOCh+pWT/+INli4qz2DYIZ/v5YOWOx8pwVSvfAP
         Pq8zOuAcLBQ/jVGvA2axZX4a/YB+zc6PbmX9x8pvixC/wm8gnKyWe71/nQkgpQl14oeV
         NUujial29nGDVSqycjSvK3020BHm/L3UwhszxkItQjpzaRtXYxCN6ryBBZdCw52hXRUX
         9u/JBzL/Fey7PHs4Tjja/ikTZQwLB8V75QNfg6omlfXx/1UGHF00sqENlkBMi13lMKEy
         Cguw==
X-Gm-Message-State: AFqh2koqLRv+cm8OtRMLGRlZ0rHtEUPzQ8sPEHcjvENtfXd+I/WxDUnw
        n9LpUPpvLSbbC9Jxzys/YDQ=
X-Google-Smtp-Source: AMrXdXv8NviJBmCp7slClPkHh04r4tzk9Cv3dnI0COE+pMAVi7+EElseN0A8zcLy/fmsQPLq51jnMQ==
X-Received: by 2002:a17:902:ecc2:b0:194:df47:2b42 with SMTP id a2-20020a170902ecc200b00194df472b42mr38797966plh.48.1674865924221;
        Fri, 27 Jan 2023 16:32:04 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b00177f25f8ab3sm3431381pla.89.2023.01.27.16.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:32:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
        <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
        <xmqqleln90ka.fsf@gitster.g>
        <4913381a-769f-aba0-c04d-559d103e8396@github.com>
Date:   Fri, 27 Jan 2023 16:32:03 -0800
In-Reply-To: <4913381a-769f-aba0-c04d-559d103e8396@github.com> (Derrick
        Stolee's message of "Fri, 27 Jan 2023 17:18:23 -0500")
Message-ID: <xmqq357v8poc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>  The "maintain
>> their clone" certainly should include running periodic maintenance
>> tasks without them having to worry about it.  It feels like this is
>> calling for an explicit "disable periodic maintenance tasks in this
>> repository" option to help these esoteric environments that disable
>> cron-like system services, while keeping the default safer,
>> i.e. fail loudly when the periodic maintenance tasks that the users
>> expect to happen cannot be enabled, or something.
>> 
>> Perhaps I am not the primary audience, but hmph, I have a feeling
>> that this is not exactly going into a healthy direction.
>
> Here, we are in an environment where background maintenance is
> unavailable in an unexpected way. If that feature is not available
> to the user, should they not get the benefits of the others?

That is not what I was saying.  I just have expected to see a way
for the user to give scalar an explicit "I understand that periodic
maintenance does not happen in this repository" consent, instead of
demoting an error detection for everybody to a warning that users
will just ignore.
