Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0CC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343CF221E5
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 20:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftv4K5rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgIKUZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgIKUZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 16:25:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A8C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 13:25:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id p65so8948072qtd.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QoMGwPRcCV9AUBf8YWkhiXnbV9iLJxlUpRqDC3OWjJ0=;
        b=ftv4K5rn9eb0NgteiYc38o6LlpJAxaxWRN96cU8IedIzOUGflrfW0KphkGPDgzk+Jo
         9OD24bsQjhaP4sfKVuQjJSeKB3j0fBkDBfPEjPSU3hmUR1yoKW91GtDcsEhfq7i5GML0
         EgaxBANNSjn1gFO935j7ZjR2dWyI/U3ur7A/zNXFHY+lC7YF5+lmzboyvukbIKB5QfpG
         tJYHPrTBo6QM3hux2CMZU2suGHMhyz5TbyCXSsBz82aJpRDT34hMqmYsfC/WOvc9Tvov
         V+MjVgu36RAxU0QKtC7hitZVCZH31Qhr+9+EiaDEUXoZhiIXz++LB/yQulp0xOhVUE80
         wi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QoMGwPRcCV9AUBf8YWkhiXnbV9iLJxlUpRqDC3OWjJ0=;
        b=YHy9WnbNVgvs5OGlOhah6krVPpVwGMYIMtvg6JTZfnzcK8zRnSUjmT9XfG907QEiFt
         6qQDhurtEwDXd01XshTDpRlJRZn4UaxRf/Mz79CU5NFLgmpdHKYXPjzdEgGYqyx10Hki
         YyZkz/e1IpMP5bp//AL7bEOssvqipYOZVZgAH5HwaHQQnmEeQJoTQONYRkj820gTiTli
         AuMpVmHl7WDYXPq0YICSeT1PQlmZB8LItBaVsrl1ukA81dVpRqxbbokMIT3LQNdVMHSE
         jgPUXfiND/9ExuL5fpn946Pl1zRUb5h7EvtXZ9FKzV8EseX7+FYUgui8mhe1lLc4I5iL
         DjtQ==
X-Gm-Message-State: AOAM533L/zP+zT9xnpsEEOuNazXuZG/xpn1IaLFhB8/gxV1mFurR4Hq+
        ym4iRJ278ubpbYGLGApwx2E=
X-Google-Smtp-Source: ABdhPJyXxZ6lmVNcqJeHKhPYETim+l4S7EsL3Cx/qT4pWpdibABz9Jo5/7L88xAgzndbxnz2R/UP7A==
X-Received: by 2002:ac8:f37:: with SMTP id e52mr3675952qtk.280.1599855932083;
        Fri, 11 Sep 2020 13:25:32 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id 76sm4089214qkl.127.2020.09.11.13.25.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 11 Sep 2020 13:25:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: post-checkout hook aborts rebase
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
Date:   Fri, 11 Sep 2020 16:25:28 -0400
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, chris.torek@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <99BE0DDB-C248-4781-A715-2517A977372B@gmail.com>
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com> <xmqq7dtlt080.fsf@gitster.c.googlers.com> <xmqq3649szs8.fsf@gitster.c.googlers.com> <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com> <dc9b58c4-96f1-2270-406b-781f8d0a4f22@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

> Le 9 sept. 2020 =C3=A0 05:43, Phillip Wood <phillip.wood123@gmail.com> =
a =C3=A9crit :
>=20
> Hi Tom
>=20
> On 27/08/2020 01:44, Tom Rutherford wrote:
>> Thank you for the response Junio.
>>=20
>> For what it's worth, my hook does not make changes to the repo. It's
>> running a command to check that the installed version of our
>> dependencies match the version specified in the commit being checked
>> out, and merely warns if the two don't match (then exits with a
>> nonzero return code).
>>=20
>> For this reason it's been convenient that the hook runs during
>> rebases, but I find it surprising that the nonzero return code would
>> impact the rebase.
>=20
> If the checkout succeeds that rebase does not print any of checkout's
> output so unfortunately you wouldn't see the message from your hook.

According to git-rebase's doc [1], that's true only for the new "merge" =
backend,
though, (which would be in use here in 2.28 unless 'rebase.backend' is =
set to 'apply').

On a slightly related note, I noticed that that part of the =
documentation is not 100% exact. I states:
"Further, both backends only call the post-checkout hook with the =
starting point commit of the rebase,=20
not the intermediate commits nor the final commit."

but I noticed that in an interactive rebase, the post-checkout hook *is* =
called for commits
marked as "edit", when the rebase stops to edit them (I haven't checked =
if it's called when the rebase stops
for other reasons, like conflicts.)

Maybe we should tweak the wording of the doc  ?

Cheers,

Philippe.

[1] https://git-scm.com/docs/git-rebase#_hooks=
