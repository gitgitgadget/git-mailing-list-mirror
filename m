From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Document git push -q
Date: Mon, 19 Oct 2009 00:01:19 -0400
Message-ID: <20091019040119.GA7170@coredump.intra.peff.net>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Pipping <webmaster@hartwork.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 06:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzjR1-0005no-Ei
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 06:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbZJSEBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 00:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbZJSEBS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 00:01:18 -0400
Received: from peff.net ([208.65.91.99]:39547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbZJSEBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 00:01:17 -0400
Received: (qmail 14206 invoked by uid 107); 19 Oct 2009 04:04:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 19 Oct 2009 00:04:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Oct 2009 00:01:19 -0400
Content-Disposition: inline
In-Reply-To: <20091018235240.GU6115@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130645>

On Mon, Oct 19, 2009 at 01:52:40AM +0200, Miklos Vajna wrote:

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index ba6a8a2..beb3422 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -138,6 +138,12 @@ useful if you write an alias or script around 'git-push'.
>  --verbose::
>  	Run verbosely.
>  
> +-q::
> +--quiet::
> +	Some transports produce output even without `--verbose` turned
> +	on. This provides a way to tell them to be more quiet (whereas
> +	simply redirecting might lose error messages).
> +

Thanks, though two complaints:

  1. This is not just about "some transports". Some of the quieted code
     is in transport_push, so hopefully it applies to all transports
     once they follow that code path (though we also pass the quiet flag
     on to pack-objects, so that part is about "some transports".

  2. Maybe it would be more helpful to the user to describe what is
     shown and what is not. I think we want to claim to suppress all
     non-error output (since that was the intent of the recent patches).
     If that is not true for some transport, then we need to fix passing
     --quiet to that transport.

...Ah, I see your confusion. You read the log for afdeeb00, but there
were some follow-on patches that impacted others part of push. :)

So maybe this instead:

-- >8 --
Subject: [PATCH] document push's new quiet option


Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-push.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ba6a8a2..37c8895 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -138,6 +138,11 @@ useful if you write an alias or script around 'git-push'.
 --verbose::
 	Run verbosely.
 
+-q::
+--quiet::
+	Suppress all output, including the listing of updated refs,
+	unless an error occurs.
+
 include::urls-remotes.txt[]
 
 OUTPUT
-- 
1.6.5.1.121.g65c47
