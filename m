Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2885C35273
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiDEM7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385430AbiDEMdD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:33:03 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1627EB31
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 04:46:02 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=NTtV2QIC1YIPJ/HoWl7xfmbilTfJNjlp5AcpfgIVjDp6YXWo+j3aYYwz4Aywn9oRIlqxjnbVOJZ5fW8lHByuOV4IWAKiGdlrBkwU1rNDHBvVVkSR5Mpc99e1a9Duvpxzx18XtDPGgNTdzqdanneJ6prAI5NWHaZUhE3fRWvjHxfl2kSN79+qNXYafflzsyXp56RWXbLmvdMV5E4jdfphHG3yLcpeEl+tRPVPdC6bJmIX0dQMe6ZgocfIhtlY6j8yHJkVCFSduhDs3bCNQ6eLuhZBvYimz0ubqqoxUSJtaMK2Ims/fgdbBbhMTOcSXuoI4G6LcHqFgr0U/2QQiHv0gg==; s=purelymail1; d=slashdev.space; v=1; bh=WkHo0aQ7WeFoZaQBbpw83WHSFVnJduHAqSvqUeOJCQQ=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=s8NaQIOBsv+hwBKQ8p1dupPWfGHNnDoIB+2mvWcFx2Q+IqHufByFXhdBUNT4qRFCjdU24T2ZYeORkoJxAnBdyqNEUt72rA8hjz1kOAlNmwTptyfP9g1hH+Um97VxipXXQfKT52ZMc6X2w8vPbqzDWXJdwbc8vIiPhdzQFjfrI6/osQ7IyIYV5FtxwmBBeOEx3sd8mcDxy6+topADRCefT3nxEbi5mzL64df9U7PRZ4Ffc4N6cOShR/WOrEQPfnhghOjVA5+jH23v3GtxyNQrWtwdhCfXkJ8cudxRpwBXDppkTn/wSxE/nBgvVqeqFcfJwBlZ9AloaRhXCBf/Prq7xA==; s=purelymail1; d=purelymail.com; v=1; bh=WkHo0aQ7WeFoZaQBbpw83WHSFVnJduHAqSvqUeOJCQQ=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 981976735;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Tue, 05 Apr 2022 11:45:58 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     avarab@gmail.com
Cc:     garrit@slashdev.space, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v2 0/4] various: use iwyu (include-what-you-use) to analyze includes
Date:   Tue,  5 Apr 2022 13:45:02 +0200
Message-Id: <20220405114505.24389-1-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331194436.58005-1-garrit@slashdev.space>
References: <20220331194436.58005-1-garrit@slashdev.space>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm sorry about the half-baked patch of mine. I initially noticed that
the "hash-lookup.h" wasn't needed (which was a correct assumption), and
then went overboard when trying to clean up the other includes.

This is truly a rookie mistake that only wastes the time of everyone
involved. This won't happen again!

On 01.04.22 10:07, =C3=83=C6=92=C3=A2=E2=82=AC var Arnfj=C3=83=C6=92=C3=82=
=C2=B6r=C3=83=C6=92=C3=82=C2=B0 Bjarmason wrote:

> ... For anyone interested in pursuing this, I think using the excellent
> include-what-you-use tool would be a nice start.
>
> We could even eventually add it to our CI if the false positive rate
> isn't bad (I haven't checked much):
> https://github.com/include-what-you-use/include-what-you-use

This seems to be a really nice tool indeed. I wouldn't be comfortable
adding it to the CI just yet, but it did make it considerably easier to
spot includes that could safely be removed.

I think we could try battle-testing this tool in the codebase to get a
sense of how it behaves. To start, I added your reference-command to a
script under "contrib/iwyu" and ran it against the files you noted.
Before breaking a bulk of the files, I wanted to make sure that this
undertaking is headed in the right direction.

Feedback is of course welcomed!

Garrit Franke (4):
  contrib: add iwyu script
  bisect.c: remove unnecessary include
  serve.c: remove unnecessary include
  apply.c: remove unnecessary include

 bisect.c             |  1 -
 builtin/apply.c      |  1 -
 contrib/iwyu/README  | 33 +++++++++++++++++++++++++++++++++
 contrib/iwyu/iwyu.sh |  2 ++
 serve.c              |  1 -
 5 files changed, 35 insertions(+), 3 deletions(-)
 create mode 100644 contrib/iwyu/README
 create mode 100755 contrib/iwyu/iwyu.sh

--=20
2.35.1

