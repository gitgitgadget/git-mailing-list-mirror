From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Wed, 18 Jan 2012 12:51:25 -0600
Message-ID: <4F1714AD.4090706@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 18 19:51:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnabf-0006Sp-6w
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 19:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758069Ab2ARSvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 13:51:31 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43464 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755359Ab2ARSva (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 13:51:30 -0500
Received: by yhoo21 with SMTP id o21so911501yho.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3BsIvd2tElvVwFxoBjUrn8PFK2bvmZxtCbzW750VPd0=;
        b=E61/ZuaskHL5KSQVOVquWeGxiNOtvlC/4wiA6hQeVTCoFH3PKrTXDrw2UYq+Fbf7JD
         I6fiP6R63zcyoLU2b5tPXKLxS4ioVgTiuFZsWlvYu5VAyDsXX41BBoiGCjbFIPMzAdoL
         sho4Szwufz/BUOZsZVLbaK3gp3znqfXuGlyYY=
Received: by 10.236.175.164 with SMTP id z24mr2599200yhl.84.1326912690097;
        Wed, 18 Jan 2012 10:51:30 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id 9sm1833357and.0.2012.01.18.10.51.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 18 Jan 2012 10:51:29 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F171088.4080006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188756>

On 1/18/2012 12:33 PM, Neal Kreitzinger wrote:
> On 1/18/2012 11:53 AM, Neal Kreitzinger wrote:
>> We use the worktree of git-repos as the webroot for virtual hosts
>> assigned
>> to ports so we can directly test changes to dev and test git-repos. We
>> have
>> some developers who want to develop offline on laptops and push to these
>> non-bare repos so they can test their changes. My plan is to set
>> receive.denyCurrentBranch = warn, and then use the post-update hook on
>> the
>> remote non-bare to do a stash of the worktree and index. My assumption is
>> that post-update hook only executes after a successful push. Correct? I
>> only want to stash the non-bare remote work-tree and index after a
>> successful push to it (effectively doing a git-reset --hard, but also
>> keeping any changes to the worktree/index of the non-bare remote as a
>> safety
>> in case someone does directly make uncommitted changes on the non-bare
>> remote.)
>>
> If I manually run git-stash on the non-bare remote after pushing to it
> from a clone (receive.denyCurrentBranch=warn) it works as expected and
> leaves the worktree and index matching the new HEAD. However, when
> post-update runs the git-stash is leaves the worktree dirty. (git 1.7.1)
>
hooks/post-update was:

git stash save
echo "worktree+index of non-bare remote current branch stashed for safety"

it created the stash and echoed the message. However, as stated earlier, 
the worktree is still dirty.  I then manually run git-reset --hard and 
that makes it clean (worktree, index, HEAD match).  However, if I add 
that to the hook it still leaves dirty worktree (index matches HEAD, but 
worktree doesn't match index)

hooks/post-update is:

git stash save
echo "worktree+index of non-bare remote current branch stashed for safety"
git reset --hard
echo "git-reset --hard on current remote branch to ensure clean state"

message is echoed, but git-reset --hard does not appear to have really 
worked. (git 1.7.1)

v/r,
neal
