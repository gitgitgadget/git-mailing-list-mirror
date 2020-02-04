Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCFC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C03D2082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GE0PgXno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgBDVMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:12:15 -0500
Received: from mout.web.de ([212.227.15.4]:35519 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgBDVMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580850729;
        bh=InT7BiZ8VIIcfIwRwSsCKNYHxWuS9mCCV1Ipzx8r4Fc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=GE0PgXnoZmij9ZKr7NbZIEHAHT1VjIcM8eaTY43d2HSCTHxANj2e26cAO7wvlV3Ly
         e/l6w/SldRbTDioGbr05v5yr+EAhDXXYZbhUJMqVoLSzuiYeolJo+3lo5u8Wl0xkm1
         OVhyjEm1zFgCk3ETR2tqFHui1L2ao2qa8st9v+KI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LshXV-1jeQnA0mfx-012Dmy; Tue, 04
 Feb 2020 22:12:09 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 00/10] name-rev: improve memory usage
Message-ID: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Date:   Tue, 4 Feb 2020 22:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i5xaUzU6Uwb/H4wpd1iok1lH9+qwxFzV58i7ZpzFotihV+1Z8Fc
 WHPTEZvBTtIEBZL7mGl2J5lSN+kQuAVWQ31YqJJODeRtR6IrJ8SJnm9P6v5I4cJ+M10mmTl
 P2yZRxbFYuU9EWHqacjriH6jVsBOyxVjko/CcVsN2UdCYX2uPyXPBcwzHXgvKD3yZ9pXDqi
 Eno0xUkCOigKY1QrT5/Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHybbFFVhpY=:wYaTpI595vNB0mH5VOi/6u
 Ouw06KP56p5RXWZrJPmPUJckYgi3VlhY3xE7cPR9eYUCSSclaEVynR6pV1iyR66AxtIoGda+I
 Us9vfCvT1J4VfbnCa/V/7LfRCxScqZIWXB4wQw3QU6TTaeIGclkVwUtoH3E5pqxlDbRrt7PmW
 /Ldq9lh811JvTcMKlzlcguZE7nVUeFmvpMx/L3zjk0lMniBOyY7pQW2sdUA7v52knj60iKU7H
 EafNXTTFtzd+tlHojbFF7ZZdTVd2o9Y9badJn1ChOGiNtUFEV64ANf4E0TKl2UfgoKvmaUAbm
 +hqKkUKB5xJ6HZRnaR60Hgn9b8JovdWgE6Won7C+q56GCA9fcTIqhTLr9t6S/BWovTVp03hJG
 h8rlLSO06JmsAywboK5Z5IGzeT+a6fhU9lT2NJ69q5GA4SB8PuitPQgu7pJ38ROKT+bYML+ez
 ym466kUFxeeqYgV8MW/bJ5KPzCusA22zAZwIAbJBez/3lUOVFu8IUB/8y+KEEyCK7Ez1Yqocq
 vqe4OTvMGzL31XtG/xpDUSL0Yqp7qy8hguEEQ0bWTJ/om8I49M2K7IjKZCEOWXDZRm1fZLpH/
 pAGDd8QLSYiPRc8UFVKxG3IVSDqBCy9z8D55cstfkUyRqy3Wkc3QCoYJfqxTvaUGN//6qzwIE
 Kh0Qa0KV1ZXVetWfJrTcN0ZHg4qkFV5FnogmlI8KQZntPwD2TPgCc4HO4B6bCvMVeZJHgMpYX
 YESPYwKlbRwwz6R/+fc56oSpB+LiE52+3V3wlGFifh3lbIKEbnHXSyOOr1i7vRs8y1zMThKZ5
 7gdbPhXdeDXz2RXOpSnCrBiudtuhGRgIUTG/apWHAEvr3TIq3LNFIUfO/r1klOrcA2igEYDHm
 aiB63PIr51fWowUmM5iPtsius9DjSO49heWmF9ZrRQJeCTeR6Px9xDv9GxBr3Va/Ky3uTBVkf
 05pBCBCCFd7wqjWh9MeTskGQUGYy93Ie+2krpYNEAmXwz09YQk5js11WvcVsVmmywoZd1joVs
 WN7oMrihqZgla/1BPea+N5n5ojzx3+uEoIxAJzSrE2syHGGTwMPDmN6PL7DD3rkmvxOLbe4NP
 ZfLJuT36V4Ct38fysIM48Xhk+AoUZoNgKpXt7AcmvEseyPt9C4jjYArivUTg5teTX4GC5q0jV
 o5bEOsHHicWdyca1UdQTXdRw38qfgdxJ0G8xTMPBVczcrgg28ws46A+33izAmcBANaPXkx36f
 B35vZJndB5NiADNNP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series seeks to get reduce the size of memory allocations, the
number of reallocations and the amount of leaks in git name-rev, to
improve its performance.  It starts with a few cleanups:

Martin =C3=85gren (1):
  name-rev: rewrite create_or_update_name()

Ren=C3=A9 Scharfe (9):
  name-rev: remove unused typedef
  name-rev: respect const qualifier
  name-rev: don't _peek() in create_or_update_name()

... then plugs a minor leak:

  name-rev: don't leak path copy in name_ref()

... and gets rid of a level of indirection in commit slab usage:

  name-rev: put struct rev_name into commit slab

The next two patches eliminate reallocations while building name strings
for parent commits, which can make a surprisingly big difference in some
cases:

  name-rev: factor out get_parent_name()
  name-rev: pre-size buffer in get_parent_name()

The next one avoids building names that are be discarded right away by
checking first if they are better than a possibly present other name
assigned earlier, which only provides a small speedup, but is the right
thing to do:

  name-rev: generate name strings only if they are better

And finally a tricky one whose commit message is a lot longer than its
diff, which adds a bit of overhead and which probably needs the most
reviewer attention to make sure it won't cause double frees:

  name-rev: release unused name strings

 builtin/name-rev.c | 133 ++++++++++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 57 deletions(-)

=2D-
2.25.0
