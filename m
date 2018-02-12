Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1139C1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 00:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeBLAQb (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 19:16:31 -0500
Received: from avasout01.plus.net ([84.93.230.227]:45780 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbeBLAQb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 19:16:31 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id l1nIeIRUyykf2l1nJe74xR; Mon, 12 Feb 2018 00:16:29 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B8mXLtlM c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=PS1KL46r0XjL7vOh31YA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] test_i18ngrep
Message-ID: <27cb6114-2aa7-c2cc-c3dc-4ac4e318d5f7@ramsayjones.plus.com>
Date:   Mon, 12 Feb 2018 00:16:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfONq3odd5fGWXd0ZDxAebafSeYByQ8cZNzTwr3RxeCISgQ9o+zzbMdXpY085NPOUqcue188e4anIFJ4dQ5QV3LQoUKWiiwcgP3ZPsB43jzXjMcjprpH0
 pENbxRkBgsmQnhQJIxe/tdP/L8M1kljaYA2HrTcHeADec+kM3CaNqCs+jGeyqa6bUzkaumMn5Ie11g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


These patches resulted from an experiment of yours [1], I wrote these up
last year, then promptly forgot about them! ;-)

These patches were built on top of v2.16, and the second patch has a simple
conflict with commit 93b4b0313c ("t5536: let 'test_i18ngrep' read the file
without redirection", 2018-02-08), which is in the 'next' branch.

The conflict looks like so:

  $ git diff
  diff --cc t/t5536-fetch-conflicts.sh
  index 644736b8a,38381df5e..000000000
  --- a/t/t5536-fetch-conflicts.sh
  +++ b/t/t5536-fetch-conflicts.sh
  @@@ -22,7 -22,7 +22,11 @@@ verify_stderr () 
          cat >expected &&
          # We're not interested in the error
          # "fatal: The remote end hung up unexpectedly":
  ++<<<<<<< HEAD
   +      test_i18ngrep -E '^(fatal|warning):' error | grep -v 'hung up' >actual | sort &&
  ++=======
  +       grep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual &&
  ++>>>>>>> master-i18n
          test_i18ncmp expected actual
    }
    
  $ 
  
The resolution is to simply take the 'master-i18n' text. However, if you
prefer, I can rebuild these patches on top of 'next' and re-submit. Just
let me know.

Note that I replaced an 'test_i18ngrep -E' with 'grep -E' rather than egrep.
(the grep man page claims that egrep, fgrep and rgrep are deprecated, but I
think that has been the case for as long as I can remember, so don't hold
your breath!).

[1] https://public-inbox.org/git/%3Cxmqqvahawirr.fsf@gitster.mtv.corp.google.com%3E/

Ramsay Jones (2):
  t4151: consolidate multiple calls to test_i18ngrep
  t5556: replace test_i18ngrep with a simple grep

 t/t4151-am-abort.sh        | 5 ++---
 t/t5536-fetch-conflicts.sh | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.16.0
