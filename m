From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Wrap up of Line Level History Browser [long]
Date: Sun, 22 Aug 2010 22:47:45 +0200
Message-ID: <201008222247.45600.trast@student.ethz.ch>
References: <AANLkTikORUbVA+AJNT-Z1d+KJ-j1xxRdBN4hzLuXBXX5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, <david@lang.hm>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 22:48:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHT9-0005xC-95
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 22:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0HVUsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 16:48:16 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:12124 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab0HVUsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 16:48:15 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 22 Aug
 2010 22:48:13 +0200
Received: from thomas.site (129.132.208.152) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 22 Aug
 2010 22:47:52 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTikORUbVA+AJNT-Z1d+KJ-j1xxRdBN4hzLuXBXX5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154190>

Hi Bo, *

As a brief introduction to people who haven't been following, and
partially answering an earlier question in another thread:

David Lang wrote:
> what is this series?
> 
> this is all good incramental information, but there's no info indicating 
> what this is updating.

For me it replaces a manual iterative process to find out in what ways
a function was patched until it came to have its current shape:

  git-blame the area, find the most recent commit C
  while 1:
    git show C
    if that explains the code: break
    git-blame the area in C^
    find the most recent commit and call it C again

I do this a lot when a particular section of code puzzles me or seems
buggy, to see if any commit message provides a reason for it.  I think
(but I never got good with it) the "blame parent" feature of 'git gui
blame' covers a similar use-case.

All of this can now be replaced by a simple

  git log -L <range> <filename>

A good example that I did a lot of testing with:

  git log --graph be58e70d^ -L /builtin_funcname_pattern/,/^}/ diff.c

Try it.  I can follow up with more examples if you're interested, but
it's much more fun if you're actually looking for some explanations.


As for the project: First off, many thanks Bo for all the work you put
into it.  I think you planned and executed this project very well.
There were some minor changes to the original drafts, but comparing
the feature list from the project proposal (this is only an abstract,
the real list was much longer):

} 1. Line-history (main work :-)
} 2. -M/-C support
} 3. Configurable context
} 4. -C -C support
} 5. Fuzzy matching for -M/-C
} 6. Configurable display (--graph)
} 7. Machine-readable output (--porcelain)
} 8. Support git-log options where possible

with the feature list you posted

Bo Yang wrote:
> And now, we have supports in detail:
> 1. 'git log -L' can trace multiple ranges from multiple files;
> 2. we support the same syntax with 'git blame' '-L' options;
> 3. we integrate the 'git log -L' with '--graph' options with
> parent-rewriting to make the history looks better and clear;
> 4. move/copy detect is in its half way. We get a nearly workable
> version of it, and now it is in a phrase of refactor, so in the scope
> of GSoC, move/copy detect only partly complete.

we see that while there's still some work to be done in the -C -C
area, most of the features are there.  The ones that didn't make it
are 5 (fuzzy matching) and to some extent 3 (context control; there is
--full-line-diff).  We agreed to drop 7 (--porcelain) in private
conversation when we found out that gitk is already halfway ready to
read --format=full output.  Combined-diff style output for merges was
also added to the list sometime in summer, then dropped again because
of time constraints.


Next, thanks also to Jens who co-mentored.  Things went very smooth
despite my roughly 4 weeks of absence during the GSoC months thanks to
his efforts.


Finally, I'd like to outline some of my dreams^Wfuture directions for
this feature.  Some of them have been promised by Bo privately, but
let's not put any pressure on him now that the project is officially
over.

* Support in gitk to read --format=full output (within some
  constraints maybe), thus letting us see the output more
  conveniently.

* Support in gitk to parse the -L option and pass it to the right
  git-log invocation.

* Combined-diff style output for merges.

* As Junio has suggested in a thread about the option parsing, it
  should be possible to extend this to scan history both ways, i.e.,
  "I have lines 11-19 in commit abcdef, explain how they came and
  where they went".


I think that's all for today, thanks for reading so much text.

Regards

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
