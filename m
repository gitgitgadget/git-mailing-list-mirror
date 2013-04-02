From: Jeff King <peff@peff.net>
Subject: Re: [BUG] inconsistent behavior with --set-upstream vs
 --set-upstream-to
Date: Tue, 2 Apr 2013 13:23:33 -0400
Message-ID: <20130402172333.GB24698@sigill.intra.peff.net>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Garrett Cooper <yaneurabeya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4wH-0004jM-UA
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918Ab3DBRXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:23:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52349 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932912Ab3DBRXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:23:37 -0400
Received: (qmail 11551 invoked by uid 107); 2 Apr 2013 17:25:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 13:25:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:23:33 -0400
Content-Disposition: inline
In-Reply-To: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219809>

On Tue, Apr 02, 2013 at 10:07:01AM -0700, Garrett Cooper wrote:

> 	It looks like git branch --set-upstream-to doesn't function with 1.8.1.3 until I run --set-upstream. Is this a known bug?

No, but I do not think that is exactly what is going on.

> root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
> fatal: Not a valid object name: 'origin/pjdfstest-onefs'.

This is complaining that origin/pjdfstest-onefs does not actually exist
Does it? If the pjdfstest-onefs branch exists on the remote, do you need
to do a "git fetch" to make sure we have a local
refs/remotes/origin/pjdfstest-onefs tracking branch locally?

> root@fuji-current:/usr/src # git branch --set-upstream origin/pjdfstest-onefs pjdfstest-onefs
> The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
> Branch origin/pjdfstest-onefs set up to track local branch pjdfstest-onefs.

This did _not_ create the remote-tracking branch refs/remotes/origin/pjdfstest-onefs.
It created a new local branch called "origin/pjdfstest-onefs" (i.e.,
refs/heads/origin/pjdfstest-onefs), whose upstream is another local
branch "pjdfstest-onefs". That "backwards" order to the arguments is why
--set-upstream is deprecated; many people have made the same mistake.

> root@fuji-current:/usr/src # git branch --set-upstream-to origin/pjdfstest-onefs pjdfstest-onefs
> Branch pjdfstest-onefs set up to track local branch origin/pjdfstest-onefs.

Note how it says "local branch" here; you are not tracking anything at
the origin. You are tracking a local branch that happens to have
"origin/" in the name.

-Peff
