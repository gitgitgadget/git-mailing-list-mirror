From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 19:54:57 +0200
Message-ID: <200904031954.57584.j6t@kdbg.org>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 19:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpndb-0000zv-Fq
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 19:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935048AbZDCRzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 13:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934493AbZDCRzF
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 13:55:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:19395 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935048AbZDCRzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 13:55:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6BF3DCDF96;
	Fri,  3 Apr 2009 19:54:58 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 455941D235;
	Fri,  3 Apr 2009 19:54:58 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090403132029.GC21153@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115548>

On Freitag, 3. April 2009, Jeff King wrote:
> On Fri, Apr 03, 2009 at 12:03:50AM -0700, Robin H. Johnson wrote:
> > +if test -n "$NO_PERL"
> > +then
> > +	test_expect_success 'skipping git-svn tests, NO_PERL defined' :
> > +	test_done
> > +	exit
> > +fi
>
> This probably got copied from an older example, but I think the
> recommended way to skip tests these days is to use 'say' instead of
> test_expect_success (since we have statistics on passing/failing tests
> now).
>
> Also, it may make sense to integrate this with Johannes Sixt's
> test_have_prereq work (which is still in next), but I haven't looked too
> closely at that.

If you base the patch on 'master', you can add this line to test-lib.sh

test -z "$NO_PERL" && test_set_prereq PERL

[But actually, if I read you patch correctly, NO_PERL will be set in 
t/Makefile only if one runs 'make test' from the main directory. You should 
invent some method to detect missing perl (or that NO_PERL was set) if 'make' 
is run directly from t/.]

Now you write the above as

if ! test_have_prereq PERL
then
	say 'perl not available - skipping git-svn tests'
	test_done
	exit
fi

Furthermore, you can skip single tests like this:

> > -test_expect_success \
> > +[ -z "$NO_PERL" ] && test_expect_success \

test_expect_success PERL \

-- Hannes
