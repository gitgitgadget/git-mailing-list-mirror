Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10DD1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 10:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeBTK26 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 05:28:58 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:8515 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeBTK25 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 05:28:57 -0500
Received: from [192.168.2.201] ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id o5ANeakAJLSHJo5ANexuFP; Tue, 20 Feb 2018 10:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519122536;
        bh=TUAuIA5UsnttbXYaCFnQ3CLZnEDtmBAELubXuptopPQ=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=cgs2wysdK26//lKGz/SMWFS/MaY8yuZQ4PubdS9pUBNHfIMvU5OMlSV2bu4Cye9SK
         6F/vBOmicUfXsyXnz+nMyO7NS6Qgcjcw7OqgdwD9vkdaj5qvpjlFY4J45HzXxb/tnS
         RGlmkQtoJp3zbdC/lsFdgHm5+7+lk+NwxWTXbk+4=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=NqehS4VJ c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=eU1zHdUWG92YyBEDvhcA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Why git-revert doesn't invoke the pre-commit and the commit-msg
 hooks?
To:     Gustavo Chaves <gustavo@gnustavo.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <CAPx58qqv84+i0JbdsVzFqWB=bRDecWHxss8frD4=nWOsFj-NPg@mail.gmail.com>
 <CAPx58qoS-J+yJ_J4QOOnKyG=EOrT5J=UoCrXfXxEijq4Z2Z_3w@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <7ff6079d-5834-3bbd-781b-a2fc0659e7e5@talktalk.net>
Date:   Tue, 20 Feb 2018 10:28:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPx58qoS-J+yJ_J4QOOnKyG=EOrT5J=UoCrXfXxEijq4Z2Z_3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLv7PhHoJpJz6arVuF+qGiaRd/W55yGhyVrGP7795FYF/aDZEZ0F4Ztos6OV+hofik93wNW1/vdBzhiQlk/bW2rrEdv8AMdse9JLbag58nFB2GS0MGab
 MA9bZ6q8mOXJSo6tq5xyPV382GSsa5U+5KUpEHYvCEdB/pSs25Mxini4qVEUzAYD2O2Hm4HzflNRJePTx/FYolL7ad9mGJx/xPGyBqdqOfYK3S9rnMHlF+Ce
 wJq6u+BMXDX09msy9Fdx0Mcii8Q5FPEfrQZhJrpS1Ig=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Gustavo

On 19/02/18 14:50, Gustavo Chaves wrote:
> 
> I asked this question on StackOverflow and got an answer:
> https://stackoverflow.com/q/48852925/114983
> 
> The problem is that git-revert invokes git-commit with the -n flag,
> explicitly avoiding the pre-commit and the commit-msg hooks.
> 
> This was originally introduced on commit 9fa4db544e2e, by Junio
> Hamano, in 2005! The rationale in the commit message was the
> following:
> 
>>> Do not verify reverted/cherry-picked/rebased patches.
> 
>>> The original committer may have used validation criteria that is less
>>> stricter than yours.  You do not want to lose the changes even if they
>>> are done in substandard way from your 'commit -v' verifier's point of
>>> view.
> 
> I get it, but since by default you are allowed to edit the commit
> message during a git-revert I think there's a case to be made to make
> the pre-commit and the commit-msg being invoked by default. Also,
> git-revert introduces new lines in the original commit message, and
> they could be used to trigger specific checks, such as the one I
> wanted to implement, to deny commits reverting merge-commits.
> 
> Shouldn't git-revert work exactly as git-commit? Instead of disabling
> hooks by default, it could accept the --no-verify flag just like
> git-commit to disable the hooks if the user wants it.
> 

I think you're right that cherry-pick and revert should not be passing
--no-verify when the commit message is being edited (I was surprised to
see that they were). I wonder if it's worth getting rid of the
VERIFY_MSG flag completely and just set --no-verify if EDIT_MSG isn't
set to avoid these problems in the future. I'm worried though that
someone out there is scripting with a non-interactive editor which may
break if we start verifying the message so maybe the default should be
changed and a --no-verify option added to cherry-pick and revert
instead. They'd have to change their script but at least it would work
and everyone else would get the behaviour they probably expect.

Best Wishes

Phillip

