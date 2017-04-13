Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAEE20960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbdDMTWH (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:22:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:50747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdDMTWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:22:06 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNIAz-1d0g7X3FrV-006uRp; Thu, 13
 Apr 2017 21:21:54 +0200
Date:   Thu, 13 Apr 2017 21:21:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Gergely Nagy <ngg@tresorit.com>,
        Aaron Teague <ateague@apple.com>, jeremyhu@apple.com
Subject: [PATCH 0/1] difftool: fix a use-after-free bug
Message-ID: <cover.1492111288.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HNMh9qUebzi0JHXoC57+jjv17hkPRriz7RpXTYVBkXsCuqLok9T
 x9DeV57UsL1DMI49xb0OfdboItzv+g4yQIJgsstNpDV0vf5ueI8y6232jZz6Hda2PFQgB0M
 draxwLOCxDEY36gPJyg6lVIAPjPQdfGBMS0/Fjlx8o9WU69dShWapnwGyfpWCU33zVRh8tI
 6WE3keyaTKeyAseQu7GRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/TGu7s0/Tko=:qcXy3nEObZ4COC+cgonIGX
 8G+Un7Js3F4ekSimicmLTpLkYRgzCVkUUdhsVaWEKPv2FIOio3zkoX/F/iJiq/PnAy5QwO9o2
 JHbteGxl7MRylSWDBzvxZA66uQk7ollhtZW5bWCq1qO2Ukg0pVQVIWzHHR2bmHXDB7TDRMy9b
 0P04o0XeLYgu2nGcYCzg/GxN4pU8JnS/1ZadW1tD4ck/BBvBev9aTsTQZkyhCfQfR/8nPAmMJ
 OP/Jb3SB36IIPVo0SsfyuQ1++rCZAbEihxPGSAeZcQpRkp5nVzU0YLL/M2q8ojXhsrMgnRK5K
 mprE62HMMPFF4O8YPWbnyiAeuNEf0iVJvQIzT+nVCRIk6d3WPFFxu6u2ZQ1hldQpjYy+ALNbd
 4HGFDeREBRN+9yISwrNGNm0X5DmWVouZaFZ9jqTuszYAChYGpAyuKti75yWk/F7fqfqYDSBpi
 1avksvdnBrOUUjNgQ0jTSeQzlP1zW7ByBePjWVkVBYPvxVUsJGBsbdhR/4u6slMx2IFrkBQyp
 md9DB+k/YjTDkbnz8YqpIRnn6mShsG1J1nrh9aLaTGVpkZfwVZxH+EPRQr5HK01LHmugdew8C
 Ft94hhCLYKGhu02WgSurEOQkHKrAMdCCgJ4YB2ZCSI3jAOHIg5ohTk/p0/GP1C4jsLx0EuqTM
 jGza87HFJLOMPmIHNPXvsKwjgednA+W0iNCp4pkB8hlmmB68CZ1BRiQnwf4BNSh9mQB40k7mL
 HsVAvL+62RyMqLJZl4TAYyVzEmxwEuQ0mwUjAcrBiXzuHmgSanUPeqLM6xQzW6CvVHBOL4ZBe
 q1VGiNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been reported previously that the base_dir recorded at the
beginning of run_dir_diff() may go stale due to the buffer to which it
points potentially being realloc()ed.

This bug has been fixed in Git for Windows 2.12.2(2) already. It took me
this long (!!!) to come up with a reliable test case... But now that I
have it, it can be easily verified.


Johannes Schindelin (1):
  difftool: fix use-after-free

 builtin/difftool.c  |  7 +++++--
 t/t7800-difftool.sh | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)


base-commit: cf11a67975b057a144618badf16dc4e3d25b9407
Published-As: https://github.com/dscho/git/releases/tag/fix-difftool-d-crash-v1
Fetch-It-Via: git fetch https://github.com/dscho/git fix-difftool-d-crash-v1

-- 
2.12.2.windows.2.1.g7df5db8d31e

