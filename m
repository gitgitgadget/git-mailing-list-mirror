Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AF3C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 19:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjDXTt0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjDXTtY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728FF6A67
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:49:21 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso4035661b3a.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682365761; x=1684957761;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhUHXQNK7dCdaE7xociDhzn5byKkuGWXZz8P+toSWQE=;
        b=B6T8EYrf2jfnB+3l7yKQc5VigXkVOWCakleYGueLb2EOdgyFtl+0eEf18KnSVXt6I+
         r74AafsFl6vnaie8gfFnceJJf4nz4QqKsmXaL4lvtDrgi7Nr2Nk1xzCyTPzfwRC7Up1G
         0xoKWTarNz27EwyWVQySEOlST1xZgoVkGn+cNdLPtoUVogGCx0cuaVOriozcwxHZZ4lo
         V3uTfDf3bNcmmn295KTUKmbAUtNUDew1loN60SKnvrm/VxKdyrRna1uheF7lZNMAuvyy
         4NBZViKXU1ajY5bcEBQSmu0Td9DVM6HgoHCHuXulD2xw1TkDNWqS4i9QNbClOCn8kzPm
         1uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365761; x=1684957761;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VhUHXQNK7dCdaE7xociDhzn5byKkuGWXZz8P+toSWQE=;
        b=aNzAUqli7TLdCbi8U93zUCEjXtsn2/v5idQfFBg3QJYbVQX1MuVgZWhKgPXI2JlqRk
         cPH2DZQ7Y15sZtB/tbWYkriii8PLlEAgPk7kQX5S+48llftgZJ8LXtuzdnuV/ZJQAbY/
         1Xm9IQWWdPmuOJTDqej7k2jZQvyOUHDNdn2gIZbQ0uur2h0RZ/m+ABI0HcR8j2sGR/Sx
         MHN1F4HVNNAuZ/1sTmTIa42YehZpT3fHzuqydzvbp5tXlyohUrCnO0eMfFeCrT2IPF1X
         3nlaOGIO9wGCObTGOpKiIRGYehcxaJkjqX4Em6r2fu3KiRf3Ukt3/ITVM/pD5jevGaUL
         iaEQ==
X-Gm-Message-State: AAQBX9drY0CEvrZjwfgtONiPVBth6fmn6sCawI3A2sqc5Gt8i7ptpq8r
        E6c3hNi/eBCizToCV3+tYMI=
X-Google-Smtp-Source: AKy350ZEWtfBbnn4KDU6A0rATA/tK4mUGK5vjz/JtH9P3kRP+Bvwpt4KNWeO5l/srpiNg5/u/zzc/A==
X-Received: by 2002:a05:6a20:8e10:b0:f3:168f:4c52 with SMTP id y16-20020a056a208e1000b000f3168f4c52mr10331880pzj.25.1682365760713;
        Mon, 24 Apr 2023 12:49:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i14-20020a655b8e000000b0051f14839bf3sm6980014pgr.34.2023.04.24.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:49:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 00/22] Header cleanups (more splitting of cache.h and
 simplifying a few other deps)
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
Date:   Mon, 24 Apr 2023 12:49:19 -0700
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 22 Apr 2023 20:17:07
        +0000")
Message-ID: <xmqq354pdps0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * dropped the 3rd patch (it was pulled into the series this one depends
>    upon to fix an issue in it)

Thanks.

>  * redid the old patch 14 (new patch 13); moved the parts of hash.h not
>    depending on repository.h into hash-ll.h so that other headers and files
>    could depend upon just that part. (Are people happy with the hash-ll.h
>    name or have alternate suggestions?)

We have precedence of abbreviating low-level to ll in ll-merge.c already.
