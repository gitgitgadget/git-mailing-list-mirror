From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 1/3] sh-setup: export GIT_DIR
Date: Wed, 23 Apr 2014 16:01:50 -0400
Message-ID: <20140423200150.GA31356@sigill.intra.peff.net>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
 <1398282160-26151-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:02:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3Mm-0006C1-VF
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbaDWUBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:01:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36999 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182AbaDWUBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:01:53 -0400
Received: (qmail 27973 invoked by uid 102); 23 Apr 2014 20:01:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 15:01:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 16:01:50 -0400
Content-Disposition: inline
In-Reply-To: <1398282160-26151-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246881>

On Wed, Apr 23, 2014 at 02:42:38PM -0500, Felipe Contreras wrote:

> It is what the clients of this library expect.

Is it? Passing GIT_DIR to sub-invocations of git will change how they
determine the repo and working tree. Your patch seems to cause failures
all over the test suite.

Without looking too hard, I'd guess the problems are one of:

  1. Setting GIT_DIR fixes the repo directory for all sub-invocations. A
     script that does "cd some-other-repo.git && git ...". You'd need to
     teach calling scripts to unset GIT_DIR when trying to move to
     another repo.

  2. If GIT_DIR is set but GIT_WORK_TREE is not, then GIT_WORK_TREE will
     default to ".". It might be sufficient to set GIT_WORK_TREE when
     you are setting GIT_DIR here. But as I said, I didn't look too
     hard, so there might be other complications.

-Peff
