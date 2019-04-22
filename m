Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D9C2037F
	for <e@80x24.org>; Mon, 22 Apr 2019 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfDVRPj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 13:15:39 -0400
Received: from avasout03.plus.net ([84.93.230.244]:43291 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfDVRPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 13:15:38 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id IcXXh7FKLR9LaIcXYhH9TX; Mon, 22 Apr 2019 18:15:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1555953337; bh=HeXjlAMWioDgyvDOXTj0uEvTA+GZdNL4FanwNLi2wHg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NwtzVAzBNvxRMxBmzMXuLqfGXDBM5HR8c5Afm5RM1+dmikS7ZgkxiPmkHWAKQy8XS
         MltXLBRaXQHBHmuvGumjZtHf8RnYv1omcAz/f+pfc4+vrNKMDFWaKSzkyFI8SqXT5W
         lITcRso3K85ff0bDM/KfPaAubmbariERWY0TvqSU7hs+sRbVYQWnTiRZiL4IMbVETN
         7ovecH2KrefUmXo1s6a0etwUuP/+mucHx6X7RpPAdXRj9w2KYZljI57Q+dzAz5ldh5
         rezkkNhiGompMB87o79RKdfeeYb1Gg2yzzBmotyRczEErNQtVD8MipXfvzC7dm4+Cm
         dsnaDufvmFN3g==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Qa0YQfTv c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=rBb2Hw9khP7VJvgNWCcA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
 <20190422144927.GA6519@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d869060a-a731-ff1d-3131-a146078fcf88@ramsayjones.plus.com>
Date:   Mon, 22 Apr 2019 18:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422144927.GA6519@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPBwI1hy3SPVmaJo2r2a/SBK2uS9xc1YfbBGsr7A80QjnGcrV8dTsX0NNCzdbFJRS2S+i8mxpqZzS6AEk8QFWT95mb/NXLaAbM1baljbbkxjcRD6eOQe
 73+zJ7GeiJthziYV+Rhp+1Bm1QIS9X3UCC2x66PLRTuHWvAKp+lfghlpNTPtFhaNgYpEl8wqnGX0BA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/04/2019 15:49, Jeff King wrote:
> On Sun, Apr 21, 2019 at 10:19:04PM +0900, Junio C Hamano wrote:
> 
>>    I am not fan of adding the "| sort -u" of the whole thing,
>>    because there is no need to dedup the output of the $(FIND) side
>>    of the alternative, but "(ls-files | sort -u) || (find)" would
>>    obviously not work.  If we truly care, perhaps we should add a
>>    new option to ls-files to show each path only once, unless it is
>>    showing the stage number (i.e. "ls-files -s" or "ls-files -u"),
>>    but this gets the problem go away without code change, hence this
>>    RFC ;-)
> 
> FWIW, after reading your commit message my thoughts immediately turned
> to "why can't ls-files have a mode that outputs each just once", but
> then ended up at the same place as your patch: it's not that hard to
> just de-dup the output.

My immediate thought was "that is simply a bug, no?" :-D

I haven't used 'git ls-files' that much, so it's no great surprise
that I had not noticed it odd behaviour!

So, this evening, I decided to have a little play:

  $ git status
  On branch master
  You have unmerged paths.
    (fix conflicts and run "git commit")
    (use "git merge --abort" to abort the merge)
  
  Changes to be committed:
  
  	new file:   d
  
  Unmerged paths:
    (use "git add <file>..." to mark resolution)
  
  	both modified:   a
  
  Changes not staged for commit:
    (use "git add/rm <file>..." to update what will be committed)
    (use "git checkout -- <file>..." to discard changes in working directory)
  
  	modified:   b
  	deleted:    c
  
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
  
  	e
  
  $ git ls-files
  a
  a
  a
  b
  c
  d
  $ git ls-files -c
  a
  a
  a
  b
  c
  d
  $ git ls-files -m
  a
  a
  a
  b
  c
  $ git ls-files -d
  c
  $ git ls-files -u
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  $ git ls-files -s
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  100644 72ad562535b8551cdd6659e8fb6c7cf6830e6a07 0	d
  $ git ls-files -sd
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  100644 72ad562535b8551cdd6659e8fb6c7cf6830e6a07 0	d
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  $ git ls-files -su
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  $ git ls-files -sm
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  100644 72ad562535b8551cdd6659e8fb6c7cf6830e6a07 0	d
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  $ git ls-files -sdu
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  $ git ls-files -sdum
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  $ git ls-files -sdumo
  e
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4ef30bbfe26431a69c3820d3a683df54d688f2ec 1	a
  100644 af72a79d2a6bd4b252b0aca22dba9946f7eedf86 2	a
  100644 f8829dfb9bf82721903d239ef069fb5de395f3e7 3	a
  100644 4f2e6529203aa6d44b5af6e3292c837ceda003f9 0	b
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  100644 a296d0bb611188cabb256919f36bc30117cca005 0	c
  $ 

Er, ... well, I obviously don't have a clue how it is supposed
to work. This just looks broken to me. :(

> So the patch itself looks good to me (though I agree that Eric's
> suggestion to de-dup inside "make" is better still).

Agreed.

ATB,
Ramsay Jones

