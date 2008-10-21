From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Archiving tags/branches?
Date: Mon, 20 Oct 2008 21:08:31 -0700
Message-ID: <48FD55BF.1020207@pcharlan.com>
References: <48F93F52.4070506@pcharlan.com>	<200810181315.49265.johan@herland.net> <20081018130204.GB3749@neumann>	<200810181532.59883.johan@herland.net> <48FC26DA.10508@pcharlan.com> <m3prlvibb7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	SZEDER Gabor <szeder@ira.uka.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 06:09:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks8Z1-0002he-RD
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 06:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbYJUEIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 00:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbYJUEIe
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 00:08:34 -0400
Received: from lax-green-bigip-5.dreamhost.com ([208.113.200.5]:53000 "EHLO
	swarthymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750747AbYJUEId (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 00:08:33 -0400
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a5.g.dreamhost.com (Postfix) with ESMTP id 65B68109EB6;
	Mon, 20 Oct 2008 21:08:32 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <m3prlvibb7.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98756>

Jakub Narebski wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> Johan Herland wrote:
> 
>>> BTW, the best way IMHO to archive old refs is to clone your repo
>>> (with all tags/branches) to a backup disk, and then regularly push
>>> (git push --all && git push --tags) your new tags/branches to this
>>> backup. You are now free to delete these tags/branches from your
>>> work repo (they will not be deleted from the backup unless you use
>>> "git push --mirror"). And if you ever need to retrieve an old
>>> tag/branch, it's just a matter of pulling it from the backup
>>> repo. Nice, clean, flexible, and requires no changes to git.
>> Thank you; that indeed seems to work and solves the problem of managing
>> refs/archived-tags manually.
>>
>> Using a secondary repo solely to overcome a flat tag/branch namespace
>> feels hackish.  Perhaps git will benefit someday from work in this area,
>> but until I come up with a patch your suggestion should work fine.  Just
>> knowing I didn't overlook an existing feature helps a lot.
> 
> I don't quite understand what you mean by _flat_ namespace for tags
> and branches.
> 
> First, it is not unusual to have hierarchical branch names, at least
> for short-term topic branches. For example in git.git history (and in
> "What's cooking..." announcements on git mailing list) you can find
> branch names such as rs/alloc-ref, nd/narrow, tr/workflow-doc.
> Additionally remote-tracking branch names have inherently hierarchical
> names: refs/remotes/<remote>/<remote branch>.  While tag names usually
> are of the type x.y.z, it is not mandated by some technological
> limitation.

What I mean by "flat" is that "/" is just another character as far as
what git exposes to the user.  Regardless of any semantics the user
chooses to assign to it, and regardless of what advantage git makes use
of "/" internally, unless I can do something like:

% git tag --ls
sometag
someothertag
releases/
% git tag --ls releases/
releases/2008/
releases/2007/
% git tag --ls releases/2008
releases/2008/r3.14
%

"/" is just like any another character in a tag or branch.

(The above notional --ls modifier is probably very easy to write, and if
I do so it may address all of my woes.  Subversion's branching/tagging
can be organized pretty much exactly like this, and importing into git
such a repository is what initially led me to ask about organizing tags
and branches.)

What I'm usually likely to want from a "list tags" command is to see the
most recent few tags, not (say) all 226 tags in git.git.  I'll probably
write a little alias that does that, but even then when looking at the
whole list it would be nice to have the option to navigate it
hierarchically.  (Or in some other manner, and/or possibly with a
configurable directory separator.)

> Second, you can always put your archived refs in another namespace,
> beside 'heads', 'tags', and 'remotes'. I for example use
> refs/tags/Attic for lightweigth tags to some interesting abandoned
> experiments, but it could have been refs/deleted/tags, or
> refs/Attic/tags.

My original question was asking whether this sort of thing would work
(e.g., they would never be automatically pruned), and I'm happy to see
that the answer is yes.  The main downside to it is that you can't
clone/pull/push changes to it using git.

Many thanks to you and everyone for their help.  Git is so flexible that
it can be difficult when starting out to know whether you're missing a
way of attacking a problem.

--Pete

> Last, please remember that there exists something like packed refs
> format (see git-pack-refs(1)... oops, it dies not describe
> .git/packed-refs format, unfortunately).
