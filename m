Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB631C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B8D6104F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhHKUTm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Aug 2021 16:19:42 -0400
Received: from mailproxy07.manitu.net ([217.11.48.71]:39468 "EHLO
        mailproxy07.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHKUTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:19:42 -0400
X-Greylist: delayed 34477 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 16:19:42 EDT
Received: from localhost (200116b86008d40055e599cb51dd17e8.dip.versatel-1u1.de [IPv6:2001:16b8:6008:d400:55e5:99cb:51dd:17e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 2055DC81D4;
        Wed, 11 Aug 2021 22:19:17 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
References: <20210811045727.2381-1-felipe.contreras@gmail.com> <20210811045727.2381-7-felipe.contreras@gmail.com> <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com> <xmqqzgto9dkd.fsf@gitster.g> <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
From:   Michael J Gruber <git@grubix.eu>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <162871314612.7067.6886805754107701040.git@grubix.eu>
Date:   Wed, 11 Aug 2021 22:19:06 +0200
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 2021-08-11 21:06:47:
> On Wed, Aug 11, 2021 at 09:00:18AM -0700, Junio C Hamano wrote:
> 
> > A more notable aspect of the above list is not the similarity but
> > difference from the rest of Git.  The above organizes various
> > operations on the staging area in a single command as its operating
> > modes, so you'd use "git stage --diff" for comparing with the
> > staging area but use something else ("git commit --diff HEAD"???).
> > 
> > It is a good example that illustrates that the proposed organization
> > may not help learning or using the system for operations that also
> > apply to other things like commit and working tree (in other words,
> > "git stage --grep" may not be such a good idea for the same reason
> > as "git stage --diff").  But if it were limited to operations that
> > apply only to the index (e.g. "git add" and "git rm"), it may be an
> > improvement (I think we added "git stage" synonym exactly for that
> > reason, already).
> 
> One thing I find off-putting about "git stage --diff" is that to me,
> "stage" reads as a verb. So it is like "git add --diff", which seems
> out-of-place; there are two verbs in a row.
> 
> I do not mind the term "staging area", but using "the stage" as a noun
> is simply confusing to me in this context.

I think this exemplifies what I meant by discussing things in order. The
concept "staging area" works in teaching and explaining things. But
that does not imply that a "stage command" is the best way to convey
that concept in the UI.

Formost, "staging area" is a conceptual item much like a "commit", a
"rev", a "reference", a "working tree" etc.

When it comes to the UI, I don't think we have any concept or guide
to decide what are verbs and nouns, what ends up as a command and what
as an option or argument. In particular: Do we say "git verb object" or
"git object verb"? Consequently, the status quo provides conflicting
examples to follow.

Take "git branch" and "git tag": Both use the term as a noun when they
list the refs (but in singular form) and as a verb when they create
them. The difference between "list" and "create" is indicated only by
the absence or presence of an argument. We are used to that, and it's
convenient, but it's certainly not good UI.

For other subcommands, they use options like "-m" etc.

"git remote", "git submodule" use arguments to indicate subcommands.

At least, they stay within their "realm" ("git branch" acting on branch
refs etc.).

The staging area/index is necessarily something that you not only "list"
or act on, but also compare to other items, or create other items from
(a commit). A very "non-verby" conceptual item, instead an "object" (in
linguistic terms).

Therefore, "git stage" as an alias to "git add" does not serve the purpose
of establishing "staging area" very well, and "git stage --diff" shows
exactly the problem with turning an "object-like item" into a "verb-like
command".

In fact: "It adds the current state of pathspec to the staging area" is
a perfect answer to the question: "What does git add pathspec do?"

I mean, so much of git is about operating on or comparing between three
different types of "sources": the working tree, the index, a treeish. A
lot of confusion comes from the fact that we hide this behind different
commands to act on them and different ways to specify these conceptual
items:
- You specify a treeish as an argument to a command.
- You specify the index as an option (--cached, --staged) or by choosing
  the right command.
- You specify the working tree as an option (--worktree) or by choosing
  the right command (checkout vs. reset) or number of options (diff).

Newer commands like "restore" try to help but fail badly when e.g. "restore
--staged" means you overwrite what is staged with something from a
treeish.

I still think it's very worthwhile to fantasize about a git which has
only verb-like commands (such as diff, add, checkout, checkin) and a
consistent way of specifying the objects to act upon (possibly amended
by "git pluralnoun" being synonymous to "git ls noun" or similar
convenience shortcuts).

Michael
