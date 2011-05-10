From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Tue, 10 May 2011 16:01:46 -0400
Message-ID: <20110510200146.GD14456@sigill.intra.peff.net>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
 <7vei47q0i6.fsf@alter.siamese.dyndns.org>
 <20110509220806.GC3719@sigill.intra.peff.net>
 <7vwrhzmnxf.fsf@alter.siamese.dyndns.org>
 <7vsjsnmnrv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:01:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJt7x-0001vp-PC
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1EJUBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:01:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59061
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab1EJUBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:01:48 -0400
Received: (qmail 25410 invoked by uid 107); 10 May 2011 20:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 16:03:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 16:01:46 -0400
Content-Disposition: inline
In-Reply-To: <7vsjsnmnrv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173354>

On Mon, May 09, 2011 at 04:56:20PM -0700, Junio C Hamano wrote:

> > Yeah, that test that hardcodes the exact commit sequence is disgusting.
> > In the meantime...
> >
> > -- >8 --
> > From: Jeff King <peff@peff.net>
> > Subject: [PATCH] t7501.8: feed a meaningful command
> 
> And then on top of that, Conrad's "allow commit --interactive <path>"
> would come, with this squashed in.  The last "reset HEAD^" is nasty but I
> don't have enough energy to fix 12ace0b (Add test case for basic commit
> functionality., 2007-07-31) today.
> 
>  t/t7501-commit.sh |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 3d2b14d..c2fd116 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -41,11 +41,12 @@ test_expect_success \
>  	"echo King of the bongo >file &&
>  	test_must_fail git commit -m foo -a file"
>  
> -test_expect_success PERL 'cannot use paths with --interactive' '
> +test_expect_success PERL 'can use paths with --interactive' '
>  	echo bong-o-bong >file &&
>  	# 2: update, 1:st path, that is all, 7: quit
>  	( echo 2; echo 1; echo; echo 7 ) |
> -	test_must_fail git commit -m foo --interactive file
> +	git commit -m foo --interactive file &&
> +	git reset --hard HEAD^
>  '

Yeah, that reset is a hack. Looking through the tests that come after,
I don't think the extra commit is silently hurting any of them, so it's
really just the stupid hard-coded rev-list one.

I looked at rewriting it into something like "git log --format=%s", but
I couldn't come up with a commit message that reasonably argued "this
tests the same thing as the original". Because I haven't really figured
out what the original is supposed to be testing. That we made commits?
That we made a particular sequence of commits with those messages? With
particular trees?

I feel like each test should be responsible for figuring out whether it
committed or not (and AFAICT, they do). So I would be tempted to just
delete the rev-list test.

-Peff
