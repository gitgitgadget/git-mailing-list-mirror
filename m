From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] cat-file: do not die on --textconv without textconv
 filters
Date: Sat, 20 Apr 2013 00:17:37 -0400
Message-ID: <20130420041737.GC24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:17:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTPFM-0002Nt-CR
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334Ab3DTERl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:17:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:44583 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab3DTERk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:17:40 -0400
Received: (qmail 7598 invoked by uid 102); 20 Apr 2013 04:17:45 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:17:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:17:37 -0400
Content-Disposition: inline
In-Reply-To: <06f2d51bf0479f3231b707d88d8d04fcd306c973.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221834>

On Fri, Apr 19, 2013 at 06:44:46PM +0200, Michael J Gruber wrote:

> -			die("git cat-file --textconv: unable to run textconv on %s",
> -			    obj_name);
> -		break;
> +		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
> +			break;
> +
> +		/* otherwise expect a blob */
> +		exp_type = "blob";
>  
>  	case 0:
>  		if (type_from_string(exp_type) == OBJ_BLOB) {

I'm not sure this is right. What happens with:

  git cat-file --textconv HEAD:Documentation

We have failed to textconv, but should we be expecting a blob?

-Peff
