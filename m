From: Hannu Koivisto <azure@iki.fi>
Subject: Re: CRLF support bugs
Date: Mon, 03 Nov 2008 17:25:18 +0200
Organization: NOYB
Message-ID: <83skq8al29.fsf@kalahari.s2.org>
References: <83od0yaxzk.fsf@kalahari.s2.org>
	<20081103090932.GA18424@coredump.intra.peff.net>
	<83y700alzf.fsf_-_@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 16:26:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx1KH-0005ni-7M
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 16:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYKCPZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbYKCPZa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 10:25:30 -0500
Received: from main.gmane.org ([80.91.229.2]:33016 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbYKCPZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 10:25:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kx1J0-0006SL-9p
	for git@vger.kernel.org; Mon, 03 Nov 2008 15:25:26 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 15:25:26 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 15:25:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:iQ/h+ryU8Cu8eqO9jCvg2RFBaLs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99953>

Hannu Koivisto <azure@iki.fi> writes:

> Actually, even if .gitattributes were applied in checkout, I think
> the whole CRLF support is broken by design because people will have
> to remember to use -n in clone, then enable core.autocrlf support
> and then checkout.  This makes it unneccessarily complicated to

I forgot one thing: so what if someone forgets to use -n or just
imagines that you can set core.autocrlf afterwards?

# Pretend someone does this on Unix
mkdir test1
cd test1
git init
echo "*.c crlf" > .gitattributes
echo -e "foo\nfoo\nfoo" > kala.c
git add .gitattributes kala.c
git commit -m "Initial checkin."
cd ..
# Pretend test1 is not a local repository and someone else does this on Windows
git clone test1 test2
cd test2
git config core.autocrlf true
git status

# On branch master
nothing to commit (working directory clean)

Now the user would have to know that even though git status claims
everything is ok, that is not the case.  The user would have to
know to say (according to #git):

rm .git/index
git reset --hard

Just for the record, when I started to learn git, one of the first
questions I had was "how do I undo checkout?"  It wasn't until now
that I learned I need to remove .git/index (in addition to all
files).

-- 
Hannu
