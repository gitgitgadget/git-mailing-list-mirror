Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B521FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935011AbcHJTmC (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:42:02 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:17628 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933183AbcHJTmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:42:00 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s8hP125pqz5tlH;
	Wed, 10 Aug 2016 21:41:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B8E8B5137;
	Wed, 10 Aug 2016 21:41:56 +0200 (CEST)
Subject: Re: [PATCH RFC] diff: add SUBMODULE_DIFF format to display submodule
 diff
To:	Jacob Keller <jacob.keller@gmail.com>
References: <20160809223219.17982-1-jacob.e.keller@intel.com>
 <CAGZ79kbzDhpsfpY8s=7O86_dNLA=VRkyC=8eiCqMambKvUnXmw@mail.gmail.com>
 <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <b44c853f-2b4b-0eeb-ba1a-df0e650f7868@kdbg.org>
Date:	Wed, 10 Aug 2016 21:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <CA+P7+xqnALzwkgLXrP57BUtFGaxGudAEG7cmGTakP47ofFEjHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 10.08.2016 um 00:56 schrieb Jacob Keller:
> On Tue, Aug 9, 2016 at 3:50 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Tue, Aug 9, 2016 at 3:32 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>>> +       if (strbuf_read(buf, cp.out, 0) < 0)
>>
>> So we keep the whole diff in memory
>> I don't know much about the diff machinery, but I thought
>> the rest of the diff machinery just streams it out?
>
> Yea, but I can't figure out how to do that. Is there an easy way to
> stream chunks from the pipe straight into the file?

You don't stream via a pipe, you let the sub-process write directly to 
the file:

	fflush(f);
	cp.out = dup(fileno(f));

Of course, you no longer "prepare_submodule_diff" anymore (which 
currently runs the child process), but you print the "Submodule" header 
line, then invoke the child process, and if there was a failure, you 
fprintf(f, "(diff failed)").

-- Hannes

