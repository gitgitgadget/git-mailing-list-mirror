From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 05/10] replace: make sure --edit results in a
 different object
Date: Sat, 17 May 2014 03:03:40 -0400
Message-ID: <20140517070339.GC13003@sigill.intra.peff.net>
References: <20140517062418.18932.21200.chriscool@tuxfamily.org>
 <20140517064133.18932.27058.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 17 09:03:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlYes-0004K6-Pf
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 09:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbaEQHDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 03:03:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:53672 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755848AbaEQHDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 03:03:41 -0400
Received: (qmail 10840 invoked by uid 102); 17 May 2014 07:03:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 May 2014 02:03:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 May 2014 03:03:40 -0400
Content-Disposition: inline
In-Reply-To: <20140517064133.18932.27058.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249453>

On Sat, May 17, 2014 at 08:41:27AM +0200, Christian Couder wrote:

> It's a bad idea to create a replace ref for an object
> that points to the original object itself.
> 
> That's why we have to check if the result from editing
> the original object is a different object and error out
> if it isn't.

I think that's reasonable.

Another option, which I think I mentioned earlier, would be to delete
any existing replacement ref, and return success. So you could use that
to "revert" a replaced object back to its original non-replaced form.

On a similar note, we might want to consider what happens when you
"--edit" an object which already has a replacement. Right now you end up
editing the _original_ object. I wonder if it would make sense to start
the editor with the contents of the replacement object (in which case
you might even "revert" without realizing it).

But those can easily come later if somebody feels like working on them.
Erroring out is not that bad an outcome, since the user can then "git
replace -d" themselves if they want to.

-Peff
