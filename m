Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0CC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0D3206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByTQ8Dkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgJBGqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgJBGqF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:46:05 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3743C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:46:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b39so325745qta.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bFUcxXRDJ5GDmk/4QzfqLri4tdIklOiKeA0VHYIXedQ=;
        b=ByTQ8DkzW64Qi9fNJr51zbZbkk5b2gV/4wO3Bp/X3uEpEJqCZXFgTGu6GUX2rGxc7A
         nj4ZYtyYg2Clw2VuWfu1TYpPsY32iRtftZqxiP1G0spXJcXlK6FS0rmweq9bRq4dxxuu
         fc249E/8FnxKTICHnaiI7zxvRAjCnm2Xg3imW97o5U/8sRsXDxsr4xnykZWCP7r+/v8U
         8rjloTrNR+UOmOEE3gmmcN2F7XgnntoxG660v5jhfAS+ROlIIqXYa1GuHWvyhHb79Xq5
         tmXhnk26GVhGgxzoALWLBw2KSSfBKwfcWJqmFTxcLPgdFH6CMo2qXeGhxhnDJ/e0fZCE
         cDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFUcxXRDJ5GDmk/4QzfqLri4tdIklOiKeA0VHYIXedQ=;
        b=rcAOFl8FBK0+XdR06n5RKPoevFd70fPStrYsbEJoOv15ogPVxm5cM3mbomKV6QyIFj
         eW0DopNHYN5DyiiT9rfKyfWzHeNGsr8yfzRhb9AIvnmioaDf5EWQSywWnx2CllIj99G9
         lF/RYIHDjmpWkPzfsxbUP5s2iRkCSOKJjbw+Oz7O3Cp9aQVIcOGCOsGLvcSdAoq0WtA9
         CRqQog1ST5/0dwRAn0jowXzWKmDKrhYn68Q6v+lZ6CwMFZzpA3hqZUXm/PygaqtZ8Y9+
         cGkSg2zg/9tzC1hh2FWX69nof35sYAndfrlJlTANvFWPw0TiobKZvkyc75mNRxlqBdJY
         3Qeg==
X-Gm-Message-State: AOAM532mg00H97dpw+G4WM2koiGZiHL5q0iEJYxoXMtlm6BrSwovidtT
        USLtM1nU39M00n9buJEX6vECUEiy0V7u
X-Google-Smtp-Source: ABdhPJwWjhpW8E7Nsamd0WsG71+/I2HA+yTaVNm+o6RLCM69O/n78Y5l6u/bC1BrNC0vwGvDkMO2Mqf1yXoV
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:ad4:41c4:: with SMTP id
 a4mr734595qvq.60.1601621164932; Thu, 01 Oct 2020 23:46:04 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:46:03 +0000
In-Reply-To: <20201002064105.4089915-1-shengfa@google.com>
Message-Id: <20201002064603.4092711-1-shengfa@google.com>
Mime-Version: 1.0
References: <20201002064105.4089915-1-shengfa@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     shengfa@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, nathaniel@google.com,
        rsbecker@nexbridge.com, santiago@nyu.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

>>> 	test_config user.hideTimeZone true &&
>>> 	(
>>> 		export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
>>> 		git commit ... &&
>>> 		git show -s --format='%aI' >output &&
>>> 		echo 2020-09-13T15:26:40+03:00 >expect &&
>>
>> Oops.  The sample date and zone must be adjusted for the values
>> exported above.  I expect that we'd need to do
>> 
>> 		...
>> 		echo 2020-09-13T12:26:40+00:00 >expect &&
>> 		test_cmp expect output
>
> Tested the following:
> 
> test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true' '
>         test_config user.hideTimezone true &&
>         (
>                 echo test2 >file &&
>                 git add file &&
>                 export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
>                 git commit -m "test2" &&
>                 git show -s --format='%aI' >output &&
>                 echo 2020-09-13T12:26:40+00:00 >expect &&
>                 test_cmp output expect
>         )
> '

I assume the opening and closing parentheses means the environment variables are only effective
within like an environment scope. Please correct if wrong.
