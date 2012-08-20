From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH 1/2] t6300: test sort with multiple keys
Date: Mon, 20 Aug 2012 07:24:29 +0200
Message-ID: <20120820052429.GF1076@camk.edu.pl>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
 <7vk3wuo0sa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 07:24:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3KTl-0008Cf-KK
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 07:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab2HTFYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 01:24:41 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34558 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868Ab2HTFYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 01:24:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 458F95F004A;
	Mon, 20 Aug 2012 07:25:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cpkRYAx3cGtI; Mon, 20 Aug 2012 07:25:31 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id B0F485F0047;
	Mon, 20 Aug 2012 07:25:31 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 17B8546743; Mon, 20 Aug 2012 07:24:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk3wuo0sa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203755>

On Sun, Aug 19, 2012 at 05:38:29PM -0700, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > Documentation of git-for-each-ref says that --sort=<key> option can be
> > used multiple times, in which case the last key becomes the primary key.
> > However this functionality was never checked in test suite and is
> > currently broken. This commit adds appropriate test in preparation for fix.

> > Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> > ---

> Thanks.

> > +test_expect_success 'Create branches to test sort with multiple keys' '
> > +	git checkout -b Branch1 &&
> > +	echo foo >> one &&
> > +	git commit -a -m "Branch1 commit" &&
> > +	git checkout -b Branch2 &&
> > +	echo foo >> one &&
> > +	git commit -a -m "Branch2 commit"
> > +'
> > +
> > +test_atom refs/heads/Branch1 objectname 32fca05e9f638021a123a84226acf17756acc18b
> > +test_atom refs/heads/Branch2 objectname 194a5b89ac661a114566ba4374bc06c2797539f3

> Do these need to be "Branch[12]", not "branch[12]" for the code to
> exhibit the bug?  If not, please don't be creative in names like
> these.  On case corrupting filesystems you may write Branch1 and
> they may come back as branch1, but that is not what we are testing
> here.

Branches names can be lowercased. Only the commit messages should be
preserved as they produce the test depends on the lexicographical order
of created SHA1s.

> > @@ -296,6 +325,8 @@ test_expect_success 'Check short refname format' '
> >  '

> >  cat >expected <<EOF
> > +
> > +
> >  origin/master

> What are these blank line outputs?

The upstreams of Branch1 and Branch2.

> >  EOF

> > @@ -309,7 +340,7 @@ cat >expected <<EOF
> >  EOF

> >  test_expect_success 'Check short objectname format' '
> > -	git for-each-ref --format="%(objectname:short)" refs/heads >actual &&
> > +	git for-each-ref --format="%(objectname:short)" refs/heads/master >actual &&
> >  	test_cmp expected actual
> >  '

> All in all, I have to wonder if you can limit the updates to other
> unrelated tests if you added a new test near the end.  Also doesn't
> the existing test already create enough refs to let you sort with
> multiple keys and demonstrate the breakage already, without adding new
> refs and objects?

My intention was to group all tests to sort in one place. But if the
preferred place for a new one is at the end, then it is possible to find
the adequate refs among existing ones.

-- 
  Kacper Kornet
