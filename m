From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Fri, 18 Feb 2011 16:55:35 -0800
Message-ID: <AANLkTikORqg_BUUbBtUQTYTVO3nttKpMDtCbxm4ikJCU@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net> <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqb7e-0004pk-TS
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab1BSA40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:56:26 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45329 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966Ab1BSA4Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 19:56:24 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1J0tuNV012844
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:55:57 -0800
Received: by iwn8 with SMTP id 8so11219iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 16:55:55 -0800 (PST)
Received: by 10.42.223.73 with SMTP id ij9mr1636581icb.442.1298076955062; Fri,
 18 Feb 2011 16:55:55 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Fri, 18 Feb 2011 16:55:35 -0800 (PST)
In-Reply-To: <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
X-Spam-Status: No, hits=-102.962 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167242>

On Fri, Feb 18, 2011 at 4:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So please consider the attached patch just a "look, guys, this is
> wrong, and here's the ugliest hack you've ever seen to fix it".

Btw, the more I think about it, the more I suspect that the
"estimate_similarity()" part of the patch is correct, or at least
better than what we used to have.

If we have a file that expanded from 100 lines to 200 lines, and all
of the old contents are there, then I think that logically people
would expect it to be a "50% similarity".

But the thing is, with the old code, we would look at the old smaller
size (100 lines), and take 50% of that. And then when the delta (also
100 lines) is bigger than that 50%, then we'd totally dismiss that
thing from similarity analysis, because it obviously isn't similar
enough.

So using the bigger size as the basis (and taking 50% of _that_ and
comparing it to the delta) is probably the sane thing to do.

The rest of the patch I still think is total crap. The _intention_ is
good, but the patch was written to be small rather than the right way
of doing things.

                          Linus
