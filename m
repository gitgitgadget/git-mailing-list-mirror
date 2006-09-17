From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Notes on supporting Git operations in/on partial Working Directories
Date: Sun, 17 Sep 2006 11:47:35 -0700
Message-ID: <450D9847.4080308@gmail.com>
References: <4509A7EC.9090805@gmail.com>	<7vu03a2po8.fsf@assigned-by-dhcp.cox.net> <4509B954.60101@gmail.com>	<7v8xkl26kb.fsf@assigned-by-dhcp.cox.net> <450AEDBF.9050307@gmail.com> <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 20:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP1gs-0004ft-SW
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWIQSrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 14:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWIQSrj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 14:47:39 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:61134 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932349AbWIQSri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 14:47:38 -0400
Received: by py-out-1112.google.com with SMTP id x66so6320198pye
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 11:47:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f/k7CT3LHoGhF792tiWMzr7usvivkrv0SEZGrvG4uUpHRV6r1Cbt3WK5AgU/qKgXo5YgAXf7DQm00j00I8Gu43VpNutc32TW72DAyXxad/+vfGt/RgBpxD0kzmDxT2vxUvd/tE18bsCuJicv+zQ90s9beofbVglcwGU+0OYLOtM=
Received: by 10.65.119.14 with SMTP id w14mr14565043qbm;
        Sun, 17 Sep 2006 11:47:38 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.86.89])
        by mx.gmail.com with ESMTP id e13sm11516068qbe.2006.09.17.11.47.37;
        Sun, 17 Sep 2006 11:47:37 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvenm3h9f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27199>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>> ...
>>> Having said that, I do not necessarily agree that highly modular
>>> projects would want to put everything in one git repository and
>>> track everything as a whole unit.
>> And yet that's exactly how a lot of developers use CVS. You can argue
>> that some other way is better but when they move from CVS they're
>> looking for continuity of productivity which often means not radically
>> changing how they work. At least in the short term.
> 
[...]

> I suspect that everything-under-one-roof approach is coming from
> an observation that:
> 
>  - with CVS, projects that share the same cvsroot can be updated
>    with single 'cvs update' command in a directory close to the
>    root.
> 
>  - with git, if you use multiple repositories checked out at
>    right places in the working tree hierarchy, you need to run
>    around and say "git checkout" or "git commit" everywhere.
> 
> and the latter looks very inconvenient.
> 
> But of course the latter is very inconvenient.  The current "git
> checkout" nor "git commit" are not such subprojects-aware
> Porcelain commands.  But that does not mean you have to house
> everything in the same repository and make partial check-in to
> work.  You will be enhancing or replacing the same "git checkout"
> and "git commit" commands to do so anyway.

I used CVS as an example but I've seen the "everything-under-one-roof" 
approach, as you put it, used in other VCS' that do work with 
changesets. One instance, in particular, has all the source and config 
files in a single tree that (I'm told) would take several Gigs of 
filesystem space to checkout fully. The codebase is modular to a great 
extent but any particular project in it usually required files from a 
large number of other projects. There is a lot of automation to find the 
required parts for builds and other actions on a project's codebase.

Could this be done with multiple repositories? Yes, but we're talking 
hundreds (no exaggeration) and many of those would likely end-up 
including a large percentage of the other repositories the way the Git 
repository includes the Gitk repository. It could work but their 
existing approach already works and is likely better suited for their 
codebase. Git can not, currently, do all the things that this 
organization wants a VCS to do, working with partial checkouts is a key one.

There is no fundamental reason Git can not support partial 
checkouts/working directories. In fact, there is no fundamental reason 
Git can not support operations on partial (sparse?) repositories in both 
space (working content/state, etc.) and time (history); it's just a 
matter of record keeping[*1*]. That isn't how the Linux kernel 
developers want to use their VCS but it _is_ how others want to use theirs.


Notes:
[*1*] I'm currently working on determining the minimum requirements 
needed to support repositories with partial or sparse history.
