From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH] remove vim syntax highlighting in favor of upstream
Date: Thu, 25 Sep 2008 14:48:17 +0200
Message-ID: <20080925124817.GC6816@neumann>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>
	<20080924155745.GA3908@coredump.intra.peff.net>
	<20080924170154.GA6816@neumann>
	<20080924175315.GA10337@coredump.intra.peff.net>
	<20080924195658.GB6816@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, vim@tpope.info
X-From: git-owner@vger.kernel.org Thu Sep 25 14:50:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiqI9-000126-VG
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYIYMsU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 08:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYIYMsU
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:48:20 -0400
Received: from francis.fzi.de ([141.21.7.5]:33202 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751395AbYIYMsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:48:19 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 25 Sep 2008 14:48:17 +0200
Content-Disposition: inline
In-Reply-To: <20080924195658.GB6816@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 25 Sep 2008 12:48:17.0545 (UTC) FILETIME=[FB72E790:01C91F0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96757>

Hi,

OK, so I'm complaining a bit.

On Wed, Sep 24, 2008 at 09:56:58PM +0200, SZEDER G=E1bor wrote:
> +To install:
> +
> +  1. Copy these files to vim's syntax directory $HOME/.vim/syntax
> +  2. Auto-detect the editing of various git-related filetypes:
> +	$ cat >>$HOME/.vimrc <<'EOF'
> +	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
> +	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
> +	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
> +	autocmd BufNewFile,BufRead .msg.[0-9]*
> +		\ if getline(1) =3D~ '^From.*# This line is ignored.$' |
> +		\   setf gitsendemail |
> +		\ endif
> +	autocmd BufNewFile,BufRead *.git/**
> +		\ if getline(1) =3D~ '^\x\{40\}\>\|^ref: ' |
> +		\   setf git |
> +		\ endif
> +	EOF

There are issues with this second step.  If I append this code to my
=2Evimrc, then vim sometimes overrides the filetype with conf.

vim has a guessing rule for detecting conf files, which triggers if
one of the first five lines of the file begins with a '#'.  So if I
start to write a new commit message or I interactively rebase 4 or
less commits, then this rule triggers and vim overrides the git
filetype with filetype conf.  If I do a commit --amend with a long
enough original commit message or an interactive rebase with more than
4 commit, then this rule no more triggers and everything is fine.

But what's really puzzling is that if I insert the above code into
$VIMRUNTIME/filetype.vim (at the spot where it can be found in vim
7.2's filetype.vim), then everything works as expected, git filetypes
are never overridden.

This is not related to the changes in this patch.  git's original vim
syntax highlight for commit messages has the exact same behaviour.

The first step is OK: it doesn't matter whether I put git-related
syntax files under $HOME/.vim/syntax/ or under $VIMRUNTIME/syntax/.

I'm using vim 7.1.138 in Ubuntu 8.04.

Anyone have a clue?


Thanks,
G=E1bor
