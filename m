From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 15:22:13 +0000
Message-ID: <200702281522.14965.andyparkins@gmail.com>
References: <es450f$d58$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQdN-00059h-Em
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXB1PWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXB1PWX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:22:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:15439 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXB1PWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:22:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so584780nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 07:22:20 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fOZcHLyCfC1uDbRYemEV0BHf+p0ptDqVzpjFXIX9btBw4zVPxu96ZulMQ8r9Ww1uB5prvz7TKSdEpku0w/EbA4B2/eGn6hDX6WNXddJhlts5ECCrTxtky+SEnEh6mxDoFzoyVgLWrlX72GB/EK2bl5CmUCRJKQcBiRrlhn4syUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=K+BzN00ZcpDth95G2rnBroN81r1sxfURhX0zz3Wn/XCrfmNlJkRzUGe9wJKVhhH+HsGeQ6wzBEOJj2aDrHqRHQxovny/vuQ9SqfL9EJm180f4zqZhBWPllSgMI7ph6QHd3DwEkVHBsxc2ruofN7zIje8JiNrtnOiHf1skEcMcCY=
Received: by 10.48.204.5 with SMTP id b5mr3808979nfg.1172676140683;
        Wed, 28 Feb 2007 07:22:20 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id k24sm6067285nfc.2007.02.28.07.22.17;
        Wed, 28 Feb 2007 07:22:18 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <es450f$d58$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40936>

On Wednesday 2007 February 28 14:53, Paolo Bonzini wrote:
> As can be seen from my other messages, I'm experimenting a little with
> git and trying to understand how its workflow compares with arch.  Right
> now, my procedure for branching off a remote archive is:
>
>    git checkout -b branchname remote/upstreambranch
>    git config --add branch.branchname.remote remote
>    git config --add branch.branchname.merge refs/heads/upstreambranch
>
> Is there a reason why "git branch" and "git checkout -b" should not
> automatically do the two "git-config --add"s when the source branch is
> remote?

I can see why that would be handy, but I often make short lived branches off a 
remote; and I wouldn't want my config cluttered up with branch defintions.

> In case the source branch is not remote, would "origin" be a good choice
> for the "branch.branchname.remote" variable?

No.  That would still reference a remote.  As in:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = refs/heads/master:refs/remotes/origin/master
[branch "master"]
        remote = origin
        merge = refs/heads/master

The remote = origin tells git to use the [remote "origin"] section.

I think what you want is something that I would like too.  If you specify "." 
to a git-pull it means to use the local repository not a remote.  It would be 
great if one could have:

[remote "origin"]
        url = git://git.kernel.org/pub/scm/git/git.git
        fetch = refs/heads/master:refs/remotes/origin/master
[branch "master"]
        remote = .
        merge = refs/remotes/origin/master

That way a "git pull" on master wouldn't need to make a remote connection in 
order to do a merge (which is the way I like it).  However, I remember there 
was a reason this wouldn't work, but I don't remember what it was :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
