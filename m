Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C481F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdLZVeB (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:34:01 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35794 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbdLZVeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:34:00 -0500
X-Greylist: delayed 889 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2017 16:33:59 EST
Received: from glandium by mitsuha.glandium.org with local (Exim 4.90_RC4)
        (envelope-from <mh@glandium.org>)
        id 1eTgXl-0006CP-80; Tue, 26 Dec 2017 13:08:45 +0900
Date:   Tue, 26 Dec 2017 13:08:45 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226040843.h7o6txkrp6zlv7u5@glandium.org>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20171215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 11:10:19PM -0700, Carl Baldwin wrote:
> The big contention among git users is whether to rebase or to merge
> changes [2][3] while iterating. I used to firmly believe that merging
> was the way to go and rebase was harmful. More recently, I have worked
> in some environments where I saw rebase used very effectively while
> iterating on changes and I relaxed my stance a lot. Now, I'm on the
> fence. I appreciate the strengths and weaknesses of both approaches. I
> waffle between the two depending on the situation, the tools being
> used, and I guess, to some extent, my mood.
> 
> I think what git needs is something brand new that brings the two
> together and has all of the advantages of both approaches. Let me
> explain what I've got in mind...
> 
> I've been calling this proposal `git replay` or `git replace` but I'd
> like to hear other suggestions for what to name it. It works like
> rebase except with one very important difference. Instead of orphaning
> the original commit, it keeps a pointer to it in the commit just like
> a `parent` entry but calls it `replaces` instead to distinguish it
> from regular history. In the resulting commit history, following
> `parent` pointers shows exactly the same history as if the commit had
> been rebased. Meanwhile, the history of iterating on the change itself
> is available by following `replaces` pointers. The new commit replaces
> the old one but keeps it around to record how the change evolved.
> 
> The git history now has two dimensions. The first shows a cleaned up
> history where fix ups and code review feedback have been rolled into
> the original changes and changes can possibly be ordered in a nice
> linear progression that is much easier to understand. The second
> drills into the history of a change. There is no loss and you don't
> change history in a way that will cause problems for others who have
> the older commits.
> 
> Replay handles collaboration between multiple authors on a single
> change. This is difficult and prone to accidental loss when using
> rebase and it results in a complex history when done with merge. With
> replay, collaborators could merge while collaborating on a single
> change and a record of each one's contributions can be preserved.
> Attempting this level of collaboration caused me many headaches when I
> worked with the gerrit workflow (which in many ways, I like a lot).
> 
> I blogged about this proposal earlier this year when I first thought
> of it [1]. I got busy and didn't think about it for a while. Now with
> a little time off of work, I've come back to revisit it. The blog
> entry has a few examples showing how it works and how the history will
> look in a few examples. Take a look.
> 
> Various git commands will have to learn how to handle this kind of
> history. For example, things like fetch, push, gc, and others that
> move history around and clean out orphaned history should treat
> anything reachable through `replaces` pointers as precious. Log and
> related history commands may need new switches to traverse the history
> differently in different situations. Bisect is a interesting one. I
> tend to think that bisect should prefer the regular commit history but
> have the ability to drill into the change history if necessary.
> 
> In my opinion, this proposal would bring together rebase and merge in
> a powerful way and could end the contention. Thanks for your
> consideration.

FWIW, your proposal has a lot in common (but is not quite equivalent) to
mercurial's obsolescence markers and changeset evolution features.

Mike
