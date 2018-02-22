Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C931F404
	for <e@80x24.org>; Thu, 22 Feb 2018 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbeBVXYN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 18:24:13 -0500
Received: from accordion.employees.org ([198.137.202.74]:45529 "EHLO
        accordion.employees.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeBVXYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 18:24:12 -0500
Received: by accordion.employees.org (Postfix, from userid 1736)
        id CB6572D5048; Thu, 22 Feb 2018 23:24:11 +0000 (UTC)
Date:   Thu, 22 Feb 2018 23:24:11 +0000
From:   Derek Fawcus <dfawcus+lists-git@employees.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: Git should preserve modification times at least on request
Message-ID: <20180222232411.GA54558@accordion.employees.org>
Mail-Followup-To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Peter Backes <rtc@helen.PLASMA.Xg8.DE>, git@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE>
 <20180221210339.GA43094@accordion.employees.org>
 <87bmgif2pa.fsf@evledraar.gmail.com>
 <20180221221420.GA7743@helen.PLASMA.Xg8.DE>
 <87a7w2ezeq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7w2ezeq.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 11:44:13PM +0100, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Feb 21 2018, Peter Backes jotted:
> > On Wed, Feb 21, 2018 at 10:33:05PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> This sounds like a sensible job for a git import tool, i.e. import a
> >> target directory into git, and instead of 'git add'-ing the whole thing
> >> it would look at the mtimes, sort files by mtime, then add them in order
> >> and only commit those files that had the same mtime in the same commit
> >> (or within some boundary).
> >
> > I think that this would be The Wrong Thing to do.

Agreed, but probably for a different reason.

> I'm merely pointing out that if you have the use-case Derek Fawcus
> describes you can get per-file mtimes via something similar to the the
> hook method Theodore Ts'o described today with a simple import tool with
> no changes to git or its object format required.

Actually, I was not proposing any change to the git objects.
I was simply suggesting a case where I'd have found a optional mechanism
for mtime restoration useful.

What would be useful is a better version of the hook based scheme which
Ted mentioned.  The import could be via a wrapper script, but checkouts
would have to be via a hook such that the original timestamps could then
be applied; and those stamps would have to be part of the tar-file commit.

The idea of automatically generating a bunch of commits in time order
would be the wrong thing here. That is because one file could well
contain changes from more than one logical commit (as guided by the
Changelog), and that one logical commit can be spread across a few
files with diffrent mode time, one has to manually tease those apart.

So here the purpose behind restoring the timestamps is as an aid in
guiding the examination of files to find the changes referenced in
the Changelog.

Git is quite useful for this sort of effort, as once a sensible commit
has been synthsized, rebase of the next tar-file commit then helps
reveal the next set of changes.

So what I'm thinking of is for stuff like this: https://github.com/DoctorWkt/unix-jun72
(and the other repros there), where one wishes to figure out and
regenerate a history of changes.  Since git is quite useful for
representing the end result, it is just that other scripting
may make it easier to use for such cases.

DF
