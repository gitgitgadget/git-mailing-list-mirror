From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: DAG scalability (was: Git commit generation numbers)
Date: Sun, 17 Jul 2011 15:25:33 -0700
Message-ID: <CA+55aFxzY6YKAzYZFVzvsraSHnkXw47M9A4Kf1d8+d+YEZchzw@mail.gmail.com>
References: <CAJo=hJvMrW4f-4Y1czR+Mx4kA=2Po+zQQXe2iOFnF7KJ=Ou3nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 00:26:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiZml-0004eC-PL
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 00:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab1GQWZ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 18:25:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54130 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751741Ab1GQWZ6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 18:25:58 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p6HMPuIM011353
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Sun, 17 Jul 2011 15:25:57 -0700
Received: by wwe5 with SMTP id 5so2661643wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 15:25:53 -0700 (PDT)
Received: by 10.216.81.5 with SMTP id l5mr2476068wee.102.1310941553106; Sun,
 17 Jul 2011 15:25:53 -0700 (PDT)
Received: by 10.216.158.65 with HTTP; Sun, 17 Jul 2011 15:25:33 -0700 (PDT)
In-Reply-To: <CAJo=hJvMrW4f-4Y1czR+Mx4kA=2Po+zQQXe2iOFnF7KJ=Ou3nA@mail.gmail.com>
X-Spam-Status: No, hits=-102.898 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177321>

On Sun, Jul 17, 2011 at 3:18 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
>
> What about `git clone`? =A0We're always recomputing the entire DAG
> during it. For a public repository like yours that only contains
> public objects, its a horrible abuse of the servers that are serving
> the repository...
>
> Just saying, not everything we do winds up being a partial or
> incomplete traversal in the name of performance.

I don't see your point.

OF COURSE we sometimes traverse the whole tree - when we need all the
data. And it's expensive in those cases, but generally those cases are
also cases where the DAG traversal itself is just a tiny part of the
big picture. The commits tend to be almost irrelevant to "git clone",
for example: it tends to be tree and blob objects that are the biggest
cost.

But there's a lot of common operations that would be much too
expensive unless we had the incomplete DAG traversal code. It's what
makes us able to do sub-second merges, it's what makes "gitk @{6am}.."
be fast, etc etc.

My point really was that the git DAG structure is really simple.
People learn about DAG's in CS courses the first year.

But the kinds of things that git does, which is to try to partition
the DAG without having to walk it entirely - that's rare. I tried to
find papers about optimized DAG walking, and couldn't (but so many
academic papers are behind a pay-wall that I still don't know if there
might be some smart person who came up with a really good algorithm
for what the git-merge-base stuff does, for example)

                    Linus
