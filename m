From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: multiple working directories for long-running builds (was:
	"git merge" merges too much!)
Date: Wed, 2 Dec 2009 00:18:30 +0300
Message-ID: <20091201211830.GE11235@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <7vskbxewti.fsf@alter.siamese.dyndns.org> <m1NFBAx-000kmgC@most.weird.com> <20091130211744.GA27278@dpotapov.dyndns.org> <m1NFGXS-000kn2C@most.weird.com> <20091201054734.GB11235@dpotapov.dyndns.org> <m1NFX19-000kn4C@most.weird.com> <20091201185114.GC11235@dpotapov.dyndns.org> <m1NFXvL-000kn2C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 22:19:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFa7f-0007AJ-E1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 22:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZLAVSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbZLAVSr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 16:18:47 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54852 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZLAVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 16:18:46 -0500
Received: by bwz27 with SMTP id 27so3880257bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 13:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=waIAJAytPy5nDbg2P7Jl2pD7KCoxDOZ29Rmjwn24KA4=;
        b=bDnbnCLW3CWiIe3f/bURTWrkgyiOPl20Rhwpab5HV/d8sD/ObRzrdiw5uazcSF9efm
         LTwP+qM24pHuf5/mBZY3QPw5EP8MfntgvRpwtHMk7uFyv1IrEnZByah4RFMFFuaLV7AB
         3oGj58yByPZxz+hU8ONCxFANKQiisPnTY2HcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MSUgBowj+Zgn51p2ZZ8WDHttvpbRI2WGMJHPt/KYwmW5WoYz4SrPSAiD/kxq8Li7QF
         LtjZg4qgSA4W7gzCBxpxryUEZhgpdjC30mAvtHB5x/4YciGZE8oYHlVgQlpqZVV2dXCE
         cSoNiWLQJhHE72bH7hvJH4Y5NTcU5RNVdeWhY=
Received: by 10.204.20.143 with SMTP id f15mr1332141bkb.49.1259702332052;
        Tue, 01 Dec 2009 13:18:52 -0800 (PST)
Received: from localhost (ppp91-78-50-138.pppoe.mtu-net.ru [91.78.50.138])
        by mx.google.com with ESMTPS id p17sm642965fka.5.2009.12.01.13.18.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 13:18:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFXvL-000kn2C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134257>

On Tue, Dec 01, 2009 at 01:58:05PM -0500, Greg A. Woods wrote:
> 
> > > I just disagreed that "git archive" was a reasonable alternative to
> > > leaving the working directory alone during the entire time of the build.
> > 
> > Using "git archive" allows you avoid running long time procedure such as
> > full clean build and testing in the working tree. Also, it is guaranteed
> > that you test exactly what you put in Git and some other garbage in your
> > working tree does not affect the result.
> 
> Sure, but let's be very clear here:  "git archive" is likely even more
> impossible for some large projects to use than "git clone" would be to
> use to create build directories.

AFAIK, "git archive" is cheaper than git clone. I do not say it is fast
for huge project, but if you want to run a process such as clean build
and test that takes a long time anyway, it does not add much to the
total time.

> 
> Disk bandwidth is almost always more expensive than disk space.

Disk bandwidth is certainly more expensive than disk space, and the
whole point was to avoid a lot of disk bandwidth by using hot cache.
If you have two working tree then it is likely that only one will be
in the hot cache, that is why you can switch faster (and to recompile
a few files) than going to another working tree. It has never been
about disk space, it is about disk cache and keeping it hot.

> 
> Multiple working directories are really the only sane solution
> sometimes.

Sure, sometimes... I do not know details to say what will be better in
your case, but I just wanted to say that you should weight that against
switching, because switching in Git is very fast. Much faster than with
any other VCS...

Another thing to consider is that if you put a really huge project in one
Git repo than Git may not be as fast as you may want, because Git tracks
the whole project as the whole. So, you may want to split your project in
a few relatively independent modules (See git submodule).


Dmitry
