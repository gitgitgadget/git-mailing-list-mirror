From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] test-lib: quote TRASH_DIRECTORY
Date: Fri, 4 Mar 2016 06:51:28 -0500
Message-ID: <20160304115127.GA8355@sigill.intra.peff.net>
References: <cover.1457088499.git.git@drmicha.warpmail.net>
 <a07529d116612bcd1c411a697f8f8e37d7c18d3f.1457088499.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:51:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aboGf-00061l-UG
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 12:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbcCDLvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 06:51:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:54674 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbcCDLvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 06:51:31 -0500
Received: (qmail 30799 invoked by uid 102); 4 Mar 2016 11:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:51:30 -0500
Received: (qmail 14557 invoked by uid 107); 4 Mar 2016 11:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Mar 2016 06:51:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Mar 2016 06:51:28 -0500
Content-Disposition: inline
In-Reply-To: <a07529d116612bcd1c411a697f8f8e37d7c18d3f.1457088499.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288248>

On Fri, Mar 04, 2016 at 11:53:49AM +0100, Michael J Gruber wrote:

> We always quote $TRASH_DIRECTORY to guard against funky path names. Do
> so in one more spot
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0b47eb6..8957916 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -868,7 +868,7 @@ case "$TRASH_DIRECTORY" in
>  /*) ;; # absolute path is good
>   *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
>  esac
> -test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
> +test ! -z "$debug" || remove_trash="$TRASH_DIRECTORY"

I don't think this does anything. The shell doesn't do whitespace
splitting on the right-hand side of a variable assignment:

  $ foo='lots of spaces and "!'\'' funky chars'
  $ bar=$foo
  $ echo "$bar"
  lots of spaces and "!' funky chars

Of course we _do_ need quotes when we refer to $remove_trash as an
argument (as with "$bar" above), but it looks like we do so correctly
everywhere.

-Peff
