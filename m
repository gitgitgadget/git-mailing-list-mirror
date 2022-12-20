Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5BC3DA7A
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 20:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiLTUtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 15:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTUtL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 15:49:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63413F4A
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:49:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so32026761ejc.12
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 12:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h/LVj4hxwr28zDStGLJghwH/+Hpuq4N8soOp+SRIFCo=;
        b=NpjqlgzAPVlXQnlper7HUNG75zRb1rVz778BG7AH7b4puAXVE94l6hEAHdXXrrpsZ6
         Qj0MuPHUH97/rkje+Pxf9pGWdIfE7QcgA3awvQWsuNQy4jpUKcpd2Wvr11RH1+/JJU1A
         wA0o2fznLjnyP6GVLLdlDDCoyZnwwNKVxUzWdtPXYGu34eJmDxbYfhX2HTI6eMoAx4eE
         8mlChomIOwk0ZZk6mXERFLTfzu2JIu50YcVLJ5PRjNcKviTXNtKXIskiMSbxuch/OCz4
         M2qnbVtGamiN3Vr387QvDQpzMFlCE3ZtZnCgv4nLkVNXCi47Sak0ubl+QotYQxFz2Ir1
         a/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/LVj4hxwr28zDStGLJghwH/+Hpuq4N8soOp+SRIFCo=;
        b=YtoqfPi4II4fJOL+3Vf/zTCRClQ1dbHgPcupLQsbVyuJzOCMcU8OkYWNZAHTtFrmkS
         PlsiBpU+BkjKPna8JTrIkkc4iqdsN/oAlCXvOzeG5x0iPhYEgMbdT/lTBa+1c8MlqCnG
         GuhiFvoPhUsTUirStYAvZIbbzH/fdLSKnpIDn7HE0nK2iqTJesc74LIRAV+q0ln856E7
         NzS8Jb+4uVCSMabxL3IYVRQRfOp5oW4OzSWuAShDZhZ60pzDE2NrymgYQd+K0hbzTlF7
         p+mOTGx1Q1u0DTtlx66sLSc73IDtygMgq8LxxxLQNVc1lgRKb7FrvGutFxABkaj+W3tO
         m3gA==
X-Gm-Message-State: ANoB5plklxWjdEaUJdiaXFMh+rT2GP1WfSDpP22f5SGZ7JifASDtcI93
        /MXt1d7jgF+ac8QP0ByQlXCgwUHg813rCQ==
X-Google-Smtp-Source: AA0mqf7pxQJls/JGoH1QaDuNuy9buY76dJekio4vF1cZDuvmPEKi9Mpu2fJuPGU0PVT9c8TkDR6l+A==
X-Received: by 2002:a17:906:8290:b0:7c0:e6d7:f8b8 with SMTP id h16-20020a170906829000b007c0e6d7f8b8mr58702383ejx.39.1671569349383;
        Tue, 20 Dec 2022 12:49:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709061f1600b007c10bb5b4b8sm6150839ejj.224.2022.12.20.12.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:49:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7jXw-007XA5-0r;
        Tue, 20 Dec 2022 21:49:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Date:   Tue, 20 Dec 2022 21:46:21 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
 <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com>
 <75107325-bd28-1adf-b260-ba8846c63229@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <75107325-bd28-1adf-b260-ba8846c63229@github.com>
Message-ID: <221220.86k02lx0l7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Derrick Stolee wrote:

> On 12/19/22 5:57 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:
>
>>> @@ -112,10 +112,10 @@ int fetch_bundle_uri(struct repository *r, const =
char *uri);
>>>   * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle t=
he
>>>   * bundles according to the bundle strategy of that list.
>>>   *
>>> - * Returns non-zero if no bundle information is found at the given 'ur=
i'.
>>> + * It is expected that the given 'list' is initialized, including its
>>> + * 'baseURI' value
>
>> The same goes for the added docs, that we "expect [that] 'list' is
>> initialized" may be true, but that would have been true before we
>> removed this unused parameter, so let's not stick that in this unrelated
>> "UNUSED" change.
>
> It is _not_ unrelated. The 'uri' parameter looks like it should
> be used to determine relative URLs for the included list. However,
> this reasoning around the 'baseURI' value points out that we are
> using that value _instead_ of the 'uri' value, which is why it
> is safe to remove the parameter.

I'm saying that the function expected that baseURI to be initialized
before, but with your rationale I think it's fine to also do it in one
commit.

I also pointed out (and you elided) that we should still document the
return code, do you agree that we should keep that?
