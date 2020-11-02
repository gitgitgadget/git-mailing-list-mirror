Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEFC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73D1206F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKBTYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:24:36 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:46456 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTYg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:24:36 -0500
Received: from client3368.fritz.box (i5C7473CB.versanet.de [92.116.115.203])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id B02243C451B;
        Mon,  2 Nov 2020 20:24:34 +0100 (CET)
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <20201102131522.coj5gb2bssvjqngo@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
Date:   Mon, 2 Nov 2020 20:24:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102131522.coj5gb2bssvjqngo@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.11.20 14:15, Pratyush Yadav wrote:
> Hi Stefan,
> 
> On 01/11/20 06:05PM, Stefan Haller wrote:
>> Do an automatic rescan whenever the git-gui window receives focus. Most other
>> GUI tools do this, and it's very convenient; no more pressing F5 manually.
> 
> I submitted a patch for this a while back but there was a lengthy 
> discussion. [0] would be a good read. IIRC the major blocker was that 
> rescan is a very expensive operation on Windows.

Ah, thanks for reminding me of that. I did actually read the discussion
back then, but had completely forgotten about it.

>> People who don't like this behavior can turn it off using
>> "git config gui.autorescan false".
> 
> To make sure the experience on Windows (and for anyone who faces long 
> rescan times) does not degrade, I think we should keep this off by 
> default. That said, I would love to be convinced to keep this on by 
> default because IMO this is a really good feature to have. I tried 
> coming up with ways to avoid slowdowns while keeping the auto rescan on 
> but I didn't come up with anything convincing.

I still think the default should be on; I consider it more important
that the information is accurate than that it is shown without delay. I
do use Windows occasionally myself, in a slow VM no less, and it does
annoy me that a rescan is so slow there; however, I still prefer that
over looking at stale information without realizing it.

Also, I had a look at how other git clients deal with this. I didn't do
an exhaustive research, just quickly looked at a few:

- Fork (https://git-fork.com)
  Rescans on activate. There's no setting to turn this off. (!)

- SourceTree (https://www.sourcetreeapp.com)
  Rescans on activate. There's an option to turn this off, but it
  defaults to on. (It is confusingly called "Refresh automatically when
  files change", which doesn't seem to be accurate, as far as I can
  tell.)

- Visual Studio Code
  Rescans on activate. There's an option to turn it off, but it defaults
  to on.

- Sublime Merge (https://www.sublimemerge.com)
  Watches files and rescans in the background.

So I would say there's plenty of precedence for having this behavior
default to on.

>> Stefan Haller (2):
>>   git-gui: Delay rescan until idle time
>>   git-gui: Auto-rescan on activate
>>
>>  git-gui.sh | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>
> 
> [0] https://lore.kernel.org/git/20190728151726.9188-1-me@yadavpratyush.com/
> 
