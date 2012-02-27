From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 0/2] submodules: Use relative paths to
 gitdir and work tree
Date: Mon, 27 Feb 2012 15:41:52 -0600 (CST)
Message-ID: <alpine.DEB.1.00.1202271538230.3340@s15462909.onlinehome-server.info>
References: <4F32F252.7050105@web.de> <4F4A6DFA.5080709@kdbg.org> <4F4A8EF2.3020901@web.de> <4F4BF357.8020407@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 22:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S28KV-00029p-FM
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 22:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab2B0Vly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 16:41:54 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:40800 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755017Ab2B0Vly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 16:41:54 -0500
Received: (qmail invoked by alias); 27 Feb 2012 21:41:52 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp070) with SMTP; 27 Feb 2012 22:41:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wVJtN/3Bw6IbuUjRBtth1HZ8m0ZU5wXFD8F6IwL
	WttciEDtQ9un3i
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <4F4BF357.8020407@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191678>

Hi,

On Mon, 27 Feb 2012, Johannes Sixt wrote:

> Am 26.02.2012 20:58, schrieb Jens Lehmann:
> 
> > -       gitdir=$(git rev-parse --git-dir)
> > +       gitdir=$(git rev-parse --git-dir | sed -e 's,^\([a-z]\):/,/\1/,')
> 
> I don't like pipelines of this kind because they fork yet another
> process. But it looks like there are not that many alternatives...

Not many, but some rather straight-forward ones. E.g.

	# quoted to preserve tabs & newslines (Windows users are creative)
	gitdir="$(git rev-parse --git-dir)"
	case "$gitdir" in
	[A-Za-z]:*)
		gitdir="/${gitdir%%:*}${gitdir#?:}"
		;;
	esac

Note: untested.

Note2: I did not add error handling, either.

Note3: yes, ${...} is available in bash and it does not fork. Neither does
       case ... esac

Ciao,
Johannes
