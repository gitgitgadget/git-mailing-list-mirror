From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 17:30:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606141729080.22630@virtualbox>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr> <alpine.DEB.2.20.1606141542040.22630@virtualbox> <alpine.LFD.2.20.1606141059420.1714@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 17:19:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCq7y-0006ME-1s
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 17:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbcFNPTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 11:19:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:51558 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbcFNPTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 11:19:37 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mcyxq-1avrTC3YFm-00ICgM; Tue, 14 Jun 2016 17:19:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.LFD.2.20.1606141059420.1714@knanqh.ubzr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FE3zDvHR140jjhUfnMBV3YZ2U581IMvJHzVYwQn8lMa2crhkXrL
 CLZm99pm47mFgC3lmP0bzHgjUav+U7b8K9rQErutOB7ZYJAYQvIXRBR1/eVxBSS/Vyw4tQt
 ftgumXgbR7Dgd5nhjidNZChGRCdWme2B2hm6dZ+2lmiEeT7pnTtsm/mfcWOIIKze9SUkhv7
 qlkfBZhM4CeyE2xcN0cnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/PJEUEsiv0Y=:XFss9PokJprL7d088C0eUZ
 DAHbudB2jBt4CXGMWIc8dWP3A+S734EUoUEWcEs9l7j9tWe+YewoQ3wVLH0tV5J9R3utz22zD
 +eD9RsKd8N7J9RwH+4QFJlYHIaSpNzQw9G2aEKpNgK5/O6gbKCxnPzJBBoxp4DU41ke/NqAv+
 w8S4mA2Xs9Rpt0kIxkUI14szYWqPSa7tLUVRL5vnvYQX3FryFiBpnJqcHK6KqJpdUujJlix+y
 D6QHn/cr6UlcpHBsSA7eeImkqVGXw2aoDaSmt27v3zxbwWY/ADnRUCAEgcKL9zWHuSCPpoNUm
 KvqMq34+zCZaMQreW7EudukpiTXpvlA1AHYwadVx+AZXZ9289Hdfiy6Bw9PuM9qRTgvKkERIO
 h0upXQrA/cXAvY740v/rE7gzgW6Ix0MjKAkYHWG28Wf3RFG+59w8MwzODb+TPu5qFJTkiZ9eP
 5nzIfgsGXDgZ5xibcNxWZtUNNbs6XpWRES4GBxEG2W82YQUFEoMEs461XgQlCV+EFlFNNWQH9
 7ues59Xsmw6HLFLgSj592NApNliSXNjXOw9/sSbcilH0jPrmSpQD8ATGE6vbObbubXnaJP7eX
 uJhuXv6b9fAH0s/CPuM4UD+zDpq9RERo2DomKOhxWL0UyKRhuSuD/r7JhjXTi+3yVqiz81SDF
 JI/ory3BNnl9iq6g5OozsRpn94+lDq+eggI5sRVuwBGBStKea//OK/uCl3LgzjK3h1sUED4DV
 8JYyjAjG7VQXqJsgJ6FSoAaTvCZQ5zFldaloCaVoKwYaoUKBIxTZkGt9nhoOj1X26oIap7pX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297299>

Hi Nico,

On Tue, 14 Jun 2016, Nicolas Pitre wrote:

> On Tue, 14 Jun 2016, Johannes Schindelin wrote:
> 
> > On Mon, 13 Jun 2016, Nicolas Pitre wrote:
> > 
> > > On Mon, 13 Jun 2016, Lukas Fleischer wrote:
> > > 
> > > > Improve the readability of recv_sideband() significantly by
> > > > replacing fragile buffer manipulations with more sophisticated
> > > > format strings.  Also, reorganize the overall control flow, remove
> > > > some superfluous variables and replace a custom implementation of
> > > > strpbrk() with a call to the standard C library function.
> > > > 
> > > > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> > > 
> > > The previous code was a total abomination, even if I happen to know
> > > who wrote it.
> > 
> > Let's give Junio a break, okay? He does a kick-ass job at maintaining
> > Git.  What we see here is simply good software development, nothing
> > more, nothing less: an initial, working code being improved. No need
> > to make the original author feel bad... :-)
> 
> In case my sarcasm wasn't clear, _I_ am the author of the alluded
> abomination.

Sorry, I did not catch that. I just looked at
583b7ea31b7c16f872b178d541591ab816d16f85 and felt that we could be nicer
to Junio...

Ciao,
Johannes
