Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6817E77370
	for <git@archiver.kernel.org>; Sat, 30 Sep 2023 11:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjI3Lcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Sep 2023 07:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3Lcb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2023 07:32:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46FCA
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 04:32:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso19825456a12.1
        for <git@vger.kernel.org>; Sat, 30 Sep 2023 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696073546; x=1696678346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsdgyKLAel+thAmL674VElnwDSYQHbpH2z3f8vwxc00=;
        b=BI5mtjUc80XqBLbc0A5SuWyTLpGPdwee9QlA4BgXfw4lO4Dh8Rd4kSS4T0EzyMJOdF
         x4DlCoJakc4HCUiDvSOKIzkykVM7UeMr76WEkZzuATnXInet18ZstpjDeNxPGtQHWLgh
         8qPh2DriuHy/9qG+J1AUjQPmgT8U77qfhc6PwBaBjdioBljt/4lp1BufTdPsjCAtZZ0r
         z0mADcgtugcP1wXPZu4I1Gry3xncrDcCyNYNPbA66rzgjd9jxuy4xjYC1vOkGi1+yCZ9
         u6LqmpOOUNJ3dGZsZDdSKVf9awWZKrIB26D9RHN8DwzB0NxLsassVYoiT9FwaLJCw/T6
         yGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696073546; x=1696678346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsdgyKLAel+thAmL674VElnwDSYQHbpH2z3f8vwxc00=;
        b=JmbBYaAzpPZFUAJ3vM7Fsig7YGANjKv7rbyKHTSi4etxGbZXY00L8pmA3woQ34vL9f
         z/9T7skbrhAYkkRCtmZQd8fdypw2VWg93OBzOrkE5nE3iEK56j+8MLr20buM8ojl6fJF
         +zMmfJTDLEKmiqMcRfy2eRBQ2OLIkio1Bsp3xq2gy0K22YdkQ19OMgnQ+cyb9a+S/H8M
         KwBMRpAPzkmOHBCSXfT+ga6xODCvJqUxvfEt3hwAHTcSt/qv+vOYayVyoyBttYJmv6cl
         yEF5i9nYNll8sjoG4WK2bGRIvY3PnLujoV/BUwN94b4wY248rtR3N6Mxc5drCQxZx4n4
         UlBA==
X-Gm-Message-State: AOJu0YxIKVnpk8Kpeq6QM2BYpx3dOn8MX48CROKGK9upFLDYICYziIDu
        tTm9cRbdd0w/mtcAfKpKp4iyQSAghyPJXyvBt/M=
X-Google-Smtp-Source: AGHT+IERvNH0YnRIHYTJWVZduZpHiLtip4pkhTakYIvxjml5mBXQuUpxviivpgvPBkpv7/D33ZbNc4PCL1pxfeiwIA0=
X-Received: by 2002:aa7:cd63:0:b0:533:780f:f016 with SMTP id
 ca3-20020aa7cd63000000b00533780ff016mr5525606edb.14.1696073546024; Sat, 30
 Sep 2023 04:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAAcHogVu+jrLdtEZi+Jx9d9gM5BvUF_nRVKEc4BsWCxCanL9Uw@mail.gmail.com>
 <CAPx1GvcjvctrQ-w1MekBs7S+R_7=KhCLUQ915-JAnxEq=BE3iQ@mail.gmail.com>
In-Reply-To: <CAPx1GvcjvctrQ-w1MekBs7S+R_7=KhCLUQ915-JAnxEq=BE3iQ@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 30 Sep 2023 04:32:14 -0700
Message-ID: <CAPx1GvdNbHFZdDtWh-s6dN52oxV6L2Ww7CV+SAefenkekiOy+A@mail.gmail.com>
Subject: Re: bug - Inconsistency of git status and branch, ./git/branches and ./git/HEAD
To:     Irina Gulina <igulina@redhat.com>
Cc:     git@vger.kernel.org, Tomas Tomecek <ttomecek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should note a slight correction here:

On Sat, Sep 30, 2023 at 4:28=E2=80=AFAM Chris Torek <chris.torek@gmail.com>=
 wrote:
> A new, empty repository cannot have any branches, because a branch
> is defined as "the latest commit that is on the branch" (this definition =
is
> unsatisfyingly circular, but that too is what it is).

This is just one of multiple definitions of "branch" in Git. A branch is al=
so
a *set* of commits, and/or a *name*. The fact that the word "branch" has
so many meanings in Git makes it almost meaningless: it's like being at
a party where everyone is named Chris. Yet somehow we humans still
manage to extract meaning from a sentence like "Hey Chris, Chris said
to tell you that Chris can't get Chris's car started, so Chris and Chris
won't be here."

Chris
