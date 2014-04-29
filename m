From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 0/4] replace: add option to edit a Git object
Date: Mon, 28 Apr 2014 22:36:29 -0400
Message-ID: <20140429023629.GB11730@sigill.intra.peff.net>
References: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 04:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WexuO-00010Z-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 04:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbaD2Cgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 22:36:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:40899 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbaD2Cgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 22:36:31 -0400
Received: (qmail 5817 invoked by uid 102); 29 Apr 2014 02:36:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 21:36:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 22:36:29 -0400
Content-Disposition: inline
In-Reply-To: <20140426194404.21546.82305.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247510>

On Sat, Apr 26, 2014 at 10:00:53PM +0200, Christian Couder wrote:

> This patch series comes from what Peff sent in the following thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/243361/focus=243528

Thanks. As I recall, these were in pretty good shape, and I just read
over them again and didn't see anything wrong.

> I added the following fixes:
> 
> - add "strbuf_release(&result);" in import_object(); this was suggested
>   by Eric Sunshine
> - use MODE_LIST instead of MODE_DELETE if no arguments are passed; this
>   makes the test suite pass
> - add "--no-replace-objects" when calling "git cat-file" in export_object();
>   so that we edit the original object if an object is already replaced

All sensible, I think.

> I am not happy with the fact that if the user doesn't modify the object when
> editing it, then a replace ref can still be created that points to the
> original object. I think something should be done to avoid that.

Yeah, it should be easy to just hashcmp the sha1s after calling
import_object. In fact, I think we can just erase any existing replace
ref in that case (the user might have started with a replace ref and
converted it _back_ to the original object, for example).

> Once that is fixed, I plan to add some tests and documentation, but I wanted
> first to let you know that I am looking at this.

Great. Thanks for working on this.

-Peff
