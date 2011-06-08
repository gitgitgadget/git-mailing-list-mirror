From: Jeff King <peff@peff.net>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 11:45:13 -0400
Message-ID: <20110608154513.GB8759@sigill.intra.peff.net>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net>
 <vpqhb8049m3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>,
	thomas@xteddy.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:45:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKwc-0001ur-JN
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576Ab1FHPpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:45:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50315
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab1FHPpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:45:16 -0400
Received: (qmail 31550 invoked by uid 107); 8 Jun 2011 15:45:23 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Jun 2011 11:45:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2011 11:45:13 -0400
Content-Disposition: inline
In-Reply-To: <vpqhb8049m3.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175387>

On Wed, Jun 08, 2011 at 05:37:56PM +0200, Matthieu Moy wrote:

> The actual code is:
> 
>     my $file_content = `git cat-file -p $sha1`;
>     chomp($file_content);
>     // ...
>     $mw->edit( {
>     	action => 'edit',
>     	summary => $_[1],
>     	title => $title,
>     	text => $file_content,
>     });
> 
> If the file is UTF-8 encoded, the page sent to the wiki is
> double-utf8-encoded.

I think there might be a way to say "all descriptors are utf8"; I don't
know if that would apply to pipes from backtick commands or not. I'm
also not sure if it would interfere with something like Mediawiki::API
talking over the socket.

> That's not exactly it, since we read the output of "git cat-file", not
> an actual file.
> 
> But something along the lines of:
> 
> open(my $git, "-|:encoding(UTF-8)", "git cat-file -p $sha1");
> my $file_content = <$git>;
> close($git);
> 
> may do it.

Yeah, I think that's the cleanest solution (assuming it works. :) ).

-Peff
