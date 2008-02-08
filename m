From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 8 Feb 2008 15:41:49 -0500
Message-ID: <9e4733910802081241g1543f873h76181c0d3165cc00@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <9e4733910802081126r5bf19c95rec817a1b6648ee4d@mail.gmail.com>
	 <1202502007.12966.30.camel@brick>
	 <9e4733910802081224k28310b0cj171453c96802ec7f@mail.gmail.com>
	 <1202502302.12966.32.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Jan Holesovsky" <kendy@suse.cz>, git@vger.kernel.org,
	gitster@pobox.com
To: "Harvey Harrison" <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNa3J-0005lO-4M
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933691AbYBHUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933652AbYBHUly
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:41:54 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:47203 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbYBHUlv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:41:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so639151wah.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 12:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YS/bF+Mh2ac7HmBusHIZtDVfiaXukXMkG+P4ys+VUPQ=;
        b=SGeOZF2xB54c4ssvMt4AQf21YbauwutPmwDmOWtzGsDWLbp2zex17svxDm7/vAh8OYDk+9kcsScik66KavDJD8V3kW5gxU+Oz9TlV8pXcmelIMYADUCw5XBed7hubnWFX9dbiE4/20owMrqtV95/gsfkMcI6C1ugDAhMDEWpKDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QvWSS0MzbagCYu0AlC5lq29GOcIvuk6wxhab272wAZH2Y00ipqFb85SqujiuWCe32EYSzXFlq1/4BApf1189PU74/c3aLx/PVj3x9v37aYmneS0O6LbsEALSuXroekx+Tk44r3TdE9fqZwtkJIT/nRnFwiBrkOpGVCWqAgwzKrY=
Received: by 10.114.111.1 with SMTP id j1mr4063094wac.138.1202503309492;
        Fri, 08 Feb 2008 12:41:49 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Fri, 8 Feb 2008 12:41:49 -0800 (PST)
In-Reply-To: <1202502302.12966.32.camel@brick>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73141>

On 2/8/08, Harvey Harrison <harvey.harrison@gmail.com> wrote:
> On Fri, 2008-02-08 at 15:24 -0500, Jon Smirl wrote:
> > On 2/8/08, Harvey Harrison <harvey.harrison@gmail.com> wrote:
> > > On Fri, 2008-02-08 at 14:26 -0500, Jon Smirl wrote:
> > > > On 2/8/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > > > > Jan Holesovsky <kendy@suse.cz> writes:
> > > > > One of the reasons why 'lazy clone' was not implemented was the fact
> > > > > that by using large enough window, and larger than default delta
> > > > > length you can repack "archive pack" (and keep it from trying to
> > > > > repack using .keep files, see git-config(1)) much tighter than with
> > > > > default (time and CPU conserving) options, and much, much tighter than
> > > > > pack which is result of fast-import driven import.
> > > > >
> > > > > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > > > > you would need machine with large amount of memory to repack it
> > > > > tightly in sensible time!
> > > >
> > > > A lot of memory is 2-4GB. Without this much memory you will trigger
> > > > swapping and the pack process will finish in about a month.
> > >
> > > Well, my modest little Celeron M laptop w/ 1GB of ram did the full
> > > repack overnight on the gcc repo, so a month is a bit of an
> > > exaggeration.
> >
> > Try it again with window=250 and depth=250. That's how you get the
> > really small packs.
> >
>
> Yes, I know, and I did if you remember back to the gcc discussion.

Now that you mention it I seem to recall some changes were made to git
during that discussion that reduced the memory footprint and made the
optimized gcc repack fit into 1GB. I've forgotten the exact timings
and git is a moving target. When I was working on Mozilla it needed
2.4GB to avoid swapping but that was with a much older git.

The rule is: if it starts swapping it is going to take way longer that
you are probably willing to wait. Buying more RAM is a cheap and easy
fix.

If people are having trouble with large repositories please let the
git community know and your issues will probably get quickly fixed.
We can't fix something we don't know about.

-- 
Jon Smirl
jonsmirl@gmail.com
