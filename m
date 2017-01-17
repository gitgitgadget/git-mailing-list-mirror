Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6718020756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdAQVTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:19:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:52157 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbdAQVTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:19:24 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfmZs-1c6ad52Ac8-00NAZK; Tue, 17
 Jan 2017 22:18:59 +0100
Date:   Tue, 17 Jan 2017 22:18:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: [PATCH 0/2] Fix remote_is_configured()
Message-ID: <cover.1484687919.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DYdNyOxPPtEiMGqIqsX/JaNn0W4WW1gQ4PtPDXCBQbWvmRgN0ic
 UyjQQbg/OTdaeLUsX1UcBqccWY/HjZj2e8P2nvjFJL4y5KcoaV+haE4S3Odqnzjc0Lqwe4D
 47emEh6MLCvN4qYhvI38bIo8rL2NHXqbFjxUAl9UhoFZcBSOoGpkdkSw3w0V9r0iZB1zqzJ
 s0LeNmWHXN2JgD205JDQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fQMh/p+Lims=:FWKMr1xp0auNRRV9AeO+Oj
 Xm/4Ob+6OxEaGgu4oeP/VnN706xxoVZ1JbgKq9E/6UgTxArnWMctb3AQztyk7Y3Arj3AY2USW
 VkDWhnrQAHXzCYtBekqu86bWEPrtrU64B2HxW9eYjzMVjUuAHEUBBhgdYw9/XbbG/nKtM9Ky7
 loyIZzw02p+ClIjKXaIQ4em1RndDnPiUhn21zUp+IuwYMgQB1htY0zyOCZlMKwWRGDyABKSEU
 NnPtJSbpaBrH4o95Qf/lDOZUQKFHGwH8y12PUidBYe5UhPuwdR5g1pVEADpJ0y5lpUN9z9oV5
 79XfEFXvv7g6XouKWZh0k6/6fCSMefAFZKQNMR/r1M3jKfJb8cPN0wVnMToymJjhG1izo+AdU
 ylOWQgtmwX/drpfZLpnDiYCpPtVmgtlE+lR1go7ugubLfXIwpLHJK0xh8HBrFou9AtEXQl+xV
 8Ea//bm99WNrOf8YJHZvJ4Qi28CF5txlVZBqAE5ule3pnwZQSdMmMUmBh6sx8JVyJEqJ63Z8C
 GZu8mvbtTkOH0rjWRam9Oh0WCaSYNUxYAP3UWlEYEbNAewXhDzog0eWA3RmiJSngNNRM4iOkE
 51PW3Yttn5EhgfBfPO3K3Ij74rBe7E6Q5LQvISiuPBd+dexia3CA2g4vUasBB44CSde2ZLcnS
 4zrtRTVkolKd94Jr+H+bibYrWzwdy6pElgHQ5psxfVni8y4gJKvKSc5GyKJsVMyq1LuduEV9T
 kHjhAss8/CZ1zgGWqXJCFWk9EecrakeF+yplNktSuj0JTCWhjmMzHkOqby1OemlK8s3SWfrAR
 XQje0jx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A surprising behavior triggered the bug report in
https://github.com/git-for-windows/git/issues/888: the mere existence of
the config setting "remote.origin.prune" (in this instance, configured
via ~/.gitconfig so that it applies to all repositories) fooled `git
remote rename <source> <target>` into believing that the <target> remote
is already there.

This patch pair demonstrates the problem, and then fixes it (along with
potential similar problems, such as setting an HTTP proxy for remotes of
a given name via ~/.gitconfig).


Johannes Schindelin (2):
  remote rename: demonstrate a bogus "remote exists" bug
  Be more careful when determining whether a remote was configured

 remote.c          | 9 ++++++++-
 remote.h          | 2 +-
 t/t5505-remote.sh | 9 +++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)


base-commit: d7dffce1cebde29a0c4b309a79e4345450bf352a
Published-As: https://github.com/dscho/git/releases/tag/rename-remote-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rename-remote-v1

-- 
2.11.0.windows.3

