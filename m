Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFCC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 02:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEPC5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 22:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEPC5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 22:57:17 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73E040D3
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:57:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f387d97dddso941498e87.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 19:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684205834; x=1686797834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwX1u6EdfN0DVIAHueP/U9nbtslGGAXbeB3Fi8xTTDQ=;
        b=P58qRGecZUy7V02HE3J3vuDV8CwtNlv6hDzH30Mu6TPIx8HWoEGzMNyQ5ZBpqkszQc
         k34KhybnSJjJvf5l9x6BLb6cu88zal2NpK6/UyVLHPOD9RRE6echoLxL2VL69KjtrpH3
         wyQFSNB0OmgCF9anJAI+r31Ee1D4gNECUTsknuP7vXZlftra8YY0R4EvuRNduz/CIfRM
         1AledmI5XyfA3NrE3wc2g35T1jLufhsaEQpp37rDtb2n1DhOs47VsxewpV3ry9mtjjuc
         mJixOYVV0zNubKnizmH+ZeL+Cx7X6ZIdMpwt980H2F8Uus1fI1wbZE6+0k8Lp/1YqKa2
         NltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684205834; x=1686797834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwX1u6EdfN0DVIAHueP/U9nbtslGGAXbeB3Fi8xTTDQ=;
        b=jae82zC5AL9dDv6B/msB2df2+DYbummtR8eWofIL+md9mtizGE6Fizr/ykVPwkgAgf
         eXj894DLZxZh6lshkhvgLS8H4V6i6klR1IPG8G1ZXmYvf1IzcuXis9Iyo4JmAUrLxwZl
         bYP1xg1cebLSxKOTd18PZyVkmaBPRCka34Ek6b1q8hR3Q+0tM4CogB0e9VmfvNxAC7Hn
         VW7tVpjHZLCUpVPqtaTXhR2cCcyhpr3llaVmUmpkm0re3dQHLy12YO93fmEs2IPDgOqj
         pLARfGVm0t3vDpAfSOHRmi4nnOPS6ZbP8dyUa0wo0XHYY+JV/ryrYTqWAaasL1Ka5UGe
         ou/A==
X-Gm-Message-State: AC+VfDysrfI0eQTILXsRjwYNyZCJS/YTwDKlHj9WUOIRCVglf2un6ho4
        O6cK2i+EI8u7gZs+tOMvAf6b+/SHboI9tExwcQk=
X-Google-Smtp-Source: ACHHUZ5pDmjrZvtHuZNwJ+mE0yEIqcQcPDlm0kgTFBbIMp6M9ib2rTr7esCySY5SulkgaW20g5vaRNMzzT72pGlnsFQ=
X-Received: by 2002:ac2:4d02:0:b0:4f3:8269:7228 with SMTP id
 r2-20020ac24d02000000b004f382697228mr1436123lfi.68.1684205833725; Mon, 15 May
 2023 19:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <3bc4dfeea901d9e57cee41666f85c783026d7e82.1683875070.git.gitgitgadget@gmail.com>
 <20230512212822.1126697-1-jonathantanmy@google.com>
In-Reply-To: <20230512212822.1126697-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 May 2023 19:57:01 -0700
Message-ID: <CABPp-BHMDbO8EEQ3L6tok+qZaCSEurUwmOK+G+4Q+p1LYRQsQw@mail.gmail.com>
Subject: Re: [PATCH v2 03/27] init-db, clone: change unnecessary global into
 passed parameter
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2023 at 2:28=E2=80=AFPM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Much like the former commit, this commit was prompted by a desire to
>
> Could we have s/former/parent? I'm not used to "former" with this
> meaning (but if it's understood by others, then that's fine).

Sure, I'll make the switch.

> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 15f9912b4ca..cc34c194f5e 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -930,6 +930,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
> >       int submodule_progress;
> >       int filter_submodules =3D 0;
> >       int hash_algo;
> > +     const int do_not_override_repo_unix_permissions =3D -1;
>
> I don't really like this name, but init_db() is undocumented so an
> anonymous -1 at the call site is not much better. For the purposes of
> this patch set (getting rid of cache.h), this should be fine for now.
