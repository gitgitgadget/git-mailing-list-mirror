From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 18:15:23 +0100
Message-ID: <201103101815.23477.trast@student.ethz.ch>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:15:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxjSV-00067a-Qu
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 18:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab1CJRP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 12:15:26 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:58629 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab1CJRPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 12:15:25 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 18:15:13 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 18:15:23 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110310001017.GA24169@elie>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168835>

Jonathan Nieder wrote:
> Thanks for a pointer.  Some ideas still at the "throw them against the
> wall and see if they stick" stage: please feel free to add to the page
> if you think you can find subsets with the right scope.

Some stuff off the top of my head, please apply a similar filter:

* Word-based merge helper

  The existing merge algorithms are all tailored to line-based formats
  such as code.  Writing, e.g., LaTeX or even asciidoc requires
  sticking to a strict word-wrapped format.  Worse even, re-wrapping
  leads to headaches if people work on the same areas a lot, much like
  the effects of code reindents.

  Something similar was already proposed in 2010, IIRC by Dscho:

    https://git.wiki.kernel.org/index.php/SoC2010Ideas#Merge_helper_for_LaTeX_files

  One possible angle of attack given --word-diff=porcelain would be:

  1. Fix --word-diff to properly represent both sides of the diff at
     least optionally.  (It was observed in a list post some months
     ago that it doesn't even represent *one* side faithfully.)

  2. Use --word-diff=porcelain as input to some to-be-written merge
     algorithm.



* Clean up add -p

  git-add--interactive.perl became a bit of a mess.  Partly due to my
  own efforts with {checkout,stash,...} it has bolted-on interfaces to
  other commands.  There are some UI issues that simply fall out of
  its design, e.g., you cannot go back from one file to another,
  Ctrl-C stops applying to the current file but does not discard
  earlier files, etc.  And that's not saying anything about 'add -i'
  which I don't really know.

  This would probably not be a very fun project, but it could add a
  little edge of usability to the tool and it's probably one of the
  few pure-Perl ideas we can offer.



> 4. filter-branch killer: using fast-import's new features to implement
>    common filter-branch operations (--subdirectory-filter,
>    --prune-empty, obliterating certain files) faster.

I would phrase this as follows:

* fast-import-filter

  Implement a utility that can execute certain transformations to
  fast-import streams, such as:

  - delete or rename entire files/directories
  - split out subtrees
  - ...

  Ideally, this should be a thin command line interface around a set
  of primitives (such as a Perl package) that allow a competent
  scripter to go beyond the CLI.  (There have been threads on this.)

  Later on, make an interface that automatically does

    git fast-export | fast-import-filter | git fast-import

  with suitable options.  Nice because it should be largely orthogonal
  to everything except the fast-import stream format.

In addition, Jeff wrote:
> Yeah, I like that. Or maybe somebody can pick up git-sequencer, which in
> theory could be used to filter-branch, too (or maybe sequencer can go on
> top of fast-import? :) ).

I'd be interested to hear how that goes, because I think the tools are
fundamentally different.  The rebase and thus sequencer family is
delta-based, and the fast-import and filter-branch families are
tree-based.  Feel free to prove me wrong of course.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
