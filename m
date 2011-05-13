From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 09:11:31 -0700
Message-ID: <BANLkTimE2GkkhcFZtNrYZASWp0LDhUx=GQ@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
 <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com> <BANLkTi=dL+KyQ3Bm58_Uj4LP9WSpbzAfJA@mail.gmail.com>
 <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <christian.couder@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org, Shuang He <shuang.he@intel.com>
To: Andrew Lutomirski <luto@mit.edu>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 18:12:11 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKuyG-00020G-Bh
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 18:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759502Ab1EMQL4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 12:11:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35146 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754116Ab1EMQLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 12:11:55 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4DGBqhP003570
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Fri, 13 May 2011 09:11:54 -0700
Received: by ewy4 with SMTP id 4so749513ewy.19
        for <multiple recipients>; Fri, 13 May 2011 09:11:51 -0700 (PDT)
Received: by 10.14.119.77 with SMTP id m53mr720726eeh.65.1305303111139; Fri,
 13 May 2011 09:11:51 -0700 (PDT)
Received: by 10.14.127.144 with HTTP; Fri, 13 May 2011 09:11:31 -0700 (PDT)
In-Reply-To: <BANLkTi=NdVUUZ=_bACzyeMGS3JWs0EMbWA@mail.gmail.com>
X-Spam-Status: No, hits=-102.978 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173544>

On Fri, May 13, 2011 at 7:56 AM, Andrew Lutomirski <luto@mit.edu> wrote:
>
> So what I really want is a fancy version of git bisect that makes no
> assumptions about the relationship of good and bad commits in the
> graph and just finds me a commit that is bad but for which all parents
> are good or vice versa.

Ehh. That's the "non-fancy" way of testing, I'm afraid: if you cannot
make assumption about the relationship between good and bad commits,
then you have to test _every_ commit.

So yes, bisection has its problems. But they really do come from the
fact that it's very efficient. When you have (on average) about ten
thousand commits between releases, you have to make assumptions about
the relationships. But once you do that, the efficiency also results
in a certain fragility.

Think of it as a compression method: it generates the smallest
possible set of test points for you. But it's a "lossy" compression -
you don't test everything. And it's extreme: it boils down 10k commit
events to about 13 bisection events. If anything goes wrong (like the
bug not being entirely repeatable, or the bug comes and goes), it will
give the wrong answer.

The good news is that _usually_ it works really well. And when the
choice is between "works really well for 10k commits but can have
problems" and "you need to test all 10k commits", the "can have
problems" part turns out to be a pretty small downside ;)

                                Linus
