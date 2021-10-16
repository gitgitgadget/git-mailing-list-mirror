Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96EC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6468361101
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhJPFzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhJPFzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 01:55:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC67C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:53:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w14so46328447edv.11
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=A01TEyLNX3Dfg/5Rp34w0Cmx/seMYQS83VJifkySe4U=;
        b=ZrVUHuB6jtQzdAq0jVzvdeP8hkEZaw36slr5srHQvCkbJgjZqu5YfXKiQesquEH9Hr
         Xt2KC3eRN0fWEY6tWtmcEA9Zy1uM/LZ5XfBNMQLNtSbL96fe/Pvnhtoal7cJ1ZsihSCu
         MkwAoI+ODJ+FPasQ/gwFBkjYN82gRUK3u6DZuwrK3fYhOJyATWC8yOxfLkduDqXNvQFv
         cfDrgsJ3g8q+NGm/Ke2O3j2bDc8mxfS70aN8st1cASMU0/MfQFKDCUbLsnP/DJkRhMoI
         uDYkyW/ntFnbXPo0UJnFs8tizI4iepJ3EmZFJhsUv1Mpp2NRZiCPYzMNBjHU70R2v7uL
         rFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=A01TEyLNX3Dfg/5Rp34w0Cmx/seMYQS83VJifkySe4U=;
        b=0awJoJgGjWEulmTBCucTb7iUSlQcAoH2ismMSCTAMjI4kbDBJc88B9kN4QtlBJPBYD
         pEZNZV7XdrXTPYi8g5mYG4GYpaht30gubFAOiaNz+YGkjykqabslZfwL17CMGrvlCSy8
         l+5fEXPgyIj0doVQL/GXI4JRlTWMK2i6YME/ewgdEgmDEVoV7WZbrYegJSthn+CxMciA
         7HLSXzH3pI0uo/Wyejy5oEanYqZGP7vQCWhBaqiSe0WMjndTtCU/U4aTKuKRE96G9N1q
         W32w/zccklc6P83FcDH0ANiEtBtNU+tYuZlwlz+VXxTS+AFa5sR2r8Q4zRlo5bmJJQxm
         wRhA==
X-Gm-Message-State: AOAM5336cXEBl+qD5XX+HDYlMbuwrZlGHk49ipmtWYm3y1XPojeC6rEG
        VyprhYaSIx8WiJk1dgMiZC0=
X-Google-Smtp-Source: ABdhPJwKOeVYNjXi228oKq22x7jSC2+WsCOYvFYZMD7nn1Mq4OA2IqFEir8LQvn0TdLTm0hW9LTYtg==
X-Received: by 2002:a17:906:9414:: with SMTP id q20mr12629724ejx.241.1634363612656;
        Fri, 15 Oct 2021 22:53:32 -0700 (PDT)
Received: from evledraar (2a02-a45a-de66-1-2cbc-c868-da6a-49d1.fixed6.kpn.net. [2a02:a45a:de66:1:2cbc:c868:da6a:49d1])
        by smtp.gmail.com with ESMTPSA id t19sm5676285ejb.115.2021.10.15.22.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 22:53:32 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mbcdP-0005sg-K2;
        Sat, 16 Oct 2021 07:53:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 00/13] hook.[ch]: new library to run hooks + simple
 hook conversion
Date:   Sat, 16 Oct 2021 07:47:04 +0200
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <xmqqbl3p4wgz.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqbl3p4wgz.fsf@gitster.g>
Message-ID: <874k9hecro.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 15 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Part 2 of the greater configurable hook saga, starting by converting
>> some existing simple hooks to the new hook.[ch] library and "git hook
>> run" utility.
>>
>> See the v1 [1] CL for more context. I've dropped the git-p4 folks from
>> the CC list, your feedback on git-p4 would still be very appreciated,
>> but I don't think I need to re-spam you for every re-roll of this.
>
>
> This, when merged to 'seen', seems to fail so many tests to make me
> question my sanity.  Something is not playing with it well.
>
> Queued on top of a merge of ab/config-based-hooks-1 into 'master';
> when tested alone, without any other topics in 'seen', it seems to
> fare much better.  Only t2400-worktree-add.sh fails at 58-59 and 62.

I haven't looked into worktree-add.sh failure (and from what Eric says
it seems unrelated), but all the rest is due to a mismerge of
reset.c. The diff here at the end on top of "seen" fixes it[1].

I'm able to reproduce it with:

    $ git reference 978c287ca92 # just a "show" alias...
    978c287ca92 (hooks: convert 'post-checkout' hook to hook library, 2021-=
10-15)
    $ git checkout origin/seen^1; git -c rerere.enabled=3Dfalse cherry-pick=
 978c287ca92

Which has a big conflict, including:
=20=20=20=20
    @@ -158,10 -90,54 +159,58 @@@
                    goto leave_reset_head;
            }
=20=20=20=20=20=20
    ++<<<<<<< HEAD
     +      if (oid !=3D &head_oid || update_orig_head || switch_to_branch)
     +              ret =3D update_refs(opts, oid);
    ++=3D=3D=3D=3D=3D=3D=3D
    + reset_head_refs:
    +       reflog_action =3D getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
    +       strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : defau=
lt_reflog_action);

I.e. the oid check there went away, but needs to be kept as well.

1.

diff --git a/reset.c b/reset.c
index 6441b22eebc..602cba75c1c 100644
--- a/reset.c
+++ b/reset.c
@@ -165,6 +165,8 @@ int reset_head(struct repository *r, const struct reset=
_head_opts *opts)
                goto leave_reset_head;
        }
=20
+       if (oid !=3D &head_oid || update_orig_head || switch_to_branch)
+               ret =3D update_refs(opts, oid);
=20
 leave_reset_head:
        rollback_lock_file(&lock);
