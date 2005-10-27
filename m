From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 12:54:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271248590.3663@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
 <17248.39333.181379.615274@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 12:55:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV5Oe-0004u5-SE
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 12:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJ0KyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 06:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJ0KyJ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 06:54:09 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54404 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750710AbVJ0KyI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 06:54:08 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97CDF13F6A5; Thu, 27 Oct 2005 12:54:07 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B150B4EBA; Thu, 27 Oct 2005 12:54:07 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5F3DB5955A; Thu, 27 Oct 2005 12:54:07 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0B64013F6A5; Thu, 27 Oct 2005 12:54:05 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17248.39333.181379.615274@cargo.ozlabs.ibm.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10713>

Hi,

On Thu, 27 Oct 2005, Paul Mackerras wrote:

> Johannes Schindelin writes:
> 
> > after thinking about my earlier approach, I think there's a better, less 
> > intrusive, and all in all just simpler approach:
> 
> How many round-trips does it take?  When you're on the other side of
> the Pacific from the server you care about round-trips. :)  One of the
> nice things about rsync is that it does everything with only 1.5
> round-trips.

The plan is to reuse the existing framework. It sends 32 "have" messages, 
then a flush, then again 32 "have" messages, flush again, then reads all 
answers until a "NAK". The last 3 steps are repeated over and over again.

That means that there are always at least 32 "have" messages on the wire 
(which is described in the source code as "one window ahead"), i.e. it is 
about 32x faster than simple "have" -> "NAK/ACK" handshakes.

Ciao,
Dscho
