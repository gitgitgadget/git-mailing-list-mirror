From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Wed, 10 Jul 2013 06:57:30 -0400
Message-ID: <20130710105729.GB9724@sigill.intra.peff.net>
References: <20130707100133.GA18717@sigill.intra.peff.net>
 <20130707101438.GD19143@sigill.intra.peff.net>
 <CA+sFfMfQcnx+OGNd+v7NJC5zSXg2OR1QiLyRSqDjXD0zb4mvtA@mail.gmail.com>
 <CA+sFfMfHYkLc1rAnMKWGiGtH9kOC11D9CqpAsFXpeE_VBY0otA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 12:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uws5a-00072e-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 12:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab3GJK5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 06:57:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:47442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754295Ab3GJK5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 06:57:34 -0400
Received: (qmail 22977 invoked by uid 102); 10 Jul 2013 10:58:50 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 05:58:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 06:57:30 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMfHYkLc1rAnMKWGiGtH9kOC11D9CqpAsFXpeE_VBY0otA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230036>

On Mon, Jul 08, 2013 at 02:35:10PM -0700, Brandon Casey wrote:

> > If 'n' is the number of objects in the pack, shouldn't it be unsigned?
> >
> > The data type for struct packed_git.num_objects is uint32_t.  Looks
> > like create_pack_revindex uses the wrong datatype when it captures
> > num_objects in the int num_ent and passes it to sort_revindex.  So, it
> > looks like that function needs to be updated too.
> 
> Hmm.  It seems more than just create_pack_revindex holds num_objects
> in a signed int.  Don't we support 4G objects in packs?
> 
> find_pack_revindex uses a signed int for the index variables in its
> binary search which means it will fail when num_objects >= 2^31.

Yes, I didn't make a test case, but I suspect it is just completely
broken at that scale. But nobody hits it because having 2^31 objects is
somewhat insane (we are still only in the 2^22 range for the kernel, and
most large repos I've seen have large objects, but not necessarily more
of them). So if development keeps up, the kernel should hit the bug in
another few thousand years. :)

-Peff
