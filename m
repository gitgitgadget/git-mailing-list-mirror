From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git pull/merge master on other branch
Date: Tue, 13 May 2008 12:24:31 -0500
Message-ID: <4829CECF.1090900@nrlssc.navy.mil>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net> <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, SungHyun Nam <goweol@gmail.com>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue May 13 19:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvyG7-0004fd-QE
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 19:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbYEMRYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 13:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbYEMRYs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 13:24:48 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52813 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbYEMRYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 13:24:47 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m4DHOWc7014891;
	Tue, 13 May 2008 12:24:32 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 May 2008 12:24:32 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
X-OriginalArrivalTime: 13 May 2008 17:24:32.0366 (UTC) FILETIME=[350BA0E0:01C8B51E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82035>

Kevin Ballard wrote:
> On May 9, 2008, at 1:24 AM, Johan Herland wrote:
> 
>> On Friday 09 May 2008, SungHyun Nam wrote:
>>> Hello,
>>>
>>> If I am on a branch (reguarly rebased), I don't want to switch to
>>> master branch, but merge origin into master.
>>> If I switch to master and pull and switch to branch, I have to
>>> rebuild almost of sources.
>>>
>>> How I can pull origin into master without switching to master
>>> branch?
>>
>> You can't; merging requires use of the working tree (to resolve
>> conflicts).
>>
>> However, what you can do is make a local clone of your project (cheap,
>> because it just hardlinks files from the original repo), and checkout the
>> master branch in the clone, perform the merge (after having set up the
>> same
>> origin and retrieved its contents), and then fetch (or push) the
>> result back
>> into the original repo (remember: "fetch" instead of "pull", since the
>> latter will initiate a merge with your current branch).
> 
> 
> If you know the pull will just be a fast-foward, then you can do
> something like
> 
>   git fetch origin && git update-ref master origin/master

I recommend against using update-ref...

and instead suggest using fetch to do all of the work.
Some variation of:

    git fetch origin master:master

This will only fast-forward the master branch based on the remote origin's
master branch. update-ref will blindly overwrite the master ref, if you make
a mistake and its not a fast-forward, you just lost some commits.

The above doesn't update your remotes though, maybe the following would be
correct, but I haven't tried it.

   git fetch origin && git fetch . remotes/origin/master:master



Also, I'm surprised no one mentioned the git-new-workdir script in the
contrib directory. It allows you to have multiple work directories
which share and update a single repository.

You could

    git-new-workdir <path_to_repo> <path_to_newworkdir> master
    cd <path_to_newworkdir>
    git pull

-brandon
