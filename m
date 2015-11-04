From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] t5509: add basic tests for hideRefs
Date: Wed, 4 Nov 2015 14:50:42 -0500
Message-ID: <20151104195042.GA16101@sigill.intra.peff.net>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
 <1446537497-13921-5-git-send-email-lfleischer@lfos.de>
 <CAPig+cQWbisskb4aQ48Oo=8_SYKZWwMK8jn_P_zsivY-xuk43g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu453-0007og-T4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965429AbbKDTup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:50:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:52861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965374AbbKDTup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:50:45 -0500
Received: (qmail 13508 invoked by uid 102); 4 Nov 2015 19:50:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 13:50:44 -0600
Received: (qmail 5825 invoked by uid 107); 4 Nov 2015 19:51:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 14:51:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 14:50:42 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQWbisskb4aQ48Oo=8_SYKZWwMK8jn_P_zsivY-xuk43g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280870>

On Wed, Nov 04, 2015 at 02:36:54PM -0500, Eric Sunshine wrote:

> > +test_expect_success 'try to update a hidden ref' '
> > +       test_config -C pushee transfer.hideRefs refs/heads/master &&
> > +       test_must_fail git -C original push pushee-namespaced master
> 
> In above tests, you use -c to set the configuration temporarily for
> the git invocation, but not in this and following tests. Is that
> because the -c isn't visible to sub-commands which git-push invokes?
> (Genuine question; I want to make sure I understand the reasoning.)

Yes, we explicitly clear "-c" variables when we cross repo boundaries.
You can do it like:

  git push --receive-pack='git -c transfer.hideRefs=...  receive-pack'

but that is probably more obfuscated than using test_config.

I was going to complain that "test_config -C" does not actually work,
but somehow I missed 5fafc07 (test-lib-functions: support "test_config
-C <dir> ...", 2015-09-05) going by. Very cool.

-Peff
