From: Jehan Bing <jehan@orb.com>
Subject: Re: git-svn branches with revision id's in name
Date: Thu, 02 Feb 2012 11:03:21 -0800
Message-ID: <4F2ADDF9.9090507@orb.com>
References: <CAGYrzvwzrsZdHHnSBaMv-sD9mDGVQ-qFuks+JM6d-NQ9Wz9KwQ@mail.gmail.com> <4F2A807B.9050206@T-Online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Duncan Jr <stephen.duncan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 20:03:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1wc-0000Mz-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab2BBTDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:03:38 -0500
Received: from plane.gmane.org ([80.91.229.3]:37628 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757002Ab2BBTDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:03:37 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rt1wT-0000ID-D9
	for git@vger.kernel.org; Thu, 02 Feb 2012 20:03:33 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 20:03:33 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 20:03:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <4F2A807B.9050206@T-Online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189673>

On 2012-02-02 04:24, Carsten Fuchs wrote:
> Hi all,
>
> Am 2012-01-30 20:42, schrieb Stephen Duncan Jr:
>> [...]
>> $ git branch -a
>> * master
>> remotes/develop
>> remotes/develop@29271
>> remotes/develop@32463
>> remotes/develop@34103
>> remotes/feature/xyz
>> remotes/feature/xyz@26438
>> remotes/feature/xyz@27542
>> remotes/feature/xyz@35233
>>
>> Why have these remote branches been created? What impact does this
>> have on my checkout? Can I remove safely remove them? How? I was
>> unable to figure out how to reference this behavior in order to search
>> for information on it.
>
> Same questions here.
> (I know how to remove them, but I'd love to learn and understand why
> they have been created.)

Those are branches that have been deleted and then recreated later.
In svn, you can always get a deleted branch back by checking out an old 
revision. But in git, branches are not part of the history, so when you 
delete a branch, it's completely gone, as if it never existed, taking 
with it any commit that has not been merged elsewhere.
To prevent that loss, git-svn doesn't delete branches. But if the branch 
was re-created later in svn, you would get a conflict in git. So 
instead, git-svn rename the old branch by adding the revision number 
where the branch last existed, i.e. the revision before it was deleted.

So in the OP case, the branch "develop" was deleted at least 3 times, at 
r34104, r32464 and r29272. The last one may also have been deleted too 
but then it was not re-created so git-svn didn't rename yet.
