From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on Using Git with Subprojects
Date: Tue, 26 Sep 2006 15:33:49 -0700
Message-ID: <4519AACD.7020508@gmail.com>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 00:34:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSLUy-0000mO-NQ
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 00:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWIZWdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWIZWdx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 18:33:53 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:43032 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932453AbWIZWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 18:33:53 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1061556nzf
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 15:33:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XXtXex2cSDm/Rm0oH+LUyHRU0BdlAY34irhz8nFLttmE6+RlBViDA2TvYmTiEwwsXFyL0+1Kfz5AgyXSILf5JViOmY3DzqPqHRtLL27n8NCmU4anBDX9WpzltWVOfnX7wbeWqtQ5isrXH8EK9w4ga50kjzK8CGVslv2nZXItR1I=
Received: by 10.65.240.17 with SMTP id s17mr1235366qbr;
        Tue, 26 Sep 2006 15:33:52 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.67.46])
        by mx.gmail.com with ESMTP id e17sm1228579qbe.2006.09.26.15.33.51;
        Tue, 26 Sep 2006 15:33:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060926213003.GA8177@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27833>

Shawn Pearce wrote:
> Daniel Barkalow <barkalow@iabervon.org> wrote:
[...]
> I agree entirely.
> 
> I have about 30 "subprojects" tacked into one large Git repository
> for this exact reason.  In at least 5 of these cases they shouldn't
> be sharing a Git repository as by all rights they are different
> projects.
> 
> What I'm doing is sort of like tacking both the Linux kernel and
> glibc into the same Git repository because you might need to change
> and bisect over updates to the system call layer.  Insane, yes.
> Probably shouldn't be done; but right now that interface layer
> between several subprojects is still in flux and it makes it rather
> easy to keep everything in sync.
> 
> Its annoying to perform commits to the "root project" every time the
> subproject changes.  And it brings some complexity when you want to
> talk about merging that root project.  But if its automated as part
> of "git commit" and "git merge" (either directly in those tools or
> by hooks users can install) then its probbaly a non issue.

So, for each subproject of a parent project, you want to record branch, 
version (commit ID), and directory location. Not quite as easy to do in 
a makefile but do-able.

An operation that _needs_ to change more than one project's versioned 
state a time should be rare. If you have to do it often, then instead of 
subprojects you probably have a partitioning of one project. A 
subproject should be independent of its parent projects. A merge of a 
parent project should not affect a subproject other than to pick a 
particular subproject version.

Your example of the kernel and glibc is an example of sibling projects. 
Each one in independent and (some) versions of each project should work 
(better or worse) with the other. The root project here shouldn't really 
do more than specify which version of the kernel and glibc to use.
