From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Wed, 16 Jan 2013 17:59:54 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161756240.21503@nftneq.ynat.uz>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz> <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
 <A0DB01D693D8EF439496BC8B037A0AEF32209AD2@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvenX-0007YE-7L
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 03:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab3AQCBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 21:01:22 -0500
Received: from mail.lang.hm ([64.81.33.126]:59164 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758059Ab3AQCBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 21:01:22 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0H21J4E028777;
	Wed, 16 Jan 2013 18:01:19 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF32209AD2@xmb-rcd-x15.cisco.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213835>

On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:

>> From: David Lang [mailto:david@lang.hm]
>>
>> Linus says that git does not have "proper locking", so think about it,
>> what do
>> you think will happen if person A does git add a/b; git commit and person
>> B does
>> git add c/d; git commit?
>
> Sorry, I wasn't clear. My assumption is that a shared repository on a network file system will either be:
>
> 1. a bare repository that is normally accessed only by "git push" and "git pull" (or "git fetch"), the central repository model.

pulling from it would not be a problem, I could see issues with multiple pushes 
taking place (the underlying repository would not get corrupted, but you will 
very quickly hit conflicts where the push is not a fast forward and you need to 
merge, not just push)

> 2. a repository where only one user does "git add" and "git commit", while 
> other users will do "git pull", the peer-to-peer model (you pull changes from 
> me, I pull changes from you).

At this point only one system is writing to the repository and it doesn't matter 
that it's on network storage vs local storage.

pulling from a shared repository is probably safe, but I wouldn't bet against 
there being any conditions where a pull at the same time someone is doing an 
update being able to cause problems.

The normal thing is to do the pulls through git-daemon, and that does make sure 
that what you are pulling is consistant.

David Lang
