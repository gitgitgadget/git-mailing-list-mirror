Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F237AC43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiFLGB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFLGBX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:01:23 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B269487
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655013640;
        bh=DjIUeAyeqCO7Q7yWsrllZTNNbMZJkJ+kUOtBbIHhepA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=gFQZQzussR+6PrR313uXDOvQ2jgyO1AJwlcrgGMzYCVJKghHvlavY4cxZi3g0qvVt
         QHvOaXnKgqJ7SfXs0s71hRDOr/X6Axt6FUUflU7/hcUaLpy8tvOpJHjkkS4qNNJUcU
         3rpUwkg/wZdxHHypFo+bEGK1iKcXUyS45bX1N3gg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1nQOCc0Gso-00az4o; Sun, 12
 Jun 2022 08:00:40 +0200
Message-ID: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Date:   Sun, 12 Jun 2022 08:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 0/5] Avoid spawning gzip in git archive
Content-Language: en-US
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.145.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ykfVihD/wXOxOn++Ff/oV2xCtNf+RtNTYHb4B6mCOknBR6sCY1m
 VcnVWlgbnHUKUuZ4WIYUAoY9NLevcpA7d78wjzWkekMwJ5MowjU9Od40BtjnNku1ua6GRN1
 65WAAx/aSZxUFy6/fI0RMruhKvsx4ZZUBfCRSSUKlkQDoaRnYGc2R3UFasxiU9uzwAIyvTJ
 vDFM0IRBalXKrvE5huMlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gnjRZ+QVT6I=:djs3DaKzONUpBNywaHKwjT
 EulytHqdX87T7mE0MGS+mmemRyhHvqPbMk1Lwvc5udPbx8ETZ99mAVEc8pc/QWp1TbKzVbiek
 w1gC/RekD2HJ2lYG80YviPBg3PSWE3s2gNIyqttsEOA/rnVyrWMIgRVWYyeCqBR8wdutLrp/n
 wbSLzFYjJHqVWkxsU13PNfGTI9lHHvlrMPRYn3JUmLPbBWWijmJd8qj9J6kNmg8Qnc7aBt3cp
 MBNaeEnEH9OEweU35AxM8ih8eghSFkG6fkU6fe9Rg4Bl5eymiGOIiHc8SVbbqrxXAINWOimpX
 uv8fHun9+kQebqukIo/JuDet1RnP9vfUnccMZzf4DF1eJJ7/ARGVQ3AXVNv6d+X4P3NY3hN3O
 mxM6HRI4dDmOH9HdYJMS16Q7OdkLCSvI2w56HKNezlWyW/by9ZsfGhnDdoRDn/RldQ7vikiv8
 BzPghiNpZg7R6ER0Wha5Ymo9pSEnyAk55GR49Wv54x0QlU0zCiDvTG23jNZYK61X3ZPal4twB
 deXzoA5eX1BG9jKYVSqi7m0MqksaRwFXBYGBnOwDcW4HBdjIlVfR7oG6NhvYqOaBR4mZrVpoJ
 5XXh1seiq2JWWPohPQnA2nYv1MPhLZ0Pu11ITeBdMEnLzZ/8qIqFrdCW2jzcFYdQSpkMY9bFG
 N1TQavTW2mm/0lVrqShSfuKANoshXBT6W304yz6lI0dJqjrMf3kTyfIBI9axG3+BfahEDDaAJ
 wwmfiSZJXaw5xhiKHi+PJ4/0kBkXpmHH2uPGyW+aTG0E2t59qDLmOgGlH1/R/kueCqJBu0EUw
 fYyLkoUj85V4b90R4nGl+Pr0WV1T9iuVB7T3+kboT4x2g8km0hL6RJncM7EMncJksuGtMKFoP
 DEUcjFrsxdQNfpkijYxW4pWC9VBaYYYjdyUHrAQBZ4a6f/MoouV1fa1UDqIeXODDcG/YjoMiM
 PxLSXmIaq3PhqKimGp/DcWGPH5pkpXGC18NkF5W+uZOwGrHubg+/zssGjBKM7DYnRyxLre0hh
 NjRyhWdXmBhJMIDFeryWEndLmY0AL+1ZLrAiD65RBTPYPDB9VamAN/jwDc6qZAhBIvwCXKHrx
 vY/OItcmt9XYg2+2BDdgVtXLUZzRT7zgOj+
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a while, let's try again.

Changes:
- Use our own zlib helpers instead of the gz* functions of zlib,
- ... which allows us to set the OS_CODE header consistently.
- Pseudo-command "git archive gzip" to select the internal
  implementation in config.
- Use a function pointer to plug in the internal gzip.
- Tests.
- Discuss performance in commit message.

  archive: rename archiver data field to filter_command
  archive-tar: factor out write_block()
  archive-tar: add internal gzip implementation
  archive-tar: use OS_CODE 3 (Unix) for internal gzip
  archive-tar: use internal gzip by default

 Documentation/git-archive.txt |  3 +-
 archive-tar.c                 | 79 ++++++++++++++++++++++++++++++-----
 archive.h                     |  2 +-
 t/t5000-tar-tree.sh           | 28 ++++++++++---
 4 files changed, 93 insertions(+), 19 deletions(-)

=2D-
2.36.1
