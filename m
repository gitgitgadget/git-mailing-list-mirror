From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 15:06:18 -0700
Message-ID: <7vll3uh76t.fsf@assigned-by-dhcp.cox.net>
References: <20050725213456.23910.qmail@web26310.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:07:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxB5d-0002Pv-TN
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 00:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVGYWGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 18:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVGYWGV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 18:06:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:728 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261184AbVGYWGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 18:06:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725220613.EDNE16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 18:06:13 -0400
To: Marco Costalba <mcostalba@yahoo.it>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

> This cumulative effect brakes local scoping of .gitignore files in 
> corresponding subdirectory.
>
> As example in a directory A we can have a .gitignore file with
>
> !foo.html
> *.html
>
> because we want to special case 'that' foo.html in 'that'
> directory.

I guess that !foo.html I wrote was a bad example of special case
not being specific enough.  Saying "!/foo.html" should work
[*1*], so I think "cumulative effect _breaks_" is a bit too strong
a word.

Having said that,...

> This can be powerful and flexible but also prone to errors. 

While I also suspect it _might_ be prone to user errors, at
least to some classes of users, Catalin (and Peter as well I
suspect, although I may be mistaken by what he originally meant
by "cumulative") seems to think it is OK.  As a developer of
another Porcelain (qgit), your input is as valuable as others,
so...

BTW, I am CC'ing git list because I saw you forwarded your
entire message to the list as a quoted message form.  Please do
not do that.  I cannot distinguish a message like that with a
message with nothing but quote and no original contents, which I
normally discard without even reading.

[Footnote]

*1* I just tried, and it seems to work.

  $ rm -f .gitignore ppc/.gitignore
  $ (echo '!/foo.bar'; echo '*.bar') >.gitignore
  $ for i in foo.bar baz.bar; do date >$i; date >ppc/$i; done
  $ git-ls-files --others --exclude-per-directory=.gitignore | grep '\.bar'
  foo.bar
  $ rm -f .gitignore ppc/.gitignore
