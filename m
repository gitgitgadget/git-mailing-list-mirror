From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_
 functions
Date: Thu, 26 May 2016 12:50:33 -0400
Message-ID: <20160526165033.GA20355@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224323.GD22443@sigill.intra.peff.net>
 <20160519000821.GA22543@sigill.intra.peff.net>
 <CACsJy8Ad=yN6aLkH9B6ujUNUvPT-b+jw+CwJORD5Fh1jYeOUZQ@mail.gmail.com>
 <xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yUb-0005Wg-5S
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbcEZQuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:50:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:44700 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750985AbcEZQug (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:50:36 -0400
Received: (qmail 5792 invoked by uid 102); 26 May 2016 16:50:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:50:35 -0400
Received: (qmail 20350 invoked by uid 107); 26 May 2016 16:50:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:50:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 12:50:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fegydmf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295670>

On Thu, May 26, 2016 at 09:42:48AM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Thu, May 19, 2016 at 7:08 AM, Jeff King <peff@peff.net> wrote:
> >> On Wed, May 18, 2016 at 06:43:23PM -0400, Jeff King wrote:
> >>
> >>>  cache.h                |  1 +
> >>>  config.c               | 51 +++++++++++++++++++++++++++++++++++++++++---------
> >>>  t/helper/test-config.c | 20 ++++++++++++++++++++
> >>>  t/t1308-config-set.sh  | 23 +++++++++++++++++++++++
> >>> [...]
> >>> +test_expect_success 'iteration shows correct origins' '
> >>> +     echo "[alias]test-config = !test-config" >.gitconfig &&
> >
> > How about using 'which' to get absolute path for test-config and put
> > it here? Then we don't rely on $PATH anymore.
> 
> Don't use which, which is not portable.
> 
> Remind me why we end up running ./test-config instead of
> ./bin-wrappers/test-config?  Should our tests be running 
> bin-wrappers early in their $PATH, perhaps?

The problem is running test-config inside of a git alias. The
bin-wrappers will set the exec-path to the root-level of git's build
directory, which the git binary will then stick at the front of the
$PATH.

So the simplest solution really is: don't do that. The only debate in my
mind is whether this is rare enough that it won't bite somebody again in
the future, or if we should look into a solution that makes this Just
Work.

-Peff
