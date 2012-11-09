From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: make remote_heads config setting work.
Date: Fri, 9 Nov 2012 11:37:10 -0500
Message-ID: <20121109163710.GD19725@sigill.intra.peff.net>
References: <20121105235047.GA78156@redoubt.spodhuis.org>
 <7vk3tvqthw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Pennock <phil@apcera.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:37:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWraD-00043N-V7
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2KIQhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:37:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40158 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab2KIQhP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:37:15 -0500
Received: (qmail 8270 invoked by uid 107); 9 Nov 2012 16:38:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 11:38:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 11:37:10 -0500
Content-Disposition: inline
In-Reply-To: <7vk3tvqthw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209230>

On Thu, Nov 08, 2012 at 08:40:11PM -0800, Junio C Hamano wrote:

> Looking at the code before this part:
> 
> 	if (my ($hi, $mi, $lo) = ($key =~ /^([^.]*)\.(.*)\.([^.]*)$/)) {
> 		$key = join(".", lc($hi), $mi, lc($lo));
> 	} else {
> 		$key = lc($key);
> 	}
> 	$key =~ s/^gitweb\.//;
> 	return if ($key =~ m/\W/);
> 
> the new code is munding the $hi and $mi parts, while the mistaken
> configuration this patch is trying to correct is about the $lo part,
> and possibly the $hi part, but never the $mi part.

Good catch. I think the "return" in the existing code suffers from the
same problem: it will bail on non-word characters in the $mi part, but
that part should allow arbitrary characters.

-Peff
