From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc git: multivar configuration parameters append to
 existing values
Date: Mon, 16 Jun 2014 15:48:49 -0400
Message-ID: <20140616194849.GA24376@sigill.intra.peff.net>
References: <1402922952-172-1-git-send-email-philipoakley@iee.org>
 <xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Robert Clausecker <fuz@fuz.su>,
	Alex Riesen <raa.lkml@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwcty-0007bU-IQ
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbaFPTtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:49:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:45447 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755719AbaFPTsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 15:48:51 -0400
Received: (qmail 12640 invoked by uid 102); 16 Jun 2014 19:48:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jun 2014 14:48:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2014 15:48:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd2e8r8yz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251808>

On Mon, Jun 16, 2014 at 11:43:32AM -0700, Junio C Hamano wrote:

> I have two doubts, while appreciating the overall direction to
> clarify things very much.
> 
>  * "single overrides, multiple appends" is not a wrong explanation
>    per-se, but sounds like an arbitrary rule that forces people to
>    memorize.  I wonder if it makes it less burdensome for readers if
>    we just said "Git acts as if the given configuration is specified
>    at the very end of the configuration files"---once the reader
>    understands that Git reads all configuration varilables of the
>    same name and the code paths that *use* one of them pick the one
>    defined the last, it is easy to realize that "single overrides"
>    is merely a natural consequence of the appending nature of "-c".

Yeah, I think the problem is really not one of "-c" in particular. If
you did:

  git config --system remote.magic.url some-default

to provide a universal alias for the "magic" remote, you could not
override it via ~/.gitconfig or .git/config, for the same reasons.

I think we need a better discussion of multivar versus "normal"
overridable variables in config.txt, and then "-c" can make a note that
this is a potential issue, and refer readers to the right section.

I also think it would be nice to have a syntax to "reset" multivars to
their initial state (both from config files and from "-c"). Their
inability to be overridden is one of the reasons we have so few of them.

>  * The last sentence added, i.e. "insteadof"-style, will not be
>    understood by any reader other than those who tried to use "-c"
>    on remote.*.url variables and does not belong here.  A better
>    way/place to give that information is needed.

Agreed. I think that could go in the discussion I mentioned above (as
"some variables have other mechanisms to accomplish the same thing,
like..."). But if we learned a mechanism for resetting multivars, such
workarounds would not be needed at all.

-Peff
