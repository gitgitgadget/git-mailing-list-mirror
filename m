X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 11:50:38 +0200
Message-ID: <454084EE.90006@op5.se>
References: <45357CC3.4040507@utoronto.ca>	 <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se>	 <200610251146.06116.jnareb@gmail.com>	 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 09:51:16 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30172>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1st-0005rC-5k for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423047AbWJZJuo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423049AbWJZJuo
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:50:44 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:19846 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423047AbWJZJun (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:50:43 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 097156BD65; Thu,
 26 Oct 2006 11:50:41 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 90B546BD65; Thu, 26 Oct 2006 11:50:38 +0200 (CEST)
To: James Henstridge <james@jamesh.id.au>
Sender: git-owner@vger.kernel.org

James Henstridge wrote:
> On 25/10/06, Carl Worth <cworth@cworth.org> wrote:
>> On Wed, 25 Oct 2006 18:08:22 +0800, "James Henstridge" wrote:
>> > If there aren't, or you made the merge by mistake, you can make a call
>> > to "bzr revert" to clean things up without ever having created a new
>> > revision.
>>
>> One result of this approach is that developers of different trees
>> don't necessarily have common revision IDs to compare. Imagine a
>> question like:
>>
>>         When you ran that test did you have the same code I've got?
>>
>> In git, the answer would be determined by comparing revision IDs.
> 
> Can you really just rely on equal revision IDs meaning you have the
> same code though?
> 

Yes. Because each commit contains parent revision id's, which in turn 
contain *their* parent revision id's, which in turn..., you know you 
have exactly the same revision, code, and history leading up to that 
revision. You may have other revisions on top or on other branches, but 
all commits, including merge-points and whatnot, leading to that 
particular revision id are EXACTLY identical.

> Lets say that I clone your git repository, and then we both merge the
> same diverged branch.  Will our head revision IDs match?  From a quick
> look at the logs of cairo, it seems that the commits generated for
> such a merge include the date and author, so the two commits would
> have different SHA1 sums (and hence different revision IDs).
> 
> So I'd have a revision you don't have and vice versa, even though the
> trees are identical.
> 

Merges preserve author and commit info. You may need to create a new 
branch (a git branch, the cheap kind which is a 41-byte file) and fetch 
"his" into "yours". This will be very cheap if you both have the same 
code but not the same history, as everything but a few commit-objects 
will be shared. A more likely scenario though is this;

Bob writes a feature that doesn't work as per spec. He doesn't know why.
He asks Alice to have a look, so he communicates the commits to her by 
"please pull this branch from here", or by sending patches and telling 
Alice the branch-point revision to apply them to.
Alice creates the "bobs-bugs/nr1232" at the branch-point and fetches 
Bobs branch into that or applies the patches on top of that (in the 
fetch scenario she wouldn't need to know the branch point, since git 
would figure this out for her).
She knows this should create a revision named 00123989aaddeddad39, so if 
it doesn't, she doesn't have the same code.


I imagine this works roughly the same in bazaar, although the original 
case where tests have already been done and the testers wanted to know 
if they had the exact same revision Just Works in git.

> 
>> In bzr, the only answer I'm hearing is attempting a merge to see if it
>> introduces any changes. (I'm deliberately avoiding "pull" since we're
>> talking about distributed cases here).
> 
> Or run "bzr missing".  If the sole missing revision is a merge (and
> not the revisions introduced by the merge), you could assume that you
> have the same tree state.
> 

"assume" != "know", or was that just sloppy phrasing?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
