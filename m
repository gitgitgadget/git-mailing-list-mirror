From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: multiple working directories for long-running builds (was:
	"git merge" merges too much!)
Date: Tue, 1 Dec 2009 21:51:14 +0300
Message-ID: <20091201185114.GC11235@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com> <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com> <20091201054734.GB11235@dpotapov.dyndns.org> <m1NFX19-000kn4C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFXp9-00011i-9y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 19:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZLASvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 13:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbZLASvc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 13:51:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:63537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbZLASvb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 13:51:31 -0500
Received: by fg-out-1718.google.com with SMTP id e12so1936935fga.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9xHRK7sNU/EfqvSr6AO2PGi43j3tdHUg2xPJBgs76sw=;
        b=bwqbx5nZEiakdm/uEgtCL9r5HKtxNbPNWNYHofauKu0WOrhplTsLVklCm6vfYRF7yK
         cEFvDztAOuuSxFJvdPkCYmnntFpWaF6mw51Ee/VUK3KYKbzoOv3mE/OQ1b8yhcx5qcCw
         IEPIZegze9uUzmONKh28yVAPvNYVOsMRYd5L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EHgInWHCIh1JOUUt1989iLwFrMU20V2Vp5+w49Ad29n1Qg6z4IM2cv0vaSH9lOqooO
         G0aF1GfR5JM3xxI0N+r7xwBc67Fh65TqHr4Fzl3qIMMRNF2XEyEizNpjL77oODyFSKGx
         qwvrtSSaxRTWj3yLhu9+2vkaxuVtJunCJoHVE=
Received: by 10.86.159.37 with SMTP id h37mr5691414fge.79.1259693496011;
        Tue, 01 Dec 2009 10:51:36 -0800 (PST)
Received: from localhost ([91.78.50.138])
        by mx.google.com with ESMTPS id e20sm2943358fga.27.2009.12.01.10.51.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 10:51:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFX19-000kn4C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134245>

On Tue, Dec 01, 2009 at 12:59:58PM -0500, Greg A. Woods wrote:
> At Tue, 1 Dec 2009 08:47:34 +0300, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Subject: Re: "git merge" merges too much!
> > 
> > On Mon, Nov 30, 2009 at 07:24:14PM -0500, Greg A. Woods wrote:
> > > 
> > > Things get even weirder if you happen to be playing with older branches
> > > too -- most build tools don't have ability to follow files that go back
> > > in time as they assume any product files newer than the sources are
> > > already up-to-date, no matter how much older the sources might become on
> > > a second build.
> > 
> > No, files do not go back in time when you switch between branches. The
> > timestamp on files is the time when they are written to your working
> > tree
> 
> Hmmm, I didn't really say anything in particular about file timestamps
> -- I meant the file content may go back in time.  More correctly I
> should have said that the file content may become inconsistent with the
> state of other files that have just been compiled.

There is no difference of content going back in time or forth. If a file
is changed, any decent build system should recompile the corresponding
files. If the build does not handle dependencies properly, you can end
up with inconsistent state just by editing some files.

> If the timestamps do not get set back to commit time, but rather are
> simply updated to move the last modify time to the time each change is
> made to a working file (which is as you said, to be expected),

More precisely, Git does not anything about modification time during
checkout. The system automatically updates the modification time when
a file is written, and Git does not mess with it.

> regardless of whether its content goes back in time or not, then this
> may or may not help a currently running build to figure out what really
> needs to be re-compiled.

Obviously, switching branches while running build may produce very
confusing results, but it is not any different than editing files by
hands during built -- any concurrent modification may confuse the build
system.

> I just disagreed that "git archive" was a reasonable alternative to
> leaving the working directory alone during the entire time of the build.

Using "git archive" allows you avoid running long time procedure such as
full clean build and testing in the working tree. Also, it is guaranteed
that you test exactly what you put in Git and some other garbage in your
working tree does not affect the result. But my point was that switching
between branches and recompile a few changed files may be faster than
going to another working tree.


Dmitry
