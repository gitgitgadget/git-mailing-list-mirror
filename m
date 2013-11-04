From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp()
 instead
Date: Mon, 4 Nov 2013 23:17:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1311042316520.1191@s15462909.onlinehome-server.info>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org> <xmqqbo20ynxs.fsf@gitster.dls.corp.google.com> <xmqq7gcnzznt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 23:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdSSk-0001Oy-2J
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 23:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab3KDWRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 17:17:30 -0500
Received: from mout.gmx.net ([212.227.17.22]:61653 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab3KDWR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 17:17:29 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MF4eJ-1VOtaV20x1-00GJF1
 for <git@vger.kernel.org>; Mon, 04 Nov 2013 23:17:28 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq7gcnzznt.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:zYrxPSdNVLejS8IheD95wS/Zbj2ldovM4upFRMjXebKeUENIR6W
 WmflWN7NElLW0F5x0JQHWcjI4FvWCfVJg+OAOQr5lCF4yZjYNTF2+OnCXPJPkNVB8TTM+rG
 jC5yjPA2MR5WyjrBaukjQwlM0/KeqQ3QIPRZEPRS2Sa9gWsV3wP8/9frU+P1qJPdLBzG5C+
 3OFxJpSy6b4abmbWz2nQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237309>

Hi Junio,

On Mon, 4 Nov 2013, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not think anybody sane uses prefixcmp() or suffixcmp() for
> > anything but checking with zero; in other words, I suspect that all
> > uses of Xcmp() can be replaced with !!Xcmp(), so as a separate
> > clean-up patch, we may at least want to make it clear that the
> > callers should not expect anything but "does str have sfx as its
> > suffix, yes or no?" by doing something like this:
> >
> >  int suffixcmp(const char *str, const char *suffix)
> >  {
> >  	int len = strlen(str), suflen = strlen(suffix);
> >  	if (len < suflen)
> >  		return -1;
> >  	else
> > -		return strcmp(str + len - suflen, suffix);
> > +		return !!strcmp(str + len - suflen, suffix);
> >  }
> >
> > I am not absolutely sure about doing the same to prefixcmp(),
> > though. It could be used for ordering, even though no existing code
> > seems to do so.
> 
> I just realized why this suggestion is incomplete; if we were to go
> this route, we should rename the function to has_suffix() or
> something. anything-cmp() ought to be usable as an ordering
> comparison function, but suffixcmp() clearly isn't.

I have to admit that I do not understand why a change in suffixcmp()'s
behavior is needed.

Ciao,
Johannes
