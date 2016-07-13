Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9522018F
	for <e@80x24.org>; Wed, 13 Jul 2016 18:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcGMS4o (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 14:56:44 -0400
Received: from mout.web.de ([212.227.17.12]:63941 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbcGMS4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 14:56:43 -0400
Received: from [192.168.0.100] ([138.246.2.138]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LqUbl-1aslTJ3kSf-00e5dg for <git@vger.kernel.org>;
 Wed, 13 Jul 2016 20:56:20 +0200
To:	git@vger.kernel.org
From:	Bergi <a.d.bergi@web.de>
Subject: [feature request] Warn about or prevent --amend commits that don't
 change anything
Message-ID: <d2c3365d-6da9-dd58-ae7d-4a2020c6b513@web.de>
Date:	Wed, 13 Jul 2016 20:56:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0anhikGfeKNpE0UuFXn6vrXKui2IlljrfsgHorZHTARhGAYZJGD
 F3k2oG50frEOCcIERgTyoW6K1H4w10vem9wmwH4Hon96FJMewUYMMt77ryzMz37aRyiL7Lb
 QeGD2FiC9mfdFyAgiEYn1bpQAcVn9VoPE+U3YkrwUnxWjZS9rtDk9pMzB2jT8tjLYTtyzwZ
 mIb38VQSXs+Dc3nR8ydkg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:chxXqb2RLXs=:VQYGv57YlLzt03OCzd/M4q
 RmG9OMO0agGQP2j5Td9a2uVEQ9KfEZno59dgzGQYaJi8v65V6gvRAJQPS/Oq+KJZWvvxK/p7g
 X20+pVZyMgrg8hgRAyhkrO3iPco9Pu1On4yWzwi1X9++M3CsN4B65R4YjtEYvtzQXsbZUYPGF
 z+uzW0T1ntWxATuxwEYh6PJbn+nSSGPjKy1Ger6CGqBvYYBPYvVoBG8m7vWNTgxZVjQWEwJFk
 FteH3tvRDoSnCBtOjs/GiKbwuoa66m8nEBlJfTezGXbHh9uGyBd7h3myJsjf5my3wrH42GdOD
 AsQ5Z6CRjjIx057TNO6ChGqk22DdX5mF5c0/Sac5z615krdzklTL+YSY/Z1qTGjm1epNDhL5J
 wKAK5CWdpoE3aCHC/Qe85wKH9Vww60tloBPp+FnqONTwdqwT1Rgyde60TAcTJG+0HUyHj7zuO
 XmpaXaAGCC2LBnpYVuGaXl6Bg8jDL5T8Vjn6AtyEP6q7s6vFFws1Tz8x1HS/moL+nr/7dQGSZ
 ytXHV9mHI2gFrcuynXj++QAkrJUxR2orIWbzQW62GhL8HzWD0H0A6izF024ajsjM3TUMThXis
 NwZiaqwuAYAZxu1WbY9Zbwq3847OZMBwc/Ebf26usMz0HhtZ2G60RsFG67TuDR1j/P8HHV8/X
 tS6O0aq78oZqSXmrWpY/qLc3RRqYprPlr+qY356X2lYBSSZno8OdxgwQBpxdiTlYNHn+nTppO
 NRrbFYpw0qFrbtsKJyYNCOsRYp/9+wqs/wLZvAsLRgqW3GlcbxV0zfq22yZe+3ukQurHZ4eu8
 eZu0ZDA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

when nothing is staged in the index then `git commit` warns about this 
fact with either "nothing to commit, working directory clean" or "no 
changes added to commit".
However, `git commit --amend --no-edit` will happily record a new commit 
that differs in nothing than its commit date from the original.

This is unexpected and can lead to mistakes. Without running `git 
status`, the user will not notice that his unstaged changes were not 
commited, as everything behaves as expected otherwise (the success 
output from `commit`, the new commit id in the log, `push` requiring the 
force option, etc).

I understand that `--amend` is (can be) used for editing commit 
messages, authors, authoring dates etc.
I would however like to see any `--amend` command that results in no 
changes to the tree, the commit message and the authoring metadata 
reject the commit with an appropriate warning similar to the one that a 
plain `git commit` would present. It should be overrideable by the 
`--allow-emtpy` parameter as well.

If this change detection is somehow unfeasible, I would at least like 
the `git commit --amend --no-edit` command (with no other flags) to 
check the tree in the same way as `git commit` does, as the intention of 
`--no-edit` is even more clear and running the command is more obviously 
a mistake/lapse.

Kind regards,
  Bergi
