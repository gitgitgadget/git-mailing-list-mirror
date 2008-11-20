From: Roger Leigh <rleigh@codelibre.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 15:19:25 +0000
Message-ID: <20081120151925.GE6023@codelibre.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net> <46d6db660811190818r3aa2a392pda9106ac4a579cf0@mail.gmail.com> <20081120112708.GC22787@ravenclaw.codelibre.net> <492560C5.5070308@op5.se> <20081120141533.GC6023@codelibre.net> <49257949.4070308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian MICHON <christian.michon@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BKl-0004jO-8Y
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbYKTPT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754871AbYKTPT1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:19:27 -0500
Received: from nagini.codelibre.net ([80.68.93.164]:49119 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYKTPT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:19:27 -0500
Received: by nagini.codelibre.net (Postfix, from userid 1000)
	id 728D394672; Thu, 20 Nov 2008 15:19:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <49257949.4070308@op5.se>
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 13:26:52 up 13 days,  1:44,  3 users,  load average: 0.01,
	0.11, 0.09
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101450>

On Thu, Nov 20, 2008 at 03:50:49PM +0100, Andreas Ericsson wrote:
> Roger Leigh wrote:
>> On Thu, Nov 20, 2008 at 02:06:13PM +0100, Andreas Ericsson wrote:
>>> Roger Leigh wrote:
>>>> On Wed, Nov 19, 2008 at 05:18:16PM +0100, Christian MICHON wrote:
>>>>> On Wed, Nov 19, 2008 at 12:37 PM, Roger Leigh <rleigh@codelibre.net> wrote:
>>>>>> Would it be possible for git to store the mtime of files in the tree?
>>>>>>
>>>>>> This would make it possible to do this type of work in git, since it's
>>>>>> currently a bit random as to whether it works or not.  This only
>>>>>> started when I upgraded to an amd64 architecture from powerpc32,
>>>>>> I guess it's maybe using high-resolution timestamps.
>>>>>>
>>> Caring about meta-data the way you mean it would mean that
>>>
>>>  git add foo.c; git commit -m "kapooie"; touch foo.c; git status
>>>
>>> would show "foo.c" as modified. How sane is that?
>>
>> I've never come close to suggesting we do anything so insane.
>>
>> What I am suggesting is that on add/commit, the inode metadata
>> be recorded in the tree (like we already store perms), so that
>> it can be (**optionally**) reused/restored on checkout.
>>
>> Whether it's stored in the tree or not is a separate concern from
>> whether to *use* it or not.  For most situations, it won't be
>> useful, as has been made quite clear from all of the replies, and I
>> don't disagree with this.  However, for some, the ability to have
>> this information to hand to make use of would be invaluable.
>>
>
> Then write a hook for it. You agree that for most users this will be
> totally insane, and yet you request that it's added in a place where
> everyone will have to pay the performance/diskspace penalty for it
> but only a handful will get any benefits. That's patently absurd.

The cost is tiny.  The extra space would be smaller than a single
SHA1 hash.

> Especially since there are such easy workarounds that you can put in
> place yourself instead.


>> There have been quite a few suggestions to look into using hooks,
>> and I'll investigate this.  However, I do have some concerns
>> about *where* I would store this "extended tree" data, since it
>> is implicitly tied to a single tree object, and I wouldn't
>> want to store it directly as content.
>
> Store it as a blob targeted by a lightweight tag named
> "metadata.$sha1" and you'll have the easiest time in the world when
> writing the hooks. Also, the tags won't be propagated by default,
> which is a good thing since your timestamps/uid's whatever almost
> certainly will not work well on other developers repositories.

And yet the fact that it won't propagate makes it totally useless:
all the other people using the repo won't get the extra metadata
that will prevent build failures.  Having the extra data locally
is nice, but not exactly what I'd call a solution.  The whole point
of what I want is to have it as an integral part of the repo.


Regards,
Roger

-- 
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.
