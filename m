Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2466AC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 15:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjEBPy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjEBPy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 11:54:58 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC0712E
        for <git@vger.kernel.org>; Tue,  2 May 2023 08:54:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-187949fdb1cso3104117fac.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683042896; x=1685634896;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynP6yT9Ez978DRASHiHrNJDgxQYtvNt75J1I+ZFmuh0=;
        b=VC/bdKPGAC2e4O1ipYewrNdSB7RVEN/wDbwhD7QtHpILENVK4LhXY1+qfvVySCeIh9
         z2+D21wJ3mPElcmeuIwMwXv5DjNB99foX/cR4KUASxmRzvPepqhGEP5WX++h9Awp/mIh
         u3P/GbX6IqFHJfjt9AfOBPCxCv0THZV4Qqs2FNPzBlDa/Z7jta30NnO1Fmln+QF/iTbj
         Hqzlj1ksIa5rnO5H3JB5MWOP83dcZZCs8F0S4cf6+aZYgZSQ5ALKjQeHozsxzG/4Lgrk
         NcN6GaiTV6B6QVCzzQxzaX7y2GLXybgz3YoBj3YiXJX2+uF96tAe9BUSdnJSm803CBiG
         TAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042896; x=1685634896;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynP6yT9Ez978DRASHiHrNJDgxQYtvNt75J1I+ZFmuh0=;
        b=ZB1vbWcYxTUPBP6Vu/EL7z87b8CFu3IQmYCG6GnrzZLIJzLN4Ssf9Uo1spwL3mkCVL
         UgTLPoTt0vZDSxxajN4f42KHAVjE7/T92UtbwrF/xgxwkeoNEFqfbte5RfDFZfCgTy5O
         gJQS9OTwZE0fUwW5qHWWm/OAlp7ZOqQqIPOmg2SZ3dwWJZy1WH6WC7D68n7d2oHQSNxE
         BNtKsCNMTs/lk+Xc7EcTyxXZSzEGcAothKYh2q/41om7f1Xtn6AQ3F5kAEgt2n/2BJdR
         mnu57ftOkX2Ik+kgsJ7wbrzxtSWoL+pO/t11wOtf4OWEF1gyONduhPmx5csG23wStMsq
         92+A==
X-Gm-Message-State: AC+VfDzKLzeh9cCIB/OUxexpldMxPiIJXIwk1oQXUt8HUVy5cmWYovWm
        xCtzA312x+cVvuuIueg8BtY=
X-Google-Smtp-Source: ACHHUZ4QbeQpQ7NbML4X0uknQQzrYNBj7HnZMWAIBBY4ZFQdXIKbyxkhTC3+ISPsXRAYpi82dPgHHg==
X-Received: by 2002:a05:6870:d502:b0:17a:a1fe:736a with SMTP id b2-20020a056870d50200b0017aa1fe736amr7603723oan.54.1683042896551;
        Tue, 02 May 2023 08:54:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j20-20020a056870d45400b0018b03bf5f97sm12365791oag.41.2023.05.02.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:54:55 -0700 (PDT)
Date:   Tue, 02 May 2023 09:54:54 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Message-ID: <6451324ed84e2_1ba2d29454@chronos.notmuch>
In-Reply-To: <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:

> Unfortunately this library doesn't seem to offer any of those features. 
> It does support a lazy test plan but uses atexit() so will not detect if 
> the test program exits before all the tests have run.

I think there's a fundamental misunderstanding of how we use TAP.

If a program generates this output:

  1..3
  ok 1 - test 1
  ok 2 - test 2

That's clearly not complete. It shouldn't be the job a test script to check for
those cases.

If you run the programm through a TAP harness such as prove, you get:

  foo.t .. Failed 1/3 subtests 

  Test Summary Report
  -------------------
  foo.t (Wstat: 0 Tests: 2 Failed: 0)
    Parse errors: Bad plan.  You planned 3 tests but ran 2.
  Files=1, Tests=2,  0 wallclock secs ( 0.01 usr +  0.00 sys =  0.01 CPU)
  Result: FAIL

Why do we bother generaing a TAP output if we are not going to take advantage
of it?

-- 
Felipe Contreras
