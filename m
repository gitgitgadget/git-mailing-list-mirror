From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Thu, 19 Jan 2006 06:56:38 +1300
Message-ID: <46a038f90601180956r69ba5dffl2106f697a6be4750@mail.gmail.com>
References: <43CE5666.90502@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHY3-0004dw-Rg
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWARR4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWARR4k
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:56:40 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:9010 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932492AbWARR4j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 12:56:39 -0500
Received: by wproxy.gmail.com with SMTP id 70so1628006wra
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 09:56:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NCmIAkat16GcseamOTP9nV0oCoHuzNLq6ggBXcpndIum9gh0nQyybQ+aV0TrrqTPfANhEq4WejB9J+onaHeBa4TTHlEwPl9dP4P7PT9o7fZLTfqRZ7zdkUSvLncyRfdwtXCiArgLT8bb3Ocp2OP8epHxeVNFDgUer7spzkScI6U=
Received: by 10.54.152.13 with SMTP id z13mr7922800wrd;
        Wed, 18 Jan 2006 09:56:38 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Wed, 18 Jan 2006 09:56:38 -0800 (PST)
To: luis@itaapy.com
In-Reply-To: <43CE5666.90502@itaapy.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14847>

Andreas' response is good is you're into pure git. Let me add some
cogito tricks ;-)

On 1/19/06, Belmar-Letelier <luis@itaapy.com> wrote:
> arch-tla equivalent of
>
> $ cd project--luis--0.1
> $ tla missing -sD paul@mail.com--public/project--paul--0.1

 $ cd project-luis
 # only if have to do cg-branch-add the first time!
 $ cg-branch-add paul http://server/git/project.git
 $ cg-fetch paul
 # show what paul has that we don't
 $ cg-log -r master:paul
 $ cg-diff -r master:paul
 # show what we have that paul doesn't
 $ cg-log -r paul:master
 $ cg-diff -r master:paul

You can also do

 $ cg-diff -r master:paul

> so I get the information like what are the interesting patch to get
>
> and then I take all of them with
>
> $ tla star-merge -t paul@mail.com--public/project--paul--0.1

 # if you've done cg-fetch paul and reviewed it what you're about to
merge, just do
 cg-merge paul

 # otherwise, for a shortcut of cg-fetch <branch> && cg-merge <branch> do
 $ cg-update paul

> or I cherry pick only one of them (here patch-6) with
>
> $ tla replay  somefriend@mail.com--public/project--branchA--0.1--patch-6

  # export the patches paul has that we don't
  $ mkdir .patchesfrompaul
  $ git-format-patch --mbox --signoff -o .patchesfrompaul master paul
  # review the contents of .patchesfrompaul and decide what patches you want
  $ git-am -3 .patchesfrompaul/0006-fix-frob-invocation.txt

Note that git does not track patch application _explicitly_ like Arch
does, it tracks them only indirectly. Merges (tla star-merge type of
merges) are recorded explicitly. This work surprisingly well. If you
do a cg-update, cg-merge or git-merge, git will keep a good record of
what points of the history have been merged.

When you cherry pick patches, if the patch applies cleanly, the next
time you do a merge from that branch it will be skipped automagically.
If the patch needs serious editing, there's a good chance that git
will try to apply it again.

cheers.


martin
