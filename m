From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: Globbing for ignored branches?
Date: Sat, 25 Jan 2014 15:15:42 +0100
Message-ID: <20140125141542.GA402@x4>
References: <0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
 <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
 <20140124204825.GA17167@sigill.intra.peff.net>
 <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
 <20140125013433.GA22336@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 25 15:15:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W741V-0004AD-Rq
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 15:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbaAYOPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 09:15:45 -0500
Received: from ud10.udmedia.de ([194.117.254.50]:59366 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbaAYOPo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 09:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud10.udmedia.de; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=beta; bh=c3+rJB2cTf45yF8ad75oqT8DBr
	ikhoC6qduximjdmSE=; b=hdl0u6H1Q3V0XqdjAxxCdW8g1H7LEkLhJSucJ+xWH4
	49ih4dWaKAOJtGC1MmE1dsxGpEVylHUkipzIgKklEuvJ7p138Mg7UIBmN1uQfCs3
	/jKRIxFmai4ZpPuLxvxVJwn/Lytpire3mOnM2Sf2rrKGjNpLhDCrbBtNB4O09pSi
	8=
Received: (qmail 9522 invoked from network); 25 Jan 2014 15:15:43 +0100
Received: from unknown (HELO x4) (ud10?360p3@91.64.96.185)
  by mail.ud10.udmedia.de with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 25 Jan 2014 15:15:43 +0100
Content-Disposition: inline
In-Reply-To: <20140125013433.GA22336@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241068>

On 2014.01.24 at 20:34 -0500, Jeff King wrote:
> On Fri, Jan 24, 2014 at 01:08:42PM -0800, Junio C Hamano wrote:
> 
> > Not really.  You do not have to view it as "'not refs/heads/foo' is
> > affecting the previous '+refs/heads/*:refs/remotes/origin/*'".
> > 
> > You can think of two refspecs "refs/heads/foo refs/heads/bar" are
> > both affecting the "end result"; so far we only had a single way for
> > multiple refspecs to affect the end result and that was a "union".
> > Introducing "subtract" as another mode of combining is not too bad,
> > I would think, at the conceptual level.
> 
> > I tend to agree that "refs/heads/foo:" is being too cute and may be
> > confusing, at least if it will be the only way to express this in
> > the end-user-facing UI.  Even some people were confused enough on a
> > very sensible "push nothing to ref means deletion" to make us add
> > another explicit way, "push --delete", to ask for the same thing.
> 
> Agreed. I went with "^refs/heads/master" in the patch below, but I am
> open to other suggestions.

Many thanks for the patch. It seems to work as advertised, but only if
the negative refspec appears on a separate line. For example:

[remote "origin"]
        url = git://gcc.gnu.org/git/gcc.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = ^refs/remotes/hjl

works fine, but:

[remote "origin"]
        url = git://gcc.gnu.org/git/gcc.git
        fetch = +refs/heads/*:refs/remotes/origin/* ^refs/remotes/hjl 

doesn't. (I think this happens because bad_ref_char in refs.c checks for '^'.)

-- 
Markus
