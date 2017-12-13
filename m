Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0AB1F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbdLMSPx (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 13:15:53 -0500
Received: from avasout01.plus.net ([84.93.230.227]:53200 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753051AbdLMSPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:15:52 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id PBZNe0vUlJjiPPBZPeH2m1; Wed, 13 Dec 2017 18:15:51 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=O6ZJhF1W c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=eWGV9nahu4I5STFbaWYA:9
 a=KuSy3MWSCYrc93rH:21 a=rAAAV9loPBDV532A:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 00/34] Add directory rename detection to git
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
References: <20171129014237.32570-1-newren@gmail.com>
 <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <14bf2760-2787-5dd3-e5cc-a2ec0e0d8950@ramsayjones.plus.com>
Date:   Wed, 13 Dec 2017 18:15:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8svxwpm.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOOzAKSi1BZpE/iWTs44zfGfM5O7B9nU1AnUZOgRiuyOx4P1AJ3FzVDpbksGl0WbQ0xhB6dpjiI9bFqdukdadRCsiJd3oWPgPUvgzDGRsxCf6laxxTUp
 q+3imDWhrrHck/drif/Ke/Td00FsOZvi86k49AeE+IhoOEnvcqT5NBP0AfmsnsxTuUCO3eDQfOv8Xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/12/17 01:06, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>> This patchset introduces directory rename detection to merge-recursive.
> 
> The use of negated form of test_i18ngrep in these patches are all
> wrong.  Because the helper must say "even though the string does not
> match (does match), the test expects it to match (does not match),
> and we know that expectation won't hold simply because we are under
> poison build", so negating the result of test_i18ngrep won't work.
> Instead, you would tell test_i18ngrep that we do not expect it to
> find matching lines.
> 
> Even with the attached, test #70 will still fail because you have a
> construct that greps in output of test_i18ngrep.  That won't work
> under poison build, because the output of test_i18ngrep won't have
> the string you are looking for under poison build.
> 
> We may probably want to redirect the output of underlying grep to
> /dev/null in test_i18ngrep to make this kind of misuse easier to
> spot.

I have test-suite failures on the 'pu' branch for t4151-am-abort.sh
(#3 and #6) and t5536-fetch-conflicts.sh (#3 and #6-7), which on a
very quick inspection seem to be due to this (ie your SQUASH commit
e5c5e24ad9).

For t4151 the test (both 3 & 6) is using test_i18ngrep on the output
of a previous test_i18ngrep, and t5536 is doing likewise in the
verify_stderr() helper function.

ATB,
Ramsay Jones


