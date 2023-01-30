Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA4C636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 18:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbjA3StW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjA3StQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 13:49:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705462DE68
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:49:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so11429355pjp.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/KMefcKVNPGXp7TIKHYWrMVVwD1o79tgw8A/VxW99A=;
        b=XUK175nYxyq0Mw/hgD8PZ6knhi0bmjoNBQvQK0rMe4LnN1Xzb/6GP5NtEjlFlL/pXn
         7j5As30rhhTN2zcRdztSYtGWfeEfDkHLqUP7x9MGDOjwgwre/vLjDop55852O8qPPXPL
         L/tJ0N2ChIVbMZDGu6Bc/62wMR11WcVFONUqANwtDiZSxyAo7wUy16tmhlJAj4oQqOhJ
         zuffDs3IRuRoDFnTgj3La43/obFBXqIIuNTw5EgG02oz6ixLRXTv/XgiPVkDO4sulCEn
         u9b//rmqGcQxu/iwu633l68HIYlPcG7tQDSB/KJ7BhPmMT4T9i+7+hOqb/y79MDBEpfF
         2ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/KMefcKVNPGXp7TIKHYWrMVVwD1o79tgw8A/VxW99A=;
        b=lt8MSeCCJ1K/5Sngp7jWpOy/y5vg5pTVE2VPjkd72xOUUyJbPYz3iNcnLuXybFRSXj
         BlSCym8F5zx8VrwdWXf4i4Y3L+rraRxPF+8K4FIVIJMcactEz297p2S/iQwGfT2jqcoR
         uxJ1jLJp2skmacXo/qlaa3UBjhHAAz1tUblC29r59xC/y7hNfeiEHyB0a/v+ELahYGe4
         VLsWwGQ3GjHjwq6FAxv0r8lwwwhKQY5eqPRoAJgfMcaXqmrbqf7ezih14WjtQDgQTytu
         pmIgXkVIBrV2MLPLbzUrXXkvC9ysmPm9k1j461Ul+xYiFFl1CPGJiSYx+YmlFQNX/JkB
         /Q3Q==
X-Gm-Message-State: AO0yUKXjGo4Ln8xJ2pXiPJ7mqzjhI/vlCsbirGaZawYuCDJzKluKyJaD
        E0s8GUk/yL6xxaUG6xmR0jQ=
X-Google-Smtp-Source: AK7set+vJksNC9QPqyPI5li/JIdh7N0OfTmF56uRtBJevO8owfX5VFZkcWlYbh6AeYysUNObhWNRBQ==
X-Received: by 2002:a17:902:ec90:b0:196:3666:12e8 with SMTP id x16-20020a170902ec9000b00196366612e8mr22380502plg.23.1675104541849;
        Mon, 30 Jan 2023 10:49:01 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902aa8100b0019251e959b1sm8081818plr.262.2023.01.30.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:49:01 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Mathias Krause <minipli@grsecurity.net>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
References: <20221216121557.30714-1-minipli@grsecurity.net>
        <20230127154952.485913-1-minipli@grsecurity.net>
        <xmqqbkmk9bsn.fsf@gitster.g> <xmqq1qnfancf.fsf@gitster.g>
        <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
        <xmqqk0156z55.fsf@gitster.g>
        <230130.867cx4s2j4.gmgdl@evledraar.gmail.com>
Date:   Mon, 30 Jan 2023 10:49:01 -0800
In-Reply-To: <230130.867cx4s2j4.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 30 Jan 2023 11:56:42 +0100")
Message-ID: <xmqq8rhj504i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> If I compile libpcre2 with JIT support I'm expecting Git to use that,
> and not fall back in those cases where the JIT engine would give up.

The thing is, the reason why their Git has JIT enabled pcre2 for
many users is not because they choose to compile their own Git for
themselves because they wanted to play with JIT.  To them, their
distro and/or their employer gave a precompiled Git, in the hope
that with JIT would be faster than without JIT when JIT is usable.

In that context, "Speed is a feature in itself" is correct but
"failing fast, forcing the user to try different things" is not a
"Speed" feature at all.  It may be interesting only for those who
are curious to see what pattern was rejected by JIT.  It is
especially true as (1) we are willing to fall back to interpreter in
the SELinux senario, and (2) for normal users who want to use Git,
and not necessarily interested in playing with JIT, there is no
other recourse than prefixing "I do not want this JITted" to their
pattern ANYWAY.  Why fail fast and force the user to take the only
recourse manually, when the machinery already knows what the user's
only viable alternative is (i.e. falling back to the interpreter)?

> Pathological regexes are pretty much only interesting to anyone in the
> context of DoS attacks where they're being used to cause intentional
> slowdowns.

Exactly.

> Here we're discussing an orthagonal case where the "JIT fails", but
> rather than some pathological pattern it's because SELinux has made it
> not work at runtime, and we're trying to tease the two cases apart.

s/and we're/but you're/.  And I do not think you want to.

> I don't think this is plausible at all per the above, and that we
> shouldn't harm realistic use-cases to satisfy hypothetical ones.

To me, what you are advocating is exactly the hypothetical ones that
harm end-users who did not choose to enable JIT themselves.  When JIT
fails for whatever reason (including the SELinux senario) for them,
they do not need to be told by Git failing, when the interpreter can
give them the correct answer.  Wanting to see the result of the
operation they asked Git to do, while allowing Git to use clever
optimizations WHEN ABLE, is what I see as realistic use-cases.

