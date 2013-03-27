From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] log: Read gpg settings for signed commit verification
Date: Wed, 27 Mar 2013 12:22:32 -0400
Message-ID: <20130327162232.GB22386@sigill.intra.peff.net>
References: <8C726954D36902459248B0627BF2E66F45D70C3E4E@AUSP01VMBX10.collaborationhost.net>
 <7vip4com2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hans Brigman <hbrigman@openspan.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Sarvis <jsarvis@openspan.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKt7y-0002D1-A0
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413Ab3C0QWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:22:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41621 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023Ab3C0QWi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:22:38 -0400
Received: (qmail 15082 invoked by uid 107); 27 Mar 2013 16:24:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Mar 2013 12:24:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Mar 2013 12:22:32 -0400
Content-Disposition: inline
In-Reply-To: <7vip4com2p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219269>

On Wed, Mar 27, 2013 at 09:15:58AM -0700, Junio C Hamano wrote:

> >  	}
> > -
> > +	if (git_gpg_config(var, value, cb) < 0)
> > +		return -1;
> >  	if (grep_config(var, value, cb) < 0)
> >  		return -1;
> 
> Hmph.  I do not particularly like the way the call to grep_config()
> loses information by not ignoring its return value and always
> returning -1, but I'll let it pass for this patch.

That's my fault for suggesting he follow the same style as grep here.
But I wonder if it is worth the effort. We have never cared about
anything beyond "was there an error" in our config callbacks, and the
value returned from the callbacks is lost in git_parse_file (i.e., we do
not propagate the actual return value, but only check that
"callback(var, value, data) < 0", and die if so).

Existing callbacks pass data out by writing into a struct pointed to by
the data pointer, which is more flexible, anyway.

So unless you want to overhaul the whole config system to propagate
return codes back to the caller, I do not think there is any point in
worrying about it.

-Peff
