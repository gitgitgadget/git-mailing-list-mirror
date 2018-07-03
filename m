Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1841F1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeGCV4K convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 3 Jul 2018 17:56:10 -0400
Received: from mail.redfish-solutions.com ([66.232.79.143]:48184 "EHLO
        mail.redfish-solutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753105AbeGCV4J (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Jul 2018 17:56:09 -0400
Received: from macmini.redfish-solutions.com (macmini.redfish-solutions.com [192.168.1.38])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.15.2/8.15.2) with ESMTPSA id w63Lu8IR002836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 15:56:08 -0600
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Better interoperability with Bitkeeper for fast-import/-export
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <CABPp-BFbDx4z2TiqiexyNJzA5UC5D7ZH6Uw-XLXeG3tDCHRKog@mail.gmail.com>
Date:   Tue, 3 Jul 2018 15:56:06 -0600
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D7D581C6-6349-4319-895C-55930431A933@redfish-solutions.com>
References: <E37C3A33-489B-4FEB-9170-097514B41317@redfish-solutions.com>
 <CABPp-BFbDx4z2TiqiexyNJzA5UC5D7ZH6Uw-XLXeG3tDCHRKog@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Scanned-By: MIMEDefang 2.84 on 192.168.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jul 3, 2018, at 3:27 PM, Elijah Newren <newren@gmail.com> wrote:
> 
> Hi Philip,
> 
> On Tue, Jul 3, 2018 at 1:40 PM, Philip Prindeville
> <philipp_subx@redfish-solutions.com> wrote:
>> Hi.
>> 
>> I tried to import into git a repo that I was working on (because it just seemed easier), but when I tried to export the repo back out after making my changes I found it choking on a few things.
>> 
>> It was explained to me (by the Bitkeeper folks) that git meta-data doesn’t accurately track file moves…  If a file disappears from one place and reappears in another with the same contents, that’s assumed to be a move.
>> 
>> Given that “git mv” is an explicit action, I’m not sure why that wouldn’t be explicitly tracked.
> 
> Not a full explanation, but see
> https://git-scm.com/book/en/v2/Git-Internals-Moving-Files


Why not add the logic to track moves/renames?  That link explains what it does, but not why it does it.


> 
>> But I’ve not looked too closely under the covers about how git represents stuff, so maybe there’s more to it than I’m assuming.
>> 
>> During an export using “-M” and “-C”, Bitkeeper complained:
> 
> Why would you add -C?  Does bitkeeper also track copies?


I figure that I’d furnish the maximum amount of meta data, and bitkeeper would use what it could and ignore the rest.


> 
>> fast-import: line 'R ports/winnt/libntp/nt_clockstuff.c ports/winnt/ntpd/nt_clockstuff.c' not supported
>> 
>> so I tried removing those two options, and it got further, this time stalling on:
>> 
>> fast-import: Unknown command: tag ntp-stable
> 
> If the fast-import command you are using can't read tags, then perhaps
> you should report that to the authors of the fast-import tool you are
> using and/or only feed branches to your fast-export command.


Well, I’ll just do branches for now…


> 
>> I like git, mostly because I’ve used it a lot more… and I like the GitHub service.  I use Bitkeeper because a few projects I work on are already set up to use it and it’s not my call whether it’s worth the effort to make the conversion or live with it.
>> 
>> So… this is an appeal for both to play better together.
>> 
>> What’s involved in getting git to track file/directory moves/renames so that it’s palatable to Bitkeeper?
> 
> Not tracking file/directory moves/renames wasn't an oversight but a
> fundamental design decision; see e.g.
> https://public-inbox.org/git/Pine.LNX.4.64.0510211826350.10477@g5.osdl.org/.


"I'm convinced that git handles renames better than any other SCM ever. 
Exactly because we figure it out when it matters.”

I disagree.  When the move happens, there’s a commit message that goes along with that.  There’s an insight into why the move is happening.

That’s something that software can’t do for you.


> 
> However, supposing that we did track renames, how would we tell
> bitkeeper?  Well, we'd print out a line that looks like this in the
> fast-export:
> 
> 'R ports/winnt/libntp/nt_clockstuff.c ports/winnt/ntpd/nt_clockstuff.c'
> 
> which is precisely the line that bitkeeper's fast-import was choking
> on.  So, it sounds like they don't support importing rename
> information (or at least the version of fast-import you're using
> doesn't).  I think this is where the bug is; you'll probably want to
> report it to whoever maintains the fast-import command that is choking
> on this line.


Already done:

https://users.bitkeeper.org/t/using-fast-import-from-git-into-bk/907

Not sure I understand the response:

"The rename info that git gives us is a guess, that’s why there is that 0-100% next to it, that’s showing you how much of the two versions of the file were identical. So that info is unreliable, it’s just a guess."

Okay, what’s stopping them from doing their best with the information provided, even if it is a guess?

By the way, what happens when you interactively rebase a bunch of commits, change their order, and in the middle of an “edit”, do a “git mv … …” followed by a “git commit --amend && git rebase --continue”?

-Philip



> 
> Once that's fixed, you can export from git with the -M flag, and from
> that output, there'll be no way to tell whether the original
> repository tracked renames or detected them after the fact.
> 
> 
> Hope that helps,
> Elijah

