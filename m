Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441E51F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 23:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdAOX4F (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 18:56:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:58176 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdAOX4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 18:56:04 -0500
Received: from [192.168.178.43] ([188.108.244.57]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfAog-1c5LOF31MQ-00Op56 for
 <git@vger.kernel.org>; Mon, 16 Jan 2017 00:56:01 +0100
To:     git <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC] stash --continue
Message-ID: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
Date:   Mon, 16 Jan 2017 00:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OOJBwKhptYBK8RF/TROEJ6pyOG/8Fs1ICRZmI66DtIciDbP06YZ
 0DlwgXx/LdLvRW+u4gWPHApQJkj2h3PGVIJBwwtydp04ogkAnp+oEVqVqUs+ntohxpDW2ul
 VESQ0bVuAwHD0e3VEfOwDAkmMRf7DesorMyury1531CsCcar7DJ7aC/qqkppwolf9a12Kd3
 OLbjblkcDYa3izoTFntYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j4n82mhbCMQ=:FJ8cYlha8dJNHmLQHqnFjl
 smu2d5pvFCSZfGG0cYXrrFtVQRdZKH8138/zNez2ST8sAV+DgbsaEnnHvF4je+m985EPMNxwN
 fxaEz6BjFZKD7GP1EBsR0z/8BeCS5eTmgfgjZ8FE9LT0qqKEL+QBgMP4cpxWxoIW5W140YuD6
 +hbyRQp/dhB8hwefiYo4uTyEP7pWiddXiyzYZ6IeF66xL69CuVLS2Z7QTz7pY5R2q82Q6nq5O
 D2Ddyd2D2P1M4ENjIaUC53zpOWeH7TNaISu41j3XXZlasbPnG25EfWf7IE2ev5L6lXLlYRxW4
 ZuYVzcAOcX0/Rh8FeizXpdIhZ39maVML6Gng4L0vd+HZImH3D32mDaX7+yZu7YLPw/89jgaiA
 uPRe+sfmfc/WSaKT/dddAhyIGRNsvEmoL1cggBI8TgHZ3Ja3bIB2TvpXyW5AGD3VEywFVzzxr
 J13V0vrjm783zlZYWleqEXgm9j7ZTw+gKaM11o2QVIB9FG+lZY4UVw8YkTFcWZSrf9iqfT9Bh
 6SDQfAruQFYj1qAE3LZwpn0i0wJleBMF0iw3a8L0sSQ5JYofLbwRzuLPGsG0VWh1DGp6ZbbY6
 v2SP/5l36hPUm4af9HFsXYdpYR9lYHwC4g4QmtEAu/jU4I6lff90dyAw+mtAOuh+4ko6lgqTZ
 l26vNtAmhRXnTPF4b4n3dSZlaJJaHn71XvmxLryaZ+i9vogbPGTBiOtWAPKfLNq406+ezxlOx
 irJzTu8DemoJsiRQTHAKUmVjK3fW5K3axBNSQWsJVoLJ+1Ar74M/QMZPKgYrg8of6gCaI0cqp
 za4ap0L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

a git-newbie-ish co-worker uses git-stash sometimes. Last time he used
"git stash pop", he got into a merge conflict. After he resolved the
conflict, he did not know what to do to get the repository into the
wanted state. In his case, it was only "git add <resolved files>"
followed by a "git reset" and a "git stash drop", but there may be more
involved cases when your index is not clean before "git stash pop" and
you want to have your index as before.

This led to the idea to have something like "git stash --continue"[1]
that would expect the user to "git add" the resolved files (as "git
status" suggests) but then leads to the expected result, i.e. the index
being the same as before the conflict, the stash being dropped (if "pop"
was used instead of "apply"), etc.

Likewise, some "git stash --abort"[2] might be useful in case you did
"git stash pop" with the wrong stash in mind.

What do you think about that?

Although I think this would be a nice-to-have feature, I am not totally
sure how to achieve backwards-compatibility, i.e., such that using
--continue is still optional... (I think that "git stash apply" would
surely generate auxiliary data in case of a conflict and --continue or
--abort would remove it...)

Best
  Stephan

Footnotes
1. Perhaps with a better name, because it does not really continue.
Maybe a "git stash conflict [--resolved]" subcommand?
2. Along the lines of [1], one could use "git stash conflict --abort"?
