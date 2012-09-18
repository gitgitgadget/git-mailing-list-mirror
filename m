From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Make test output coloring more intuitive
Date: Tue, 18 Sep 2012 22:36:17 +0100
Message-ID: <20120918213617.GB2567@atlantic.linksys.moosehall>
References: <1347882637-21766-1-git-send-email-git@adamspiers.org>
 <7vboh4tluo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 23:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE5TV-0005tT-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 23:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab2IRVgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 17:36:47 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:43969 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577Ab2IRVgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 17:36:19 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id DEB232E5DB;
	Tue, 18 Sep 2012 22:36:17 +0100 (BST)
Mail-Followup-To: git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7vboh4tluo.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205878>

On Mon, Sep 17, 2012 at 01:50:39PM -0700, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > 1. Change the color of individual known breakages from bold green to
> >    bold yellow.  This seems more appropriate when considering the
> >    universal traffic lights coloring scheme, where green conveys the
> >    impression that everything's OK, and amber that something's not
> >    quite right.
> >
> > 2. Likewise, change the color of the summarized total number of known
> >    breakages from bold red to bold yellow to be less alarmist and more
> >    consistent with the above.
> >
> > 3. Change color of unexpectedly fixed known breakages to bold red.  An
> >    unexpectedly passing test indicates that the test is wrong or the
> >    semantics of the code being tested have changed.  Either way this
> >    is an error which is arguably as bad as a failing test, and as such
> >    is now counted in the totals too.
> 
> I agree with Peff's comments.
> 
> The point #3 above wants to be a separate patch;

OK, re-rolling this.

> we may even want to consider a follow-up change to add an option to
> make a "test that is expected to fail did not fail" case a failure.

Sounds like a nice idea.

> >  test_known_broken_ok_ () {
> >  	test_fixed=$(($test_fixed+1))
> > -	say_color "" "ok $test_count - $@ # TODO known breakage"
> > +	test_broken=$(($test_broken+1))
> > +	say_color error "ok $test_count - $@ # TODO known breakage vanished"
> >  }
> 
> Also I wonder if this is still a "TODO".

Hah, I should trust my first instincts more; my first version of the
patch dropped the "TODO", but then I put it back in because I thought
people would object :-)

> "# TODO fixed known breakage", meaning that it is something that
> must be looked at by whoever happened to have fixed the known
> breakage by accident, might be a better wording.

I would challenge the assumption that the test passed because someone
deliberately fixed the code it was testing.  Whilst this is a probable
scenario (e.g. if they forgot to adjust the test to expect success
rather than failure), it's not the only one.  Tests can be brittle and
depend on external factors which can change unexpectedly.  For
example, I noticed that the final 'general options plus command' test
in t9902-completion.sh is currently dependent on the contents of the
current $PATH.  This is because I have a shell-script called
`git-check-email' on mine, so `check-email' becomes an extra
subcommand completion possibility for the prefix `check'.  Almost
every other developer running this test would not encounter the same
failure.  It's not a huge stretch to imagine a similar corner case
which could unexpectedly cause a test to pass when failure was
expected.

Therefore I would suggest a wording which avoids implying that
something was deliberately fixed.  That was my reasoning behind
introducing the word "vanished" to the output.
