From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 16:52:15 -0400
Message-ID: <20130826205215.GB23598@sigill.intra.peff.net>
References: <20130826195331.GA21051@sigill.intra.peff.net>
 <20130826195616.GB21074@sigill.intra.peff.net>
 <521BB6DA.5050807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: phil.hord@gmail.com, Phil Hord <hordp@cisco.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:52:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3m1-0006qo-Tn
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab3HZUwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:52:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:39914 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab3HZUwT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:52:19 -0400
Received: (qmail 31193 invoked by uid 102); 26 Aug 2013 20:52:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 15:52:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 16:52:15 -0400
Content-Disposition: inline
In-Reply-To: <521BB6DA.5050807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233026>

On Mon, Aug 26, 2013 at 10:13:14PM +0200, Johannes Sixt wrote:

> Am 26.08.2013 21:56, schrieb Jeff King:
> > Also, prevent the delimiter being added twice, as happens now in these
> > examples:
> > 
> >   git grep -l foo HEAD:
> >   HEAD::some/path/to/foo.txt
> >        ^
> 
> Which one of these two does it print then?
> 
>     HEAD:/some/path/to/foo.txt
>     HEAD:some/path/to/foo.txt

It should (and does) print the latter.

But I do note that our pathspec handling for subdirectories seems buggy.
If you do:

  $ cd Documentation
  $ git grep -l foo | head -1
  RelNotes/1.5.1.5.txt

that's fine; we limit to the current directory. But then if you do:

  $ git grep -l foo HEAD | head -1
  HEAD:RelNotes/1.5.1.5.txt

we still limit to the current directory, but the output does note note
this (it should be "HEAD:./RelNotes/1.5.1.5.txt"). I think this bug is
orthogonal to Phil's patch, though.

-Peff
