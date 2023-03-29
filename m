Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F42C74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 18:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC2SxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjC2SxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 14:53:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5E5FFA
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:53:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso19592974pjb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115992;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVDUS7uD7xpwmjIAJvmY3ViEB1rjYCUdj0Zp1FqJcoo=;
        b=Lo1Zemq9Vlvj2kfvl90vlgewjatAgN34xk+YzAKdvvXNrLm9yEitAvDrGAv7JdAziW
         ZSOeuN8AaDhe15OOP9nbdq6iNgruRDl/4oz8yZxPomF2C1hrO6j4Vn90nwdlqXRVS4Hy
         eB16lj0ehNAd4rflZ+KQnYgxeqX+P4dro561CdPBXcO2FMJJ4fmc12D0u9W+H438VNXr
         bfyBZ5ImWHaCbSOAeRObBOGPsExjiO4ijIZ5nfiyYo2hPvdGsBhiQPtcO9niZdz+Z/15
         qbY0nzK9QqSjnHRtyZtcXXHRmd6JRzGq6chUUm8WYxJ9lBkd25xfXmmW98jX2XZGQCNd
         qoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115992;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UVDUS7uD7xpwmjIAJvmY3ViEB1rjYCUdj0Zp1FqJcoo=;
        b=wy0VgHmWBijS0mtKtfDpkI7bVrd9MsxXQkBtCWsjkziA93UjTYK6eBY62R7YyPti3c
         k+8dg11cAb/wUfUmiC+i2eoPesXkv/64wmtjYEFR49ZudFyk+Zdn1STVmO65bDJaJFSm
         Vnc1u1nawlC8UvXjQ158Z4/Wc7y+BF8a2ilSHimfdl7MgAM3qE4Hm2TCLQZygf+n7BFC
         iYxA9vDtPlgRA0nuNnORZswR+L04uxmi9N+X3nlyrmDDyz5RK8u13F3aGWcoMBotCnDg
         l+CRqDi24Z63QGmrF3/WDLKPxesd3V0MAY5mK7Vdx8OhmTdCkYBgtoXX40M8ORLP3+Ph
         i1Bw==
X-Gm-Message-State: AAQBX9dzp/mr4HnsyM5HJdKQ62NN1luGI4gG7SMSI7Cbhf9NEp2fOwlF
        vkhU7c1XttJLGD5tAXEqP1E=
X-Google-Smtp-Source: AKy350a+LxKQBAi+WpLFa4pxZsJgqe1qNminxVhRHJMbuzVqrWZpGi9dYF4ccBPDn0+j3GD1D/ORfg==
X-Received: by 2002:a17:902:c949:b0:1a1:adb0:ed72 with SMTP id i9-20020a170902c94900b001a1adb0ed72mr24184292pla.4.1680115992271;
        Wed, 29 Mar 2023 11:53:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id s12-20020a632c0c000000b004fadb547d0csm21744611pgs.61.2023.03.29.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:53:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Stanislav M <stanislav.malishevskiy@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Stanislav Malishevskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
        <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
        <xmqqlejrmj4y.fsf@gitster.g>
        <20230321172223.GA3119834@coredump.intra.peff.net>
        <xmqqjzzahufj.fsf@gitster.g>
        <CAEpdKf=pMcMn6q0wGGcrFN1yi1duguSNLDkqhDmvMBeKQ--yuA@mail.gmail.com>
        <20230323180159.GA1015351@coredump.intra.peff.net>
        <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
Date:   Wed, 29 Mar 2023 11:53:11 -0700
In-Reply-To: <CAEpdKfm0S4tkLz8DMnkJmhMmJk8Cj1tUm7NbMe7kpATq0bkxCw@mail.gmail.com>
        (Stanislav M.'s message of "Thu, 23 Mar 2023 21:16:50 +0300")
Message-ID: <xmqqfs9n9yp4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stanislav M <stanislav.malishevskiy@gmail.com> writes:

[administrivia: do not top-post]

>> Yes, but I'm not sure if there is a way for Git to trigger curl to look
>> at the certificate that does not involve feeding it an https URL (and we
>> want a valid one, because we want to see that it correctly speaks to the
>> server).
> ...
> In my opinion they need the same set of tests which is used as usual
> for https. But use the right certificate and key.
> But I don't have any idea how to do that with hardware usb eToken in my case.

OK, so where does this put us, with respect to the change?  We have
some behaviour change that we do not know how to test?  How would we
know when we break it in the future?  It is not like the new feature
is not useful enough that nobody would care if it gets broken by
accident or anything like that, so...?

At least perhaps we can throw bogus strings in the environment and
make sure cURL library gives complaints, or something?

Thanks.
