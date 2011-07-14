From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Git commit generation numbers
Date: Thu, 14 Jul 2011 11:24:27 -0700
Message-ID: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQbK-0003Vg-Eg
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab1GNSZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:25:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53721 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755509Ab1GNSZV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 14:25:21 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6EIOmba026658
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:24:49 -0700
Received: by wwe5 with SMTP id 5so605140wwe.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:24:47 -0700 (PDT)
Received: by 10.216.54.197 with SMTP id i47mr6608359wec.48.1310667887185; Thu,
 14 Jul 2011 11:24:47 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Thu, 14 Jul 2011 11:24:27 -0700 (PDT)
X-Spam-Status: No, hits=-102.895 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177146>

Ok, so I see that the old discussion about generation numbers has resurfaced.

And I have to say, with six years of git use, I think it's not a
coincidence that the notion of generation numbers has come up several
times over the years: I think the lack of them is literally the only
real design mistake we have.

And I absolutely *detest* the generation number cache thing I see on the list.

Maybe I missed the discussion that actually added them to the commits
(I don't read the git mailing list regularly any more) but I think
it's a mistake to add an external cache to work around the fact that I
didn't add the generation numbers originally.

So I think we should just add the generation numbers now. We can make
the rule be that if a commit doesn't have a generation number, we end
up having to compute it (with no real need for caching). Yes, it's
expensive. But it's going to be a *lot* less expensive over time as
people start using a git version that adds the generation numbers to
commits.

And we can easily mix this - there's no "flag-day" issues. Old
versions of git will ignore the generation number and generate new
commits that doesn't have it. New versions of git will generate them,
and use them. And once the project starts having generation numbers in
some commits, the "generating them" part will get cheaper over time.

I'll send out a patch that admittedly does not have much testing as a
reply to this one. It ends up being really simple. Of course, maybe
it's simple because I did something incredibly stupid, but please take
a look.

                                 Linus
