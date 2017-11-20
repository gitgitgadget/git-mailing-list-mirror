Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94BBC202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 20:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdKTUQx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 15:16:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:35171 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752546AbdKTUQw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 15:16:52 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id GsUrejPHPzbmWGsUseBvQH; Mon, 20 Nov 2017 20:16:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=qmtHxtvZsTsTWKRDoHYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t3512 & t3513 'unexpected passes'
Message-ID: <73f0fb1e-5b55-1049-7706-652f1f9deaed@ramsayjones.plus.com>
Date:   Mon, 20 Nov 2017 20:16:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFjjKGSgDX+V3BW90f9c74gZdnKd+rczWUOvwPCGqqw8ah1QBo5YcmL5BRNsrd3tRavCcpDWbxk3LNDm/w3FYa0QpNiM/3z+XnLmePbREbgED+J2ce+C
 sxP7OEb3cwVSdUMzRPOWIUGiMouI808n8zB/5f+QQ2RnoGpUDX7IXShfVubcjAiaTYt+dVbRKianWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

For several days, I have been staring at some 'unexpected passes' in
the t3512-cherry-pick-submodule.sh and t3513-revert-submodule.sh test
files (tests #11-13 in both cases).

I finally found time tonight to 'git bisect' the 'problem', and found
that bisect fingered commit b5a812b298 ("sequencer: try to commit without
 forking 'git commit'", 17-11-2017).

During the bisection I stumbled across (several times) the following
compilation error:

      CC sequencer.o
  sequencer.c: In function ‘do_commit’:
  sequencer.c:1142:9: error: void value not ignored as it ought to be
       res = print_commit_summary(NULL, &oid,
           ^
  Makefile:2105: recipe for target 'sequencer.o' failed
  make: *** [sequencer.o] Error 1

which I 'fixed' like so: s/res = //

So, given that the 'fingered' commit didn't immediately seem to be
related to the problem, along with the above errors, this may well
not be the culprit.

Just FYI.

ATB,
Ramsay Jones

