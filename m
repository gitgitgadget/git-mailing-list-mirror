Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04624C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF4F206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1FPrBNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgJBGlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBGlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:41:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E8C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:41:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 139so706653ybe.15
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZiD3U6j0BpogeE5ke25+1nwea2JrFI61Sz5Qnar+yMs=;
        b=D1FPrBNbec5vDo8Cv2tznX9+nGJLLSfGC9j1/P5vxvSKmI9jvUxhL0fs58ehz1vIqg
         IDINt1bnDqCH701CzdHY8gqlwXJlFtIzPnF1fCgJXaGTPFkmONyBvt3kPxSczljDERs3
         Tvf5HwCPlugmZUSt3gqdZ+UmlXNikmgZlrYSzxPj6iGGd2WMMfJspxEN7eesSVwkeumE
         nuAkCcjHBxVPEniFBOdpaqWIHcKLFA2O/JifBiLAp9Lig12QzPMu5JB+i0q6eLa5vy4l
         NZA0ZLGzVZTIodAXeaVifd2zXEyxH5igSHYDy69zavdiEgqWk5iphDBc/aA+HVdBr2Em
         sIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZiD3U6j0BpogeE5ke25+1nwea2JrFI61Sz5Qnar+yMs=;
        b=tWWym3vHO+d61ueFOzZvgbAtvhpS6xjb7vvUtEp8c0RcknD9iFBV3UEFnRLqADSs7P
         VA6u/OJI/mr2hizUW/fmBw99vAcwoMSSNggD8SgNCoGy4SP0sqTSa4unqhUJkdqFql+t
         C1Y6AdGwJ+2z9Fs9yP2Ep37koN38UtxiAMv27sIJnmWRCZVk7AseNbq7kG11S7sr6Uap
         Ezmm5ZzkCQLJCJvIRUbyTdBAZqkcpzClPTQHnal17wC6+4zsoE96OPvxbbmBYQYvAtwG
         MWH13pu+Uf+b5O+/lvZC3EvH4IDoP5qygo97L3Afs8+ZYGG1OmZsGnU6f20N1uIu9g9/
         yIPQ==
X-Gm-Message-State: AOAM531mzC5tUBd4CcHFxPKzOjDDBrZib6D0gFjbJvHdMnhBOcwi0S10
        Xk9oaRMa/8vFODFxgQDLO5duCB+c8rWV
X-Google-Smtp-Source: ABdhPJwd54LNmEbYv9eY5F1946IYasbIbpT/5gDgM/uWt1hBXGYszCVZxp9n9ZCAhMgopEc/+f0JT1lGi3Nc
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:c790:: with SMTP id
 w138mr896231ybe.409.1601620866541; Thu, 01 Oct 2020 23:41:06 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:41:05 +0000
In-Reply-To: <xmqq362yeqbo.fsf@gitster.c.googlers.com>
Message-Id: <20201002064105.4089915-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqq362yeqbo.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> 	test_config user.hideTimeZone true &&
>> 	(
>> 		export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
>> 		git commit ... &&
>> 		git show -s --format='%aI' >output &&
>> 		echo 2020-09-13T15:26:40+03:00 >expect &&
>
> Oops.  The sample date and zone must be adjusted for the values
> exported above.  I expect that we'd need to do
> 
> 		...
> 		echo 2020-09-13T12:26:40+00:00 >expect &&
> 		test_cmp expect output

Tested the following:

test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true' '
        test_config user.hideTimezone true &&
        (
                echo test2 >file &&
                git add file &&
                export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
                git commit -m "test2" &&
                git show -s --format='%aI' >output &&
                echo 2020-09-13T12:26:40+00:00 >expect &&
                test_cmp output expect
        )
'

