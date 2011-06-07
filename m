From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Tue, 7 Jun 2011 19:01:42 -0400
Message-ID: <20110607230013.GA23409@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <7vipsi8zwl.fsf@alter.siamese.dyndns.org>
 <20110606220821.GB13697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5HT-0005CQ-2c
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab1FGXBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:01:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48646
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029Ab1FGXBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:01:45 -0400
Received: (qmail 22982 invoked by uid 107); 7 Jun 2011 23:01:51 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 19:01:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 19:01:42 -0400
Content-Disposition: inline
In-Reply-To: <20110606220821.GB13697@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175278>

On Mon, Jun 06, 2011 at 06:08:21PM -0400, Jeff King wrote:

> On Mon, Jun 06, 2011 at 01:31:54PM -0700, Junio C Hamano wrote:
> 
> > >  static struct ref *wanted_peer_refs(const struct ref *refs,
> > >  		struct refspec *refspec)
> > >  {
> > > -	struct ref *local_refs = NULL;
> > > -	struct ref **tail = &local_refs;
> > > +	struct ref *head = get_remote_ref(refs, "HEAD");
> > 
> > The rest of the patch looked quite sane but I wonder if this should be
> > using get_remote_ref() that calls find_ref_by_name_abbrev() which in turn
> > would hit "refs/heads/HEAD" if the remote side didn't give you "HEAD".
> > Shouldn't it be using find_ref_by_name() directly?
> 
> Ick, yeah, that was just me blindly cutting down what get_fetch_map was
> doing to the bit that I wanted, and thinking get_remote_ref was it.  I
> didn't even notice the fact that it was using the _abbrev form of
> find_ref_by_name.
> 
> It should definitely be an exact match. I'll fix it in my re-roll.

OK, here is the re-roll. I've omitted the first two patches, which are
the same as before. So this replaces the old 3/3. When merged with (or
rebase on top of) the remote-helpers fixes I posted yesterday, all tests
pass.

  [1/2]: make copy_ref globally available
  [2/2]: clone: always fetch remote HEAD

-Peff
