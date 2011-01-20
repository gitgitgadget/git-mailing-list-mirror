From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Opinions on my GIT model
Date: Thu, 20 Jan 2011 10:03:27 +0530
Message-ID: <20110120043322.GA9493@kytes>
References: <1295465635148-5941048.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: julia <deborave@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 05:32:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfmCI-0003zb-FV
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 05:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177Ab1ATEc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 23:32:28 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55440 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab1ATEc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 23:32:28 -0500
Received: by yib18 with SMTP id 18so50534yib.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 20:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4+QAMvLsMtjQPEWfzglKnBagtGtolgtFgwzCgFYcGbw=;
        b=sLl1FYJJdIRBT/ydqumiwVGv4N+ZkmeAWN9H9uN5QqNYd7TaYWR3hG0PNCCfVh/JQe
         iHhGhv/Rt2URYkZRh2EA/NSH5bjyQA5bfDZxt0BXQkzXij8/gYJJJQE55LTVU8TTo31n
         lwrBov175ZcwFqwAr1opdRK13l6fsh3TSNOCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t0FoK7GwwW3vuMcDLPZAeLWGO5AuY2yTDAiuO1WLBzdeDUDBpLYkezFghU7ls0E1rk
         2yGvTq+84HKZQ/HlsBoohM5sy0dmF3bcPyZ3mSCeaJzh5uK//A9Pn4UCgr0E67W3Y8F9
         As3qF4AM50G9tNBPCDj18ZW9jI05PJ4D9yS10=
Received: by 10.151.148.11 with SMTP id a11mr1941865ybo.3.1295497947359;
        Wed, 19 Jan 2011 20:32:27 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v4sm954983ybe.17.2011.01.19.20.32.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 20:32:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295465635148-5941048.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165302>

Hi Julia,

julia writes:
> Working on a GIT model for my projects.
> 
> 1.  Three main repositories, bare public repo, maintainer repo, developer
> repo
> 2.  Developer1 clones the public repo and makes feature1 branch, updates,
> commits changes and pulls/pushes.
> 3.  Developer2 on their local repo does the same thing and pushes updates.
> 4.  Maintainer get the green light to rebase feature1 branch with master -
> they pull the whole repo, rebase the feature1 branch with master and then
> push feature1.
> 5.  Developer1 pulls feature1 brach again and continues to work, does a
> pull/push to feature1 on public repo.

Having a mainline + feature branches is a very common development
model.

> Now, main question is - given that in step 4 maintainer rebase the feature
> branch with master then pushed, he is committing a cardinal sin by rebasing
> a branch that has already been pushed to the public repo, so if anyone has
> made any changes based on the commits originally pushed that now have been
> rebased - developer who tries to push those changes will have issues.
> 
> Will these be solved by executing of a pull? 

In many projects, including git.git itself, master's history is never
overwritten. Feature branches are merged into `pu`, then into `next`,
and finally graduate to `master`. I suppose it's a matter of
convinience- you should have atleast one stable branch (ie. `master`)
so that developers know what to base their work on.

git-pull.sh is a porcelain-level helper that executes a fetch and
performs a kind of merge/ rebase depending on the situation and
command-line flags. I'd encourage you to read the manpage and shell
script itself and see what all these options are, and how they work.

Finally, I think the merge operation is what you're looking
for. Please read git-merge(1).

-- Ram
