Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85031F955
	for <e@80x24.org>; Fri, 29 Jul 2016 12:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbcG2MpE (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 08:45:04 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:57359 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbcG2MpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 08:45:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id EEFA64630F2;
	Fri, 29 Jul 2016 13:44:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QqXF+QX9NDo; Fri, 29 Jul 2016 13:44:58 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id C9045462ED8;
	Fri, 29 Jul 2016 13:44:57 +0100 (BST)
Date:	Fri, 29 Jul 2016 13:44:44 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160729124443.GA3686@salo>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <20160729110426.GA2945@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160729110426.GA2945@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 04:04:26AM -0700, Josh Triplett wrote:
[snip]
> 
> These definitely seem like a family of related problems.  I'd like to
> use git-series as a format for storing iterations on things like GitHub
> pull-requests or Gerrit patch versions (in the latter case, overcoming
> Gerrit's limitations on only handling one patch at a time).  Integrating
> reviews with that seems helpful.

Worth noting here that Gerrit's one patch per change format isn't
intrinsic to Notedb, since we just need to track the sha we want
to merge and optionally the branch we intend to merge into.

> 
> > The prototype library I have is partly the result of some discussion and work
> > with the Gerrit folks, since they were thinking about this problem
> > before I even started writing git-candidate, and solved it with Notedb.[5]
> > 
> > Let me know if you'd like to work together on this,
> 
> I'd love to.
> 
> I'll be presenting git-series at LinuxCon North America; will you be
> there by any chance?  If not, perhaps we could meet by IRC or some other
> medium and talk about this family of problems.

Cool :)

I didn't plan to be at LinuxCon North America,
but I can certainly send contact details out of band.

> 
> I hope to use git notes with git-series in the future, by putting
> another gitlink under the git-series for notes related to the series.
> I'd intended that for more persistent notes; putting them in the series
> solves some of the problems related to notes refs, pushing/pulling, and
> collaboration.  Using notes for review comments makes sense as well,
> whether in a series or in a separate ref.

Sounds interesting, can you explain how this works in more detail?
I ended up solving the push/pull issue with a custom merge driver
that effectively runs the Notedb parser on each side of the merge
and emits the union of the two sets of change notes.

> 
> > I've been considering taking the perl-notedb prototype and writing
> > a C library for it with bindings for other languages (i.e. Rust).
> 
> A C library based on libgit2 seems like a good idea; ideally the
> bindings could interoperate with git2-rs.  (Alternatively, Rust can
> *export* a C interface, so you could write directly with git2-rs. :) )

Certainly a fair alternative, though it may arguably be safer to write
the C and export to other languages, as cool as Rust looks it's not
established the way C is, so may be a slightly riskier foundation,
in my view.

And ofcourse in C we have native access to libgit2.

> 
> One of the items on my long-term TODO list is a completely federated
> GitHub; I've been looking at other aspects of that, but federated
> reviews/comments/etc seem critical to that as well.
> 

I agree.
