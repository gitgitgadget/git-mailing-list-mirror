From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Tue, 06 May 2008 23:29:07 +0100
Message-ID: <4820DBB3.8020009@ramsay1.demon.co.uk>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172553.GC23747@sigill.intra.peff.net> <481CA227.1000801@ramsay1.demon.co.uk> <20080504192332.GB13029@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 00:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtVnO-0004Dw-7A
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 00:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760402AbYEFWhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759919AbYEFWhM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 18:37:12 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:38091 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754729AbYEFWhK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 18:37:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1JtVmU-0003Tl-O9; Tue, 06 May 2008 22:37:07 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20080504192332.GB13029@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81384>

Jeff King wrote:
> On Sat, May 03, 2008 at 06:34:31PM +0100, Ramsay Jones wrote:
>>
>> The git command issued by gitk appears to be:
>>    git diff-tree -r -p -C --no-commit-id -U3 1d6aeb410dc19893adbc0209bcf859f35ff1c7d6
> 
> Hrm. Is gitk on cygwin somehow squishing stderr and stdout together? Or
> does gitk in general look at what happens on stderr?

maybe. After further testing, the above "git diff-tree..." does indeed issue the
warning on stderr; on both cygwin and Linux.

[I forgot to type ./git-diff-tree as I had not installed the new git yet, since
it does not pass "make test".  That is a different problem for another day...]

It appears that gitk on Linux is quite happy with that message on stderr, but on
cygwin it chokes.

> 
> Because while I am happy that removing this message fixes your problem,
> it is a little disconcerting to think that we can break gitk just by
> issuing a warning diagnostic on stderr.

Indeed.

Also note that the warning is issued twice, since gitk issues that same
command twice; viz:

    $ GIT_TRACE=/home/ramsay/git-trace gitk --all & # exit asap
    $ cat /home/ramsay/git-trace
    trace: built-in: git 'config' '--get' 'i18n.commitencoding'
    trace: built-in: git 'rev-parse' '--git-dir'
    trace: built-in: git 'rev-parse' '--no-revs' '--no-flags' '--all'
    trace: built-in: git 'rev-parse' '--is-inside-work-tree'
    trace: built-in: git 'show-ref' '-d'
    trace: built-in: git 'symbolic-ref' 'HEAD'
    trace: built-in: git 'log' '--no-color' '-z' '--pretty=raw' '--topo-order' '--parents' '--boundary' '--all' '--'
    trace: built-in: git 'diff-index' '--cached' 'HEAD'
    trace: built-in: git 'rev-parse' '--git-dir'
    trace: built-in: git 'diff-tree' '-r' '--no-commit-id' '1d6aeb410dc19893adbc0209bcf859f35ff1c7d6'
    trace: built-in: git 'diff-files'
    trace: built-in: git 'diff-tree' '-r' '-p' '-C' '--no-commit-id' '-U3' '1d6aeb410dc19893adbc0209bcf859f35ff1c7d6'
    trace: built-in: git 'diff-tree' '-r' '-p' '-C' '--no-commit-id' '-U3' '1d6aeb410dc19893adbc0209bcf859f35ff1c7d6'
    $

NOTE: I get exactly the same trace on Linux and cygwin.

As a quick-fix, I added a "-l300" parameter to the above git command in ~/bin/gitk.
[diff.renamelimit only affects git-diff]

All the Best,

Ramsay Jones
