From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Fri, 20 Jan 2012 18:13:05 -0600
Message-ID: <4F1A0311.30502@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com> <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org> <4F1764B9.90907@gmail.com> <7vboq0ld5e.fsf@alter.siamese.dyndns.org> <4F188FA2.1000209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Jan 21 01:13:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoOa6-0002IN-7p
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 01:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683Ab2AUANM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 19:13:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57424 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553Ab2AUANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 19:13:09 -0500
Received: by ghbg18 with SMTP id g18so565428ghb.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 16:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TOw+8hqo/n3lxWWUkxNb9X72+bC8FsNiLHby2VpECSM=;
        b=FBWgnSu9VPO5Q2J63WCHC/3BWkPklSCEY5+LyN88dIfgE8Bnh6E5+MMKp098wwL048
         Iy/vABG1MllWYsr5nq4vg3zWr1Z6Hq4M8uW5Cgx91qmikd/B2vPVetJq8h9xNHstvrPp
         1/EhL9ZqD6it3JUCQuZtxwVf9poEYuINZDZJw=
Received: by 10.236.124.97 with SMTP id w61mr12861956yhh.63.1327104789192;
        Fri, 20 Jan 2012 16:13:09 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id d7sm8047413yhn.16.2012.01.20.16.13.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 20 Jan 2012 16:13:08 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F188FA2.1000209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188910>

On 1/19/2012 3:48 PM, Neal Kreitzinger wrote:
> On 1/18/2012 7:00 PM, Junio C Hamano wrote:
>> Neal Kreitzinger<nkreitzinger@gmail.com> writes:
>>
>>>> Have you checked where in the filesystem hierarchy that script
>>>> is run (hint: pwd)?
>>>>
>>> echo pwd in post-update echoes /path/WORKTREE/.git in git-push
>>> stdout. ... 'git-checkout -f' works manually, but in post-update
>>> hook...
>>
>> Stronger hint. Did you run "git checkout -f" in
>> /path/WORKTREE/.git to back that "works manually" claim?
>
> (Manual behavior): If pwd is WORKTREE/ then git-checkout has correct
> effect, ie. worktree, index, and HEAD match. If pwd is
> WORKTREE/.git/ then git-checkout complains 'must be run in a
> worktree' and has no effect.
>
> (post-update hook behavior): If pwd is WORKTREE/.git/ then git-push
> verbage does not complain, and git-checkout exits zero status but
> has incorrect effect, ie. index and HEAD match, but worktree matches
> HEAD@{1}. If pwd is WORKTREE/ then git-push complains 'not a git
> repository', and git-checkout exits non-zero status and has no
> effect, ie. worktree and index match HEAD@{1}.
>
> Evidence:
>
> (post-update hook script): MYPWD=`pwd` echo $MYPWD pushd
> /home/neal/FSNMSTHTML MYPWD=`pwd` echo $MYPWD git checkout -f HEAD
> if [ $? -ne 0 ]; then echo "error on checkout!" else echo "checkout
> HEAD to non-bare remote current branch after push" fi echo $MYPWD
> popd MYPWD=`pwd` echo $MYPWD
>
> (git-push verbage): $ git push origin HEAD Counting objects: 9, done.
> Delta compression using up to 8 threads. Compressing objects: 100%
> (5/5), done. Writing objects: 100% (5/5), 462 bytes, done. Total 5
> (delta 4), reused 0 (delta 0) Unpacking objects: 100% (5/5), done.
> remote: warning: updating the current branch remote:
> /home/neal/FSNMSTHTML/.git remote: ~/FSNMSTHTML ~/FSNMSTHTML/.git
> remote: /home/neal/FSNMSTHTML remote: fatal: Not a git repository:
> '.' remote: error on checkout! remote: /home/neal/FSNMSTHTML remote:
> ~/FSNMSTHTML/.git remote: /home/neal/FSNMSTHTML/.git To
> file:///home/neal/FSNMSTHTML cee9269..34dc5a9 HEAD -> master
>
To get this to work I had to learn more about shell scripting and export
the GIT_WORK_TREE git environment variable.

(post-update hook):
export GIT_WORK_TREE=/home/neal/FSNMSTHTML
git checkout -f HEAD

for more info see this stackoverflow thread
http://stackoverflow.com/questions/6635018/reuse-git-work-tree-in-post-receive-hook-to-rm-a-few-files

v/r,
neal
