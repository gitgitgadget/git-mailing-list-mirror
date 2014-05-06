From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: preserve config file permissions on edits
Date: Tue, 6 May 2014 18:02:36 -0400
Message-ID: <20140506220236.GB30185@sigill.intra.peff.net>
References: <20140505215853.GA23299@dcvr.yhbt.net>
 <20140506001714.GA29049@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 07 00:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhnRr-0003xS-H8
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbaEFWCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:02:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:46262 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751208AbaEFWCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:02:38 -0400
Received: (qmail 15114 invoked by uid 102); 6 May 2014 22:02:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 May 2014 17:02:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2014 18:02:36 -0400
Content-Disposition: inline
In-Reply-To: <20140506001714.GA29049@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248257>

On Tue, May 06, 2014 at 12:17:14AM +0000, Eric Wong wrote:

> Users may already store sensitive data such as imap.pass in
> .git/config; making the file world-readable when "git config"
> is called to edit means their password would be compromised
> on a shared system.

Makes sense, and the patch looks good to me.

> +test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
> +	chmod 0600 .git/config &&
> +	git config imap.pass Hunter2 &&
> +	perl -e \
> +	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) != 0600" &&

I don't think we usually bother with a PERL prereq for running
one-liners like this from the test script, though I don't think it hurts
anything to do so.

-Peff
