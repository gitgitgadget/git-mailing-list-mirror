From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: kill $prompting variable
Date: Mon, 19 Aug 2013 17:25:59 -0400
Message-ID: <20130819212559.GB29258@sigill.intra.peff.net>
References: <1376674444-29599-1-git-send-email-rv@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWxk-0005Fj-K1
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab3HSV0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:26:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:59306 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3HSV0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:26:03 -0400
Received: (qmail 6232 invoked by uid 102); 19 Aug 2013 21:26:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Aug 2013 16:26:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Aug 2013 17:25:59 -0400
Content-Disposition: inline
In-Reply-To: <1376674444-29599-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232570>

On Fri, Aug 16, 2013 at 05:34:04PM +0000, Rasmus Villemoes wrote:

> The variable $prompting is weird. It is only read in one place (when
> deciding whether to prompt for a Message-ID to use in In-Reply-To),
> and it will be false unless we've taken the completely unrelated
> branch filling in @initial_to.
> 
> Prompting should be done if the info is needed, not if some unrelated
> item had to be prompted for. So kill $prompting.

The prompting flag dates back to 1f038a0 from late 2005. I _think_ the
intent was that you could use certain command lines to specify the
required information (like initial compose subject line, sender, etc),
and then send-email would skip prompting for the optional information
(like in-reply-to). That makes it easier to use in a "batch" mode in
which the user does not want to be prompted (they do not have to give a
blank "--in-reply-to" to prevent the prompt).

Over the years, the set of items which triggered prompting (and which
depended on previous prompts) has grown and shrunk, and most prompts do
not respect the $prompting system at all. So I kind of doubt that
anybody will care if it goes away; it does not make much sense at this
point.

However, your patch will make the default be to ask about the initial
message-id. Which is likely going to annoy people, as it is not
necessary (and people who care can specify it on the command line).
Would we want to get rid of it entirely?

-Peff
