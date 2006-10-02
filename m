From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and time
Date: Tue, 03 Oct 2006 01:50:47 +0200
Organization: At home
Message-ID: <efs8js$gt7$1@sea.gmane.org>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com> <Pine.LNX.4.64.0609272232040.9349@xanadu.home> <7vfyec63jx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609281029300.9349@xanadu.home> <7vd59ejokp.fsf@assigned-by-dhcp.cox.net> <20060930045037.GB18479@spearce.org> <7v4pupizix.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609301033460.3952@g5.osdl.org> <7vd59d7y8v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Oct 03 01:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUXYb-0002Qr-4B
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 01:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWJBXum (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 19:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWJBXum
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 19:50:42 -0400
Received: from main.gmane.org ([80.91.229.2]:63404 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965010AbWJBXul (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Oct 2006 19:50:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GUXYT-0002PV-W7
	for git@vger.kernel.org; Tue, 03 Oct 2006 01:50:38 +0200
Received: from host-81-190-17-45.torun.mm.pl ([81.190.17.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 01:50:37 +0200
Received: from jnareb by host-81-190-17-45.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Oct 2006 01:50:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-45.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28239>

Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> On Sat, 30 Sep 2006, Junio C Hamano wrote:
>>
>>> Shawn Pearce <spearce@spearce.org> writes:
>>> 
>>> > Agreed.  I've been missing such a command and have wanted to add
>>> > one but it wasn't important enough to me to actually code it.  :)
>>> 
>>> Everything you said in your message sounds sane and makes sense
>>> to me.  Now we have to find a sucker^Wvolunteer to implement it
>>> ;-).
>>
>> Ehh. As far as I can see it's 
>>  - a damn hard thing to do efficiently
>>  - essentially exactly the same problem you already solved with "git 
>>    describe"
>>
>> In other words, I think you could make git describe do it, by simply 
>> making it parse not just all tags, but also walking the branch log.
> 
> As a user interface, I think it makes a lot of sense to have
> "git describe" do it without introducing a new command.
> 
> However, I think the traditional "find the closest ancestor"
> behaviour and ref-log behaviour are mutually incompatible, while
> they both return information to help address similar issues to
> the end user when viewed at a very high level.
> 
> Especially, "find the closest ancestor" behaviour means when you
> get "tag-gXXXX" as an answer, the tag proper does _not_ contain
> the given commit (e.g. commit v1.4.2-g4839bd8 is not part of
> v1.4.2).  To answer "when did the fix deadbeef go into master
> branch", reporting "master@{yesterday}-gdeadbeef" with the same
> logic and format is misleading; "master@{yesterday}" may be the
> closest ancestor of commit deadbeef, but that means it does
> _not_ contain the fix.  When walking ref-log, we want it the
> other way around: "find the earliest descendant among the
> entries in ref-log for a particular branch".
> 
> The internal logic for doing that may be somewhat different and
> I suspect you may not be able to share much code with the
> existing logic..

Isn't git-name-rev doing kind of earliest descendant among refs?
Well, I'm not sure if name-rev does not use shortest description
instead of earliest (closest) descendant... but we could extend it.
I'd like also to limit refs used to given pattern, and perhaps
also to only tag objects.

This is command to extend it using it together with ref-log to know
when given fix appeared in repository.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
