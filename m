Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362BF1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeFGAQU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 20:16:20 -0400
Received: from avasout04.plus.net ([212.159.14.19]:46961 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752794AbeFGAQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 20:16:19 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id Qib8fLLoUI9T1Qib9fRZL9; Thu, 07 Jun 2018 01:16:17 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Z6vC4kZA c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=snJLLXHIXBCU0bFzGk0A:9 a=QEXdDO2ut3YA:10
 a=OXx4ngWzwLx9h_IvVXMu:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
To:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
Date:   Thu, 7 Jun 2018 01:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606210300.GA1879@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfF8uOwwSMw5CiXtIIXTCEDot7/14x8FPN7dHm7J4Sakn6J7f6Z08iW+QArHci/0XDK0bIXlWzRbLlxq9601skj402iBQuvEdF0yuScd8O7I0YIIXPP54
 +uulnwnATNdGRnpMyz2J7uq4snm4wFZJkvwAn5A7hGVT2azrkxmAJfgv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/06/18 22:03, Jeff King wrote:
> On Wed, Jun 06, 2018 at 01:10:52PM -0400, Todd Zullinger wrote:
> 
>> git@jeffhostetler.com wrote:
>>> +# As a sanity check, ask Python to parse our generated JSON.  Let Python
>>> +# recursively dump the resulting dictionary in sorted order.  Confirm that
>>> +# that matches our expectations.
>>> +test_expect_success PYTHON 'parse JSON using Python' '
>> [...]
>>> +	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&
>>
>> Would this be better using $PYTHON_PATH rather than
>> hard-coding python as the command?
> 
> Probably. We may want to go the same route as we did for perl in 
> a0e0ec9f7d (t: provide a perl() function which uses $PERL_PATH,
> 2013-10-28) so that test writers don't have to remember this.
> 
> That said, I wonder if it would be hard to simply do the python bits
> here in perl. This is the first use of python in our test scripts (and

Hmm, not quite the _first_ use:

$ git grep PYTHON_PATH -- t
t/lib-git-p4.sh:        (cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
t/lib-git-p4.sh:        "$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
t/t9020-remote-svn.sh:export PATH PYTHON_PATH GIT_BUILD_DIR
t/t9020-remote-svn.sh:exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/gendouble.py" >%double.png &&
t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
$ 

I don't run the p4 or svn tests, so ... :-D

> really the only user in the whole code base outside of a few fringe
> commands). Leaving aside any perl vs python flame-war, I think there's
> value in keeping the number of languages limited when there's not a
> compelling reason to do otherwise.

I agree that fewer languages is (generally) a good idea.

ATB,
Ramsay Jones



