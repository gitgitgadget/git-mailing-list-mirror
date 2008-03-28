From: Bosko Ivanisevic <ivanisev@sezampro.com>
Subject: Re: Git and git-svn question.
Date: Fri, 28 Mar 2008 14:07:27 +0100
Message-ID: <47ECED8F.5050507@sezampro.com>
References: <47ECA3DC.8010901@sezampro.com> <ae63f8b50803280427m55f6b957r12745c8e4178588b@mail.gmail.com>
Reply-To: ivanisev@sezampro.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jean-Baptiste Quenot <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEJn-0000oe-8I
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbYC1NHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbYC1NHo
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:07:44 -0400
Received: from mail2.sezampro.yu ([77.105.0.24]:2752 "HELO asus.sezampro.yu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750773AbYC1NHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:07:43 -0400
Received: from ivanisev@[89.216.110.224] [89.216.110.224] (authenticated as ivanisev) by SezamPro with SMTP; Fri, 28 Mar 2008 14:07:34 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <ae63f8b50803280427m55f6b957r12745c8e4178588b@mail.gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78403>

Hi Jean

Jean-Baptiste Quenot wrote:
> Hi Bosko,
> 
> 2008/3/28, Bosko Ivanisevic <ivanisev@sezampro.com>:
>> My company uses SVN and I have to work on the code from two offices.
>>  Since SVN is far away from git in branching I've decided to set up git
>>  repository as a mirror of company's SVN repo, which I would use as
>>  intermediate repository for my code:
>>
>>  git svn clone -t tags -b branches -T trunk
>>  svn+ssh://company_server/path_to_svn_repo --prefix=company/
> 
> -t tags -b branches -T trunk == -s
> 
>>  Since I just started to use git I wonder if anyone can give me any hint
>>  what is the best way to accomplish following tasks with git:
>>
>>  - In office 1 and office 2 I clone git repository that is a mirror of SVN:
>>    git clone ssh://company_server/path_to_git_repo
> 
> You can't do that as SVN information is not cloned.  You have to call
> git-svn clone on every working copy.
I do not understand why I need to do this. I do not want to track SVN 
repository in every working copy. When I create new branch in my working 
copy with:

git checkout -b new-feature company/trunk

this branch should track refs/remotes/company/trunk from git repository 
on the server and code at this point is completely synchronized with 
code from SVN, since git repository on server is regularly updated 
(git-svn fetch is done on every commit in SVN). This is working without 
problem. I guess that after

git pull
git rebase company/trunk

(on local repository) I will get all new updates in the local git 
repository in the working branch (which is new-feature), isn't it? Or 
maybe I'm missing something.

What I do not know is when I push changes made in local repository will 
git actually push new branch with all changes and is it possible to use 
that uploaded branch from the other place in order to continue work. If 
that's the case is it possible, when work on new feature is finished, to 
delete those branches in both local repositories and in "central" git 
repository?

> 
>>  - I start new feature in office 1 based on the trunk version of SVN:
>>    git checkout -b new-feature company/trunk
>>
>>  - Work on this feature is not finished and, after few commits to the
>>  local 'new-feature' branch, I have to move to office 2.
>>
>>  - From office 1 I push local branch 'new-feature' to the git repository
>>  on company server.
>>
>>  - In office 2 pull changes and continue to work on 'new-feature' branch
>>  created from office 1.
>>
>>  - Commit everything in the git repository on company's server.
> 
> 
> Yes you'll need also a central Git repository to work with plain Git
> branches between the offices.
> 
>>  - Finally commit everything to the SVN repository.
> 
> I suggest to use cherry-pick to propagate the changes from the feature
> branch to the SVN-aware branch.
> 
> All the best,

Regarding commit to SVN I thought it is possible to do it from central 
repository in the following way:

git checkout new-feature (to checkout branch I was working on from both 
offices)
git svn fetch (fetch all new changes from SVN)
git svn rebase (apply changes from SVN in the new-feature branch)
git svn dcommit (upload changes to the SVN)

Regards,
Bosko Ivanisevic
