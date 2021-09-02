Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0969C4320A
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B4E61053
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 11:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhIBLiu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhIBLit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 07:38:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E1C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 04:37:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so1587325pgr.11
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJuMKf6ICAjG1OUbX7EERGRIQ6yFiIFe8R+cFJqINAs=;
        b=RuTU9nHFsiAcEGsHSP7tyn6zmQjcpqtL8y6tNXeSQ5eg8xqvHkavfIpEM3eFswY4VB
         4Zf+MZY/vKhCW4nOdG+0BE0E3vCjG8aQlxYOiYlJdg3yHtwoZ/7i7BdH55tvTGrFiSel
         jezSRClEWyBKnMcwK2aOhpXD7wudRIA4RTC7Pnv00Yt02Vt6FeEpkhnIdl+KdZyPcQtm
         OpEaLfUji+sIsyEieK431xVwhhOf4cpT9p1J/aVWAp8ETcg7FZ8pX/0evJDLwYtLsicE
         2oTRU7wjzSFjzbuJPp59e7ReRPjv1xN/n69GZztzxWtuV7wyPp8v14PsDNhGIE5+WdB4
         9ZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJuMKf6ICAjG1OUbX7EERGRIQ6yFiIFe8R+cFJqINAs=;
        b=C2p1DRRoQGkUN8HK7lxqL4m30nVuSSIDnuYxohTa31/5d/IiJ2uZkCxBDB0ZUceX01
         6v4r0dmZOrUUA/Nl5GVb03Jo1MIeSOzog5NRz37V1ulL3Vf64zec1zwKmaOSO9Xn8Y+q
         FXqy6YwBGIm4ChbpoevriKDA3SzX32Fuv0RS/uICLaMaXTyW7sN+WdXdlL8Ym6nc41Lj
         ShqxwFubZN4WUilfLDhOlbQZ+kvMmGhoxtF1E3UXAcQhpVG9pTK4QzircAyB6cDHCP21
         M25MSao1Hbl4yde/+1pue+vUYMTaooEsakMaTG0i5ClLMD1Rr5xmdt9UGLQ5R6sJabwm
         h25A==
X-Gm-Message-State: AOAM533g/GlHRXrPqAjgl9hhSNaLHaaE3a4epXBw5o85OvuaeBQ7onXm
        CWANN8wLCBaV/JdQ+fj1W6eWNsVlLNQhpDjK
X-Google-Smtp-Source: ABdhPJx8PrqseWByy8cXnG03ZSmZ+z3kkRLbcwSOEeF8TOqLqzh+jbH25XHmRJy5C0uP6uSCI4Ocrg==
X-Received: by 2002:a65:5948:: with SMTP id g8mr2826865pgu.51.1630582669502;
        Thu, 02 Sep 2021 04:37:49 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.145])
        by smtp.gmail.com with ESMTPSA id a10sm2053554pfo.75.2021.09.02.04.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 04:37:48 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v5 06/14] t5702: replace with "test_when_finished" for cleanup
Date:   Thu,  2 Sep 2021 19:37:40 +0800
Message-Id: <20210902113740.76680-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.456.g1a7c4c5894.dirty
In-Reply-To: <87zgt5axjv.fsf@evledraar.gmail.com>
References: <87zgt5axjv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Thanks, much needed cleanup. I have an unsubmitted patch to do pretty
> much this, plus some: https://github.com/avar/git/commit/27b3543c6ed
>
> You might find the difference between the two interesting..

Cool.

I had took a look at the commit. In comparision, I ignored some places that need
to cleanup, I don't know if I got your meaning?

If so, how to deal with this situation better, continue my work or rebase your commit
to the current patchset?

>> -test_done
>> +test_done
>> \ No newline at end of file
>
> More newline churn.

Will be fixed in the next patch.

Thank you.
