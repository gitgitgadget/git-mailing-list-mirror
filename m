From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-filter-branch: avoid collisions with variables in
	eval'ed commands
Date: Wed, 25 Mar 2009 22:24:03 +0100
Message-ID: <20090325212403.GU8940@machine.or.cz>
References: <1238015581-12801-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 25 22:26:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmac1-00014x-Ej
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbZCYVYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbZCYVYM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:24:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55067 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbZCYVYK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:24:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8E1261E4C02E; Wed, 25 Mar 2009 22:24:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238015581-12801-1-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114667>

On Wed, Mar 25, 2009 at 03:13:01PM -0600, newren@gmail.com wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Avoid using simple variable names like 'i', since user commands are eval'ed
> and may clash with and overwrite our values.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Almost-acked-by: Petr Baudis <pasky@suse.cz>

But:

>-i=0
>+git_filter_branch_count=0

Why branch_count? It counts commits, not branches, doesn't it?


> I discovered this a few months ago, but apparently never got around to
> sending it earlier.  Anyway, without this patch in a repository with a
> file called 'world' I see the following behavior:

Some hints:

> $ git filter-branch --tree-filter '
>    for i in $(find . -type f); do

This won't work right if your filenames contain $IFS.

>      if ( file $i | grep "\btext\b" > /dev/null ); then

if [[ "$(file $i)" == *text* ]] might run noticeably faster (though is
slightly less precise). Having a filename-keyed cache of file types even
more so.

>        perl -i -ple "s/\\\$(Id|Date|Source|Header|CVSHeader|Author|Revision):[^\
> \$]*\\$/\\$\1\\$/" $i;

Using '\'' instead of " could save you quite a few backslashes in net
count.

>      fi;
>    done ' -- --all

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
