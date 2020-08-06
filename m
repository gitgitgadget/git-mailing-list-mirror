Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B289C47436
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F2B2313F
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgHFIQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:16:58 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50832 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgHFIQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 04:16:53 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4BMhD254TZz5tlD;
        Thu,  6 Aug 2020 10:16:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D5DFB43C;
        Thu,  6 Aug 2020 10:16:49 +0200 (CEST)
Subject: Re: [PATCH 2/3] mergetool-lib: keep a list of cross desktop merge
 tools
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=c3=b1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=c3=b1o?= =?UTF-8?Q?=29?= 
        <mail@3v1n0.net>
Newsgroups: gmane.comp.version-control.git
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4ef90c30-6c06-a355-69eb-9c8e10c6bef6@kdbg.org>
Date:   Thu, 6 Aug 2020 10:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.08.20 um 23:08 schrieb Eric Sunshine:
> On Wed, Aug 5, 2020 at 3:53 PM Marco Trevisan (Treviño) via
> GitGitGadget <gitgitgadget@gmail.com> wrote:
>> Instead of repeating the same tools multiple times, let's just keep them
>> in another variable and list them depending the current desktop
>>
>> Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
>> ---
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> @@ -288,11 +288,12 @@ list_merge_tool_candidates () {
>>         if test -n "$DISPLAY"
>>         then
>> +               cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
>>                 if is_desktop "GNOME"
>>                 then
>> -                       tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
>> +                       tools="meld $cross_desktop_tools $tools"
>>                 else
>> -                       tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>> +                       tools="$cross_desktop_tools meld $tools"
>>                 fi
> 
> I have mixed feelings about this change. On the one hand, I see the
> reason for doing it if the list of tools remains substantially the
> same in each case, but it also seems like it could become a burden,
> possibly requiring factoring the list into more pieces, as new
> platforms or tools are added.
> 
> What I might find more compelling is creation of a table of tools and
> the platforms for which they are suitable. It doesn't seem like it
> would be too difficult to express such a table in shell and to extract
> the desired rows (but that might be overkill). At any rate, I'm rather
> "meh" on this change, though I don't oppose it strongly.

There may be some confusion caused by the name of the new variable. A
better name would perhaps be $tools_with_desktop_dependent_preference.
(That's a tongue-in-cheek suggestion, BTW.)

On a side note, the refactoring that happened in 21d0ba7ebb0c
("difftool/mergetool: refactor commands to use git-mergetool--lib",
2009-04-08) did not preserve the original order of diff tools. The
spirit was to prefer meld over kompare and kdiff3 with GNOME, and the
other way round with KDE. But since that refactoring, kompare is always
first in the list.

-- Hannes
