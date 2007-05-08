From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Yet another git perforce integration
Date: Tue, 8 May 2007 11:47:31 +0200
Message-ID: <81b0412b0705080247l2385529t61ad4ecd083261c7@mail.gmail.com>
References: <200705081023.38810.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue May 08 11:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMIG-0002ul-6X
	for gcvg-git@gmane.org; Tue, 08 May 2007 11:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934815AbXEHJre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 05:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934814AbXEHJre
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 05:47:34 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:63299 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934816AbXEHJrc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 05:47:32 -0400
Received: by an-out-0708.google.com with SMTP id d18so217569and
        for <git@vger.kernel.org>; Tue, 08 May 2007 02:47:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tZto7+WETXaMxOG5qq02GqFda8rCkdW0F/znFgcS6xtR/eMkX6SAByoGzZO6daHYO1NSTPxqUMMe4OiAMuc5GfdRw9RG36rkwYTmWTNeeyw9TtXyoaXrR/KPyfNLrfHPZAhQu9NmNiN9KWwKY+BVyDRZE45HOQ5oE2k68ibkx2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QLD5z1Rxsu7IbDmhSB4RwR26iCEhQn/4k8edQtF7ravvc2Mce1DcG4WOac6jZoigehxEPRvO0W9ofbXNQDt69dzGeI1CdefksTFp4wyN6EcsdN6Qulr4Ujm1xbTkY2untzwH+odJJKq+PPxHfl8FCYkDIE3ircK+ivwzEWzQJM8=
Received: by 10.100.200.12 with SMTP id x12mr5538416anf.1178617651580;
        Tue, 08 May 2007 02:47:31 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Tue, 8 May 2007 02:47:31 -0700 (PDT)
In-Reply-To: <200705081023.38810.simon@lst.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46557>

On 5/8/07, Simon Hausmann <simon@lst.de> wrote:
>
> git-p4 submit
>
> is used to submit changes back into Perforce (use at your own risk! :)

right, because you have to know where (and when) your perforce repo is,
and then where and when your copy (in Git) is, copy the p4 changes,
rebase your changes on top of the just copied changes (p4 history
is linear), try to submit, watch out for fails, because someone else could
have submitted something, possibly resync and repeat. Cursing and
swearing notwithstanding.
I simplified the operation  by promising to hit everyone who submits
anything in my domain (and was supported by the local P4 sysadms,
so it worked).

> The import itself uses git-fast-import, so it's very fast. There is also no
> need to have the imported Perforce projects in the Perforce client view as it
> just uses "p4 changes //depot/path" and "p4
> print //depot/path/file#revision", which I find very convenient and still
> fast enough for use (since of course only changed files are printed).

I confirm that, but could not use the same approach in git-p4-import
I posted earlier: I don't control the sync operation, and the stupid prog
that does the sync does not allow in-client operation (p4 sync -n).
I just have to work somehow with the junk it left in working directory

> It also doesn't require any additional meta-data. Instead every import commit
> has a line added to the log message that contains the Perforce path the
> changeset comes from as well as the change number. git-p4
> sync/rebase "parses" this on the last commit in the "p4" git branch to find
> out where to continue importing for incremental imports.

How do you handle that patchwork of mappings synced to diverse revisions
that P4 clients tend to become? Don't you have to save change number or
revision for _each_ file?

> What's still missing is a bit of cleanup. For example I'd like to put the
> import branch into refs/remotes instead of refs/heads, but I've had some
> problems with fast-import when trying that. Also the support for Perforce
> branches isn't quite working yet.

AFACS, it is impossible: Perforce does not have branches (in Git's meaning
of the word). It only has directories. Integration (it is something like
"in-repo-copy") metadata are just duct-taped on it (that stupid branchspec).

> Also I've never tried it on Windows and I expect problems as the script uses
> pipes, calls "patch", etc.

...and case-sensitivity. BTW, how does your script handle filenames with
special characters and spaces in them?
