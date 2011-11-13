From: Gelonida N <gelonida@gmail.com>
Subject: Re: git diff --numstat <branch> always shows dirty submodules
Date: Sun, 13 Nov 2011 01:45:25 +0100
Message-ID: <j9n3v5$ncj$1@dough.gmane.org>
References: <j9lsc1$4uf$1@dough.gmane.org> <4EBED0ED.7060005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 01:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPODZ-0001Lk-T7
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 01:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab1KMApm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 19:45:42 -0500
Received: from lo.gmane.org ([80.91.229.12]:48027 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1KMApl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 19:45:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RPOCZ-00010D-HY
	for git@vger.kernel.org; Sun, 13 Nov 2011 01:45:39 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 01:45:39 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 01:45:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <4EBED0ED.7060005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185320>

Hi Jens,

Thanks a lot for your answer.

On 11/12/2011 09:02 PM, Jens Lehmann wrote:
> Am 12.11.2011 14:29, schrieb Gelonida N:
>> I recently started using submodules and they behave mostly as I like to.
>> Normally I use diff --numstat<branch>
>> to check quickly whether I am aligned with another branch or not.
>> . . . 
>> Is there any quick way flag / helper script / . . .
>> to show differences between two branches without raising the fact, that
>> submodules are dirty?
> 
> Yes, there is the "--ignore-submodules" command line option and the
> diff.ignoreSubmodules (which can be set globally and/or per repo) and
> submodule.<name.>ignore configuration settings. They can be set to
> "untracked", "dirty" or "all" to control what you want to see.
I tried this immediately and at works perfectly for git diff.
Please see also my comments at the end of this post

> 
> Did you check areas in the Documentation where you did expect to find
> them mentioned but they weren't? Then please say so that we can fix
> that.
> 

Apologies. My bad. I must have read the output of
git help diff
too quickly.
It is there plain as the day. :-(

>>> From a user perspective I don't see why this is reported.
>> I am not being warned about dirty files in the top level repository
> 
> This is so you can't forget to add new files inside the submodule,
> which can lead to breakage when other people clone the superproject
> but won't get the new files from the submodule because you didn't
> commit them there.

Well I wouldn't expect to find this kind of info (by default) in the
output of a git-diff.

If you git-diff two branches of a project without submodules it doesn't
tell you either, that you have untracked files in the repository.


I would have expected this kind of output just as result of
'git status'
(as it is already today)
#	modified:  submodule (untracked content)

Git status reports untracked files in the super project AND in it
reports, that there are untracked files in the submodule.
So this seems to be more consistent to me than the diff case.


On the other hand I would consider it usefult if git status could
optionally report the complete list of untracked files also for the
submodules
(So far I didn't search in depth  in doc whether there is a switch
for it.)


A first shot was reading the output of git help status:
>       If status.submodulesummary is set to a non zero number or true (identical to -1 or an unlimited number), the
>        submodule summary will be enabled for the long format and a summary of commits for modified submodules will
>        be shown (see --summary-limit option of git-submodule(1)).

I put thus following lines in .git/config of my repository
status]
    submodulesummary = true


 but the untracked files of my submodule were not reported. (will follow
the doc of git-submodule)



What is also confusing to me is, that the setting
diff.ignoreSubmodules is also being used by git status.

There seems to be no variable
status.ignoreSubmodules

So it seems impossible (without aliases) to
have git diff NOT report the untracked files,
but git status report them.

I guess I'll go for a solution with git aliases
