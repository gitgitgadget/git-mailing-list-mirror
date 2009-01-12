From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: Recent annoying problem with Linus's git repository?
Date: Mon, 12 Jan 2009 08:59:42 +0100
Message-ID: <20090112075942.GB29673@fiberbit.xs4all.nl>
References: <alpine.LNX.2.00.0901111615500.4963@x9.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, rmk@arm.linux.org.uk
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMHjw-0001JR-SY
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbZALH7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 02:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbZALH7v
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 02:59:51 -0500
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:4403 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbZALH7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 02:59:50 -0500
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0C7xgh4053405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Jan 2009 08:59:42 +0100 (CET)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1LMHi2-0000QC-Du; Mon, 12 Jan 2009 08:59:42 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0901111615500.4963@x9.ybpnyarg>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105299>

On Sunday January 11th 2009 at 16:42 walt wrote:

> I've been tracking Junio's git.git and Linus's kernel.git for ages,
> and just in the last two weeks or so I've been having a recurring
> problem with the file "arch/arm/mach-integrator/clock.h" from Linus.
> 
> Any time I check out an old kernel version (e.g. during a bisect)
> and then do a "checkout master" when I'm done fiddling, git thinks
> my repository is "dirty".
> 
> This is the reason for my impurity:
> 
> # git status
> # On branch master
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       deleted:    arch/arm/mach-integrator/clock.h
> 
> It's always that same damned clock.h that remains in my working
> directory after doing the "checkout master" but it shouldn't be
> there -- it has indeed been deleted from branch master.
> 
> When I then do a "git reset --hard" I Am Purified! and no longer
> considered dirty.  But why should that extra reset step be needed?
> 
> Only that one file is involved in this recurring annoyance.  Can
> anyone figure out why, or at least reproduce the problem?

It is because commit d72fbdf01fc77628c0b837d0dd2fd564fa26ede6 "[ARM]
integrator: convert to clkdev and lookup clocks by device name" didn't
really _delete_ file arch/arm/mach-integrator/clock.h but only made it
empty. So the file still exists in the repository, but with size 0.

Cleanup scripts within the kernel build environment however always
consider empty files leftover products from the build and so delete
them.

That's why you get this result, after cleaning up.

The file should probably just be really deleted. Adding Russell to the
Cc. ;-)

At the moment (git describe gives v2.6.29-rc1-1-gae04d14) this is the
only "empty" file in the kernel repository. We've had these cases
before.
-- 
Marco Roeland
