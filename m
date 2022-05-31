Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A2C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346762AbiEaR7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 13:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344446AbiEaR7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 13:59:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A085EE4
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:59:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id u2so2963151pfc.2
        for <git@vger.kernel.org>; Tue, 31 May 2022 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/2ZBM0wHdIs8Cgw+r4XUT/xsUwvxfVbUXXk7WGm6lyU=;
        b=fKcUOhoSHgGeWB2WhJBtAOlKrLe0uR92I6Z/KO8ZaBE4htr49dS5n10eULvLWNvJGF
         51U40/XOoRewyRyxhFnsCJaNO2+Yn7GvV0W+BnWvtlpFC3fnMeEk5ZEqEpJsHAg8WfyP
         DSNo8RpICWnLlzdRPVCDs4Srhb4aJzwnmoNiCD35yED1rC13BQFyH0t8J8GNE62DPfF4
         c/8Jr1jO2U3Gg0JIQa05JOmTa24dQU5h5Zi+WK//xTxkGUW59qpKcuxlYNWejlGkaqa+
         RO6JSGHQzhFsjTth7CbULjoFwetrapCU0oonRc9ZygnTKAjgr9fEN7F4Wq2PoFxDju4+
         vfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/2ZBM0wHdIs8Cgw+r4XUT/xsUwvxfVbUXXk7WGm6lyU=;
        b=cfTz4d7wGzKEuiyiOe8IiaibM9f2vOEY6eXTPdqWSDkSt/ZGTwgqbeyVUQ5o8w9Llw
         dRDsAe0VfVrVxtpYVcPx/rwugJoRk19DZEaLWsn3my8tFY+RczGF6KDc3Ot4suVEsH/d
         eFsBA4+TOOFsMUAn2btL3pXRJPPj/no/GWSjbjyVMZG/jrQ+ep1Dd1wS9c5YCW4da6Ik
         GJJpDJ2iW24zRt4a8h01wvt2Bo24W6w3YW3px5jicepyxpCtCjuN/F5B23NLwgELbENg
         SUGhE29F5QsmTnWKHqjt4EZdsCtJIKC/GYFyhTMtTaczIwD7Iooc35r+N/oWzjf920oV
         4Nhg==
X-Gm-Message-State: AOAM533TiQvbld7JuKDWd6PiLDc1STE8GRCsSnDFh7B3sPMpV7xKJOq8
        qAXZPkEF2omVOod0F5QhQ1r/6iHdh3MNFA==
X-Google-Smtp-Source: ABdhPJyY1BtAR0nSguSorlErjwPC2zTnc1de7H+6g+omftUWDjCOCcfQSKzcNDXG1xOc+GX65pPWdA==
X-Received: by 2002:a63:f95e:0:b0:3fa:5855:9a3a with SMTP id q30-20020a63f95e000000b003fa58559a3amr37394248pgk.468.1654019990260;
        Tue, 31 May 2022 10:59:50 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:42f:67e0:2ed2:1f46])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090abf9100b001df68146a20sm2239661pjs.56.2022.05.31.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 10:59:49 -0700 (PDT)
Date:   Tue, 31 May 2022 10:59:43 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 0/3] trace2: log "signal" end events if we invoke
 BUG()
Message-ID: <YpZXj/VzMTNPSA1H@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
 <xmqq8rqp3x9z.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rqp3x9z.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.05.25 18:20, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > (depending on the TZ) that he'd encountered trace2 event streams
> > without an "exit" event, which as discussed can be seen from usage.c
> > is due to our invoking of abort() there.
> 
> Josh, is this related to the "in rare cases" thing we discussed on
> the "run-command: don't spam trace2_child_exit()" thread?
> 
> https://lore.kernel.org/git/4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com/
> 

No, this is a much more frequent issue than the repeated "child_exit"
events from that thread. Any time Git exits without calling our exit()
wrapper, we don't log any "exit" events (and presumably skip "atexit"
as well).
