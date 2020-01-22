Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8BC32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B8824673
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuK2Hnxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAVWZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:25:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39157 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAVWZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 17:25:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so935378qtm.6
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t8aZeckWp1rlKkzCvNmniAClQ2coG42tzhovGEUasAM=;
        b=DuK2Hnxp6XxvIZLeT9Ef7G7LFyjiQjC4iBwoZRQWRqLZp3mI73wtKDyB9S7tnPNLaC
         LaNE3es2xyKF2n5sFEaa72aKvW0nw8X0APyZAiaPLI9P/DQneCGEkAWfJjpQBSjMjTs3
         dM7eo5hc5drJvPlvF7HCmvGJC7y1KNEHGLmDFkhpvKk5TRm9NA//dWc3Xp+0GZKEMsbI
         K8PX8tUAAYYvZ83ORR9cyl6w4PR66GBlBIEwhhk8zKsvK6j/YRPTEgzrwUEsX+C3VeZt
         X6Eqilzx7fG0C1OmSqVoqfPe2IjXAtYKGTAsasMY4EMuFv81LljH89asuliUHxA75uAY
         1g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t8aZeckWp1rlKkzCvNmniAClQ2coG42tzhovGEUasAM=;
        b=ZYQvGW1afKZiwB5DVLmI7T6DdmILjC3gT43IxRMSNbKyex2505Gz0UaV8SM3OStycU
         NjfwoS9nockm45CXKTtjKmMvx4J4cKxL11wKLzsA0y8ZLYDurPPLdLEs07XiTHDeAZST
         e2TrCXDAMdxmTfRmDW2x31Br7bysSuvFD/B1O3t0Op1VFeU6qxvh/g35Gmuo8K8plqlf
         /gh7pzmfxrUVOcw+4PjTGkk7TvIe7YEDTF1DLRY8FaGYnb5Kl1inih48av+wEKuQfsyl
         UZUBDyb5ohbxwFgVZ3fKVKUfFikoW7Wc4GZ3ijvYwwsdLQj3aTOAZIACfk/iouzfiUi2
         dkHQ==
X-Gm-Message-State: APjAAAU97eBSS4g7pdThq1Sz7oRxmfQ3HtdyQy2+V15yiU2o6/JqXthA
        JKf1CfYQYCc4ZNmnG6Nd9zY=
X-Google-Smtp-Source: APXvYqxSvBArDWACd12sQx6/kazBl9riuHMZRizCjgp1vdYqrBPn45Sq95JhsuSzjOlrFKxKB1Yqng==
X-Received: by 2002:aed:2284:: with SMTP id p4mr12769230qtc.329.1579731923947;
        Wed, 22 Jan 2020 14:25:23 -0800 (PST)
Received: from [100.81.200.96] ([204.48.76.96])
        by smtp.gmail.com with ESMTPSA id i19sm19096536qki.124.2020.01.22.14.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 14:25:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/4] checkout/reset/read-tree: fix --recurse-submodules in linked worktree
From:   Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <xmqqwo9j5ei3.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 22 Jan 2020 17:25:21 -0500
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <69FFF66E-9273-488F-A747-2B4EBBDD7A7B@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <pull.523.v2.git.1579618877.gitgitgadget@gmail.com> <xmqqwo9j5ei3.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,=20

> Le 22 janv. 2020 =C3=A0 17:10, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> Cc:Max Kirillov max@max630.net [max@max630.net] Brandon Williams=20
>> bwilliams.eng@gmail.com [bwilliams.eng@gmail.com] Jonathan Tan=20
>> jonathantanmy@google.com [jonathantanmy@google.com] Stefan Beller=20
>> stefanbeller@gmail.com [stefanbeller@gmail.com] Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy=20
>> pclouds@gmail.com [pclouds@gmail.com] Eric Sunshine sunshine@sunshineco.c=
om
>> [sunshine@sunshineco.com] Derrick Stolee stolee@gmail.com [stolee@gmail.c=
om]
>=20
> This is somewhat unreadable wall of names X-< Is it a funny
> rendering of what is originally in some mark-up format (perhaps
> HTML???)

Yes, Gitgitgadget unfortunately failed to convert this wall of text into a p=
roper CC: list because there was no space between the "Cc:" and "Max".=20
I=E2=80=99ll try to submit a PR for that in GGG.=20

Cheers,
Philippe.=20=
