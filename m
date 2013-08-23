From: Jeff King <peff@peff.net>
Subject: Re: t3010 broken by 2eac2a4
Date: Fri, 23 Aug 2013 14:51:58 -0400
Message-ID: <20130823185158.GC30130@sigill.intra.peff.net>
References: <CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
 <xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
 <CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
 <CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
 <xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
 <CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
 <CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
 <7vsiy1j7dd.fsf@alter.siamese.dyndns.org>
 <CAPig+cRumXHk-30yvS8Q2xvOxA0qEEXaD7=iJo_X26HL-YRRJg@mail.gmail.com>
 <xmqqk3jcpbuc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCwT2-0005gQ-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633Ab3HWSwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:52:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:39437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab3HWSwB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:52:01 -0400
Received: (qmail 14537 invoked by uid 102); 23 Aug 2013 18:52:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 13:52:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 14:51:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3jcpbuc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232822>

On Fri, Aug 23, 2013 at 10:15:55AM -0700, Junio C Hamano wrote:

> When 5102c617 (Add case insensitivity support for directories when
> using git status, 2010-10-03) added the directories to the name-hash
> with trailing slash, there was only a single name hash table to
> which both real cache entries and leading directory prefixes are
> registered, so it made some sense to register them with trailing
> slashes so that we can tell what kind of entry is being returned.
> 
> But since 2092678c (name-hash.c: fix endless loop with
> core.ignorecase=true, 2013-02-28), these directory entries that are
> not the cache entries are kept track of in a separate hashtable,
> which makes me wonder if it still makes sense to register
> directories with trailing slashes.
> 
> And if we stop doing that (and instead if we shrunk the namelen when
> an unconverted caller asks for a name with a trailing slash to see
> if a directory exists in the index), wouldn't it automatically fix
> the directory_exists_in_index_icase()?  It does not need to assume
> that dirname[len] has '/'; after all, it may not even be a valid
> memory location in the first place.

Yeah, I think that is sane overall direction. When I did the sketch that
eventually turned into Karsten's 2092678c, that was one of the goals.
But I did not keep up with his response and the final patch, and I'm not
sure if the slashes still serve some function. So it would definitely
need somebody looking carefully at the current logic.

More details are in this sub-thread:

  http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=216284

-Peff
