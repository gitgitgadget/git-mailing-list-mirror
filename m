Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17344C4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC6B2225F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 09:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X2DgRC9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509430AbgJVJMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 05:12:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:39995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509411AbgJVJMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 05:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603357949;
        bh=PqVtpuTvwSMotH1wkRq9OpW1vC6TcGNXnwtgnsKf/VM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X2DgRC9Rck7ZO/JZLwQi4mrO+SuM7i9fva29WGIKVcg9yKfOgHW+3FuqgpmZQylyu
         8ofGepWPkxYdRHBt41KW1Ftm6UUgLID1FjCaZ1zq9bzN3HJdkUvcXEdHuFm/NM6wgp
         D3DCskjJE3q37qvHUaQhtrG9PgEa9SQ8EMCNe4Fo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.45]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1kfSGH0scO-009ytM; Thu, 22
 Oct 2020 11:12:29 +0200
Date:   Thu, 22 Oct 2020 11:12:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: remove duplicate rollback_lock_file() call
In-Reply-To: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010221111320.56@tvgsbejvaqbjf.bet>
References: <pull.894.git.git.1603286675709.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RXHJ+uU5kzMQ2os9toL0/Urrj22DsJhlhO3WHieg9UkRLZxfgTT
 rZwJO43S3v4eOp8yl3JCsJbrrcpKs9K3tzVe6dWLHXPzp+5Wl4xe+rO9YucNYUwO604+Kbj
 JFwZLTfAwyNO9ntNQY5BkC9IgdNRE7xR+8/exoehgSa0kWNdLPOOxssUto1XD32VhlXwu4i
 V7D2Pw9qlHH70pX9ceeGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SF1M3DDuTUM=:CPfTaw7ipPnMbDil1HcjtL
 uT4i3vkXpL8Qbe0sHTq1/XyBaMZB6J0sMu4d/SDeMs7xdSF8a7dBE9ldtDgRA1hRLTdp+eQN1
 V+TMHHNSGXM5GTe/GBvwUvA3kNqUDbRR2srQKiQ7swvRt3k+pyoVf11OgbuDOrNPZazmZF9L/
 EmAZyEKZFUodeqEd0cbpTOQi3ymujDrGgAaD4FCcMPAVSNU+x9rRCoDC5iLlC6P4P58FYOg/K
 xaJXzwf5IpwpK2STpARsm5soqk3LwCfDdikrAeGdB9rxeR54IyDDcV+/KZu+WLL8JA28LgDuU
 y/RO4xc8LUIzvLF0iDdV8lPNkWBgb8gYhloBt5dOqSv4uwDhW57YMnyC5xZmPClfC3ajXy3bo
 YB5bdNQlzje4S7u3FntleE7C9EoWI19QdxUjfmlW0qiaKRkAmXpEDrUQmn/kNkKjsflrAZ7Ik
 OQsISzcFrN1tQANGTuTc/zJPiUXn9Ebg09fy9QoC980/d/2/Itw7GWEM/1s6QshpDAG11al1W
 jEAJRbD+TOjNkCi5/KbzwPpck45LFtUtQVTQ622SGzvL0BF4JDHC6vpFtytIj2xpamy5F8YlI
 ukb+vXjbsryvjjTGtT02XAyEE+qcRk7F9akuDD/gLkbDwlAmEXBJn+72RD2z6VV8UUwbWPkLJ
 544iqw+JqyVs/q4bXmWnCR6f6Aigzv+YqK8F0bcxjNePbnaPXOzwq6H8IK0AjQBEV+9GdpK+2
 py1gQVzg0UqJYeVqzIHtX3+0Fan0eydsz00NDhGDxFsCvvl2cHZ6u+OID2t56lILQ4q878dpu
 wo+5QO1NWAq+2LkmncMUzMaHRxNSwMc0jkW6HP6OiQo0a+AiTByblQziEESbjsyKs+i6aIj6b
 y+XCdNdC5vcWn/VxBWjfN87jIvTVx9mc0UGvsL0dA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 21 Oct 2020, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 2b6ad0f4bc ("rebase --rebase-merges: add support for octopus
> merges", 2017-12-21) introduced a case where rollback_lock_file() was
> unconditionally called twice in a row with no intervening commands.
> Remove the duplicate.

Thank you for cleaning up after me. I _know_ that this slipped in a couple
times during my rebasing, and still, this last time it slipped through.

ACK,
Dscho
