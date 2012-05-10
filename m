From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Change error messages in ident.c...
Date: Thu, 10 May 2012 15:23:39 -0400
Message-ID: <20120510192339.GA32357@sigill.intra.peff.net>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 21:23:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYxn-0002my-EN
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761545Ab2EJTXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:23:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39070
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755627Ab2EJTXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:23:41 -0400
Received: (qmail 1917 invoked by uid 107); 10 May 2012 19:24:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 15:24:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 15:23:39 -0400
Content-Disposition: inline
In-Reply-To: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197620>

On Thu, May 10, 2012 at 08:06:09PM +0100, Angus Hammond wrote:

> Subject: Re: [PATCH 1/2] Change error messages in ident.c Make error messages
>  caused by failed reads of the /etc/passwd file easier to understand.
>  Signed-off-by: Angus Hammond <angusgh@gmail.com>

Holy line-breaks, Batman!

As amusing as I find the existing messages, this is probably a good
direction (although I find it unlikely that most people would see the
messages under normal use).

I am also tempted to suggest that we simply replace the static buffers
with dynamic strbufs. I guess that may open up new vectors for an
attacker to convince git to allocate arbitrary amounts of memory, but
that is already pretty easy to do, so I doubt it's a big deal.

> @@ -46,7 +46,7 @@ static void copy_gecos(const struct passwd *w, char *name, size_t sz)
>  	if (len < sz)
>  		name[len] = 0;
>  	else
> -		die("Your parents must have hated you!");
> +		die("Your GECOS field is too long.");

I know that "GECOS" is the standard name for the field, but I wonder if
it is a bit unnecessarily jargon-y. Wouldn't something like:

  die("unable to get real name from system password file: name too long");

be a little more friendly? It tells what operation we were actually
performing, and it doesn't use any jargon.

> @@ -106,7 +106,7 @@ static void copy_email(const struct passwd *pw)
>  	 */
>  	size_t len = strlen(pw->pw_name);
>  	if (len > sizeof(git_default_email)/2)
> -		die("Your sysadmin must hate you!");
> +		die("Your name field in is too long.");

s/in is/is/. Also, similar complaints to above (if you see this message
unexpectedly, you might ask "which name field? One inside a commit
object?").

> [...]

And similar comments for the rest of the messages.

-Peff
