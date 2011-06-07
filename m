From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Tue, 7 Jun 2011 13:10:52 -0400
Message-ID: <20110607171052.GA21674@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org>
 <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
 <20110606161143.GC11485@sigill.intra.peff.net>
 <BANLkTikLZSrsy0D0Gs-tNKgbqJOG7qJNsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:11:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTznz-0004i0-CH
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab1FGRK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:10:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44655
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180Ab1FGRK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:10:56 -0400
Received: (qmail 16676 invoked by uid 107); 7 Jun 2011 17:11:02 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:11:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:10:52 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikLZSrsy0D0Gs-tNKgbqJOG7qJNsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175216>

On Mon, Jun 06, 2011 at 09:05:11PM +0200, Sverre Rabbelier wrote:

> On Mon, Jun 6, 2011 at 18:11, Jeff King <peff@peff.net> wrote:
> > I'll try the nicer fix Sverre mentioned and post a real patch. I wanted
> > to add a test for multiple refs to the test suite, but I got bogged down
> > by other breakages. Some of which I think are the fault of testgit, but
> > one of which I think may be a problem in the transport-helper code.
> 
> I'm not 100% the current remote-helper code allows that, since there
> might be some interaction where the transport-helper code needs to
> read from the helper before closing the connection. I don't think
> that's the case, but I'm not sure of it either.

No, I think it is how the import command was expected to run. The order
of the code in transport-helper.c is:

  1. Redirect the incoming pipe to fast-import.

  2. Print one or more "import $ref" lines.

  3. Print "\n", then close the outgoing pipe.

  4. Wait for fast-import to report completion.

So there really is no room for further communication.

-Peff
