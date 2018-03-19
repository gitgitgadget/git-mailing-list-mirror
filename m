Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170A71F404
	for <e@80x24.org>; Mon, 19 Mar 2018 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755741AbeCSPoU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 11:44:20 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.109]:9568 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCSPoT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 11:44:19 -0400
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1exwxX-0004LI-00; Mon, 19 Mar 2018 16:44:27 +0100
Subject: Re: [PATCH v3 0/2] stash push -u -- <pathspec> fixes
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180314214642.22185-1-t.gummerer@gmail.com>
 <20180316204306.862-1-t.gummerer@gmail.com>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Message-ID: <bc69c1f4-7098-1bbf-e69b-97808c4d8779@syntevo.com>
Date:   Mon, 19 Mar 2018 16:44:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316204306.862-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.03.2018 21:43, Thomas Gummerer wrote:
> Thanks Marc for catching the regression I almost introduced and Junio
> for the review of the second patch.  Here's a re-roll that should fix
> the issues of v2.

Thanks, existing issues are fixed, but cleanup of the stashed files 
seems to not work properly when stashing a mixture of tracked and 
untracked files:

$ git init
$ touch file1
$ touch file2
$ git add file1 file2
$ git commit -m "initial import"
$ echo "a" > file1
$ echo "b" > file2
$ touch file3
$ git status --porcelain
  M file1
  M file2
?? file3
$ git stash push -u -- file1 file3
Saved working directory and index state WIP on master: 48fb140 initial 
import
$ git status --porcelain
  M file1
  M file2

file1 and file3 are properly stashed, but file1 still remains modified 
in the working tree. When instead stashing file1 and file2, results are 
fine:

$ git stash push -u -- file1 file2
Saved working directory and index state WIP on master: 48fb140 initial 
import
$ git status
On branch master
nothing to commit, working tree clean

-Marc


