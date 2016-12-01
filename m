Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658F61FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 16:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbcLAQYg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 11:24:36 -0500
Received: from mout.web.de ([212.227.17.12]:64397 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbcLAQYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 11:24:35 -0500
Received: from [192.168.178.36] ([79.213.126.9]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpf3q-1crseD01dW-00fOdX; Thu, 01
 Dec 2016 17:24:27 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] string-list: make string_list_sort() reentrant
Message-ID: <3083fbf7-d67e-77e4-e05f-94a7e7e15eba@web.de>
Date:   Thu, 1 Dec 2016 17:24:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:tWglIAcNIYvp2wLtWwijQndffrgSWLhKCbolX3XZbmY7Cq/v5x6
 Jrqn2ozKmsfFDg+C7Ks69cN1QUtwYdnI4c/3F5QBWy/grDZm9Hxc+y5NpaSVc5tOw/r7baZ
 +fe8uxs+TFSncrUsMB/B5d3e2Rq3xop2zsgyTQ0NQL5y+hzIbtCWwvMh3kL48GL9jswvvSS
 EzEQ5WmlcV3R8lliDlxkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O0ACZxBDuPw=:JE0o6z15NKDv8fpKb+zA/A
 5A+AC6KSs3EJqMP8HKOL5wRVC84eruTqG2o9tkpfGR7NKsnriQetyFulF7Yk5OiJjgaeVclmF
 swRber1FnskTpXf1fWliodye1PM6SatTsAxHlybntHh8IoUVHaIkooKxzGM3E+qlzJeTfwZzI
 wiyBfsCZsC4Uqm6nIoNVUEkr6SBHUuAWhNS9Bk3EFlUQD307rKJPJ9noT4q7MQGOs0jT6Chbu
 8grujT5OrpGq0OO7RnmgVzL+hWZ+7NTsB5e6XY2sIXsQO4qBwxotMiwrz5oCVAmr2UFYbm6X8
 UhHs1n8ImzLvGKj4NqfLVPwH2SvIdNILFM0kfABi2Dq6Fy1yv/sPCLU/al7+TryZ1s/6BC7rD
 4IUF6KJdZ7clH1+93lQuiUIOgKQ6W9tubypMcGMAQdxlDYuQfohx3azElyuenXPM7KaPf+03D
 GxYKARTTd/Xpc0B1n/6ZIlQxVdsJfbYa7PszIsLJlKQH2/FXUAHZ4ZTtmEfbeBp0Pez1Wuj3c
 Q0RcwKDUCDu7IG8CFPB9O4kx4+CL1UWxL2nTiDRPMjcZFiPhQixeGzUvxlr8/dXoF6Byo3aGc
 /iQLhrjNxo2uW/Ij0eh/GssRO3xT5CqbBBjTw81U9YdAqWcu51LpaTh/AEZt3SR8FZcYDcdPs
 Zlvzb5eVxYUlMj3rLeddZ4q/Q2J8DTy0ereLAUv6TKI7M3VDBqB5KTrFq1RaTYmH6hhcnYE1X
 k+mJQ2EYFKgJo+hEe6lcrI1721Uv9FY9tfT51hzu/ZzIQevzmWKk3tcYHfZ5jbC3RC7cQ/XzV
 5/Fwqqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use qsort_s() from C11 Annex K to make string_list_sort() safer, in
particular when called from parallel threads.

  compat: add qsort_s()
  add QSORT_S
  string-list: use QSORT_S in string_list_sort()

 Makefile          | 10 ++++++++
 compat/qsort_s.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h | 11 +++++++++
 string-list.c     | 13 ++++-------
 4 files changed, 95 insertions(+), 8 deletions(-)
 create mode 100644 compat/qsort_s.c

-- 
2.11.0

