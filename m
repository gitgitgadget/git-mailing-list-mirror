Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFE2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E22610D0
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhIGQGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbhIGQFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 12:05:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEA5C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 09:03:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id t19so20650079ejr.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HgYN4nLRhP2yEEgNkYxetmAEndwiU3k9dJiov4fzN+g=;
        b=Ns84FQ77PiWlXa/XuyaO+T1XQ5g8VpQo3/OSmq4DPXb+dpMO3fNe7qKZdebJ63HuyK
         poKYfGLw8mSphzl2SAu+3Dv84GPE5hyGLjwVejQtJF++iOEZGD/8dS6ORJMlacd6rm0O
         PtS25cfoqL9AAV5ziqI+RJwkQ4n/yDejKSlEgU/DVn/dpMIwFL9rWIhWd9YyifGqQZhR
         Lyzw71RyWaBczTzSmKs+GP/RbMSPw+46Z1EKP3BDgGVDu7gBmazv2tez8n0KlyOl0TLa
         M7/Ab/+uvc/PAjrwuA8plIhkjrIQD4HvG83JBufPOkOpGK4WGrkM2RJviJcs+Br6xCaP
         5Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HgYN4nLRhP2yEEgNkYxetmAEndwiU3k9dJiov4fzN+g=;
        b=W9VZA3g4iwfWLHFnzfP0I/IMIugesLZwUgFEY4zi9g5Un03FX/kYec3abzp3c9uI2u
         lrF6CflTH1mhpG3/QHGw0HJZgNuoQbyQUZZjaxvz4vfzVCKdaYJmFzsoie5I1kDhRYfx
         nZeqkdT63OdR3/rbUDk9nC0HI/DX22VJoT61NeIKrgBIf9CMi8SEthNhvvdG5+dFLnfG
         L2t6o6IMdC2h6ZQ933Z/wglJhjUzt2I+LkA9MeH/gH/5PrfRnOcuyDaJTWfZmvnzqJbv
         LKeI50JCw9Db42swoFRoTCGr9DmFrNTDVQkUY/Cvdv2O1fPBHoxnQPY0nHPivLQDLA2k
         36/A==
X-Gm-Message-State: AOAM530/K9ZfNSHjTRZX+0pGD0IbqAGdpqcvStuRxm6G1XZONaEHSrT4
        kXlLEfsPrr3cZFwm3YvuTtY4oYpZYrRJ6A==
X-Google-Smtp-Source: ABdhPJwXpPttkxEAAP29d7z+SDl8bUpmzF9bb2KSrFPiWigQMUR2nzO3XMtwkd7kV7628HFSbYtikg==
X-Received: by 2002:a17:906:34ca:: with SMTP id h10mr19462801ejb.137.1631030609920;
        Tue, 07 Sep 2021 09:03:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm5740431ejj.91.2021.09.07.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:03:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/5] test-ref-store: tweaks to for-each-reflog-ent
 format
Date:   Tue, 07 Sep 2021 17:53:07 +0200
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
 <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
 <11b296a55e9e450575c64ade1a2cb93a1886b9da.1630947142.git.gitgitgadget@gmail.com>
 <878s09nxh1.fsf@evledraar.gmail.com>
 <CAFQ2z_Oen0Q5hfpbZdzWgJ8D=EetBNGx7sQ3ZxnJSXC-tSKGYw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAFQ2z_Oen0Q5hfpbZdzWgJ8D=EetBNGx7sQ3ZxnJSXC-tSKGYw@mail.gmail.com>
Message-ID: <87fsugl6en.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Han-Wen Nienhuys wrote:

> On Tue, Sep 7, 2021 at 12:35 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> > -     printf("%s %s %s %"PRItime" %d %s\n",
>> > -            oid_to_hex(old_oid), oid_to_hex(new_oid),
>> > -            committer, timestamp, tz, msg);
>> > +     printf("%s %s %s %" PRItime " %+05d\t%s\n", oid_to_hex(old_oid),
>> > +            oid_to_hex(new_oid), committer, timestamp, tz, msg);
>>
>> Nit: Would be a more readable diff if this wasn't a
>> line-wrap-while-at-it change in addition to changing the format string.
>>
>> I.e. the last 4x parameters aren't changed, so leaving them on their own
>> line & just changing the string & the two oid_to_hex()...
>
> This is clang-format's output, and the new code takes up less lines verti=
cally.
>
> If you think this is really, really important, I can change it, but I
> think it's a better use of everyone's time to leave mechanical tasks
> (like formatting) to the machines.

It's not "really, really important" or even "really important", just
notes while reading the series.

Patches are read N times, including during review. Since humans read
formatting changes, it's in general are not something we can leave to
machines. We're after all looking at the patch on-list, not diffing two
versions of the generated machine code, or of clang-format's output.

I don't think the intent of the clang-format target is to run it before
patch submission, but to serve as input on suggested formatting changes.

If on master you run:

    git ls-files '*.[ch]' -z | xargs -n 1 -0 clang-format -i

You'll get:

    631 files changed, 48246 insertions(+), 45061 deletions(-)

Which I think speaks for itself in the likelyhood that
"git-clang-format" is going to inject unnecessary churn into submitted
patches.

I think this case is quite small and not worth a re-roll.
