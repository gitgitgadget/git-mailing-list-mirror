From: Jeff King <peff@peff.net>
Subject: Re: Clear an invalid password out of the credential-cache?
Date: Mon, 14 Apr 2014 18:15:30 -0400
Message-ID: <20140414221530.GA29704@sigill.intra.peff.net>
References: <2D1883E9414E4E1E99559A6A2163BE87@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'Git List' <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Tue Apr 15 00:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZpAC-0005Rm-G9
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 00:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbaDNWPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 18:15:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59869 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755687AbaDNWPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 18:15:33 -0400
Received: (qmail 30760 invoked by uid 102); 14 Apr 2014 22:15:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Apr 2014 17:15:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Apr 2014 18:15:30 -0400
Content-Disposition: inline
In-Reply-To: <2D1883E9414E4E1E99559A6A2163BE87@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246270>

On Sat, Apr 12, 2014 at 09:12:57AM -0400, Jason Pyeron wrote:

> Is it me or is the only way to clear a single invalid password out of the
> credential-cache is by "git credential-cache exit"?

Try the "reject" action:

  $ : remember a credential
  $ url() { echo url=https://example.com; }
  $ (url; echo username=me; echo password=foo) | git credential-cache store

  $ : get it again
  $ url | git credential-cache get
  username=me
  password=foo

  $ : forget it
  $ url | git credential-cache erase

  $ : now produces nothing
  $ url | git credential-cache get

Git should do this for you automatically if it tries to use the password
and gets rejected (but only if the rejection is a password rejection,
like an HTTP 401).

-Peff
