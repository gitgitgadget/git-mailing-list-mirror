From: Jeff King <peff@peff.net>
Subject: Re: Commit/merge messages for binary files
Date: Sat, 19 Feb 2011 03:03:07 -0500
Message-ID: <20110219080307.GA18039@sigill.intra.peff.net>
References: <AANLkTikXMi92iUd-1bEfs5WfawyHp4G7=Ynd+eaq_wsR@mail.gmail.com>
 <vpq39nlsb3r.fsf@bauges.imag.fr>
 <4D5ED6F2.8030008@gmail.com>
 <vpqwrkx9h2z.fsf@bauges.imag.fr>
 <4D5EE7D2.5060703@gmail.com>
 <20110219070601.GA14059@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 09:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqhmq-0007e8-0W
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 09:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab1BSIDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 03:03:12 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49802 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374Ab1BSIDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 03:03:11 -0500
Received: (qmail 7399 invoked by uid 111); 19 Feb 2011 08:03:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 08:03:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 03:03:07 -0500
Content-Disposition: inline
In-Reply-To: <20110219070601.GA14059@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167254>

On Sat, Feb 19, 2011 at 02:06:01AM -0500, Jeff King wrote:

> Now that seems wrong. What about doing another diff:
> 
>   $ git show --oneline --stat --summary
>   43961bc two
>    foo.rand |  Bin 4096 -> 4096 bytes
>    1 files changed, 0 insertions(+), 0 deletions(-)
> 
> That's right. Now let's turn on break detection:
> 
>   $ git show --oneline --stat --summary -B
>   43961bc two
>    foo.rand |   34 +++++++++++++++-------------------
>    1 files changed, 15 insertions(+), 19 deletions(-)
>    rewrite foo.rand (100%)
> 
> Broken again. So I guess we have some problem with making sure we treat
> broken filepairs as binary.

Yep, builtin_diffstat just didn't handle that case. Two patch series to
follow:

  [1/2]: diff: handle diffstat of rewritten binary files
  [2/2]: diff: don't retrieve binary blobs for diffstat

The first one fixes the bug, and the second is a convenient optimization
I noticed while there.

-Peff
