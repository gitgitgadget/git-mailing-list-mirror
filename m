Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB5AF1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfHVSn1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:43:27 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50153 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729830AbfHVSn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:43:27 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7F874240004;
        Thu, 22 Aug 2019 18:43:24 +0000 (UTC)
Date:   Fri, 23 Aug 2019 00:13:12 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822170817.GB35435@google.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/19 10:08AM, Emily Shaffer wrote:
> On Thu, Aug 22, 2019 at 09:58:48AM -0700, Bryan Turner wrote:
> > On Thu, Aug 22, 2019 at 5:32 AM Giuseppe Crinò <giuscri@gmail.com> wrote:
> > >
> > > Note how `git log` discards the ending quote character:
> > 
> > <snip>
> > 
> > > root@NBR1710R:~/repo# git add foo
> > > root@NBR1710R:~/repo# git commit -m 'first'
> > > [master (root-commit) a78e11f] first
> > >  Committer: Les Actualite <root@NBR1710R>
> > 
> > If you look closely here, in the "git commit" output, you can see
> > that, as Pratyush indicated, it was actually "git commit" that dropped
> > the trailing apostrophe, and "git log" is simply presenting the
> > information as it exists in the repository.
> > 
> > If your goal is an accented "e", wouldn't it be better to set your
> > name using é, rather than a trailing apostrophe? "git commit" would
> > likely preserve that without issue.
> 
> Hmm, I don't think it's a good idea to get into the business of telling
> contributors how to write their names. There tends to be an axiom that
> "all assumptions developers make about human names are false."
> 
> Does it make more sense to replace this strbuf_addstr_without_crud()
> setup with something more intelligent (i.e. checking for matching crud
> on either end, like ^[$crudchars].*\1$? We already check for matched <>.

Sounds like something easy enough to implement. There are two types of 
characters that crud() removes: there are the ones which _should_ appear 
on both the start and end (', ", <, >), and the ones which don't 
necessarily have to (., ,, :, ;, \).

So we'd need to handle two cases. For the former type, remove a 
character both at the start and at the end. For the latter, remove only 
where they appear.

If this sounds like something reasonable to do, I'll send a patch fixing 
this.

-- 
Regards,
Pratyush Yadav
