From: Jeff King <peff@peff.net>
Subject: Re: How to resume broke clone ?
Date: Thu, 5 Dec 2013 11:12:17 -0500
Message-ID: <20131205161217.GB27869@sigill.intra.peff.net>
References: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
 <5297004F.4090003@gmail.com>
 <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
 <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <52A07DC5.5090508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>, Duy Nguyen <pclouds@gmail.com>,
	zhifeng hu <zf@ancientrocklab.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 05 17:12:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VobXO-0002NY-LB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 17:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336Ab3LEQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 11:12:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:51004 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756835Ab3LEQMT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 11:12:19 -0500
Received: (qmail 18270 invoked by uid 102); 5 Dec 2013 16:12:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Dec 2013 10:12:19 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Dec 2013 11:12:17 -0500
Content-Disposition: inline
In-Reply-To: <52A07DC5.5090508@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238890>

On Thu, Dec 05, 2013 at 02:21:09PM +0100, Michael Haggerty wrote:

> A better alternative would be to ask users to clone from the central
> server.  In this case, the central server would want to tell the clients
> to grab what they can from their local bootstrap mirror and then come
> back to the central server for any remainders.  The trick is that which
> bootstrap mirror is "local" would vary from client to client.
>
> I suppose that this could be implemented using what you have discussed
> by having the central server direct the client to a URL that resolves
> differently for different clients, CDN-like.  Alternatively, the central
> Git server could itself look where a request is coming from and use some
> intelligence to redirect the client to the closest bootstrap mirror from
> its own list.  Or the server could pass the client a list of known
> mirrors, and the client could try to determine which one is closest (and
> reachable!).

Exactly. I think this will mostly happen via CDN, but I had also
envisioned that the server could add metadata to a list of possible
mirrors, like:

       [mirror "ko-us"]
       url = http://git.us.kernel.org/...
       zone = us

       [mirror "ko-cn"]
       url = http://git.cn.kernel.org/...
       zone = cn

If the "zone" keys follow a micro-format convention, then the client
knows that it prefers "cn" over "us" (either on the command line, or a
local config option in ~/.gitconfig).

The biggest problem with all of this is that the server has to know
about the mirrors. If you want to set up an in-house mirror for
something hosted on GitHub, but its only available to people in your
company, then GitHub would not want to advertise it. You need some way
to tell your clients about the mirror (and that is the inverse-mirror
"fetch from the mirror, which tells you it is just a bootstrap and to
now switch to the real repo" scheme that I think you were describing
earlier).

-Peff
