From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Wed, 24 Oct 2012 04:46:36 -0400
Message-ID: <20121024084636.GA23500@sigill.intra.peff.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 10:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQwc9-0007Xk-7K
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 10:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933731Ab2JXIqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 04:46:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53815 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933463Ab2JXIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 04:46:44 -0400
Received: (qmail 27987 invoked by uid 107); 24 Oct 2012 08:47:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Oct 2012 04:47:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Oct 2012 04:46:36 -0400
Content-Disposition: inline
In-Reply-To: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208300>

On Wed, Oct 24, 2012 at 10:03:35AM +0200, Krzysztof Mazur wrote:

> The git-send-email always use RFC2047 subject quoting for files
> with "broken" encoding - non-ASCII files without Content-Transfer-Encoding,
> even for ASCII subjects. Now for ASCII subjects the RFC2047 quoting will be
> skipped.
> [...]
> -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
> +	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> +			($subject =~ /[^[:ascii:]]/)) {

Is that test sufficient? We would also need to encode if it has rfc2047
specials, no?

It looks like we use the same regex elsewhere. Maybe this would be a
good chance to abstract out a needs_rfc2047_quoting while we are in the
area?

Other than that, I did not see anything wrong with the patch.

-Peff
