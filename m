From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 6 Mar 2014 14:07:57 -0500
Message-ID: <20140306190757.GA27583@sigill.intra.peff.net>
References: <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
 <20140305005649.GB11509@sigill.intra.peff.net>
 <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
 <20140305185212.GA23907@sigill.intra.peff.net>
 <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
 <53183506.5080002@alum.mit.edu>
 <20140306155626.GB18519@sigill.intra.peff.net>
 <5318A537.4010400@alum.mit.edu>
 <20140306174803.GA30486@sigill.intra.peff.net>
 <xmqqbnxjywxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:08:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdeG-0002tk-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbaCFTH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:07:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:34256 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751548AbaCFTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:07:59 -0500
Received: (qmail 24995 invoked by uid 102); 6 Mar 2014 19:07:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 13:07:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 14:07:57 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnxjywxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243533>

On Thu, Mar 06, 2014 at 11:00:08AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also noticed that the diff engine does not play well with replacements
> > of blobs. When we are diffing the trees, we see that the sha1 for path
> > "foo" is the same on either side, and do not look further, even though
> > feeding those sha1s to builtin_diff would fetch the replacements.
> 
> Sorry, I do not quite understand.
> 
> In "git diff A B -- path", if the object name recorded for A:path
> and B:path are the same, but the replacement mechanism maps the
> object name for that blob object to some other blob object, wouldn't
> the result be empty because both sides replace to the same thing
> anyway?

Oh, right, I was being stupid. I did:

  git replace --edit HEAD:some-file

and expected "git show" to find the diff. But that doesn't make sense.
On top of that, I need to do:

  git replace --edit HEAD^{tree}

to replace the sha1 of the entry in the tree. In which case diff would
find it just fine.

-Peff
