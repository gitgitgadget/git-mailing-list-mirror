Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63AC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE60F61176
	for <git@archiver.kernel.org>; Thu, 27 May 2021 17:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhE0RKO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 13:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbhE0RKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 13:10:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F060C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:08:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j20-20020a170902f254b02900f8d1e07b12so288797plc.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=DE+WZgiaDI00SIXwf8wG5P/JzItXM9fnTk12gi0A0w4=;
        b=DB360GT8espmqsI7jzbalMrIXBwalgS33Ufiifmpwz1jE86ZXAhdY8CRWkqtKcPe5G
         bp/49tFI6/2i5LCV6lh8hNjsBA1nPR0onLxQtksskev+g5wiGYM2PgvyuguL/gn57M7e
         SWzMy7IbNGUlv7xKUTr/wtq0E5qVVIfR/lIPc1k4rY/tehbUs48pm8KEuqX4xa9ahd9e
         gxnxNvY3r0QSikuWt/qJmVD6JZ7nbVvTxMYmpHMLNAueqm8GTq9hnSMlO8dfArjz4oAF
         +E/IhALWJzxct+Q1dbhCTc5nE+qCltLAd/PJP/q1qdoY2bXE8gzrsB1jdu7Rqr8ptvTu
         ir+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=DE+WZgiaDI00SIXwf8wG5P/JzItXM9fnTk12gi0A0w4=;
        b=uj7hmDRRsSZF+Oqvuybykdr6iEE3Qj36hATINGt5lyvLZx0Do9BW72zoCQdBbQyzEP
         6G4roD53aQB6ZPHmmlDMi2yXVxXdCoDdas91uiAGWh41aZi6RQVljSWyxZO/fOcTgWIU
         40rLTgYiqOU6Twd/hTpkRtSZZ6JSEOntItogvyV4dlkY/ydcfn+Bt7p5X6uNZTJRuK8A
         5C0QlwfBN0ElGuyeFz//CwiDQTW2tI3/hge48sS8i+CPHC0EQIf/+g80T7ASaKAzUGmQ
         nHl+5nfJRcGQKsoVOAgsQvMbIjQvPNqZXLvs3lWWq7LONCGQ0uR+mmR4IU+uJG9APZY/
         ImVA==
X-Gm-Message-State: AOAM530pooi3iC/ZQ6Yfaq/HwDUqRqkpFMGT2lqtwBoxgxmwcRF+DHSz
        Jv8gONqMH+jq+HeCe9quvO84rgGZD0sVvdYwHK9N
X-Google-Smtp-Source: ABdhPJz90UReoil7ohb7D7rH3LNy1m1nBC8wtNsKGAcobzGvrAGqPb3Zpqto9Y96272OPC2VrUkn7bxCCmNjellPBNII
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:bc85:b029:fa:39b3:770b with
 SMTP id bb5-20020a170902bc85b02900fa39b3770bmr4096848plb.59.1622135316538;
 Thu, 27 May 2021 10:08:36 -0700 (PDT)
Date:   Thu, 27 May 2021 10:08:32 -0700
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527170832.2669483-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 00/17] fsck: better "invalid object" error reporting
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So in some senes this matters to nobody, but I'm doing this as part of
> general changes I've been pushing to make fsck/gc error reporting more
> graceful, and errors more recoverable. We now have a few more places
> in object-file.c where we don't just die(), but properly return
> API-like return codes/data to the caller instead.

Well, I guess it's useful if somehow your repository got corrupted, and
you want to pinpoint where it occurred.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (17):
>   fsck tests: refactor one test to use a sub-repo
>   fsck tests: add test for fsck-ing an unknown type
>   cat-file tests: test for missing object with -t and -s
>   cat-file tests: test that --allow-unknown-type isn't on by default
>   rev-list tests: test for behavior with invalid object types
>   cat-file tests: add corrupt loose object test
>   cat-file tests: test for current --allow-unknown-type behavior
>   cache.h: move object functions to object-store.h
>   object-file.c: make parse_loose_header_extended() public
>   object-file.c: add missing braces to loose_object_info()
>   object-file.c: stop dying in parse_loose_header()
>   object-file.c: return -2 on "header too long" in unpack_loose_header()
>   object-file.c: return -1, not "status" from unpack_loose_header()
>   fsck: don't hard die on invalid object types
>   object-store.h: move read_loose_object() below 'struct object_info'
>   fsck: report invalid types recorded in objects
>   fsck: report invalid object type-path combinations

My main comment as a reviewer is I think that there are a lot of
unrelated changes in this patch set - in particular, the first 7 tests
(1 fsck test that refactors something unrelated, 1 fsck test that I
presume will be overridden later, and 5 tests for other commands
unrelated to fsck). I'll also give comments on individual patches.
