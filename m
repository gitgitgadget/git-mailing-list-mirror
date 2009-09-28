From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: how optparse can go horribly wrong
Date: Mon, 28 Sep 2009 15:37:07 +0200
Message-ID: <20090928133707.GA3343@localhost>
References: <20090925233226.GC14660@spearce.org> <20090926015127.GA12994@vidovic> <fabb9a1e0909260644w781d3c3h4fca22e3b7d97768@mail.gmail.com> <20090926192527.GF14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 28 15:37:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsGPx-0003QZ-DD
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 15:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbZI1NhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 09:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZI1NhR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 09:37:17 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60927 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZI1NhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 09:37:16 -0400
Received: by bwz6 with SMTP id 6so1257225bwz.37
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=4Xn02pv2r/FUDRvKosgLkyd4tduhgexoBiUn4Kr3t1I=;
        b=YvSzTHSem0qI1ht2y6YiC11L/VRUSCL0/9QarTptm+RiSFoFG3RsvSSVedE/yHMxfk
         OdQ7tx1CdK4O5yfbCYoDSpW2f8qCjrw3bLfc3I2RvawswlBM8XMNb+rD+otNeMipOo3G
         GKGT0I4uejZi1NeT1vhpXfSX9FIGpAIpS8WvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=gtb9/2ncs6T9WVq8Ilfbd1mJYkjrWwTURwqU9MXbN+NDRnKnpcJZqBkiedjNV536ck
         Q+Cpp5/Njs5+2y+USw/NDd5weOWeKo7vfUhZDuXsQci0MjXlaO8mNLkQJ+BtZ4OyLesE
         XU5XjHLmow/KwkK4t+QG3wUHEA1G8T0DV7Q7I=
Received: by 10.204.25.15 with SMTP id x15mr3060672bkb.47.1254145039129;
        Mon, 28 Sep 2009 06:37:19 -0700 (PDT)
Received: from darc.lan (p549A37E8.dip.t-dialin.net [84.154.55.232])
        by mx.google.com with ESMTPS id 22sm22393270bwz.38.2009.09.28.06.37.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 06:37:17 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MsGPb-00013w-Vk; Mon, 28 Sep 2009 15:37:07 +0200
Content-Disposition: inline
In-Reply-To: <20090926192527.GF14660@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129260>

On Sat, Sep 26, 2009 at 12:25:27PM -0700, Shawn O. Pearce wrote:

> What I think we should do is not allow cuddling of short options
> when the final option takes more than 1 character worth of argument.
> Thus `git commit -a -mfoo` is OK, but `git commit -amfoo` is not.

I also think that would be the most sensible solution.

A little experimentation with git-log reveals that it does not behave very
well either.

 git log -n1asdf	-> asdf is ignored
 git log -pn1		-> error
 git log -p1		-> error
 git log -1p		-> p is ignored

So I think this should instead behave just like you described above.

 git log -n1asdf	-> error: unknown option(s) -asdf
 git log -pn1		-> git log -p -n1
 git log -p1		-> git log -p -n1
 git log -1p		-> git log -p -n1

Clemens
