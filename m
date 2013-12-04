From: Jeff King <peff@peff.net>
Subject: Re: Use mongoose to test smart-http unconditionally?
Date: Wed, 4 Dec 2013 13:48:42 -0500
Message-ID: <20131204184842.GA11024@sigill.intra.peff.net>
References: <CACsJy8BHnTHRugJoTDGs7h=dF1qQUWyPXYxCU8YsDU57s+5gyg@mail.gmail.com>
 <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 04 19:48:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoHVB-0007qf-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021Ab3LDSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 13:48:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:50403 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932867Ab3LDSso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 13:48:44 -0500
Received: (qmail 20554 invoked by uid 102); 4 Dec 2013 18:48:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 12:48:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 13:48:42 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJuzP=zYsEZvC5ugKaAWPLAcTzmFJxT5PNFKbBEv0ctnDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238800>

On Wed, Dec 04, 2013 at 10:13:11AM -0800, Shawn Pearce wrote:

> On Wed, Dec 4, 2013 at 2:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > I was thinking of an alternative to apache for testing smart-http so
> > that most of http tests could always run. Mongoose [1] looks like a
> > good candidate to bundle with git. Just one pair of source files,
> > mongoose.[ch], a mainloop wrapper and we have an http server. Just
> > wondering, do we rely on any apache-specific features? I'm not so
> > familiar with lib-httpd.sh..
> 
> I don't think we do anything Apache specific in the test suite. It
> basically relies on CGI execution, being able to configure a URL to
> serve a directory, and making some URLs 404 or 500 so we can emulate a
> broken or failing server to test the client behavior in those
> conditions. At worst that 404/500 forced failure mode could be handled
> by a CGI.

I don't think there's anything apache specific, but there's a fair bit
of config for handling various auth scenarios. It's stuff I'd expect any
decent server implementation to handle, but somebody actually needs to
go through and translate all of the config to mongoose.

I've been tempted to add lighttpd support, as I generally find its
config much more readable (and less prone to breaking during upgrades).
But I think it would be a mistake to support multiple servers, as it
would mean updates to the tests need to hit all of the servers. If
mongoose gives a sane lowest common denominator, that's fine with me.

I don't know if it is worth all that much effort, though. I suppose it
could get us more exposure to the httpd tests, but I do not know if it
would be a good idea to turn them on by default anyway. They touch
global machine resources (like ports) that can cause conflicts or test
failures. I assume that is the reason we do not turn on git-daemon tests
by default (though perhaps it would be better in both cases to have it
on by default and let people with special needs, like running multiple
test instances at once, turn it off).

-Peff
