Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AEEC2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083622071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 23:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOkHTjQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgAXXAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:00:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34799 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAXXAn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 18:00:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id d10so3786930qke.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOORBCMAiKeikiqgr4fKlQxzDU2xL0k/usmrZ5dth8A=;
        b=hOkHTjQcR5y3SUV1t5ZQH+VeOiPEhDbf5cBt7biG9ZwFwEEqkJ1DqXY4xZEfwuDKdk
         ij1XVvNdOxJJYfav135dnNixkF9tC+5hr6kNgz0/5OoowCwF+xUYvk4vo+nHRN/nvCbb
         XBnOIjliRWQq+ijBgxL75Ivi6PwtC0e1EpoNbD7UuDbMisyIY/wLsaJ8Jqz4Sdm6to9z
         GyHub64BpweXdzQ6FdnaBUrp3p5uq6l8/n+bUOpOu4MC/MedlduDf5AvAp1yYnGJF7B4
         GbUXRmBeOgT5S6p6K0DWhOm07d85ftUvOM9QFuxjS5EFtWQXmKX+V9MJeqf9jrfd7udj
         JyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dOORBCMAiKeikiqgr4fKlQxzDU2xL0k/usmrZ5dth8A=;
        b=OYoR9aJlCTVPTES6nAb7DHoln1k2SMOdLyyTksGJpmqosJEjmly7pef7he6k70FdEZ
         bjbpRkPkQKfw+Awb4FAtyS8ms3vOqC1CAUfESzv4G9jaF8HHw9FOp5wuOQfkUReXv+lb
         hNuIgnY1hlVPC7AbGVl9qimbVyJJaE4LURyXW0N0BgBB4j07SbFosFZNVobgsuRcnOjS
         vHKeL4LJ6VsTxK2Ir00ikWFLRfr3hfQdp6LmdhDVgUBFLX7zy55IN+oLCFAzMC/102Vj
         aTaXU96lV1fs4qjMzE3EUd7GwMdMqIJ411f2SSPRO8404mXjEtBY1wU8ZFVnbflQUzwx
         dWmQ==
X-Gm-Message-State: APjAAAVYsntColzvrzLTf8DCke3Xqa/5nayAfAgSp48xhcjlIfWLS5Ou
        oJMGmc5UjleRR/LgS5DqRRPfrhxh
X-Google-Smtp-Source: APXvYqwxdlLwfCuZDSBGDtAdKCZ9uocjr59X1VmIXGqPg3GYY0DhcGRAIsd//GVBHHf/BvqjmY0iSg==
X-Received: by 2002:a37:4891:: with SMTP id v139mr5031092qka.172.1579906842604;
        Fri, 24 Jan 2020 15:00:42 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m54sm4559230qtf.67.2020.01.24.15.00.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jan 2020 15:00:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <69FFF66E-9273-488F-A747-2B4EBBDD7A7B@gmail.com>
Date:   Fri, 24 Jan 2020 18:00:39 -0500
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37804466-7DC9-4161-9B98-D2175233831D@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <pull.523.v2.git.1579618877.gitgitgadget@gmail.com> <xmqqwo9j5ei3.fsf@gitster-ct.c.googlers.com> <69FFF66E-9273-488F-A747-2B4EBBDD7A7B@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 22 janv. 2020 =C3=A0 17:25, Philippe Blain =
<levraiphilippeblain@gmail.com> a =C3=A9crit :
>=20
> Hi Junio,=20
>=20
>> Le 22 janv. 2020 =C3=A0 17:10, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>>=20
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>>> Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams=20
>>> bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan=20
>>> jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller=20
>>> stefanbeller@gmail.com [stefanbeller@gmail.com] Nguy=E1=BB=85n Th=C3=A1=
i Ng=E1=BB=8Dc Duy=20
>>> pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine =
sunshine@sunshineco.com
>>> [sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com =
[stolee@gmail.com]
>>=20
>> This is somewhat unreadable wall of names X-< Is it a funny
>> rendering of what is originally in some mark-up format (perhaps
>> HTML???)
>=20
> Yes, Gitgitgadget unfortunately failed to convert this wall of text =
into a proper CC: list because there was no space between the "Cc:" and =
"Max".=20
> I=E2=80=99ll try to submit a PR for that in GGG.=20
For the record, https://github.com/gitgitgadget/gitgitgadget/pull/198 =
has been merged so this should not happen again.

