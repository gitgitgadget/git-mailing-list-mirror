From: "Dan McGee" <dpmcgee@gmail.com>
Subject: Re: Update local tracking refs when pushing- no way to disable
Date: Fri, 6 Jul 2007 09:20:02 -0400
Message-ID: <449c10960707060620t3538b6d7w3e9cba50eaa0e369@mail.gmail.com>
References: <449c10960707051722q6650ec7dq6012695acdfba4af@mail.gmail.com>
	 <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 15:20:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6njG-0000zI-19
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 15:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbXGFNUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXGFNUG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 09:20:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:7730 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbXGFNUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 09:20:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so701145ugf
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 06:20:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m43W1Mtw7he+3PQ6y4LoLAk8OuE1jzu1D8WbQnt5Z/qmSVS3UnifmFsU/G8w36VHNu+5qfJDj9mehYvwBZtVIgT9wVVoDJzAehU8r+XGqYie5f1WuO6zubJPcP9K+cRRAisNBuqPdg/MITIIMpwSpEahKFYyNO03fV1eGY8gUT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W23ekeBgcLK15+z/VrJqXLq0l4Lo10rx12+1oc3Yf0c2nxlkydg1IkpTeVNu27gg6jE5gJQIIrfw39+vrRUuS1iGe4rQBCfMlEVXixGSD3thHCR/aP7Biokd3j5AqQISHgnuoouGxWdIhw7fmCQIkB0asU/I/cMSJNP/9E1NgYc=
Received: by 10.82.156.12 with SMTP id d12mr1710127bue.1183728002676;
        Fri, 06 Jul 2007 06:20:02 -0700 (PDT)
Received: by 10.82.135.2 with HTTP; Fri, 6 Jul 2007 06:20:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707052320090.14638@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51750>

On 7/5/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Thu, 5 Jul 2007, Dan McGee wrote:
>
> > In this commit:
> > b516968ff62ec153e008d033c153affd7ba9ddc6
> >
> > I don't know if anyone else has the same way of working as I do, but I
> > tend to set the "remote.<name>.skipDefaultUpdate" property to true for
> > my publicly visible repository, just so I don't have duplicate branch
> > heads lying around in my local repository. Call this peculiar, but I
> > like it that way. However, git-push does not respect this property,
> > meaning I know have these branches whether I want them or not. In a
> > tool such as qgit or even 'git branch -a' output, it starts to get
> > awful cluttered.
>
> What git-fetch and git-push care about is whether you have an entry
> "remote.<name>.fetch" with a colon and stuff on the right of it. If so,
> this is a pattern that is used to generate the duplicate branch heads that
> you don't want. git clone sets it up to a default pattern
> (refs/remotes/origin/*), and I don't think there's any way to make it not
> do that, but you can just reconfigure it afterwards if you don't like it.

Wow, my bad here on this one. Didn't even think about the default config line:
[remote "toofishes.net"]
       url = toofishes.net:~/gitprojects/shoepolish.git/
       fetch = +refs/heads/*:refs/remotes/toofishes.net/*
       push = +refs/heads/*:refs/heads/*

Getting rid of that fetch line makes it work as intended. And not to
hijack my own thread, but did behavior change between 1.5.2.3 and
1.5.3 wrt non-subset pushes?

$ git push toofishes.net
error: remote 'refs/heads/alpm_list_speed' is not a strict subset of
local ref 'refs/heads/alpm_list_speed'. maybe you are not up-to-date
and need to pull first?
error: remote 'refs/heads/asciidoc' is not a strict subset of local
ref 'refs/heads/asciidoc'. maybe you are not up-to-date and need to
pull first?
error: remote 'refs/heads/color' is not a strict subset of local ref
'refs/heads/color'. maybe you are not up-to-date and need to pull
first?
error: remote 'refs/heads/permissions' is not a strict subset of local
ref 'refs/heads/permissions'. maybe you are not up-to-date and need to
pull first?
error: remote 'refs/heads/pkgname_check' is not a strict subset of
local ref 'refs/heads/pkgname_check'. maybe you are not up-to-date and
need to pull first?
updating 'refs/heads/working'
 from 59d9ccf48d84fd1e59f78cb4dcf428e53d1c6911
 to   6b7b9743181078aa7152daffdfc1eaeb46304c0f
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
refs/heads/working: 59d9ccf48d84fd1e59f78cb4dcf428e53d1c6911 ->
6b7b9743181078aa7152daffdfc1eaeb46304c0f

I thought the '+' sign in the push refspec would supress these errors,
but it doesn't seem to. Running 'git push -f' works but that was never
necessary before after doing some rebasing of these branches.

-Dan
