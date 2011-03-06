From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Adding non-bare branches to a non-bare repository
Date: Sun, 06 Mar 2011 17:23:26 -0600
Message-ID: <4D74176E.8050205@gmail.com>
References: <201103031053.35864.mail@samtuke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "mail@samtuke.com" <mail@samtuke.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 00:23:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwNIW-0005Ee-Q8
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab1CFXXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:23:32 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:56674 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1CFXXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:23:31 -0500
Received: by gwb15 with SMTP id 15so2206979gwb.10
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RDIZ8xxS4enARBxXXjU1DVzBufouxrZl2irmBOxkloc=;
        b=Jmpoy4sDcCNIw1GqGfwHukcnxHtfG1+4mF681x8AWVPKy91AT2uis0ZOS5wtbqvnrY
         BVbS9DgQk2ojW+7W+ngNJwMGmge9I8DiU1uY6Yi244sbPJnxChntkokE6LnGPbBE4o9v
         8m7nbJxgoc8aa6MSeCY9fwYZyr+L15KWSlrfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=pykZN/GiAtHD5ac3uYTeknRqM28Ki2FIiQwErelInng7Y3xbsiHmDJ2az4Kg0Yo9/2
         XSVgnGyW88ZGe470yZuvqDTDAv6A08S/k5fy0mTVhTM2txj44QdMJZTqRhKL01C9CsVk
         skqp95oGHOcYUFf0KHzc5rvrOE+EMfrH6ojRg=
Received: by 10.236.143.178 with SMTP id l38mr145172yhj.54.1299453811184;
        Sun, 06 Mar 2011 15:23:31 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id z5sm1296164yhc.35.2011.03.06.15.23.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:23:30 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.14) Gecko/20110221 Thunderbird/3.1.8
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <201103031053.35864.mail@samtuke.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168560>

On 3/3/2011 4:53 AM, mail@samtuke.com wrote:
> My website is a non-bare git repository. I have a copy of the website for
> testing purposes which is a separate git repository. Currently these two
> repositories are not aware of each other, and I copy across files from one to
> the other in order to bring features from the test repo into the live site.
>
> I would like to make the testing repository into a branch of the live website
> repository so that I can easily merge in changes from one to the other.
>
> Both repositories need to be complete copies of files as they are web
> accessible and must be functional.
>
> Is this possible?
>
> In future I also need to make a third copy of the site to have a beta as well
> as an alpha testing copy of the website.

I recommend re-creating beta repo as a git-clone or linux copy (cp -r 
prod-repo beta-repo) so that beta repo shares the same history as 
prod-repo.  If you have stuff on beta-repo not yet in prod-repo then tar 
it up and "re-apply" it to the "new" beta-repo using the "vendor branch" 
methodology described in the git-rm manpage.  (do likewise for 
alpah-repo  -- clone/copy it from prod-repo and apply beta-repo 
additional commits via method described below.)

You can create an "integration" repo to perform merges between the 
production repo and the beta repo (and alpha repo):
(1) clone the integration repo from the production repo.  this is 
important because it will cause the integration repo master branch to 
correlate to the production repo master branch which is the "real" 
master branch or "ultimate" master branch.
(2) add the beta repo as a remote to the integration repo.
e.g. (a) git remote add -t master BETA git:///url.to.beta
(b) git fetch BETA --no-tags
(c) git branch beta-master remotes/BETA/master
(this will track the master branch of the beta repo in the beta-master 
branch of the integration repo)
(d) after initial creation of beta-master via (a thru c) you update 
beta-master with:  (d1) git checkout beta-master
(d2) git pull BETA
(3) now you can merge beta-master into master and then push master to 
the production repo.  i imagine that beta-master will always be built on 
master so the merge should always resolve as a fastforward:
(a) git checkout master
(b) git merge --ff-only beta-master
(b1) you should set production repo to deny non-fastforwards. see 
git-config manpage.
(c) git push origin HEAD (assuming you leave the default name of the 
remote to the production repo as "origin")

For the alpha-repo you can do the same steps but point to the url for 
the alpha repo and call the remote handle ALPHA.   Call the tracking 
branch of the ALPHA master branch "alpha-master" in your integration 
repo and merge it into beta-master.  However, when you push beta-master 
to the master branch of BETA you will need to specify a specific syntax 
so it pushes "beta-master" to the "master" branch on BETA instead of 
creating a new branch called "beta-master" on BETA.  Look at the git 
push manpage for the syntax.

Hope this helps.

v/r,
neal
