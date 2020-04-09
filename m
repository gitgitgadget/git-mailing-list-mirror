Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368CC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2AD2083E
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9/kUAV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDIWWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:22:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgDIWWs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:22:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id n10so196778pff.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oiomvP6jWZT1Vmsux6pz2M3MKs0agAZ72FRCDoqmYyw=;
        b=A9/kUAV6QpuyRGiq19tdvvmslJnuoxOiKS6DVhTycTS26Ukd7cmeAZqDzt6cF2YmiD
         GJfLPgz8eg9JtRoytHu/tVbHGNg1gqwYoJA9dEei2QUETMgnaE4XX4FVf6UrociAQGkT
         FWP5iPoRBEBl2pruU8vErd9VKTYDbMMUB3j6mq2Snllrk4UAf0/vrzbDIPm0JEhiu9Xs
         ACuMhfEYaWFUJzMwyElzHdy7DojBGUTDYT3ZGGdmIhHXozrdunrFs1DmMeCtxhqCShcj
         45WLDu+19CbxQdYoIrInCBpCkBOfB513Dd0hkAaJs/UsgFSKz95hbN89B9ALQE2byvvA
         Lh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oiomvP6jWZT1Vmsux6pz2M3MKs0agAZ72FRCDoqmYyw=;
        b=nRdGdsCc8YVIXKhtQ0JnAwBqPXSZHe7XladHrwk5f+mYSD6rRQWHrDei8UlzMVhEZX
         OBVNkvtguUUjKXcx5MGf5eS4cQiM0tkXXFY8sLTWSS/lPNYs5vHxCo91YSzvzGbw++7a
         ljU4BdKkkSRIEA22+rc63TSoEBWqotPC6+NJQo1GgiozogOWbRYBOsTXP1IvTtVkEnsY
         5lIWU0PZUKf4m8qw97/69DeUaowGvhwMG02JZtCfVzkupX44VdFjOYSTiWU+HKgnHUf4
         7uIHdUPF9yceI6lyXf5vaepPx6SMhTfhTHj9NTJkuwGVdbrAQYCJBMnUIWsagb88tFFY
         b3mg==
X-Gm-Message-State: AGi0PuYbOKR1byrxJiwC5zoXnZnc4Pfd2tA4N2pVpmPgTWoYQMZqnwos
        0utd01WZqhNlhgr7IxPr0PU0AfujmC33BLLKb+HYMnKDq6Y=
X-Google-Smtp-Source: APiQypKYWnI1sIp7QsN3DQxq9iWZuxjYZWaXVJCMwxOwcHmkA2wz4+Q0AhXyDiCdKXEf4Dw0P6hn5EdGUi9uHtWkeDA=
X-Received: by 2002:a63:64c4:: with SMTP id y187mr1578315pgb.36.1586470965394;
 Thu, 09 Apr 2020 15:22:45 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>
Date:   Thu, 9 Apr 2020 19:22:34 -0300
Message-ID: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
Subject: [BUG] segmentation fault in git-diff
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there!

I have found a bug in the git-diff utility, which is reproducible in
the next branch. In any repository, if I run

    git diff :/any/path/

(The important part is the trailing forward slash. No slash will
generate either a valid diff or an error message about the path not
being known. ":/" also works without issue)

it will trigger a SIGSEV. I have traced that back to the
refs_read_raw_ref() function, where it seems the ref_store parameter
passed to it is 0x0 (according to GDB). It's always possible to include
a null-check in that function to fix the issue, but I don't think
that'd be the best solution. I can attempt to fix it, but I don't know
what (and where) the proper solution would be, because I don't know what
the expected behavior is here, nor where exactly it should fail. Do you
think this could also warrant the creation of a test?

I don't know what the best debug resources (valgrind output, core file
from gdb) would be, but I can provide them if necessary.

Thanks,

=C3=89rico Nogueira
