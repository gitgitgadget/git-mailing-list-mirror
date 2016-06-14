From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 13:09:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606141245490.1714@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:09:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCrq6-0005Gl-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbcFNRJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:09:19 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:60198 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbcFNRJS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 13:09:18 -0400
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id CrpzbcqVl7gE8Crq0bSgdB; Tue, 14 Jun 2016 13:09:17 -0400
X-Authority-Analysis: v=2.1 cv=B94ZqLZM c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=dg4UtMH5AAAA:8 a=hTuVF_uvy4Da_anBD-kA:9 a=CjuIK1q_8ugA:10
 a=byNfn09xH3PuSfgbYLsR:22
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 765B42DA01A5;
	Tue, 14 Jun 2016 13:09:15 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
X-CMAE-Envelope: MS4wfEaQHWq7AP2CoieRls1Wza4PVQrHPxZjNalHE5ySFk4LvD6MYwDKf5Fh5wELpGOgGD5mbrM3qos3Vo6vzAlpQcUmlgrxnVcCG/ZIwIUAbpKAqKxpQtxc
 GXc7gWakrX47+CzUZIcbyTRZtGBS4jebMTvgQd4FkEgDDeWy1RTB55WxpBJleQDSzgwYr+5iuMZkTiptFkJIIfzJ7Uk9g1kUlFY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297308>

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
> 
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

I just looked again at all the contraptions _I_ wrote (not Junio's) for 
a reason why I went to such extremes in making this code co complicated.

One aspect that is now lost with your patch is the atomic nature of the 
write.  See commit ed1902ef5c for the explanation.  You could probably 
use sprintf() into a temporary buffer and write it in one go to avoid 
segmented writes from the C library. It's probably not worth having that 
complex code just to avoid a string copy.

> > I had a really hard time reading and understanding this function when I
> > came up with my last patch. What I ended up with is almost a complete
> > rewrite of recv_sideband() and I find the end result to be much more
> > readable than what we have now. Given that this is quite invasive, it
> > would be good to have some more eyes and opinions...

I'd also suggest you look at "git log --author=Pitre sideband.c" output 
where I documented other examples of messed up displays that led to 
the current code so you could confirm your patch covers them.


Nicolas
