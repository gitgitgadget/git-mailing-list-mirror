Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D8C433E0
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 02:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D4020739
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 02:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="gmRiq4MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgGFCgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbgGFCgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Jul 2020 22:36:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DF9C061794
        for <git@vger.kernel.org>; Sun,  5 Jul 2020 19:36:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so6821895pjb.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2020 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6CSe9ouijpg5vz5e9E0d+awrsydHK2Fmk8PlpDSc1XQ=;
        b=gmRiq4MNOy+UnmRwF4tqxpjyE+1AjqAcKl11bcSowgEcX0ba3ydnZ7zLuxs1tz9ZhD
         Pn2ZjZ40/p4YpI7jbS8197QRUGHUNHnwOWE2i6Yyyn0udqUyInXio/eujcIPz/tIC1XG
         T8t+RvwSS0HZcD/VzZupbOI/XdRVv9R1zFUqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=6CSe9ouijpg5vz5e9E0d+awrsydHK2Fmk8PlpDSc1XQ=;
        b=li4lsa+/v9jh4sDv/J3Lhr/40FnEr6pTtcvFFMOA8pnlg9bKhT6pMwHkcbGOTPEElN
         ZKEWEib3MsZBi3eCpZEp7L5/I3TDOubbOdvLFCz+qd72ewgcLxz8Ps2SInixOEtFVGZX
         j/0nzc71leqJQJBDeOJiwxyy5YRAWocN+1IngdSG3OLJceBxbsXgRYXitJrr1MnW8ryf
         927gKl7QlOqTZ9mWtLJsOQK0S9XtguM0DqoTghj4j61T2U25dSRDLsz7Kr85RI146tWg
         N5ktoX9coaemokg8WGA/IConq8CfY6K0WRYdCf/GKmpEZym83Qm6AvOVkQjXj2VfTiED
         Vqsw==
X-Gm-Message-State: AOAM531zEtvxGnvfuyHqazlJQDdUskV8ZD9b8eyknCJBmuybMOJW+nHQ
        to0WxWyAOC3NahP8SeOzRO9v1Nmxeq4=
X-Google-Smtp-Source: ABdhPJyVxlGnS7F172Eu7T8O7L7jwKTMK92NGerTXTWAv8/uT+xpi38KmAR/Lj8E0lk9qbLHO3LFng==
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr23874035pjb.91.1594002968723;
        Sun, 05 Jul 2020 19:36:08 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id d18sm16682264pjz.11.2020.07.05.19.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2020 19:36:08 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>
References: <pull.781.v6.git.git.1593650687697.gitgitgadget@gmail.com>  <pull.781.v7.git.git.1593746805771.gitgitgadget@gmail.com> <xmqqo8oxb3rv.fsf@gitster.c.googlers.com> <2920401d651a1$1ac3ea80$504bbf80$@zoom.us>
In-Reply-To: <2920401d651a1$1ac3ea80$504bbf80$@zoom.us>
Subject: RE: [PATCH v7] Support auto-merge for meld to follow the vim-diff behavior
Date:   Mon, 6 Jul 2020 10:36:04 +0800
Message-ID: <2c85c01d6533e$33d4cc30$9b7e6490$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHMDywQjtCwMdSCwpYqVrUTM1HyZgGcI5q0AZgY684Cck2C0KjhJ/KQ
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Doah,

>To follow your comments, the new [PATCH v8] is uploaded, try to reduce =
calling `git config --bool`.
>Please review again. Thank you.
>https://lore.kernel.org/git/pull.781.v8.git.git.1593825400699.gitgitgadg=
et@gmail.com/

Please review the [PATCH v9] instead, it will calling the `git config =
--bool ...` until last moment.
https://lore.kernel.org/git/pull.781.v9.git.git.1594002423685.gitgitgadge=
t@gmail.com/

B.R.
Lin


