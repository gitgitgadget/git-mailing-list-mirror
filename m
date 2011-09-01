From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote: "rename o foo" should not rename ref
 "origin/bar"
Date: Wed, 31 Aug 2011 22:46:17 -0400
Message-ID: <20110901024617.GD31838@sigill.intra.peff.net>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1314841843-19868-2-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 04:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyxIO-00078X-EZ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 04:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757494Ab1IACqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 22:46:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59380
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757479Ab1IACqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 22:46:19 -0400
Received: (qmail 9742 invoked by uid 107); 1 Sep 2011 02:47:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Aug 2011 22:47:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Aug 2011 22:46:17 -0400
Content-Disposition: inline
In-Reply-To: <1314841843-19868-2-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180518>

On Wed, Aug 31, 2011 at 09:50:43PM -0400, Martin von Zweigbergk wrote:

> When renaming a remote called 'o' using 'git remote rename o foo', git
> should also rename any remote-tracking branches for the remote. This
> does happen, but any remote-tracking branches starting with
> 'refs/remotes/o', such as 'refs/remotes/origin/bar', will also be
> renamed (to 'refs/remotes/foorigin/bar' in this case).

To be totally correct, shouldn't this check each ref against the RHS of
the remote's old refspec, and rename it according to the remote's new
refspec?

Maybe that is just being pedantic, though. This should work fine with
the default config[1].

-Peff

[1] Since this part of the renaming process obviously depends heavily on
    refs/remotes/$OLD being the naming convention, shouldn't the
    renaming of the refspecs do the same thing? I.e., it's another
    reason that your patch 1/2 should only tweak refs/remotes/$OLD.
    Otherwise you will get renamed refspecs, but the actual refs won't
    be moved.
