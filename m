From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 15:44:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606141542040.22630@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 15:33:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCoTP-0005na-U6
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 15:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbcFNNdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 09:33:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:49966 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbcFNNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 09:33:39 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M2cYX-1bVzHV2bY5-00sOxq; Tue, 14 Jun 2016 15:33:32
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:r9ZnRyXYRwC2bQk712iNGmrL3ZsFZZKqQoIhk0ZP7HXlGfB4Mc7
 ZuogsythMOfZd5CEMyf0TwlvtpxxhrOY5oo+7QJZlU91guXemtHz2VI8g0aYQdEWSt20gBn
 Q8J4kEjcG8/WU5NP3doh5EUqJJ7fQE31ckw7lMzsmx+MgUDK/5Y/n98GXpqKZ35kRhck9J5
 SFPKgKY16tScctLbyzeOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:maSf0gAX52k=:vCiXMLW9Y2wQTv+/QswQF3
 0WFoyYOjPvyGAB+5oECMvj0PVD9bV9/+edN7Jrf9tFFMRqe3XWdnmTcmbX4ZQzzT/OGmDAB/1
 Aj5tlB7AQrAu+ja4na4Za6SvotjHuaLPXgbhQ6gDAdA4KWxD22ibIfgTAvz5rB1IKYQxsvZBi
 0ocNASwojlfFS7kZ/xPk21etZs1uWxVEB8iQqhbWg0n6XlzhFAgtHttwwUpyscr/F62a5RRvF
 T7n4gMQuH9H8Ev9/KXYaMYbs1uN/kuxSjVngt4nkX/tbkLJWkWGwDv17iW4FI4F5P4/IZ4QH/
 dBK1nI4Va4B34qEgfFLEBipZ0OxeUPu4LMm0M0eF7fx4LRx9CzHaRR0CyMyl+z0Oakmqpj7DC
 XtxZ8y6ltwkJbOUtwdlNcrq5wL60vi9lXnDtQzLKUzwLslEI3lS2mufOgBvCWvSabBx+Y2QuN
 TSCLd3VAo8tnk1dMNrB6iuoAM1HdpcyQJeV/viDiQfOf0hPi+Lva188t2u4Zv6IRIYlUjydDv
 ZMW+nzE8Nws817aAd92U3MwzE3WWSMXO7jKFUQ5ndDOwyuFp7Ccb5kJT9FWoPZZB3FQDokIFk
 MHhih+TRsu23BJ2RF5l89dAXSezkA0qCL2Y8nQjG6N1uwthQHQGs/Li1p6Vb72UTJdKBaQXi3
 TwK0lvdaESUIBDc7oTmYXwNhgC/5HksV+1fr7rpRP1sSQYwSUQ2OuOzXaGE040v7CrqjDAKCo
 Atu1Q8cpKcImSrcyTAI7unS/+rlyDST21XfotqMY71987CBIoQqWB2yIs/dQ725y1BI2Fw/A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297293>

Hi,

On Mon, 13 Jun 2016, Nicolas Pitre wrote:

> On Mon, 13 Jun 2016, Lukas Fleischer wrote:
> 
> > Improve the readability of recv_sideband() significantly by replacing
> > fragile buffer manipulations with more sophisticated format strings.
> > Also, reorganize the overall control flow, remove some superfluous
> > variables and replace a custom implementation of strpbrk() with a call
> > to the standard C library function.
> > 
> > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> 
> The previous code was a total abomination, even if I happen to know who 
> wrote it.

Let's give Junio a break, okay? He does a kick-ass job at maintaining Git.
What we see here is simply good software development, nothing more,
nothing less: an initial, working code being improved. No need to make the
original author feel bad... :-)

Ciao,
Dscho
