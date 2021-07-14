Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12F6C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947D5610D1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 17:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbhGNRdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:33:45 -0400
Received: from elephants.elehost.com ([216.66.27.132]:30084 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhGNRdp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 13:33:45 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16EHUntZ072838
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Jul 2021 13:30:50 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>        <20210712223139.24409-3-randall.becker@nexbridge.ca>    <xmqqr1g1zow4.fsf@gitster.g>    <006b01d778b6$b74b8600$25e29200$@nexbridge.com> <xmqqczrkyg77.fsf@gitster.g>
In-Reply-To: <xmqqczrkyg77.fsf@gitster.g>
Subject: RE: [Patch 2/3] Documentation/config.txt: add worktree includeIf conditionals.
Date:   Wed, 14 Jul 2021 13:30:44 -0400
Message-ID: <001101d778d5$fd6c7670$f8456350$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF2HyHHSxX17r/iTwhwCI4yh2NyqQFrZIJJAS8qKBsA0h6pwwJj6elwq9bna6A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 14, 2021 1:10 PM, Junio C Hamano
>"Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>>>Assuming that I guessed correctly, is this a deliberate design
>>>decision not to "automatically add ** after a pattern that ends with a
>>>slash", and if so why?  I would have thought that "in the worktrees
>>>that I create inside /var/tmp/, please enable these configuration
>>>variables" would be a fairly natural thing to ask, and I do not
>>>immediately see a reason why we want to apply different syntax rules
>>>between "gitdir" and "worktree".
>
>> The reason for this comes down to what is in *the_repository.
>
>Sorry, but I still do not understand.
>
>> Essentially, the_repository->gitdir always has a /path/to/.git
>> directory with full qualification.
>
>Yes.
>
>> the_repository->worktree does not have /.git added  for obvious
>>reasons, so the /path/to is bare of the trailing /.
>
>It may be the case, but /path/to/.git does not have trailing slash, either, so I do not see the relevance.
>
>When you say [includeIf "gitdir:/path/"], the "behave as if ** is added after the slash at the end" rule kicks in, and the pattern
"/path/**" is
>used to see if it matches "/path/to/.git" and it does, right?  When you say [includeIf "worktree:/path/"], wouldn't the resulting
"/path/**"
>match "/path/to"?

I think I over-complicated the first test case and got myself into a mess. Will fix that.

>By the way, I think [PATCH 1/3] should turn the body of
>include_by_gitdir() to a common helper function that
>
> - accepts a path to a directory and a pattern
> - turns it into a relpath
> - prepares the pattern with prepare_include_condition_pattern()
> - do the match include_by_gitdir() does.
>
>and make include_by_gitdir() a very thin wrapper that passes
>opts->git_dir to that common helper.  Then you do not have to copy
>the entire function to create your new include_by_worktree(); it can be another very thin wrapper that passes
the_repository->worktree
>instead of opts->git_dir to the common helper, as there is no other difference in these two functions.

That sounds like a plan. Will go for it in V2.

-Randall

