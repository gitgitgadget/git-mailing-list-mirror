X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 10:36:19 +0100
Message-ID: <456C0313.3020308@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org> <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net> <20061122034056.GB23856@spearce.org> <20061123232313.GB24909@nan92-1-81-57-214-146.fbx.proxad.net> <20061125065338.GC4528@spearce.org> <20061125111235.GO5443@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251037000.6991@woody.osdl.org> <45689747.3020403@midwinter.com> <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org> <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 09:36:41 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32500>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GozO5-0005QS-5n for gcvg-git@gmane.org; Tue, 28 Nov
 2006 10:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758644AbWK1JgW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 04:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758645AbWK1JgW
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 04:36:22 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:37306 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1758644AbWK1JgV (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 04:36:21 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CA9796BCBE; Tue, 28 Nov 2006 10:36:19 +0100 (CET)
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

Daniel Barkalow wrote:
> On Sat, 25 Nov 2006, Linus Torvalds wrote:
> 
>> On Sun, 26 Nov 2006, Yann Dirson wrote:
>>> Also, I'd rather expect "git-commit -a" outside of any submodule to
>>> commit everything in the supermodule, triggering submodule commits as an
>>> intermediate step when needed - just like "git-commit -a" does not
>>> require to manually specify subdirectories to inclue in the commit.  I'd
>>> rather expect a special flag to exclude submodules from a commit.
>> So, how do you do commit messages? It generally doesn't make sense to 
>> share the same commit message for submodules - the sub-commits generally 
>> do different things.
> 
> The same way you do the first commit message. Ask independantly for each 
> commit message in sequence with enough context in the comment section that 
> you know what you're talking about.
> 
>> I'd actually suggest that "git commit -a" with non-clean submodules error 
>> out for that reason, with something like
>>
>> 	submodule 'src/xyzzy' is not up-to-date, please commit changes to 
>> 	that first.
>>
>> exactly because you really generally should consider the submodule commits 
>> to be a separate phase.
> 
> I think this is getting close to the classic usability blunder of having 
> the program tell you what you should have done instead of what you did, 
> and then making you do it yourself, rather than just doing it.
> 
> Just have it run "git commit -a" in each dirty submodule recursively as 
> part of preparing the index, since that's what the user wants to do 
> anyway, and nothing already done would be affected.
> 

Running "commit -a" is definitely the wrong thing to do, as it prevents 
one from using the index at all. Erroring out if the submodules are 
dirty, or just accepting the fact that they are and taking whatever 
commit HEAD points to is *always* preferrable.

I'd actually prefer the second solution here and let git print a list of 
submodules with dirty state and ask for some sort of user-response 
before creating the actual commit. As non-interactive commits should 
always be clean, requiring user intervention on non-clean state should 
be a safe thing to do.

> "git commit -a -m <message>" should probably fail, of course.
> 

Why? There's no reason to rob this command of its power just because 
we're using submodules.

> 	-Daniel
> *This .sig left intentionally blank*
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
