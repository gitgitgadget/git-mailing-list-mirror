From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Faster git grep.
Date: Thu, 25 Jul 2013 16:08:57 -0400
Message-ID: <20130725200857.GB1225@sigill.intra.peff.net>
References: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Jul 25 22:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Rqg-0004To-GI
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 22:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758050Ab3GYUJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 16:09:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:51023 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757983Ab3GYUI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 16:08:59 -0400
Received: (qmail 4261 invoked by uid 102); 25 Jul 2013 20:08:59 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Jul 2013 15:08:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jul 2013 16:08:57 -0400
Content-Disposition: inline
In-Reply-To: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231148>

On Thu, Jul 25, 2013 at 08:29:05PM +0200, Ond=C5=99ej B=C3=ADlka wrote:

> One solution would be to use same trick as was done in google code.
> Build and keep database of trigraphs and which files contain how many=
 of
> them. When querry is made then check
> only these files that have appropriate combination of trigraphs.

That seems like a sensible approach.

> Updating database would be relatively inexpensive compared to disk
> access we need to do anyway.

Yes, I think it can be quite cheap, since you would only need to
re-index files that have changed (and git is very quick at telling you
what those files are).

> A space usage might be problem so which is why I decided go option
> route.
>=20
> Comments, pointers?

I think it is a good idea, but not need to be part of core git. It seem=
s
more like you would want to glue together an existing code-indexing
solution (like codesearch) with git (which would provide the list of
files to index and to search).

If that proves useful in practice, but the interface is clunky for
whatever reason, then a good follow-on project could be to build suppor=
t
for updating and using the index via the usual "git grep".

-Peff
