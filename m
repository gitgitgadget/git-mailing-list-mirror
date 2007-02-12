From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 09:31:48 -0500
Message-ID: <9e4733910702120631o1be92037ue89b069b0354c8cb@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
	 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
	 <7vzm7k9c3c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0702121241130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 15:32:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGcDn-0006yC-NR
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXBLObw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbXBLObw
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:31:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:8801 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964939AbXBLObv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:31:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so597834uga
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 06:31:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eX9rheDf23TZ/RnmmR9NBXD8gzvuaCrf/nm+J2dQMS/XUt240tkRm5po9XULfVY4MdtuxtiejjofkjJhgjd+c60x4TUsvmjE0RbAWm1xv0Okryf+EmTAqIJZutORvv4zueRQQuQ2NygXrsnMVSrDT2BDOW1jWJ79CQFfsSQxQJQ=
Received: by 10.114.174.2 with SMTP id w2mr5821029wae.1171290708457;
        Mon, 12 Feb 2007 06:31:48 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Mon, 12 Feb 2007 06:31:48 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702121241130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39406>

On 2/12/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 11 Feb 2007, Junio C Hamano wrote:
>
> > You are assuming everybody does initial clone all the time.  I do not
> > think that holds true in practice.
>
> It depends how you interpret "all the time". What you (Junio) are
> suggesting is that the count of initial clones is relatively small as
> compared to the total number of fetches.
>
> However, you can interpret "all the time" in terms of "time". Most fetches
> are really small. They even often end up in no objects pulled at all.
> These are cheap for the server. The initial clones take a long time. They
> are expensive.
>
> I'd be interested to learn how much of the CPU time is actually spent in
> initial clones, rather than other types of fetches. It might make sense
> yet to optimize initial clones.

I don't think CPU is a problem at kernel.org, but disk IO defnitely
is. The initial clones cause several minutes (sometimes 10 min or more
when there kernel.org is loaded) worth of disk IO. They also totally
thrash the kernel.org cache. The alternative of using a clone to
trigger a repack would go through this once, and then use sendfile (is
gitd that smart?) to send the packs. Sendfile uses the smallest cache
required.

Why doesn't clone copy the existing packs down first with sendfile,
then build a small pack for what is left and avoid the initial step of
making a giant pack. Isn't clone going to break when the repo exceeds
2GB?


>
> Ciao,
> Dscho
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
