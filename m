From: Jeff King <peff@peff.net>
Subject: Re: Lack of detached signatures
Date: Wed, 28 Sep 2011 18:25:43 -0400
Message-ID: <20110928222542.GA18120@sigill.intra.peff.net>
References: <alpine.LNX.2.00.1109271742460.24832@bruno>
 <7vty7xttxh.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com>
 <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
 <1317195719.30267.4.camel@bee.lab.cmartin.tk>
 <alpine.LNX.2.00.1109280555460.25187@bruno>
 <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joseph Parmelee <jparmele@wildbear.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Olsen, Alan R" <alan.r.olsen@intel.com>,
	Michael Witten <mfwitten@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 00:25:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R92Zb-0003lR-6q
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 00:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab1I1WZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 18:25:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47663
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab1I1WZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 18:25:46 -0400
Received: (qmail 9962 invoked by uid 107); 28 Sep 2011 22:30:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Sep 2011 18:30:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Sep 2011 18:25:43 -0400
Content-Disposition: inline
In-Reply-To: <7v1uv01uqm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182368>

On Wed, Sep 28, 2011 at 09:45:21AM -0700, Junio C Hamano wrote:

> The world is not so blank-and-white. Trust is ultimately among humans. If
> this message is not from the real Junio, don't you think you will hear
> something like "No, that c6ba05... is forgery, please don't use it!" from
> him, when he finds this message on the Git mailing list?  If he does not
> exercise diligence to even do that much, does he deserve your trust in the
> first place?
> 
> GPG does add security (if you have the key) but you can do pretty well
> even without it in practice.

Your suggestion above is something like an audit trail. It doesn't
prevent all mischief from happening, but after it happens and is
noticed, we can do some analysis, figuring out what happened and how to
clean up. Banks do this all the time with transactions.

At the same time, banks don't rely solely on an audit trail. They also
have up-front mechanisms, like passwords and ATM secrets, that help
prevent mischief from happening in the first place. And when they fail,
we fall back to the audit trail.

So having preventative mechanisms and audit mechanisms is not an
either-or situation. They complement each other; the strengths of one
can help when the other fails.

In this case, I think signed tarballs would be a nice complement to the
natural human audit trail. It can stop some attacks early, without
having to worry about the effort of analyzing and cleaning up after the
fact. Can the signature be wrong, or be checked improperly? Of course.
If you realize your machine has been hacked and your key stolen, then
you let everybody know and we fall back to auditing what has already
happened.

Each mechanism you put in place has a cost, of course. And it's worth
thinking about whether that cost is worthwhile. But it really is as easy
as running "gpg --detach-sign" when you upload a release, isn't it? You
already do something similar with the signed tags. So the cost of the
mechanism is quite low.

> I do not think that is true at all. Developers just dropped *.tar.gz on a
> 'master' machine, and left the rest to a cron job that reflates the
> tarball into *.tar.bz2, sign both using a GPG key, and mirror them to the
> public-facing machines 'www'.
> 
> Somebody who had access to the 'master' machine could add a new tarball
> and have it go thru the same exact process, getting signed by the cron.

Right. In theory the master machine is harder to hack than the public
facing mirrors, but in this case it was not. Every link in the trust
chain introduces new possibilities for failure.

Given that git releases are all made by you, why not just sign them
locally with the same key you use to sign the release tags? It does mean
you have to generate and upload the .bz2 yourself[1], but is that really
that big a deal?

-Peff

[1] This is a minor nit, and probably not worth breaking away from the
way the rest of the world does it, but it is somewhat silly to sign the
compressed data. I couldn't care less about the exact bytes in the
compressed version; what I care about is the actual tar file. The
compression is just a transport.
