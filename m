Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5882070F
	for <e@80x24.org>; Sat,  9 Jul 2016 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbcGIHYL (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:24:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:65365 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbcGIHYE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:24:04 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MQ2Wx-1bR1Xv2oM7-005K43; Sat, 09 Jul 2016 09:23:44
 +0200
Date:	Sat, 9 Jul 2016 09:23:43 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Naja Melan <najamelan@autistici.org>
Subject: [PATCH 0/2] Fix xdiff's --ignore-space-at-eol handling
Message-ID: <cover.1468048754.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JzNPvPSnRyLL3FBfRnZCFwt6ZP7A087KJhg9RQC1pAEX6thDGjN
 /Q5Hcshhxjo9Z0JCjT7xXcDLIgLAVD58jd0bh6hlfiBkfj0xCmGHqS5vsM0hhX0yDjVNl4Q
 SFLzFBYKNyLMbcfh38OUMKa44aDOVL6ZqmHFVXmt6hbAONjcHgO2SXk5ZviF9IAEf8jg9rX
 YJfRUaNkRvoaxjJxfJLoQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:5siuWyOQ4lw=:cUoNHUlQtPwK3aepVBTW1a
 TU5faUChXLfd8vomKNCVHUjjhV/uz+IZ8QkIr0TL6Qm1EtXgkbJ0de9ht8u8GrgNHMyreNR8v
 ldCy/eI7UVkohueM1dhZ+u4mMyBCy8HSrriQJONNLMyeTyj/HabpvNjNZC9bHVAWEEd/Rcrdr
 TYMHm6Pk51hJEcFHOdToMwjL7QrqiHQmEe5EXMxAIoHgh+w0YfAlk2lbcXJeHX9DWHUFGmIN0
 4a43ewNSpDtyNjbDbKzNpL58iBMxwb/GZleRWkogFy23vJK+HA0Bot1bJ1RA35v+FABJ4B4v0
 9TmZnZ59C34d7o5omXQEzMDO8rKJhkwt62Giq1G4VjIsJv5DglRo2g83floxdKKUD3kSaqVUD
 8ONd5G+6wihsWsbU0YopAYQrDaYfwvfnBDoftiJL+pRR69nn4CFWSzrPPLmguRtDrV4Asx1FZ
 Cd8mmCeZpdi9KnryO7dKnGeAHzLzt4oyTzHgxXznDGYRF62cj6GYCATHJbPJpb4g2ME34zoW2
 WrxHBhCFiPBoDM6M1JUaNdmWwcoHHkiHNj791LQ/sOKhk67E+o+iTEj1rQeSUCgUDfHKjHX21
 2O3eow5u+KwT49sOgDWwEpdq8NQN4ubhYIZPZ/S6XH4ktWlnk6bJ8VujMpkyDvbMs8XRVZvi/
 NapaWRFXd6QuGLNzXDWFoaPUxxooUoyCW/RtX/3ebM3rtYudQvyUOUu4OtCaBM2GtaBWG7m+A
 N2dXI3NG9NlKwkIqP1g6B4SrQMPPKSFYCnKeEAQ9D3luC+lzHVldfaJv7jCjKTSSc0uSH56WB
 jnEdzaR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It turns out that I am not the only Git developer capable of producing
an off-by-one bug ;-)

This patch series fixes a bug where we ignored single-character changes
at the end of the lines when trying to ignore white space at the end of
the lines.

I split the changes into two patches because the fix turned out to have
a much broader scope than the test (which demonstrates just a symptom):
the bug was not in the patience-specific part of the diff code, after all.


Johannes Schindelin (2):
  diff: demonstrate a bug with --patience and --ignore-space-at-eol
  diff: fix a double off-by-one with --ignore-space-at-eol

 t/t4033-diff-patience.sh | 8 ++++++++
 xdiff/xpatience.c        | 2 +-
 xdiff/xutils.c           | 6 ++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/patience-v1
-- 
2.9.0.278.g1caae67

base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1
