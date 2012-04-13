From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] checkout --detached test: write supporting files
 before start of tests
Date: Fri, 13 Apr 2012 19:33:46 -0400
Message-ID: <20120413233346.GB16663@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413232535.GB13995@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:33:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIq01-00074D-21
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab2DMXds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:33:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33589
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757263Ab2DMXds (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:33:48 -0400
Received: (qmail 14486 invoked by uid 107); 13 Apr 2012 23:33:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 19:33:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 19:33:46 -0400
Content-Disposition: inline
In-Reply-To: <20120413232535.GB13995@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195455>

On Fri, Apr 13, 2012 at 06:25:35PM -0500, Jonathan Nieder wrote:

> As a general rule, git's tests use the following layout:
> 
>  - first, setting the --help description and including test-lib
>    and other libraries
> 
>  - next, writing static files and setting variables that will last
>    through the entire script, and defining helper functions
> 
>  - next, the test assertions themselves
> 
> This way it is visually obvious where the code for each test assertion
> begins and ends and there is no temptation to use command substitution
> to do nontrivial work outside of the test_expect_success / failure
> blocks.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

I agree with that general rule, although:

> -cat >expect <<'EOF'
> -Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
> -EOF
>  test_expect_success 'tracking count is accurate after orphan check' '
> +	cp master-1-ahead.message expect &&
>  	reset &&
>  	git branch child master^ &&
>  	git config branch.child.remote . &&

it is quote common to keep expected output closer to its test, and this
expectation is only useful for this one test.  If anything, should this
not be moving the cat inside the test_expect_success? Or is there some
follow-on patch I am missing that is also going to use the message?

-Peff
