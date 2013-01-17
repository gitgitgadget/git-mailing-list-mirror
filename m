From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Wed, 16 Jan 2013 17:26:13 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com> <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz> <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: "Matt Seitz (matseitz)" <matseitz@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:28:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TveGw-0003TK-2m
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 02:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095Ab3AQB1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 20:27:41 -0500
Received: from mail.lang.hm ([64.81.33.126]:44878 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab3AQB1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 20:27:41 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0H1RcbX028504;
	Wed, 16 Jan 2013 17:27:38 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213833>

On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:

>> From: David Lang [mailto:david@lang.hm]
>>
>> On Wed, 16 Jan 2013, Matt Seitz (matseitz) wrote:
>>
>>> Linus seemed to think it should work:
>>>
>>> http://permalink.gmane.org/gmane.comp.version-control.git/122670
>>
>> In the link you point at, he says that you can have problems with some
>> types of
>> actions. He points out things like git prune,
>
> Linus wrote:
>
> You do need to be a bit careful if you do maintenance operations
> concurrently (I would suggest avoiding doing concurrent "git gc --prune",
> for example), but any normal git workflow should be fine.
>
>> but I would also say that there
>> are probably race conditions if you have two git processes that try to
>> change the HEAD to different things at the same time.
>
> What makes you think there are race conditions?
>
> Linus wrote:
>
> And git doesn't have "proper locking", because it doesn't need it for
> database ops: git objects are stable. For refs, git should be using the
> proper NFS-safe "create and atomic rename" ops.

As Linus points out, objects are stable, so when you create objects you don't 
have to worry about locking, if two things write an object at the same time, the 
same contents are being written so races don't matter.

However, if you have two people doing a commit or merge, you will get different 
results based on the order they are happening in. This seems to be exactly the 
type of thing that falls into the 'maintinance operations' category.

Linus says that git does not have "proper locking", so think about it, what do 
you think will happen if person A does git add a/b; git commit and person B does 
git add c/d; git commit?

Since the tree will look different depending on what order these four commands 
execute in, the resulting HEAD could have multiple different values depending on 
the order. The individual commits may even be different.

David Lang

>>> And "git init" specifically has a "shared" option:
>>>
>>> --shared[=(false|true|umask|group|all|world|everybody|0xxx)]
>>
>> I think this is dealing with multiple users _reading_ a repository, not
>> making
>> updates to it at the same time.
>
> The description of "shared" says "This allows users belonging to the same 
> group to push into that repository."  The "push" command is about making 
> updates.
