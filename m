From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2013, #08; Tue, 23)
Date: Wed, 24 Apr 2013 10:30:02 +0200
Message-ID: <5177980A.4090305@viscovery.net>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org> <7vwqrtgi1r.fsf@alter.siamese.dyndns.org> <51779052.8020507@viscovery.net> <CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 10:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUv5o-000256-4r
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 10:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab3DXIaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 04:30:10 -0400
Received: from so.liwest.at ([212.33.55.23]:64012 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab3DXIaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 04:30:07 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UUv5X-00072z-1E; Wed, 24 Apr 2013 10:30:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C3FDB1660F;
	Wed, 24 Apr 2013 10:30:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222239>

Am 4/24/2013 10:04, schrieb Felipe Contreras:
> On Wed, Apr 24, 2013 at 2:57 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 4/23/2013 21:31, schrieb Junio C Hamano:
>>> * fc/transport-helper-error-reporting (2013-04-17) 9 commits
>>>   (merged to 'next' on 2013-04-22 at 5ba6467)
>>>  + transport-helper: update remote helper namespace
>>>  + transport-helper: trivial code shuffle
>>>  + transport-helper: warn when refspec is not used
>>>  + transport-helper: clarify pushing without refspecs
>>>  + transport-helper: update refspec documentation
>>>  + transport-helper: clarify *:* refspec
>>>  + transport-helper: improve push messages
>>>  + transport-helper: mention helper name when it dies
>>>  + transport-helper: report errors properly
>>>
>>>  Update transport helper to report errors and maintain ref hierarchy
>>>  used to keep track of remote helper state better.
>>>
>>>  Will merge to 'master'.
>>
>> Please don't, yet. There is a new test case that fails on Windows. I'll
>> have to figure out a work-around.
> 
> Which test case? If it it failed, it failed before this series. I
> don't see how this new series would affect anything.

The test introduced in the commit at the tip: 'push update refs'.
More precisely:

---- 8< ----
D:\Src\mingw-git\t>sh t5801-remote-helpers.sh
ok 1 - setup repository
ok 2 - cloning from local repo
ok 3 - create new commit on remote
ok 4 - pulling from local repo
ok 5 - pushing to local repo
ok 6 - fetch new branch
ok 7 - fetch multiple branches
ok 8 - push when remote has extra refs
ok 9 - push new branch by name
not ok 10 - push new branch with old:new refspec # TODO known breakage
ok 11 - cloning without refspec
ok 12 - pulling without refspecs
ok 13 - pushing without refspecs
ok 14 - pulling without marks
not ok 15 - pushing without marks # TODO known breakage
ok 16 - push all with existing object
ok 17 - push ref with existing object
not ok 18 - push update refs
#
#               (cd local &&
#               git checkout -b update master &&
#               echo update >>file &&
#               git commit -a -m update &&
#               git push origin update
#               git rev-parse --verify remotes/origin/update >expect &&
#               git rev-parse --verify testgit/origin/heads/update >actual &&
#               test_cmp expect actual
#               )
#
ok 19 - proper failure checks for fetching
ok 20 - proper failure checks for pushing
ok 21 - push messages
ok 22 - push signed tag
ok 23 - push signed tag with signed-tags capability
# still have 2 known breakage(s)
# failed 1 among remaining 21 test(s)
1..23
---- 8< ----

The verbose failure is:

---- 8< ----
expecting success:
        (cd local &&
        git checkout -b update master &&
        echo update >>file &&
        git commit -a -m update &&
        git push origin update
        git rev-parse --verify remotes/origin/update >expect &&
        git rev-parse --verify testgit/origin/heads/update >actual &&
        test_cmp expect actual
        )

Switched to a new branch 'update'
[update 86cfeec] update
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
d:/Src/mingw-git/git-remote-testgit: cannot make pipe for process substitution: Function not implemented
d:/Src/mingw-git/git-remote-testgit: cannot make pipe for process substitution: Function not implemented
d:/Src/mingw-git/git-remote-testgit: line 97: join: command not found
Everything up-to-date
fatal: Needed a single revision
not ok 18 - push update refs
---- 8< ----

An example of a successful test is this:

---- 8< ----
expecting success:
        (cd local &&
         git checkout -b new-name  &&
         echo content >>file &&
         git commit -a -m seven &&
         git push origin new-name
        ) &&
        compare_refs local HEAD server refs/heads/new-name

Switched to a new branch 'new-name'
[new-name 455466e] seven
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
d:/Src/mingw-git/git-remote-testgit: cannot make pipe for process substitution: Function not implemented
d:/Src/mingw-git/git-remote-testgit: cannot make pipe for process substitution: Function not implemented
d:/Src/mingw-git/git-remote-testgit: line 97: join: command not found
Everything up-to-date
ok 9 - push new branch by name
---- 8< ----

-- Hannes
