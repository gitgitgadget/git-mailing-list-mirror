From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 01 Mar 2006 17:07:26 +0100
Message-ID: <4405C6BE.2000706@op5.se>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu> <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com> <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net> <44056BF1.6000109@op5.se> <Pine.LNX.4.64.0603010745320.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 17:08:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETrR-0005X1-TE
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 17:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCAQH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWCAQH3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 11:07:29 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43983 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932402AbWCAQH2
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 11:07:28 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E93F06BCBE; Wed,  1 Mar 2006 17:07:26 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603010745320.22647@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16986>

Linus Torvalds wrote:
> 
> On Wed, 1 Mar 2006, Andreas Ericsson wrote:
> 
>>Eric Wong wrote:
>>
>>>Should rev-parse be taught to be less strict and look for basenames
>>>that can't be found in heads/ and tags/ in other directories?
>>
>>It already does. The search order is this, for a ref named 'foo':
>>	$GIT_DIR/foo
>>	$GIT_DIR/refs/foo
>>	$GIT_DIR/refs/tags/foo
>>	$GIT_DIR/refs/heads/foo
> 
> 
> Yes, but I think Eric wanted to avoid having to write the prefix part, 
> which git won't let you do right now.
> 
> If you have a ref in .git/refs/svn-tracker/git-svn-HEAD, you would have to 
> write out all of "svn-tracker/git-svn-HEAD", because unlike a "real 
> branch", get_sha1() won't look into the "svn-tracker" without it being 
> explicitly mentioned.
> 
> Now, some tools will actually do "for_each_ref()" and check the ref-name 
> against each of them (so if you pass in "foo", it will check them afainst 
> _any_ ref-subdirectory that contains "foo"). But get_sha1() won't.
> 

Didn't know that. The day is not a complete waste then.


> We could fix get_sha1(), but part of the logic was that other 
> subdirectories are special, and as such they _should_ be mentioned, so 
> that a file in such a special directory isn't ever confused with a real 
> branch.
> 
> But if you were to use for example .git/refs/git-svn/tracking as the 
> svn-tracking reference head, and then you'd be perfectly able to use
> 
> 	git log git-svn/tracking..
> 
> to see what you've done since the last svn import?
> 

Personally I'm all for namespace separation. I'm assuming the script has 
the tracker-branch hardcoded anyway, so I don't really understand why it 
would be necessary to keep other refs in a separate directory and, if it 
*is* necessary, why that subdirectory can't be .git/refs/heads/svn.

Eric mentioned earlier that the tracking-branch can't be committed to 
(ever), so the user convenience for searching other directories should 
be nearly non-existant.

Perhaps I'm missing something obvious. Perhaps I'm just stupid. Perhaps 
the pub just opened and I don't feel like reading it twice to make sure 
I understood. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
