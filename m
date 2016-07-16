Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A8820195
	for <e@80x24.org>; Sat, 16 Jul 2016 02:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbcGPCXI (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 22:23:08 -0400
Received: from atl4mhob07.myregisteredsite.com ([209.17.115.45]:53622 "EHLO
	atl4mhob07.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217AbcGPCXH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 22:23:07 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u6G2N4ki015125
	for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:23:04 -0400
Received: (qmail 1209 invoked by uid 0); 16 Jul 2016 02:23:04 -0000
X-TCPREMOTEIP: 69.47.70.101
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.100?) (andrew@kellerfarm.com@69.47.70.101)
  by 0 with ESMTPA; 16 Jul 2016 02:23:04 -0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
Date:	Fri, 15 Jul 2016 22:23:03 -0400
Cc:	Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <36F872B1-D5C4-4FC5-9B9E-5297C4B01950@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com> <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 5:19 nachm. schrieb Junio C Hamano <gitster@pobox.com>:
> 
> On Fri, Jul 15, 2016 at 1:30 PM, Andrew Keller <andrew@kellerfarm.com> wrote:
>> Am 15.07.2016 um 12:34 nachm. schrieb Andrew Keller <andrew@kellerfarm.com>:
>> 
>>> I pulled out the source for version 2.9.1 and briefly skimmed how run_commit and
>>> prepare_to_commit work.  It seems that Git already understands that a pre-commit
>>> hook can change the index, and it rereads the index before running the
>>> prepare-commit-msg hook: https://github.com/git/git/blob/v2.9.1/builtin/commit.c#L941-L951
>> 
>> Quick question: Why does Git reread the index after the pre-commit hook runs?
> 
> Offhand I do not think of a good reason to do so; does something break
> if you took it out?

According to only test failures, it seems that only the `update_main_cache_tree(0)` invocation
is needed to avoid a torrent of test failures (490 failures across 102 tests).  Removing lines
946, 947, 949, and 950 do not cause test breakages (although my computer is not set up to
run all of the tests).

However, there seems to be an interaction between lines 946-947 and `update_main_cache_tree(0)`
on line 948: although lines 946-947 can be removed by themselves without test breakages,
when 946-948 are all disabled together (and, in turn, lines 949-950 never run), one additional test
failure is registered (t2203.5).

Thanks,
 - Andrew Keller

