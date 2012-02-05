From: Jeff King <peff@peff.net>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 5 Feb 2012 18:47:50 -0500
Message-ID: <20120205234750.GA28735@sigill.intra.peff.net>
References: <20120202084859.GC3823@burratino>
 <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
 <7vipjlezas.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 00:48:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuBoU-00077D-IV
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 00:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab2BEXrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 18:47:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58438
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab2BEXrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 18:47:53 -0500
Received: (qmail 20699 invoked by uid 107); 5 Feb 2012 23:54:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 05 Feb 2012 18:54:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Feb 2012 18:47:50 -0500
Content-Disposition: inline
In-Reply-To: <7vipjlezas.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189986>

On Sun, Feb 05, 2012 at 01:38:19PM -0800, Junio C Hamano wrote:

> > The map_user() API takes an email address that is terminated by either NUL
> > or '>' to allow the caller to learn the corresponding up-to-date email
> > address that is NUL terminated, while indicating with its return value
> > that if the caller even needs to replace what it already has.  But the
> > function does not properly terminate email when it only touched the name
> > part. And I think that is the real bug.
> 
> And the gist of the patch to fix the bug would look like this two liner.
> In the real fix, "p" should be renamed to "end_of_email" or something
> descriptive like that.

Exactly; this is much better.

We could also go as far as saying that map_user would _always_ terminate
in this way (i.e., the caller gets a munged result, whether we found
anything or not). Then internally, map_user could be simplified to stop
worrying about making a temporary copy in mailbuf. And callers could
simply call map_user without worrying about branching on whether it
found anything or not.

But maybe it is not worth that level of refactoring. From my reading,
your patch fixes the problem just fine.

-Peff
