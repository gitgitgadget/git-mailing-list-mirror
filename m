From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 01:21:31 +0100
Organization: At home
Message-ID: <etptkp$2uo$1@sea.gmane.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 01:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HToXm-0005eY-9D
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 01:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXCUATE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbXCUATE
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 20:19:04 -0400
Received: from main.gmane.org ([80.91.229.2]:51014 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbXCUATB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 20:19:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HToXS-00079d-K4
	for git@vger.kernel.org; Wed, 21 Mar 2007 01:18:50 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:18:50 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 01:18:50 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42768>

John Goerzen wrote:

> I've read the FAQ and Linus' philosophy on this topic, and have some
> questions still.  I'm considering using Git and its philosophy on
> renames is troubling me.
> 
> My use for version control presently has most changes being written and
> committed by me directly, with occasional patches coming in from random
> others.  As such, running something like 'git mv' when a rename occurs
> is not a problem.
> 
> My main concerns with Git are:
> 
> 1) git log does not show complete history of files that have been
>    renamed or copied.
> 
>    If I have foo.txt, and rename it to bar.txt, the liberal use of -M
>    can tease out a proper patch from a number of places.  But
>    git log bar.txt, with any set of options I can possibly come up with,
>    absolutely refuses to show me the history of bar.txt before it was
>    renamed to bar.txt.  git log foo.txt also does not show me the old
>    history for the file.

That is because "bar.txt" in "git log bar.txt" is not file name to show
history of, but path limiter (BTW. it is not output filter, as it also
simplifies history). And you can say for example "git log Documentation/"
which I guess is not available in any other SCM beside Git.

There were at least two attempts to provide a kind of --follow=<filename>
to the git-log family of commands, to track/show history of a given file
across renames. See "Why does git not track renames?" entry in GitFaq
(http://git.or.cz/gitwiki/GitFaq) for some history; lately Linus has
send prototype of blame engine based implementation of --follow option.

> 2) For me, a rename is a logical change to the source tree that I want
>    to be recorded with absolute certainty, not guessed about later.
>    Sometimes I may make API changes and it is useful to see how module
>    names changed, with complete precision, later.  I do not want to be
>    victim to an incorrect guess, which could be possible.

This is much against Git philosophy of "tracking contents", although there
was talk allowing recording some optional _helper_ information about file
renames, in the proposed 'note' field (header) in commits, but it never
materialized.

You can always say that there was rename (or that file was split into two,
or that file was refactores) in the commit message.

Besides, the place where you want renames detection to work is during
merge. I don't know what would happen if merge base is so far back that
git doesn't recognize rename; on the other hand you get huge conflict
to resolve anyway.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
