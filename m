From: Jeff King <peff@peff.net>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Mon, 25 Apr 2011 14:37:16 -0400
Message-ID: <20110425183715.GA24069@sigill.intra.peff.net>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie>
 <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
 <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
 <20110425075750.GA28172@elie>
 <m2pqoa9121.fsf@linux-m68k.org>
 <20110425085913.GB28885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEQf0-0005th-SE
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 20:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811Ab1DYShT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 14:37:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46511
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758696Ab1DYShT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 14:37:19 -0400
Received: (qmail 12692 invoked by uid 107); 25 Apr 2011 18:38:58 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Apr 2011 14:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2011 14:37:16 -0400
Content-Disposition: inline
In-Reply-To: <20110425085913.GB28885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172038>

On Mon, Apr 25, 2011 at 03:59:13AM -0500, Jonathan Nieder wrote:

> who wonders where his origin/HEAD symref came from and if
> "git remote set-head --auto origin" was ever automatic

It is created by "clone", but not by "git remote add". The "auto" in
remote's "set-head" means "right now, look up the HEAD on the remote and
set our $remote/HEAD based on it". Not anything about being set up or
tracked automatically.

Perhaps "git remote add" should automatically do "set-head --auto", just
as if you had cloned. I think the main reason against it is that doing
so requires hitting the network, which "remote add" (without "-f") does
not otherwise need to do.

Certainly if we are doing "-f", it would not be a big deal. In other
cases, we could perhaps fill in the value on the first "fetch", but we
may need infrastructure to know when we are on the first fetch (and it
is not simply the case that the user deleted $remote/HEAD themselves).

-Peff
