From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP] Pluggable reference backends
Date: Mon, 10 Mar 2014 13:56:58 -0400
Message-ID: <20140310175658.GA23255@sigill.intra.peff.net>
References: <531D9B50.5030404@alum.mit.edu>
 <CAJo=hJtiPgByhk9M4ZKD98DARzgeU6z2mmw7fcLTEbBza-_h6A@mail.gmail.com>
 <20140310155230.GA29801@sigill.intra.peff.net>
 <xmqqwqg2q752.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>,
	Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 18:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN4Rs-0008UP-2H
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 18:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753257AbaCJR5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 13:57:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36611 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753092AbaCJR5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 13:57:01 -0400
Received: (qmail 11227 invoked by uid 102); 10 Mar 2014 17:57:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Mar 2014 12:57:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Mar 2014 13:56:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqg2q752.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243781>

On Mon, Mar 10, 2014 at 10:46:01AM -0700, Junio C Hamano wrote:

> >> No to SQLLite in git-core. Using it from JGit requires building
> >> SQLLite and a JNI wrapper, which makes JGit significantly less
> >> portable. I know SQLLite is pretty amazing, but implementing
> >> compatibility with it from JGit will be a big nightmare for us.
> >
> > That seems like a poor reason not to implement a pluggable feature for
> > git-core. If we implement it, then a site using only git-core can take
> > advantage of it. Sites with JGit cannot, and would use a different
> > pluggable storage mechanism that's supported by both. But if we don't
> > implement, it hurts people using only git-core, and it does not help
> > sites using JGit at all.
> 
> We would need to eventually have at least one backend that we know
> will play well with different Git implementations that matter
> (namely, git-core, Jgit and libgit2) before the feature can be
> widely adopted.

I assumed that the current refs/ and logs/ code, massaged into pluggable
backend form, would be the first such. And I wouldn't be surprised to
see some iteration on that once it is easier to move from scheme to
scheme (e.g., to use some encoding of the names on the filesystem to
avoid D/F conflicts, and thus allow reflogs for deleted refs).

> The first backend that is used while the plugging-interface is in
> development can be anything and does not have to be one that
> eventual ubiquitous one, however; as long as it is something that we
> do not mind carrying it forever, along with that final reference
> backend.  I take the objection from Shawn only as against making the
> sqlite that final one.

Sure, I'd agree with that. I'd think something like an sqlite interface
would be mainly of interest to people running busy servers. I don't know
that it would make a good default.

-Peff
