Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D209C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 13:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbiF3NrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbiF3Nqx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 09:46:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C721274
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:46:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id d2so27388913ejy.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qJ3RGGASZhurGum1NJ2sambtVw3v6GH2tymrjSp5uww=;
        b=S/FTAcPTAN0YKVGRuPtJWDs0iiZv8SDnANL/LU439xPtp9nf0Tq6UneZbDeUGovuxf
         5qITucXqTik/L/E/TDDcUk9tWLEPW3AdHXAEbuOlxu9fAxDrlxRXVP5qctHkOy7g6/hu
         ZPXIr8VFh25gPZed9269VH5BcF9J0G1smIyxfA5eWPdzM5anlRUy6fbjk7tM64/vcNR0
         Pp38UNCnoXRCRhUzkjz3r7du3AKfJS4bN/iXTYqvRjfuAmbeZGvKwHm5CSAlsD9gpFm0
         dy1b1ZUE1O0Wc59tJ7MI4+ElmNMbIw0tyTyFwXN0aT/awkTadzuhn4q1UUhULq4MOC0l
         RJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qJ3RGGASZhurGum1NJ2sambtVw3v6GH2tymrjSp5uww=;
        b=CzLVwp92ENnmWVK5tJhxK7cQQ9/+gAiba6c6+CNSzpwaMRBy8wNduqx2lrws59ipz3
         qD4pmD9ZmeqWgkkKxIz0fpKzewq6yJS2oHh/RTGCreJPNgLKEJOSywaqWubFT94u04HI
         o5uYv1GlWE/n5bSgx9S+B2VU77TFOrdEg8mNCDmcciBvQNozdboOGExKULatWeKy4+dS
         qJzT6F2akK+fQLwIGQgAE6Q1rjKL+IQmd5OBdm+NOdi4YL9qm5OmO7muF61yUp8Ud4p4
         5tc215fjPZCjqUTQRx+7B8PCvJ5/UQJY0gs3QQWhA6n/DmwadZlVZE505YSWGTWI88LD
         SH9A==
X-Gm-Message-State: AJIora9O9Zo1O6Lh6eex/Z9ia+BXZd88/zje6Li7j2R6211RXExNANBz
        iBq28N2k/LxV5RbdPkxXGJw=
X-Google-Smtp-Source: AGRyM1tA9kLBEhU5oomaa/f/8hc6vs2p6zhUqfxKshwDeBiky1jZKj41VoFhmwPo9Z08ISYwN/vd2Q==
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id sc37-20020a1709078a2500b00726c9f22f5emr8868099ejc.286.1656596808993;
        Thu, 30 Jun 2022 06:46:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r12-20020a170906c28c00b006ff52dfccf3sm9131179ejz.211.2022.06.30.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:46:47 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6uVK-002LWh-Hz;
        Thu, 30 Jun 2022 15:46:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <hanxin.hx@bytedance.com>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
Date:   Thu, 30 Jun 2022 15:43:48 +0200
References: <cover.1656044659.git.hanxin.hx@bytedance.com>
 <cover.1656381667.git.hanxin.hx@bytedance.com>
 <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
 <220628.865yklgr6g.gmgdl@evledraar.gmail.com> <xmqq35folmgf.fsf@gitster.g>
 <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <5n35o008-pso2-6440-424p-q387q9n4so41@tzk.qr>
Message-ID: <220630.86v8siclh5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Tue, 28 Jun 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> >> +test_expect_success 'setup: prepare a repository with commit-graph c=
ontains the commit' '
>> >> +	git init with-commit-graph &&
>> >> +	echo "$(pwd)/with-commit/.git/objects" \
>> >> +		>with-commit-graph/.git/objects/info/alternates &&
>> >
>> > nit: you can use $PWD instead of $(pwd).
>>
>> We can, and it would not make any difference on non-Windows.
>>
>> But which one should we use to cater to Windows?  $(pwd) is a full
>> path in Windows notation "C:\Program Files\Git\..." while $PWD is
>> MSYS style "/C/Program Files/Git/..." or something like that, IIRC?
>
> Indeed, and since the `alternates` file is supposed to be read by
> `git.exe`, a non-MSYS program, the original was good, and the nit
> suggested the incorrect form.

I looked at t5615-alternate-env.sh which does the equivalent of:

	GIT_ALTERNATE_OBJECT_DIRECTORIES=3D"$PWD/one.git/objects:$PWD/two.git/obje=
cts" \
        	git cat-file [...]

We run that test on all our platforms, does the $PWD form work in the
environment variable, but not when we write it to the "alternates" file?
Or is there some other subtlety there that I'm missing?

