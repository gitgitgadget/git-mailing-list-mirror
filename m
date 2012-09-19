From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 4/6] Refactor mechanics of testing in a sub test-lib
Date: Wed, 19 Sep 2012 21:15:58 +0100
Message-ID: <20120919201558.GE19246@atlantic.linksys.moosehall>
References: <1348074915-19985-1-git-send-email-git@adamspiers.org>
 <1348074915-19985-5-git-send-email-git@adamspiers.org>
 <20120919175655.GC11699@sigill.intra.peff.net>
 <20120919184406.GC19246@atlantic.linksys.moosehall>
 <20120919193708.GA21950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:16:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQgt-0001v9-5K
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab2ISUQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:16:01 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:45135 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab2ISUQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:16:00 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 81E082E39E
	for <git@vger.kernel.org>; Wed, 19 Sep 2012 21:15:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20120919193708.GA21950@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205993>

On Wed, Sep 19, 2012 at 03:37:08PM -0400, Jeff King wrote:
> Looking at it again, it is actually quite subtle what is going on. We
> wrap the outer test_expect_* calls in double-quotes so that the inner
> ones can use single-quotes easily. But that means that technically the
> contents of the here-doc _are_ interpolated. But not at test run-time,
> but rather at the call to test_expect_*. And that is why we nee to use
> "\\" instead of "\". So I think anybody trying to tweak these tests
> using shell metacharacters is in for a surprise either way.

Actually I already did that in one place:

    test_expect_success 'pretend we have a fully passing test suite' "
            run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
            for i in 1 2 3; do
                    test_expect_success \"passing test #\$i\" 'true'
            done
            test_done
            EOF
    [...]
    "

Without the \\ preceeding the EOF, it needed to be:

                    test_expect_success \"passing test #\\\$i\" 'true'

> I'm not sure it is worth worrying about, though, as handling it
> would probably make the existing tests less readable.

Yeah, the for loop is perhaps slightly overkill :-)

> It all looks sane to me. Thanks again.

Thanks for your (unnervingly) thorough reviews ;-)
