From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: "git ls-files -i" does not shows ignored files on Windows
Date: Wed, 27 May 2009 03:37:42 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh1pdc6.ojl.sitaramc@sitaramc.homelinux.net>
References: <85647ef50905261036u2d3c00c9lcf0df8f29de051ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 05:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M99xt-0002dj-E8
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 05:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756287AbZE0Dh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 23:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbZE0Dh4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 23:37:56 -0400
Received: from main.gmane.org ([80.91.229.2]:45606 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060AbZE0Dh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 23:37:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M99xk-0000JU-FB
	for git@vger.kernel.org; Wed, 27 May 2009 03:37:56 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 03:37:56 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 May 2009 03:37:56 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120023>

On 2009-05-26, Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> I have encountered a strange problem on Windows (cygwin git 1.6.1.2
> and msys git version 1.6.2.2.1669.g7eaf8).
>
> Lets execute the following sequence of commands:
>
> git init
> echo a >.gitignore
> echo test >a
> git ls-files -i --exclude-standard
>
> The last command in the sequence gives an empty output. But "git
> status" and "git ls-files -o --exclude-standard" show only
> ".gitignore" file as untracked. So the file "a" is considered as
> ignored by git, but it is not displayed in output "git ls-files -i
> --exclude-standard".
>
> Does the bug happen on other platforms and versions of git?

here's what works, after I used your 4 commands on an empty
directory.  Numbers in parens added for the purpose of this
email, the rest is a straight paste:

    $ git ls-files -i --exclude-standard -o (1)
    a
    $ git ls-files -o (2)
    .gitignore
    a
    $ git add a
    The following paths are ignored by one of your .gitignore
    files:
    a
    Use -f if you really want to add them.
    fatal: no files added
    $ git add -f a
    $ git ls-files -i --exclude-standard (3)
    a
    $

(1) your "a" is untracked right now, so ls-files seems to
consider it part of "other" files.

(2) and indeed, using just "-o" does show the file

(3) and when you forcibly add it, then you can see it with
your original command.

Yes, I agree it doesn't make too much sense.  I have long
had the following aliases in my gitconfig:

    ls-del  = ls-files -d
    ls-mod  = ls-files -m   # this will include deleted files also
    ls-new  = ls-files --exclude-standard -o
    ls-ign  = ls-files --exclude-standard -o -i

HTH and all that,

Sitaram
