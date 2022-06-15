Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC5EC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 16:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbiFOQyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiFOQyW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 12:54:22 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798745511
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655312015;
        bh=xAUU/rDgyFwlo8dmJ7cizp7H9FCs6kn2rA/i/2ydCtM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=LYBFU8OXKVmUFycb/E3/pY+iDGWWp4GoiM+GVuD7E68q7R5x8Lyw7aATG3xzpx/+5
         aCDC5HNtVf4HGAVY38q8Ep6W3ustZKRkz/hFEgvm1qleQvMzfFReS9t+cB5uAaNAQK
         a2ufg2/Gy5kKJEjsuO9FleqVx4zrYnGu4EyELsr0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQPdl-1oNseE32MD-00MS7c; Wed, 15
 Jun 2022 18:53:35 +0200
Message-ID: <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
Date:   Wed, 15 Jun 2022 18:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v4 0/6] Avoid spawning gzip in git archive
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
X-Provags-ID: V03:K1:wFw7Yi6J/zWX1jEgnDAzyqKOc7yW585/iVR6dQwW3qi6UwLfL+c
 MnD6C/SixYcSGS882wx2QNNGAU9rqFGT2+cL9M1qrZ1Kq62t6NRIUVbs3TjmYWBbip+2iQM
 XTDPcDegAdYgLV01BCFrfXWSCggsCQ2b85pzyhWeQORAO7K1KyGc8YNBIPD9CpQvfu1k8QT
 RkgXI7zzqJr3cQgUagKlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:25gnwSuYjVg=:FtE3WSU3cEB5OFc6IoBLLZ
 mNiHMapsWdOOKDksPUF1V0AoQ9UWqgb4gcAEeab4ocf4F0Xw/xlBMk4X2haJOk+cH3nFMv/DQ
 3MmSePqaAg42RM4Qudfj6s5vscu2C5u1HcS34Vz/z4M3Nn/Z1cejSh0QS0EcDuDfRQ5+bzODA
 pERsz4LYn5OxUfN+3XWgqQf6gkClgr3Db+Vq2VImSRxuNy7EJK6C8YgMLlaQpWfSe9TyqwUW6
 g2ABjuQ64ndNmCWDz7Dddc8hUJZuTnwU01l7yG/LZKLy5rY6qGr7ci8n7PwuojI5rKpa8P3Of
 WgrYwGy1YNu2X3uVCoGH7OJUikXmzPvQtVDW2qBQmSR1kfcc8/7RydXsLJ+gElkyIQ5g1XQgB
 8q7/hhmGSFl//zV5rO7PaBvRBRm7cJyVM005dsTQJ48ABbYsXAGpikPq/hEGd5E/s/hID21q/
 8koozmLHTg62/M6KMZmoPL+nk0tmJiYNfaEuHkBKfRoJlspEK1GdBY/jwjoRpiNBLyM0ufNIE
 pPu5ls17YxKcrSzY0PqJip2hDsJVtqSzzfx5psKWvYX04VpUlcLDDNxuxaCC0rkFJiSbVfFwA
 Jv5dlUxsfNoJyV1Rr6ulro9o7rKknAYwI8TAhpyIu+892oEyzN2SX0dfY6LsWjVvv1pvCPsio
 WqWss9ORoWjhuUfPxNIyixIKcRJnMoef1lxb0UrrGKP4ovCYZsG7OgjbIukjPy0bPn+3gjKLs
 TZbRuwSLR/A8T2MqTdoi5ixbWVIngrpvMWWpiLl8x5lRKCVx3dMR8TjJyw8rC+mhrHtLNpyBT
 dbL11E3zDGneHGLnJSWA54Bwv6inmFZy8n+p4XiVD+6UesH3sYbbtdv84nueLLDKgg92sEVNI
 8cs7FanDUnPjqcqoEqLKZOZYbc1phclgEBGH/UBU9QmfbnS9ujgsmamDdiY4TMFGqmLGO6KSc
 DIJOUAR6CCottbJbeMkloOzP4TFqnI/H7juwsUdVSpXUhbsA2PpWl30mK9kl7ZFSe01QjefBW
 yI5pm8EfXnMwiZag4dH7qDAt8SVsqvkO1YT4EehL3GG0Idr7Ucc77E1Q0ihv8Ca41KpuhTsnA
 vitfBMWtXvNkCStA+m/+3LFgZrZX4uhA9aN
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:
- Use deflateSetHeader() correctly, thanks to Dscho.
- New patch to update the format-related documentation.

  archive: update format documentation
  archive: rename archiver data field to filter_command
  archive-tar: factor out write_block()
  archive-tar: add internal gzip implementation
  archive-tar: use OS_CODE 3 (Unix) for internal gzip
  archive-tar: use internal gzip by default

 Documentation/git-archive.txt | 21 +++++-----
 archive-tar.c                 | 77 ++++++++++++++++++++++++++++++-----
 archive.h                     |  2 +-
 t/t5000-tar-tree.sh           | 28 ++++++++++---
 4 files changed, 100 insertions(+), 28 deletions(-)

Range-Diff vs. v3:
-:  ---------- > 1:  67369ed452 archive: update format documentation
1:  73ccd190bd =3D 2:  6a7cce50ef archive: rename archiver data field to f=
ilter_command
2:  352cff7163 =3D 3:  c86e82bee8 archive-tar: factor out write_block()
3:  4e7cf97631 ! 4:  6196b0e39d archive-tar: add internal gzip implementat=
ion
    @@ Commit message

      ## Documentation/git-archive.txt ##
     @@ Documentation/git-archive.txt: tar.<format>.command::
    - 	format is given.
    + 	to the command (e.g., `-9`).
      +
    - The "tar.gz" and "tgz" formats are defined automatically and default=
 to
    --`gzip -cn`. You may override them with custom commands.
    -+`gzip -cn`. You may override them with custom commands. An internal =
gzip
    -+implementation can be used by specifying the value `git archive gzip=
`.
    + The `tar.gz` and `tgz` formats are defined automatically and use the
    +-command `gzip -cn` by default.
    ++command `gzip -cn` by default. An internal gzip implementation can b=
e
    ++used by specifying the value `git archive gzip`.

      tar.<format>.remote::
    - 	If true, enable `<format>` for use by remote clients via
    + 	If true, enable the format for use by remote clients via

      ## archive-tar.c ##
     @@ archive-tar.c: static int write_tar_filter_archive(const struct ar=
chiver *ar,
4:  cb2bbe9f6d < -:  ---------- archive-tar: use OS_CODE 3 (Unix) for inte=
rnal gzip
-:  ---------- > 5:  19d286af6a archive-tar: use OS_CODE 3 (Unix) for inte=
rnal gzip
5:  5dd968ced1 ! 6:  74683137af archive-tar: use internal gzip by default
    @@ Commit message

      ## Documentation/git-archive.txt ##
     @@ Documentation/git-archive.txt: tar.<format>.command::
    - 	format is given.
    + 	to the command (e.g., `-9`).
      +
    - The "tar.gz" and "tgz" formats are defined automatically and default=
 to
    --`gzip -cn`. You may override them with custom commands. An internal =
gzip
    --implementation can be used by specifying the value `git archive gzip=
`.
    -+the magic value `git archive gzip`, which invokes an internal
    -+implementation of gzip. You may override them with custom commands.
    + The `tar.gz` and `tgz` formats are defined automatically and use the
    +-command `gzip -cn` by default. An internal gzip implementation can b=
e
    +-used by specifying the value `git archive gzip`.
    ++magic command `git archive gzip` by default, which invokes an intern=
al
    ++implementation of gzip.

      tar.<format>.remote::
    - 	If true, enable `<format>` for use by remote clients via
    + 	If true, enable the format for use by remote clients via

      ## archive-tar.c ##
     @@ archive-tar.c: void init_tar_archiver(void)
=2D-
2.36.1
