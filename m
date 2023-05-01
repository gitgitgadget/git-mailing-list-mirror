Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77EDC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjEAPza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjEAPz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:55:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D177C12F
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:55:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaff9c93a5so4481255ad.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682956520; x=1685548520;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPFIrU87PgOb5TMTSnvxh3Vpi42NratKsl+gMSCJ5vI=;
        b=dO0VD7g8+rPg6qpC90hN9CM63FLA18LFhRKyOFmz6QBTlfiBlOEoxUPHLJNgDH7XTP
         cSqUwUSSm1+dbGQg8WSdiJLX45/PRZ3gikPu4WjU1mAcPqfsZhrcluTQRrMHMOksqWvB
         5ByaITt8e3q5eMwRNMvXfGj0YKG+6XZSG5dvfID9WmCc9vAADmIrGHUg+vC4kghgO7rt
         mv8ZWysY5uQhTTZofBus+0hEuWFp7RdYAzxKrBgLSoLfjgk8NYhO4qzSkRd8QJM7Uyfc
         a8EXVziicm5ZQAcV9jFAisPzOC7EBlzBAOCa6wqw8TRH+j1VLb5kl8BU6GdOYXV8xrxg
         5V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956520; x=1685548520;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPFIrU87PgOb5TMTSnvxh3Vpi42NratKsl+gMSCJ5vI=;
        b=dVU75C2mTT0vStqtZgf/aMwY1oeWeGB4x8aPKRWbxT7NbakTrdGhsd8KjU0mCkDZbH
         r+bsTg4nVEsoxDMhHV3ckM50ZK5sYsixJE2PCCX729diPj3LLSSkutqGFZ6CmtSnBW0H
         fyhU5zbGVXHCSz0hJYjl7lV0LaLbHM5zCppfFYViyR7okDxMvpHW1yPErLtOFz2UmQsJ
         K/fEFLz610gNgkoEbd7jtVbaX32KE45zcY8Wd3CK5UHbED3OOcBkaIIqjSSwz1NAuu0X
         ffsKxo/cs0e81AX2jbZQwhESrmdV4TuBqjn9PTWFmGtaESG0V35v7wUAgM+eQUsKs1Mb
         Nxqw==
X-Gm-Message-State: AC+VfDwfuokTAVjdkAdWJJOtGc/h0z5k4JhXu58rRFcXAAAi6AfQK9o4
        WFZMSWxZDAIeWr34h+UrCJ9LN2tMeso=
X-Google-Smtp-Source: ACHHUZ7tRb+pbsvlDrGvYCq/gy43Nved9YmLk/9qufG3h9RSydeESWNdbW0jtb/x/nmskzO+oP83IA==
X-Received: by 2002:a17:902:ec8d:b0:1a6:566b:dd73 with SMTP id x13-20020a170902ec8d00b001a6566bdd73mr17987673plg.60.1682956520104;
        Mon, 01 May 2023 08:55:20 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001aaf13db1acsm2584078plh.276.2023.05.01.08.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:55:19 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] cocci: remove 'unused.cocci'
References: <kl6lzg731xib.fsf@chooglen-macbookpro.roam.corp.google.com>
        <20230420205350.600760-1-szeder.dev@gmail.com>
        <230501.864jowjh15.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 May 2023 08:55:19 -0700
In-Reply-To: <230501.864jowjh15.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 May 2023 15:27:54 +0200")
Message-ID: <xmqqlei86o7s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It wasn't something I intended at the time, but arguably the main use of
> this rule since it was added was that it served as a canary for the tree
> becoming completely broken with coccinelle, due to adding C syntax it
> didn't understand:
> https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com/

If it weren't Coccinelle, we could have used the much nicer looking
UNUSED(var) notation, and the compilers were all fine.

Only because Coccinelle did not understand the "cute" syntax trick,
we couldn't.  Yes, it caught us when we used a syntax it couldn't
understand, but is that a good thing in the first place?

