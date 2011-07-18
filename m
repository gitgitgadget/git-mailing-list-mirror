From: Chris Packham <judge.packham@gmail.com>
Subject: Re: How to push the very last modification only ?
Date: Mon, 18 Jul 2011 20:58:51 +1200
Message-ID: <4E23F5CB.3090009@gmail.com>
References: <20110718131730.4898ddaf@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Mon Jul 18 10:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QijfB-0002cx-Ao
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 10:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1GRI6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 04:58:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64394 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1GRI6r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 04:58:47 -0400
Received: by pvg12 with SMTP id 12so2809757pvg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=aYxmY3S3uDrIiQOMUpknaMdN2oAdVl+rjRU2SGG17To=;
        b=FMZzq0K8piN/15rhoJJQaa3IzNqarIa8MjcSE3Lq6w0HX+lg9Y6hVMXx6meq2KRUgr
         iLtNzjKm+T4HaVIgtn1s38SjVmvKTnAQaTjwplVKwlkTKkb8d25YkdA+r5/tG6GmqU8q
         cDPl7osLnmNoJ+/gXT8nljCuBKSep46yMTYwA=
Received: by 10.142.140.3 with SMTP id n3mr71674wfd.101.1310979526661;
        Mon, 18 Jul 2011 01:58:46 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id d1sm2383839pbj.88.2011.07.18.01.58.44
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 01:58:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110718131730.4898ddaf@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177361>

Hi,

On 18/07/11 19:47, J. Bakshi wrote:
> Hello list,
> 
> I have found that during push, all local commit goes into the git 
> server.

Yes that's the normal behaviour. When you think about what push is doing
it's trying to make the remote branch the same as your local branch.

> Where I like to only push the very last modification with
> a meaningful comment which will be available at the git server. How
> can I then push only the last modified one ?

This is easily doable. What you need to do is prepare a branch that you
do want to push. Something like this, assuming that your current branch
is 'master' and you want to push to origin/master:

  # first create temporary a branch to use while you're delivering
  git checkout -b delivery origin/master

  # now cherry pick the commits you do want to push. I usually use
  # gitk and cherry-pick from the right-click menu, but for simplicity
  # I'll use git cherry-pick here.
  git cherry-pick master
  # you can provide a commit id instead of 'master'.

  # at this point you could also use git commit --amend to add any
  # final tweaks to the commit

  # check that your delivery branch is good using git log/gitk. Build,
  # test, etc

  # now push it to your local delivery branch to the remote master
  # branch
  git push origin delivery:master

  # now do some cleanup
  git checkout master
  git branch -d delivery
  git rebase origin/master
