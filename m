From: Stephen Kelly <steveire@gmail.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Tue, 06 Apr 2010 11:06:42 +0100
Message-ID: <hpetj1$6af$1@dough.gmane.org>
References: <hpcscv$umg$3@dough.gmane.org> <y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com> <vpqd3ydr9g6.fsf@bauges.imag.fr> <n2x32541b131004051236m3a800c57k41536729ae3f192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 11:07:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz4kU-0005ra-53
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab0DFJG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:06:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:45509 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157Ab0DFJG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 05:06:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nz4kG-0005mw-Rh
	for git@vger.kernel.org; Tue, 06 Apr 2010 11:06:52 +0200
Received: from dialbs-092-079-186-075.static.arcor-ip.net ([92.79.186.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 11:06:52 +0200
Received: from steveire by dialbs-092-079-186-075.static.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 11:06:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dialbs-092-079-186-075.static.arcor-ip.net
User-Agent: KNode/0.99.01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144119>

Avery Pennarun wrote:

> On Mon, Apr 5, 2010 at 3:22 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> You can even make sure it _never_ happens, by making a one-commit
>> release branch which changes the version number for each release. This
>> one-commit is never merged in anything:
>>
>> 0.1                         0.2
>> |                           |
>> v                           v
>> --o--o--o--o--o--o--o--o---o--o--o <--- master branch
>> \                      /
>> o--o--o--o--o--o--o--o--- ...  <--- maintainance branch
>> \              \
>> o <- 0.1.1     o <- 0.1.2
>>
>> Here, the maintainance branch never changes the version number in
>> README & friends.
> 
> This works too.  In fact, I even do it on one of my projects.
> However, I find it a little annoying, because then I don't know which
> version to tag: the pre-number-changed version, or the
> post-number-changed version.
> 
> The latter sounds like the obvious answer, but if I do that, then "git
> describe" never says anything useful on my master branch.  But if I do
> the former instead, then the tag doesn't accurately reflect the
> version I *actually* released.
> 
> I've never found an adequate solution to this problem, other than not
> including the version number in the repo at all.

Hi all, 

Thanks for the pointers. I considered the above solution too, but 
disregarded it for the same reason.

I also considered the git describe solution, but disregarded it because in 
CMake I need to know each component of the version separately 
(Grantlee_VERSION_MAJOR, Grantlee_VERSION_MINOR and Grantlee_VERSION_PATCH). 
I could split it on '.', but I think the better solution is to just put the 
version into the CMake files and deal with the conflict in that one place as 
it comes up. I can always switch in the future anyway if using describe 
makes more sense.

> you might want to have a look at this: http://nvie.com/git-model

Yes, that is an interesting read, but he doesn't cover this issue. In fact, 
he references a fictional script which updates the version number in the 
tracked files.

Junio C Hamano wrote:
>> Additionally, I have some stuff currently in master that should not be in
>> the 0.1 release, but should be in the 0.2 release. If I branch and then
>> remove those files from the 0.1 branch, a merge will then remove them
>> from master too? How do I keep them on master but delete them on 0.1 and
>> still be able to merge from 0.1 into master?
> 
> You do not have to fork maint-0.1 branch from the tip of the master.  In
> the earlier parts of the master branch there must be a point where
> everything before are for 0.1 and all things after that are not, and you
> fork from there.  After that, queue changes that are applicable to both to
> the 0.1 branch and merge that to 'master' as necessary, while queueing
> changes not for 0.1 to 'master'.
> 

There might be such a point, yes, but there are also likely commits which 
touch files which should be included and files which should not, so I'd 
probably end up rebasing ancient history of master and or creating a big 
mess.

I think for this situation the best solution is indeed the merge_revert 
commit.

Thanks for the responses.

All the best,

Steve.
