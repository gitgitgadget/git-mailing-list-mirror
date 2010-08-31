From: Jeff King <peff@peff.net>
Subject: Re: [RFC] notes: avoid recommitting identical trees
Date: Tue, 31 Aug 2010 14:29:32 -0400
Message-ID: <20100831182931.GA21489@sigill.intra.peff.net>
References: <4C7CD65F.10509@atlas-elektronik.com>
 <bc44b3393db4018487bb956d00a12fa73f04ca9e.1283267564.git.git@drmicha.warpmail.net>
 <20100831160145.GC11014@sigill.intra.peff.net>
 <4C7D2AAE.9000701@drmicha.warpmail.net>
 <7vfwxud94w.fsf@alter.siamese.dyndns.org>
 <4C7D495A.1080806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	stefan.naewe@atlas-elektronik.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:29:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVaB-0004De-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab0HaS3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:29:15 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56148 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab0HaS3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:29:14 -0400
Received: (qmail 29713 invoked by uid 111); 31 Aug 2010 18:29:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 18:29:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 14:29:32 -0400
Content-Disposition: inline
In-Reply-To: <4C7D495A.1080806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154959>

On Tue, Aug 31, 2010 at 08:26:34PM +0200, Michael J Gruber wrote:

> Junio C Hamano venit, vidit, dixit 31.08.2010 18:44:
> > Michael J Gruber <git@drmicha.warpmail.net> writes:
> > 
> >>>> +	if (!parent || parse_commit(parent->item) || parse_tree(parent->item->tree) ||
> >>>> +		hashcmp(parent->item->tree->object.sha1, tree_sha1)) {
> >>>
> >>> I didn't check, but I can imagine you can drop the parse_tree here. We
> >>> should know the object sha1 once the commit is parsed.
> >>
> >> parse_commit() does a lookup_tree() but I don't think that it parses the
> >> tree, i.e. I don't hink it fills in tree->object.sha1.
> > 
> > Huh?  parse_tree(tree) calls read_sha1_file(tree->object.sha1) to parse
> > the tree.  How can it do without filling tree->object.sha1?
> > 
> 
> Sure parse_tree() does that. That's why I call it. I never claimed it
> doesn't.

I think the claim is that it is already parsed. Look at parse_tree. The
first non-declaration lines are:

  if (item->object.parsed)
          return 0;
  buffer = read_sha1_file(item->object.sha1, &type, &size);

So _somebody_ has already filled in item->object.sha1.

-Peff
