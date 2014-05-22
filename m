From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] remote-curl: recognize text/plain with a charset
 parameter
Date: Thu, 22 May 2014 02:05:16 -0400
Message-ID: <20140522060516.GB16587@sigill.intra.peff.net>
References: <20140521102524.GA30301@sigill.intra.peff.net>
 <20140521103301.GG30464@sigill.intra.peff.net>
 <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 08:05:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnM83-0004Sx-TE
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 08:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaEVGFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 02:05:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:57110 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbaEVGFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 02:05:18 -0400
Received: (qmail 1102 invoked by uid 102); 22 May 2014 06:05:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 01:05:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 02:05:16 -0400
Content-Disposition: inline
In-Reply-To: <90CE006F-EE74-40D2-8847-507E37021D84@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249875>

On Wed, May 21, 2014 at 05:07:38PM -0700, Kyle J. McKay wrote:

> >+	p = skip_prefix(type->buf, "text/plain");
> >+	if (!p || (*p && *p != ';'))
> >+		return 0;
> >+
> >+	return 1;
> >+}
> >+
> 
> I think that a strict reading of RFC 2616 allows "text/plain ;
> charset=utf-8" as well as "text/plain;charset=utf-8" and "text/plain;
> charset=utf-8".  So perhaps this if line instead:
> 
> +	if (!p || (*p && *p != ';' && *p != ' ' && *p != '\t'))
> 
> See RFC 2616 section 2.2 for the definition of linear white space (LWS) and
> the end of section 2.1 for the "implied *LWS" rule that allows it.

You're right. There are a few exceptions in 3.7:

  Linear white space (LWS) MUST NOT be used between the type and
  subtype, nor between an attribute and its value.

but it does not include between the subtype and parameter. So the
"find_parameter" also needs to accept the collapsed whitespace, too, I
guess.

-Peff
