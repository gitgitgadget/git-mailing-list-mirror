Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818BB20195
	for <e@80x24.org>; Sat, 16 Jul 2016 02:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbcGPCj3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 22:39:29 -0400
Received: from atl4mhob11.myregisteredsite.com ([209.17.115.49]:51475 "EHLO
	atl4mhob11.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751292AbcGPCj1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 22:39:27 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.209])
	by atl4mhob11.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id u6G2dOBf001868
	for <git@vger.kernel.org>; Fri, 15 Jul 2016 22:39:24 -0400
Received: (qmail 9575 invoked by uid 0); 16 Jul 2016 02:39:24 -0000
X-TCPREMOTEIP: 69.47.70.101
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.100?) (andrew@kellerfarm.com@69.47.70.101)
  by 0 with ESMTPA; 16 Jul 2016 02:39:24 -0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
From:	Andrew Keller <andrew@kellerfarm.com>
In-Reply-To: <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 15 Jul 2016 22:39:23 -0400
Cc:	Git List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <06EA5AA7-3E0B-4C2E-B5C3-89399F9890D1@kellerfarm.com>
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com> <2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com> <CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com> <xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.2104)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.07.2016 um 6:03 nachm. schrieb Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>> On Fri, Jul 15, 2016 at 1:30 PM, Andrew Keller <andrew@kellerfarm.com> wrote:
>>> Am 15.07.2016 um 12:34 nachm. schrieb Andrew Keller <andrew@kellerfarm.com>:
>>> 
>>>> I pulled out the source for version 2.9.1 and briefly skimmed how run_commit and
>>>> prepare_to_commit work.  It seems that Git already understands that a pre-commit
>>>> hook can change the index, and it rereads the index before running the
>>>> prepare-commit-msg hook: https://github.com/git/git/blob/v2.9.1/builtin/commit.c#L941-L951
>>> 
>>> Quick question: Why does Git reread the index after the pre-commit hook runs?
>> 
>> Offhand I do not think of a good reason to do so; does something break
>> if you took it out?
> 
> Ahh, I misremembered.  2888605c (builtin-commit: fix partial-commit
> support, 2007-11-18) does consider the possibility that pre-commit
> may have modified the index contents after we take control back from
> that hook, so that is probably a good place to enumerate what got
> changed.  Getting the list before running the hook can give an
> out-of-date list, as you said.

Interesting.  So, the implication is that disallowing the pre-commit hook
to change the index may cause some problems (491 problems, if my run
of the tests was accurate).

Does that mean it would be desirable to update the index before the
commit message template is rendered?

Thanks,
 - Andrew Keller

