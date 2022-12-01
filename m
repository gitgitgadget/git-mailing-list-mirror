Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B333CC4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 23:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiLAXEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 18:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiLAXER (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 18:04:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EAA896B
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 15:04:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id fc4so809789ejc.12
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tT9tKudbc+KIDE/D0FhlqxlEMzouEItXP5nsKdly1Vc=;
        b=V7oCbN0MZ0+NFALvmKKyWLXEjVGfMKzWW7TQqAEVij13T5XOu6iiB+SsaSZ7VzmkVW
         1sPwX4uIy5w9dy1qUk4cHwAf9hRRfPybglDPZRjDWRYay1qBKuWaVuAR6v4hdN5bRMLX
         2e7neDFgK9Sy1Yf1JtBNPgRFjxSgok/mQO3OeeVFBlvmbPolYx87aZQK7kMoapc96ihm
         CdnIM/7wBNLY747+xreFNA/UTbWnImZGNZ0g8STUIaTqdaPlHXwfpinbHs0UIxa1uesZ
         Wx6wkbXg86ezpQq1aR7Qw2Bwwy2EX4Aowp8bV2F+nsBv3WaCZx5rBDxgrNg4d9k0/wW7
         5pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT9tKudbc+KIDE/D0FhlqxlEMzouEItXP5nsKdly1Vc=;
        b=ZwcfvU20MbctwyC+8Ylglc64oZEJESJQU5t7VHljn/w4+NAEDoL5UWS8T3RXhaVqb7
         YUBaSGaFty5NniphmaDLiHmt1x7vyybf433+f2WLVgrMBEb7MIXNX+sgjT6b6A1KFvI3
         D0NPPo8f82DLqE/qWib55B/qkkfaHik7PjSXv7TYdqAJIrYVO8vKq/rwc+cmm1LoRxuM
         7k1JVmuNPjUbvpgb+gae9gqSCRlBUz+8UX400PJns0LVn/XHdMLa7DGw1NehaujYpOMJ
         7L+XWE4xJNxfxA3O9NcHDAPuXiHqK5gRme8+93zspb3dhldH82APxAKOiFADfynFQJlS
         06yg==
X-Gm-Message-State: ANoB5pn2abRuhFPjxQYzbPhRzJdLi+V67G27gnz8JsZsB40BjC1n2Lfu
        bJucUaaUii0kdspcKEyGww0=
X-Google-Smtp-Source: AA0mqf7xMx7dWIIkarFPYfc/wseMNPu0r8hAUvyKrAqwoaJbq9XaYyo858N7rpkFwoyWCDOFn7/aBw==
X-Received: by 2002:a17:906:1e4a:b0:78d:3505:6f3e with SMTP id i10-20020a1709061e4a00b0078d35056f3emr56160705ejj.611.1669935853212;
        Thu, 01 Dec 2022 15:04:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d71792c8dsm2270669ejf.180.2022.12.01.15.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:04:12 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0sbD-002LJt-1X;
        Fri, 02 Dec 2022 00:04:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] diff: build parseopts array on demand
Date:   Fri, 02 Dec 2022 00:00:17 +0100
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
 <221201.86r0xjgicc.gmgdl@evledraar.gmail.com>
 <572e29a2-3f19-e946-d152-009999651084@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <572e29a2-3f19-e946-d152-009999651084@web.de>
Message-ID: <221202.86iliuhgk4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 01 2022, Ren=C3=A9 Scharfe wrote:

> Am 01.12.2022 um 17:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Thu, Dec 01 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Calling repo_init_revisions() and release_revisions() in that order
>>> leaks the memory allocated for the parseopts array in the embedded
>>> struct diff_options member.  Get rid of that leak by reducing the
>>> lifetime of that array.
>>>
>>> Original patch:
>>> https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de/
>>>
>>> Submitted separately from that thread because it's independent enough.
>>>
>>> Change since v1:
>>> - Actually remove the parseopts member.  Its removal got lost during
>>>   refactoring in v1.  Thank you for spotting that, Junio!
>>>
>>>   diff: factor out add_diff_options()
>>>   diff: let prep_parse_options() return parseopt array
>>>   diff: remove parseopts member from struct diff_options
>>>
>>>  builtin/range-diff.c |  2 +-
>>>  diff-no-index.c      |  3 +--
>>>  diff.c               | 26 +++++++++++++++-----------
>>>  diff.h               |  2 +-
>>>  4 files changed, 18 insertions(+), 15 deletions(-)
>>>
>>> Range-Diff gegen v1:
>>> 1:  630f95320f =3D 1:  4dc8b2632b diff: factor out add_diff_options()
>>> 2:  4b56fa795c =3D 2:  10903d355e diff: let prep_parse_options() return=
 parseopt array
>>> 3:  7e54e4370a ! 3:  24bd18ae79 diff: remove parseopts member from stru=
ct diff_options
>>>     @@ diff.c: void diff_free(struct diff_options *options)
>>>       }
>>>
>>>       void diff_flush(struct diff_options *options)
>>>     +
>>>     + ## diff.h ##
>>>     +@@ diff.h: struct diff_options {
>>>     + 	unsigned color_moved_ws_handling;
>>>     +
>>>     + 	struct repository *repo;
>>>     +-	struct option *parseopts;
>>>     + 	struct strmap *additional_path_headers;
>>>     +
>>>     + 	int no_free;
>>
>> This looks good to me. Would you mind running the tests with:
>>
>> 	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck GIT_TEST_SANITIZE_LEAK_LOG=3Dtru=
e make SANITIZE=3Dleak
>>
>> And then marking up the ones that now pass with
>> TEST_PASSES_SANITIZE_LEAK=3Dtrue. I think it's all except one of these
>> (one isn't marked on "master", I forget which one):
>>
>> 	Test Summary Report
>> 	-------------------
>> 	t1022-read-tree-partial-clone.sh                 (Wstat: 256 Tests: 1 F=
ailed: 0)
>> 	  Non-zero exit status: 1
>> 	t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t3210-pack-refs.sh                               (Wstat: 256 Tests: 30 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t4053-diff-no-index.sh                           (Wstat: 256 Tests: 19 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t5554-noop-fetch-negotiator.sh                   (Wstat: 256 Tests: 1 F=
ailed: 0)
>> 	  Non-zero exit status: 1
>> 	t5613-info-alternate.sh                          (Wstat: 256 Tests: 13 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t6021-rev-list-exclude-hidden.sh                 (Wstat: 256 Tests: 42 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t6415-merge-dir-to-symlink.sh                    (Wstat: 256 Tests: 24 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t7403-submodule-sync.sh                          (Wstat: 256 Tests: 18 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 30 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t9115-git-svn-dcommit-funky-renames.sh           (Wstat: 256 Tests: 12 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t9146-git-svn-empty-dirs.sh                      (Wstat: 256 Tests: 14 =
Failed: 0)
>> 	  Non-zero exit status: 1
>> 	t9160-git-svn-preserve-empty-dirs.sh             (Wstat: 256 Tests: 12 =
Failed: 0)
>> 	  Non-zero exit status: 1
>>
>> I.e. this makes a lot more tests pass leak-free, yay!
>
> With -rc1 (i.e. without this series) I get:
>
> t1022-read-tree-partial-clone.sh                 (Wstat: 256 Tests: 1 Fai=
led: 0)
>   Non-zero exit status: 1
> t2016-checkout-patch.sh                          (Wstat: 256 Tests: 16 Fa=
iled: 0)
>   Non-zero exit status: 1
> t2012-checkout-last.sh                           (Wstat: 256 Tests: 22 Fa=
iled: 0)
>   Non-zero exit status: 1
> t4023-diff-rename-typechange.sh                  (Wstat: 256 Tests: 4 Fai=
led: 0)
>   Non-zero exit status: 1
> t4053-diff-no-index.sh                           (Wstat: 256 Tests: 19 Fa=
iled: 0)
>   Non-zero exit status: 1
> t4058-diff-duplicates.sh                         (Wstat: 256 Tests: 16 Fa=
iled: 0)
>   Non-zero exit status: 1
> t4205-log-pretty-formats.sh                      (Wstat: 256 Tests: 21 Fa=
iled: 0)
>   Non-zero exit status: 1
>   Parse errors: No plan found in TAP output
> t5406-remote-rejects.sh                          (Wstat: 256 Tests: 3 Fai=
led: 0)
>   Non-zero exit status: 1
> t5507-remote-environment.sh                      (Wstat: 256 Tests: 5 Fai=
led: 0)
>   Non-zero exit status: 1
> t5554-noop-fetch-negotiator.sh                   (Wstat: 256 Tests: 1 Fai=
led: 0)
>   Non-zero exit status: 1
> t6001-rev-list-graft.sh                          (Wstat: 256 Tests: 14 Fa=
iled: 0)
>   Non-zero exit status: 1
> t6021-rev-list-exclude-hidden.sh                 (Wstat: 256 Tests: 42 Fa=
iled: 0)
>   Non-zero exit status: 1
> t6401-merge-criss-cross.sh                       (Wstat: 256 Tests: 4 Fai=
led: 0)
>   Non-zero exit status: 1
> t6407-merge-binary.sh                            (Wstat: 256 Tests: 3 Fai=
led: 0)
>   Non-zero exit status: 1
> t6415-merge-dir-to-symlink.sh                    (Wstat: 256 Tests: 24 Fa=
iled: 0)
>   Non-zero exit status: 1
> t7006-pager.sh                                   (Wstat: 256 Tests: 109 F=
ailed: 0)
>   Non-zero exit status: 1
> t7008-filter-branch-null-sha1.sh                 (Wstat: 256 Tests: 6 Fai=
led: 0)
>   Non-zero exit status: 1
> t7504-commit-msg-hook.sh                         (Wstat: 256 Tests: 30 Fa=
iled: 0)
>   Non-zero exit status: 1
> t7517-per-repo-email.sh                          (Wstat: 256 Tests: 16 Fa=
iled: 0)
>   Non-zero exit status: 1
> t7605-merge-resolve.sh                           (Wstat: 256 Tests: 4 Fai=
led: 0)
>   Non-zero exit status: 1
>
> There is some overlap with your results, but also several differences.
> I wonder why so many more tests appear to be leak-free for me.  I used
> Debian clang version 11.0.1-2.

Sorry to have sent you down this rabbit hole, I misrecalled that it was
relatively clean on "master", but it's "next" that's in that state (due
to ab/various-leak-fixes).

> In any case it seems we need to update the marks before we can
> attribute which tests are made leak-free by any new patches.

Yes, let's leave it for now in this series. I think it would make sense
if "master" was almost clean, but I'll just submit another change like
e5e37517dd9 (tests: mark tests as passing with SANITIZE=3Dleak,
2022-11-08) after this lands.
