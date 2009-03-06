From: Jeff King <peff@peff.net>
Subject: Re: orthogonal cases of log --date option
Date: Fri, 6 Mar 2009 07:12:58 -0500
Message-ID: <20090306121258.GC3437@sigill.intra.peff.net>
References: <20090305104304.GA17760@coredump.intra.peff.net> <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com> <20090305211120.GB20157@coredump.intra.peff.net> <7vy6vjy5js.fsf@gitster.siamese.dyndns.org> <20090306052318.GB3426@sigill.intra.peff.net> <7vmybzw3el.fsf@gitster.siamese.dyndns.org> <76718490903052258j277fa8e9g963deae1c3264a22@mail.gmail.com> <7v1vtbw03h.fsf@gitster.siamese.dyndns.org> <76718490903060031u2bbc5c08k6a635dcdb1c8bc32@mail.gmail.com> <7vk573t4cm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfYwk-0001ZV-Qg
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 13:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbZCFMNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbZCFMNF
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 07:13:05 -0500
Received: from peff.net ([208.65.91.99]:44630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbZCFMNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 07:13:04 -0500
Received: (qmail 7913 invoked by uid 107); 6 Mar 2009 12:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 06 Mar 2009 07:13:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Mar 2009 07:12:58 -0500
Content-Disposition: inline
In-Reply-To: <7vk573t4cm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112432>

On Fri, Mar 06, 2009 at 12:58:33AM -0800, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > Yeah, that part is easy. I wasn't sure the best way to handle places
> > where a constant date_mode is used e.g.:
> >
> > pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
> > 		     encoding);
> 
> One approach that will be hated by libgit2 effort would be to keep the
> date_mode an enum as before (sans DATE_LOCAL) and make the "tz_offset"
> thing as a setting global to the process, defined in environ.c

I haven't looked, but might it not be possible to put it in the rev_info
struct next to the date format, but not as part of a struct? You will
then sometimes have to pass two options around (the format and the tz
offset) instead of one (the struct with both), but it makes split usage
much easier:

  pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
               revs->tz_offset, encoding);

-Peff
