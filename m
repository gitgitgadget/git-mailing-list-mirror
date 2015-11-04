From: Jeff King <peff@peff.net>
Subject: Re: Strange diff-index output
Date: Wed, 4 Nov 2015 01:38:04 -0500
Message-ID: <20151104063803.GA16605@sigill.intra.peff.net>
References: <CABxGUTj-5vdmyVGkKuoMdBAG2EAQvLJNYLLA++T2hNFvGRmb0w@mail.gmail.com>
 <1446510469.4131.35.camel@twopensource.com>
 <CABxGUTihNmHqp-RovCVreTRqoK_sj+KCjRQE_YOVZ8OQzOHHoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Ch'Gans <chgans@gna.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 07:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztrij-0007L6-A9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 07:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbbKDGiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 01:38:11 -0500
Received: from cloud.peff.net ([50.56.180.127]:52542 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbbKDGiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 01:38:07 -0500
Received: (qmail 31960 invoked by uid 102); 4 Nov 2015 06:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 00:38:06 -0600
Received: (qmail 32743 invoked by uid 107); 4 Nov 2015 06:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 01:38:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 01:38:04 -0500
Content-Disposition: inline
In-Reply-To: <CABxGUTihNmHqp-RovCVreTRqoK_sj+KCjRQE_YOVZ8OQzOHHoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280853>

On Tue, Nov 03, 2015 at 02:00:33PM +1300, Ch'Gans wrote:

> I first tried "git update-index" but it didn't work. However "git
> update-index --refresh" seems to fix our problem.
> I didn't get why "--refresh" is needed thought, I'm really not
> familiar with the caching aspect of git.

It is because update-index is a general command for manipulating the
index. For example, you can add, delete, or change entries without
regard to what is in the working tree.

One of the manipulations is "refresh the index based on what is in the
working tree", and that is spelled "--refresh". Most porcelain-level git
commands (like "git diff") will do this for you automatically and
transparently. But when using the scriptable plumbing (like diff-index),
git gives you more control. This lets you do things more efficiently
(e.g,. you might refresh once and then issue several low-level
commands), at the cost of convenience.

You could also have used "git diff-index --cached HEAD", which instructs
diff-index not to look at the working tree at all (so you would compare
whatever is in the index, whether it is up to date with what is in the
working tree or not). Depending on what you are trying to achieve, that
might be fine (it's also more efficient in general, as it does not
require an lstat() of every file in the working tree).

-Peff
