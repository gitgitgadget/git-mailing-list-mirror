From: Jeff King <peff@peff.net>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 3 Mar 2009 11:03:24 -0500
Message-ID: <20090303160324.GA32079@coredump.intra.peff.net>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net> <49AD5164.8090507@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=22Peter_Valdemar_M=C3=B8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeX7c-0003q9-77
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbZCCQDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbZCCQDa
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:03:30 -0500
Received: from peff.net ([208.65.91.99]:59500 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbZCCQD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:03:29 -0500
Received: (qmail 17512 invoked by uid 107); 3 Mar 2009 16:03:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 11:03:28 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 11:03:24 -0500
Content-Disposition: inline
In-Reply-To: <49AD5164.8090507@sneakemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112100>

On Tue, Mar 03, 2009 at 04:48:52PM +0100, "Peter Valdemar M=C3=B8rch (L=
ists)" wrote:

> If a commit removes mention of foo one place and just accidentally =20
> happens to add foo somewhere completely unrelated then it wouldn't sh=
ow =20
> up in the output.

Right. But think for a minute about what it means to "move". If I have:

  foo
  bar

and then change it to:

  bar
  foo

Did "foo" move, or did "bar"?

So I'm not sure that what you're asking for is necessarily well-defined=
=2E

> Would be neat with a feature that does what I thought -S did tho...

You can do:

  git log -z -p | perl -0ne 'print if /^[-+].*string/m' | tr '\0' '\n'

which I think is what you want (show any commit that has changed lines
that contain the string). But of course you will lose colorizing and
automatic paging, and it's a lot slower. And note that whether it finds
the example above will depend on how the diff is generated: did "foo"
move or did "bar"? But in practice it will generally find what you are
looking for.

> Thanks, Jeff, for both the answer and the documentation patch.

You're welcome.

-Peff
