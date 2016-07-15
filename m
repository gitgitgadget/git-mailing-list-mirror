Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3EB2018F
	for <e@80x24.org>; Fri, 15 Jul 2016 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbcGOIEe (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 04:04:34 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50458 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbcGOIEa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 04:04:30 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bNy6b-0003QE-Ni; Fri, 15 Jul 2016 17:04:17 +0900
Date:	Fri, 15 Jul 2016 17:04:17 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?iso-8859-15?Q?=C6var_Arnfj=F6r=F0?= Bjarmason 
	<avarab@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
Message-ID: <20160715080417.GA12802@glandium.org>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 08:46:03AM +0200, Christian Couder wrote:
> Hi,
> 
> It seems to me that there are many current topics/patch series in
> flight that are about making Git interact with external code/processes
> and that it could be interesting to step back a bit and see if we
> could find a common approach/mechanism for at least some of these
> current topics.
> 
> (This is also inspired by private discussions with AEvar, thanks to
> him, and by the fact that I am now also working for GitLab on the long
> run on external ODB for large file support.)
> 
> The current topics/work I can think of are:
> 
> - the ref backend work by Michael based on Ronnie Sahlberg's and others' work,
> - the smudge/clean filters work by Joey and Lars,
> - the watchman/index helper work by David, Duy and Ben,
> - the external ODB work by Peff and myself.

Relatedly, some future topics I'd like to have at some point and that
would require the same kind of hooking:

- committish mapping resolution.

It's not really clear what I mean with this, but here's the idea: You're
using a remote helper to talk to a non-git repository. Common examples
are svn, p4 and mercurial. I'm not sure how this would work for svn, or
what p4 revisions look like, but speaking as someone who clones
mercurial repositories with git (and working on one of the tools to do
so), there are many cases where I wish I could just do something like:

   git show hg::d4a5c8fbfc20cebcae60d1e073874d19fa47d831

where d4a5c8fbfc20cebcae60d1e073874d19fa47d831 is a mercurial changeset
id. And this is a simple example, but the idea is that it would work
anywhere we can use committishs and revranges. Ideally, it would also
work with abbreviated mercurial changesets e.g. hg::d4a5c8fbfc20


- providing information for --decorate

Here the idea would be the converse of the above, and would make e.g.
`git log --decorate` show hg::d4a5c8fbfc20cebcae60d1e073874d19fa47d831
or the abbreviated form hg::d4a5c8fbfc20 for the corresponding git
commit.


Cheers,

Mike
