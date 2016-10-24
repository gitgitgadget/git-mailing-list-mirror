Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667A020193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938853AbcJXTYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:24:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15294 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934309AbcJXTWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:22:37 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t2mQ24jZjz5tlP;
        Mon, 24 Oct 2016 21:22:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 37812529C;
        Mon, 24 Oct 2016 21:22:34 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not
 inherited by child processes
To:     larsxschneider@gmail.com
References: <20161024180300.52359-1-larsxschneider@gmail.com>
 <20161024180300.52359-3-larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, e@80x24.org,
        jnareb@gmail.com, gitster@pobox.com
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <10135d1c-d9a7-d4ec-438a-bb0a8f6762fe@kdbg.org>
Date:   Mon, 24 Oct 2016 21:22:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161024180300.52359-3-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.10.2016 um 20:03 schrieb larsxschneider@gmail.com:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> This fixes "convert: add filter.<driver>.process option" (edcc8581) on
> Windows.

Today's next falls flat on its face on Windows in t0021.15 "required 
process filter should filter data"; might it be the failure meant here? 
(I haven't dug deeper, yet.)

++ test_config_global filter.protocol.process 
'/d/Src/mingw-git/t/t0021/rot13-filter.pl clean smudge'
++ test_when_finished 'test_unconfig --global 
'\''filter.protocol.process'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig --global '\''filter.protocol.process'\''
                 } && (exit "$eval_ret"); eval_ret=$?; :'
++ git config --global filter.protocol.process 
'/d/Src/mingw-git/t/t0021/rot13-filter.pl clean smudge'
++ test_config_global filter.protocol.required true
++ test_when_finished 'test_unconfig --global 
'\''filter.protocol.required'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig --global '\''filter.protocol.required'\''
                 } && (exit "$eval_ret"); eval_ret=$?; { test_unconfig 
--global '\''filter.protocol.process'\''
                 } && (exit "$eval_ret"); eval_ret=$?; :'
++ git config --global filter.protocol.required true
++ rm -rf repo
++ mkdir repo
++ cd repo
++ git init
Initialized empty Git repository in d:/Src/mingw-git/t/trash 
directory.t0021-conversion/repo/.git/
++ echo git-stderr.log
++ echo '*.r filter=protocol'
++ git add .
++ git commit . -m 'test commit 1'
[master (root-commit) aa5dd37] test commit 1
  Author: A U Thor <author@example.com>
  2 files changed, 2 insertions(+)
  create mode 100644 .gitattributes
  create mode 100644 .gitignore
++ git branch empty-branch
++ cp 'd:/Src/mingw-git/t/trash directory.t0021-conversion/test.o' test.r
++ cp 'd:/Src/mingw-git/t/trash directory.t0021-conversion/test2.o' test2.r
++ mkdir testsubdir
++ cp 'd:/Src/mingw-git/t/trash directory.t0021-conversion/test3 
'\''sq'\'',$x.o' 'testsubdir/test3 '\''sq'\'',$x.r'
+++ file_size test.r
+++ cat test.r
+++ wc -c
+++ sed 's/^[ ]*//'
++ S=57
+++ file_size test2.r
+++ cat test2.r
+++ wc -c
+++ sed 's/^[ ]*//'
++ S2=14
+++ file_size 'testsubdir/test3 '\''sq'\'',$x.r'
+++ cat 'testsubdir/test3 '\''sq'\'',$x.r'
+++ wc -c
+++ sed 's/^[ ]*//'
++ S3=49
++ filter_git add .
++ rm -f rot13-filter.log
++ git add .
error: last command exited with $?=128
not ok 15 - required process filter should filter data

