Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1E81F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732827AbfILOvy (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:51:54 -0400
Received: from sym2.noone.org ([178.63.92.236]:48546 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732444AbfILOvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:51:54 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46ThYh1Gc5zvjc1; Thu, 12 Sep 2019 16:51:52 +0200 (CEST)
Date:   Thu, 12 Sep 2019 16:51:51 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: trim leading and trailing whitespaces in author
 name
Message-ID: <20190912145151.7ztvovxqatfqmvig@distanz.ch>
References: <20190912115201.888-1-tklauser@distanz.ch>
 <CAPig+cQ53m0LrmScKnrcddyQzBRw_P=74cJ_H51GGrs8FD4RRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ53m0LrmScKnrcddyQzBRw_P=74cJ_H51GGrs8FD4RRg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-09-12 at 16:47:41 +0200, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Sep 12, 2019 at 7:59 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> > In some cases, the svn author names might contain leading or trailing
> > whitespaces, leading to messages such as:
> >
> >   Author: user1
> >    not defined in authors.txt
> >
> > (the trailing newline leads to the line break). The user "user1" is
> > defined in authors.txt though, e.g.
> >
> >   user1 = User <user1@example.com>
> >
> > Fix this by trimming the author name retreived from svn before using it
> > in check_author.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> > diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> > @@ -1491,6 +1491,7 @@ sub call_authors_prog {
> >  sub check_author {
> >         my ($author) = @_;
> > +       $author =~ s/^\s+|\s+$//g;
> >         if (!defined $author || length $author == 0) {
> >                 $author = '(no author)';
> >         }
> 
> This fix seems incomplete. What happens if $author is undefined?
> (There is a check for $author defined'ness just below the new code you
> add.)

Right, thanks for noting. The whitespace trimming should be moved below
the defined'ness check. I'll send an updated patch.
