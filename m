From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: Some git performance measurements..
Date: Fri, 7 Dec 2007 19:15:36 +0000
Message-ID: <e2b179460712071115k369dddcatb0f6456d0028acbb@mail.gmail.com>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
	 <finmvm$da8$1@ger.gmane.org>
	 <alpine.LFD.0.9999.0711291812530.8458@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0711292131350.9605@xanadu.home>
	 <B161871F-E812-44B4-A699-44341B5783D3@zib.de>
	 <e2b179460712070535x2eb10710s75a581664139e0cf@mail.gmail.com>
	 <Pine.LNX.4.64.0712071348100.27959@racer.site>
	 <e2b179460712070809r4127dc0br8dc20f55b1076501@mail.gmail.com>
	 <Pine.LNX.4.64.0712071816100.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ig5-0006ix-Ay
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXLGTPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbXLGTPi
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:15:38 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:40681 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbXLGTPh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:15:37 -0500
Received: by wr-out-0506.google.com with SMTP id c49so652723wra
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ck8GutolWeeNN+gM1hpvqRZg2wdOZMzfX86d/vu4ZaY=;
        b=DFv6iTM9+3eqnR1n9COOdD7BtKHZbJ5IaDDBFTK6/5h7BdLQ1WiCectfRomZ6P7eNi/OIpDhGHJDMGzaW4Gs3U/CpBIDPGvANCtSrmhLGacoSB9fWA0u2TckXKZaAQW/cBBvMJqDLC8uDxXgAHXewT1rBNRCmj3oYxF3nR/4XP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EfIxibTERCSAvmKb1zWrDU8OpV16+lag71vFHno9rggNFcaUah35SoJdaaKnn4D9SRg5lYa4JW43tKda3ZqTU3ddSWWq8lGbEn4DT4/VDIYDWd1SUrpLXBNmNqJZ/DXyXwRXxbXijroIdAK2oQ1v8lmJg+wQTaPGoyWrprAHfS8=
Received: by 10.70.69.1 with SMTP id r1mr5690984wxa.1197054936834;
        Fri, 07 Dec 2007 11:15:36 -0800 (PST)
Received: by 10.70.59.11 with HTTP; Fri, 7 Dec 2007 11:15:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712071816100.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67443>

On Dec 7, 2007 6:37 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 7 Dec 2007, Mike Ralphson wrote:
>
> > On Dec 7, 2007 1:49 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Fri, 7 Dec 2007, Mike Ralphson wrote:
> > >
> > > > I benchmarked 3 alternative qsorts, qsortG [2] was the fastest on my
> > > > system but has funky licensing, the NetBSD qsort was middle-range
> > > > and the glibc one the slowest of the three (but that could be due to
> > > > it being tuned for a "Sun 4/260"). All of them show over 100x speed
> > > > improvements on a git-status of my main repo (104s -> ~0.7s)
> > >
>
> Okay, sorry, I did not bother reading further when I read "You may use it
> in anything you like;".
>
> But if the author did not respond, it might be a better idea to just
> reimplement it.
>

I've just tried the mergesort implementation as used in msysgit and
that performs faster for me. It's simpler, and compatibly licensed. It
looks good.

Mike
