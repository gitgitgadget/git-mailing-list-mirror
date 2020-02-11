Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41673C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108FF206DB
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk2NFjEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgBKPDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:03:15 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40555 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgBKPDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:03:14 -0500
Received: by mail-qt1-f182.google.com with SMTP id v25so8135767qto.7
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mXqt5XeZGeanfteFZqffcLr7umqUowaZQawAeXNued8=;
        b=Yk2NFjEoYMB8ZVHLVfY0C5ZtltzdiRa2xZlxIVawzCagioOsrBdxz7A/mvuBlD0cCM
         Ut80TB77UU3gglN/Rr0kSzLtRWAY32j2aCrCyh6LaRz91yNU53YMnCKAip00iMHquG6W
         Az54nVpZNWTifUizoHuYzmtyXyI0O7Iy1tGtIbXRFvi+N/PifVLsvaAJI2jp8JeLOcHC
         TSQgV9oYowe2eCml7kos98PhJjDt7fEKVnfLnlQIGd1lAgNR2eru+y5/LgPmflbsNyMI
         TdF0VeylLz54OwtCCCCnBHuBjXZZQ38wsSfHGuPe2++0oiAGCIT8i9r0LFbE+Xw/P9lb
         Wf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mXqt5XeZGeanfteFZqffcLr7umqUowaZQawAeXNued8=;
        b=f1NO44QJHQZ5jUy5oBO/BAHLwlzUv/fbuhvhXmdH+zMJZTokjJyZAtYO9k/5EurKF5
         kbxv04iQs4cMxOsyvf1M+uJnnAQjOANUJs2KskAGi+fR6Ao7zV9f+LS0GruMlPU1VBqK
         2E4of3eeVCXMtmj9CrE/G6Fk0s7wfORxCVHG0LeCMYPrJ1A6PA7x5Ee4Fj8WJlev7u6k
         hLyoxapBlkTfJ8lpi+wjRC1rj6n1CLgyrkBQJMgiSBuAp+rs5PvtkWurWjU5XuPDlJcd
         YeYtA2vW+Rt5JlYocjMLEoNTBBgGqkwqhBQFJGCvT4/VPgqvN9s+s6qCfEzgtIcorKu0
         Zvtg==
X-Gm-Message-State: APjAAAVJLlqpQ+Cr4ilWa2t+g2Yyppb9b8jeP+1NFnJy8vTU3eU82MHo
        mN1v89yy3cqHv7P6GOvZnJMXJhHX0Ls=
X-Google-Smtp-Source: APXvYqyKEPju4/sn8aIgHGaxjdqRl8atq9QRx9Mnn9KZIn1mGlMPyPXhtHlNw1g0T5tG/QNTQo9wOw==
X-Received: by 2002:ac8:4e3c:: with SMTP id d28mr2852978qtw.190.1581433392835;
        Tue, 11 Feb 2020 07:03:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:ed2f:d451:8ae6:b41a? ([2001:4898:a800:1012:9e63:d451:8ae6:b41a])
        by smtp.gmail.com with ESMTPSA id z11sm2143488qkj.91.2020.02.11.07.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 07:03:12 -0800 (PST)
Subject: ds/ (was Re: What's cooking in git.git (Feb 2020, #02; Mon, 10))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a780fe83-c82c-c8fa-3f8d-5db9a7886875@gmail.com>
Date:   Tue, 11 Feb 2020 10:03:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/2020 5:31 PM, Junio C Hamano wrote:
> * ds/fsmonitor-testing (2019-12-09) 8 commits
>  - test-lib: clear watchman watches at test completion
>  - t7519: disable external GIT_TEST_FSMONITOR variable
>  - t7063: disable fsmonitor with status cache
>  - tests: disable fsmonitor in submodule tests
>  - t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
>  - t1301-shared-repo.sh: disable FSMONITOR
>  - fsmonitor: do not output to stderr for tests
>  - fsmonitor: disable in a bare repo
> 
>  Updates around testing fsmoitor integration.
>  cf. <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>

Feel free to eject this one for now. I was attempting to get us closer
to running the full test suite with fsmonitor enabled, but I haven't
been able to update it further towards that goal. I may pick this up
again if I have time.

Thanks,
-Stolee


