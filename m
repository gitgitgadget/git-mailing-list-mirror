Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD9C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 22:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356375AbiDOW40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiDOW4V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 18:56:21 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89865443F8
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 15:53:51 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23FMrkjf038634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Apr 2022 18:53:46 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqq8rs7yzul.fsf@gitster.g> <YlnzGecOaayPM6ve@google.com>
In-Reply-To: <YlnzGecOaayPM6ve@google.com>
Subject: RE: What's cooking in git.git (Apr 2022, #04; Thu, 14)
Date:   Fri, 15 Apr 2022 18:53:41 -0400
Organization: Nexbridge Inc.
Message-ID: <00a001d8511b$aa547c20$fefd7460$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNGCtW5muXFQTzdE46MaZuFF64AwH+UTOirPgUIeA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 15, 2022 6:35 PM, Emily Shaffer wrote:
>After quite some time, I'll provide an update on the "submodules UX rework"
>effort Google has been working on.

I'm looking forward to being able to test this extensively. This has
interest in my community.

>On Thu, Apr 14, 2022 at 05:06:26PM -0700, Junio C Hamano wrote:
>> [Stalled]
>> * es/superproject-aware-submodules (2022-03-09) 3 commits  .
>> rev-parse: short-circuit superproject worktree when config unset  .
>> introduce submodule.hasSuperproject record  . t7400-submodule-basic:
>> modernize inspect() helper
>>
>>  A configuration variable in a repository tells if it is (or is not)
>> a submodule of a superproject.
>>
>>  Expecting a reroll.
>>  cf. <kl6l4k45s7cb.fsf@chooglen-macbookpro.roam.corp.google.com>
>>  source: <20220310004423.2627181-1-emilyshaffer@google.com>
>
>Yes, a reroll is planned. The most recent attempt (locally) also rerolled a
follow-on
>series adding a shared "config.superproject" readable by both a
superproject and
>its submodules, in order to demonstrate some real-world application and an
>example of how to use this config telling us whether or not we're a
submodule.
>The series has gotten away from me
>- as I've been working on internal team planning type things.
>
>Beyond this work, there is some other work in progress, still in design
stages
>downstream:
>
>Glen Choo is continuing work on design for 'git checkout -b'/'git switch
-c' when
>submodules are involved and 'submodule.recurse' is set.
>
>Glen Choo sent an update to continue converting 'git submodule update'
>into C; this appears to have no reviews.
>https://lore.kernel.org/git/20220315210925.79289-1-chooglen%40google.com
>
>Josh Steadmon is working on design for 'git pull --rebase
--recurse-submodules' in
>basic (non-conflicting) cases; this means he's also working on 'git rebase
--recurse-
>submodules' in these same basic cases. This work is still fairly early in
the design
>stage, but will be something to look forward to.
>
>Beyond those pieces, I thought it might be interesting for me to share
what's
>coming up for my team from April through June. So here's a grab bag of
what's
>next for us:
> - Improving 'git fetch --recurse-submodules':
>   * To retry a failed submodule more than once (in fact, the existing
>     behavior seems to have a bug: if we fail to clone a submodule in
>     the "retry queue", we give up and don't try to clone any of the
>     other retryable submodules after that one)
>   * Cloning submodules that were added in a commit which is newly
>     fetched with 'git fetch'
> - Parallelizing 'git checkout --recurse-submodules' (at least when
>   partial clones are involved). Without this change, we see that the
>   initial checkout of a partial-cloned repo with many submodules takes
>   a long, long, long time.
> - Parallelizing 'git status --recurse-submodules' when many submodules
>   are involved (and probably tidying the output)
>
>And some more odds and ends. After those few bits, and the in-progress work
>already seen on the list, we have some users lined up to try the workflow,
>because we're pretty sure that puts us in a position to try out basic Git
usage with
>many submodules. So hopefully we have some interesting feedback and bug
fixes
>coming from that, as well.
>
> - Emily

