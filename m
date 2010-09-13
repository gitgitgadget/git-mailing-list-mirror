From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Input welcome for "Git Bisect and Testing" presentation at GTAC 2010
Date: Mon, 13 Sep 2010 01:04:50 -0700
Message-ID: <AANLkTi=k-oUi0uT=ho9TdCyhKwV=wiW8nj6AWZA_9F7-@mail.gmail.com>
References: <201009122225.52520.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>, Andreas Ericsson <ae@op5.se>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 13 10:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov42V-0000en-8o
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542Ab0IMIFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:05:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41026 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab0IMIFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 04:05:12 -0400
Received: by wwb13 with SMTP id 13so3576903wwb.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=LdKSAf7vf1J4VqsgD4+T4q0MTzP3xZQuohjlTKiwc84=;
        b=P9+XSQ7FQJOFfhpFWVfYnLiffncJtTll9UoLs6TNNIEKZVqvx54R5GMLqHcHUOQypK
         ATc0nWltpw9Qe/v5o0zKWsd+Bw0YkF/fBQ7jRbmvvuxsvC09hkJbuPnN86pzc0Nijq6n
         NK1M8+PQJ3DzBcat3u/ZSgDh5UBvS6mV8ckpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ePewj2k6BCP7vUzOchRFPT8+vI5W8M7U2SJTAybZD+zc4zpJkKJj8iiOKNKUC4ejTj
         YKYM9Cu6oMac2uQDIk40TJibEnBAXAd96/0zo1/nn/lWvBP06ig+dtPpHKp199mz7Tv1
         ntFj5Mp2/kkjHeDMjU3vhKfpiF7sQCrLJrTiQ=
Received: by 10.216.67.66 with SMTP id i44mr2276934wed.53.1284365110421; Mon,
 13 Sep 2010 01:05:10 -0700 (PDT)
Received: by 10.216.49.72 with HTTP; Mon, 13 Sep 2010 01:04:50 -0700 (PDT)
In-Reply-To: <201009122225.52520.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156072>

On Sun, Sep 12, 2010 at 1:25 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> For example it can be how "git bisect run" is used automatically in build
> systems, or how "git bisect" is used manually on GUI applications in your
> company, or how you use Avery Pennarun's "git-builder" (http://github.com/apenwarr/gitbuilder, it uses "git bisect"
> underneath), or what features you would want to see added, or what have been
> your experience with it, and so on.

Ha, when I saw my name in the (very short) cc: list, I was wondering
why I was being included explicitly here.  Thanks for reminding me
that I wrote gitbuilder and it uses git-bisect :)  It's interesting in
that it has quite a few followers on github, but I don't get any
feedback about it.  (I assume either it Just Works or it Just Doesn't
Work :))

Since you asked, here are some passing comments about git-bisect
and/or gitbuilder:

- for most smallish projects, doing 'git bisect' by hand (especially
'git bisect run') gives you the most instant gratification and is the
easiest way to find where you introduced an error.  gitbuilder takes
longer and is thus less interesting.

- for bisect to be useful, you really need to be careful to commit
things in logical chunks and to make sure each commit *works*.  I've
noticed that people do their commits totally differently when they
are/aren't thinking about future bisections.  That means bisect is a
bit of an "artificial" construct: you can't just bisect your way
through just *any* source tree and get useful results, because in many
commercial projects (at least), most commits don't even run.  Sad, but
true.  So you really need to train developers to think seriously about
making their commits small, atomic, and non-broken before pushing.

- gitbuilder, conversely, is more useful for very large projects with
extensive test suites.  For example, at work we have a project that
takes about an hour to build from scratch and run through all the
tests. Bisecting this sort of project by hand is a huge pain.  In
fact, even running the automated tests before committing is a lot to
ask - and people often don't do it.  Thus, having a system that
*automatically* grinds away at releases and pinpoints the sources of
error can be very valuable.

- Because gitbuilder builds all your branches from multiple
repositories automatically, failing the gitbuilder test doesn't have
to be an embarrassment because it doesn't have to hurt anybody but
yourself; if it catches a failure, just rebase your branch and get it
turning green before committing to mainline.  gitbuilder has been
instrumental in a) helping get our internal development projects to
zero unit test failures in the mainline at all times, and b) making it
easy to decide which branches are ready to merge and which aren't, and
c) knowing who to complain to when a problem is introduced even so.

- gitbuilder uses git-bisect (actually git rev-list --bisect) in a
peculiar way: with --first-parent.  This is on purpose, although you
have to think carefully about your workflow in order to benefit from
it.  There are two advantages to doing it this way: 1) the gitbuilder
status display makes way more sense to normal people because it can
just show a linear sequence of commits; 2) to a maintainer, merges
into the mainline are an all-or-nothing sort of thing.  If I merged in
a branch and it started failing, then I don't want to bisect it, I
want to complain to the person whose branch I merged in.  And that
person's branch should *already* be built by gitbuilder and bisected
away, so he should have no trouble tracing it by looking at the
gitbuilder stats for his own branch.  So far, users here have found
this way of thinking about the bisection to be pretty easy to
understand, much more so than git's rather mind-melting DAG graphs
that you might get from things like 'git bisect visualize'.  It's also
pretty resilient against people who make frequent non-working commits
in their side branches; the mainline maintainer never has to worry
about "accidentally" bisecting into them, which removes the need for
things like 'git bisect skip'.  I've never much trusted 'git bisect
skip', though now that it's pseudorandom it supposedly works better
than it once did, so maybe I should adjust my opinion.

I'm sorry I'll miss meeting you and/or seeing your presentation at
GitTogether.  Have fun in India!

Have fun,

Avery
