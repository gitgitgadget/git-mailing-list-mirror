From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Tue, 13 Dec 2011 22:44:19 +0100
Message-ID: <4EE7C733.4010209@web.de>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx> <4EE682A3.8070704@web.de> <4EE71E9F.90204@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:44:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raa9b-0007h2-N3
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646Ab1LMVor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:44:47 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:60858 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab1LMVoq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:44:46 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id DAAF267E4F58
	for <git@vger.kernel.org>; Tue, 13 Dec 2011 22:44:21 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LqlAw-1R570Y3cw6-00eJ0y; Tue, 13 Dec 2011 22:44:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EE71E9F.90204@ursus.ath.cx>
X-Provags-ID: V02:K0:ezdK9kwAvOaAkOa9VzCvkAMpwkmL0YL5tjoj4EI4Sh5
 OrRTRS/ObiKHo1zzSrwPEkTcc0G25NvsKHWwUOCaP4nxbNun27
 QjAGw8JS7HtfCqGLDTocbWNP2fBGb2B+hTPm8ZTaBExiO8aJF3
 H35i72q38LcGuJFiXn7i0aVR9a8iTItSfpjTW7Pswu47URdkH8
 x14rid59h16fimkqQxPQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187065>

Am 13.12.2011 10:45, schrieb Andreas T.Auer:
> On 12.12.2011 23:39 Jens Lehmann wrote:
>>  Am 11.12.2011 22:15, schrieb Andreas T.Auer:
>> > The other use case wants to follow the commits of that other
>> > submodule without checking the corresponding gitlinks into the
>> > superproject. But wouldn't it also make sense here to define
>> > actually a mapping in the .gitmodule that says "if the branch
>> > 'develop' is checkedout in the supermodule then with every
>> > submodule update automatically pull the newest 'unstable' commit
>> > from the submodule"? Or for "master" follow "stable" or for the
>> > "maint" branch follow updates in the "bugfixes" branch.
>> >
>> > For example
>> >
>> > [submodule "commonlib"] update = heads develop:unstable
>> > master:stable maint:bugfixes
>>
>>  Having that configured with "branch=unstable", "branch=stable" etc.
>>  in .gitmodules on the superprojects branches would be simpler and
>>  achieve the same functionality.
> 
> Yes, this has been my first thought also, but there is also a good point to keep the .gitmodules stable, or you always have to change the file when branches change their names. So when the maint branch of version 1.3 become an archive branch and the new maint is on 1.4, which was the master before then you have to change the .gitmodules on these branches. I.e. .gitmodules of 1.4 have "stable" and must have "bugfixes" now and .gitmodules of 1.3 has "bugfixes" and must remove the floating completely. I'm not sure that this can always be solved with "easy" merging and therefore it is probably not really simpler, when you have to do this for every new release. Or what do you think?

I never rename branches, so I do not concur ;-) And I think the
.gitmodules file could benefit from a special merge driver being
aware of the format and some subtleties (like not just adding a
"branch" setting but rather creating a merge conflict) anyways.
So I'd prefer to keep it simple and just use the .gitmodules we
already have which can be different in different branches.

>> > So whenever a defined branch is checked out in the superproject
>> > the mapped branch will be checked out in the submodule ("new"
>> > commit), but if a (e.g. tagged) commit is checked out ("old"
>> > commit) then the gitlink in the superproject is used to check out
>> > the referenced commit in the submodule.
>>
>>  I think checkout should only use the submodule commit recorded in the
>>  superproject and a subsequent "git submodule update" should be needed
>>  to update the submodule to tip. Otherwise you record SHA-1 but still
>>  won't be able to bisect ...
> 
> bisect would leave the branch and therefore uses the recorded SHA1 for the submodule checkout instead of the tip. "follow-the-tip" should only work if the superproject follows the tip.

If you follow a tip there won't be any new SHA-1s recorded during
that following so you could not do a bisect and expect the submodule
to be what the developer had when doing the commits, no?

> If you configure auto-update on checkout you would not expect that a separate git submodule update has a different behavior.

Sure you do, when auto-update on checkout is active "git submodule update"
becomes a no-op for the exact submodule model, as "git checkout" will do
all the work "git submodule update" did before.

>> > In http://thread.gmane.org/gmane.comp.version-control.git/183837
>> > was discussed whether the gitlink in the superproject should be
>> > set to all-zero if updates follow the tip or maybe use the SHA1 of
>> > the commit when the submodule was added. I think the gitlink should
>> > be updated everytime when a new commit in the superproject is
>> > created.
>>
>>  Nope, only when "git submodule update" is run. Otherwise you'll
>>  spray the history with submodule updates totally unrelated to the
>>  commits in the superproject, which is rather confusing.
> 
> Of course, committing a new version to the superproject should not trigger pulling in a new version for the submodule or an automatic jump to the tip of the submodule. I just meant a normal manual "commit -a" behavior. Putting a 0{40} hash in the gitlink or only the hash of the submodule, when it first was added would be a special treatment that is neither needed nor wanted.

I don't get that, what SHA-1 do you want to put into the gitlink?
I understand that floating is not about updating the SHA-1 for the
submodule each commit, right?
