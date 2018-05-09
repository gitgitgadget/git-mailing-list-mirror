Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59491F424
	for <e@80x24.org>; Wed,  9 May 2018 15:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965305AbeEIP4v (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 11:56:51 -0400
Received: from ao2.it ([92.243.12.208]:37522 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964984AbeEIP4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 11:56:49 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fGRSN-0007b6-3I; Wed, 09 May 2018 17:56:43 +0200
Date:   Wed, 9 May 2018 17:56:47 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] wrap-for-bin.sh: facilitate running Git executables
 under valgrind
Message-Id: <20180509175647.0961d469e01367783090e764@ao2.it>
In-Reply-To: <CABPp-BEvNOBkq0-v_Uq0CHkvRixCKmUhYPMeH-MHHZGb0x9NkA@mail.gmail.com>
References: <20180509132858.21936-1-ao2@ao2.it>
        <CABPp-BEvNOBkq0-v_Uq0CHkvRixCKmUhYPMeH-MHHZGb0x9NkA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 May 2018 08:25:21 -0700
Elijah Newren <newren@gmail.com> wrote:

> Hi Antonio,
> 

Hi Elijah,

> On Wed, May 9, 2018 at 6:28 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > Testing locally built git executables under valgrind is not immediate.
> >
> > Something like the following does not work:
> >
> >   $ valgrind ./bin-wrappers/git
> >
> > because the wrapper script forks and execs the command and valgrind does
> > not track children processes by default.
> >
> > Something like the following may work:
> >
> >   $ valgrind --trace-children=yes ./bin-wrappers/git
> >
> > However it's counterintuitive and not ideal anyways because valgrind is
> > supposed to be called on the actual executable, not on wrapper scripts.
> >
> > So, following the idea from commit 6a94088cc ("test: facilitate
> > debugging Git executables in tests with gdb", 2015-10-30) provide
> > a mechanism in the wrapper script to call valgrind directly on the
> > actual executable.
> >
> > This mechanism could even be used by the test infrastructure in the
> > future, but it is already useful by its own on the command line:
> >
> >   $ GIT_TEST_VALGRIND=1 \
> >     GIT_VALGRIND_OPTIONS="--leak-check=full" \
> >     ./bin-wrappers/git
> >
> 
> Wow, timing; nice to see someone else finds this kind of thing useful.
> 
> I submitted something very similar recently; see commit 842436466aa5
> ("Make running git under other debugger-like programs easy",
> 2018-04-24) from next, or the discussion at
> https://public-inbox.org/git/20180424234645.8735-1-newren@gmail.com/.
> That other patch has the advantage of enabling the user to run git
> under other debugger-like programs besides just gdb and valgrind.
> 

Thanks Elijah, I am not subscribed to the list so I didn't see your
change and I usually only track the master branch.

Obviously your changes work for me, so I am dropping my patch.

As the changes in 842436466aa5 ("Make running git under other
debugger-like programs easy", 2018-04-24) are not specific to valgrind
they should also address Jeff's concerns in the sense that it's up to
the particular GIT_DEBUGGER how it handles sub-processes.

In valgrind case one may still want to pass "--trace-children=yes" in
GIT_DEBUGGER after all for better coverage. Thank you Jeff for the
remark.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
