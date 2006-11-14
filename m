X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: when is a remote a branch?
Date: Tue, 14 Nov 2006 21:28:35 +0100
Message-ID: <20061114202835.GJ7201@pasky.or.cz>
References: <ej7fra$8ca$2@sea.gmane.org> <ej7h1n$ed8$1@sea.gmane.org> <20061112163624.GE7201@pasky.or.cz> <200611121831.18851.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 20:29:14 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611121831.18851.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31369>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk4tc-0007Sk-Nz for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966322AbWKNU2h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966326AbWKNU2h
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:28:37 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47020 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966322AbWKNU2g (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:28:36 -0500
Received: (qmail 17420 invoked by uid 2001); 14 Nov 2006 21:28:35 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Nov 12, 2006 at 06:31:18PM CET, Jakub Narebski wrote:
> Petr "Pasky" Baudis wrote:
> > Git and Cogito share the same models of branches. These branches are
> > 'heads' with commit pointers stored in refs/heads/, etc. 
> 
> Not exactly. "Live" branches (i.e. branches you can commit to) are head
> refs stored in refs/heads/. But in repository cloned with git-clone
> --use-separate-remotes tracking heads (tracking branches) would be at
> refs/remotes/<remotename>/. You can fetch to such a ref, but you can't
> checkout it, nor commit to it.

That was meant to be the "etc". ;-))

> > The branches/ 
> > directory says that some branches do not correspond to local development
> > (and should never be used for that) but instead they correspond to a
> Does that _should_ is enforced in Cogito? Is it enforced in Git?

Yes (you cannot switch to it). No (AFAIK).

> > particular branch in some remote repository. Such branches are called
> > "REMOTE BRANCHES".
> 
> I'd rather call them "tracking branches", at least in git. So if there
> is branch 'localbranch' in refs/heads/ (?), and there is corresponding
> branches file branches/localbranch, which contains a single URL
>   git://host.domain/path/to/repository#remotebranch
> it is AFAICU equivalent to having some remotes file, named e.g. 'repo',
> with the following contents:
>   URL: git://host.domain/path/to/repository
>   Pull: remotebranch:localbranch
>   Push: remotebranch:localbranch
> or equivalent entry in git config.

Yes, except that the remote must be named 'localbranch'.

> > So it's "if branch X has corresponding .git/branch/X file, it's not a
> > local branch but instead a REMOTE BRANCH corresponding to the URL stored
> > in that file". That simple. The URL is address of the repository plus
> > optionally a '#branchname' if the branch name in the remote repository
> > should not default to remote HEAD or master.
> 
> The whole concept of branches file (and marking some branches as "remote"
> branches) is IMHO from the times where there were most common to have one
> live branch per repository, and we fetched and pushed single branches.
> This simple picture changed with more widespread use of multiple heads,
> and with the introduction of tags (I think).

I completely agree. The original remotes implementation was messy, but
with refs/remotes/ it's simple again. Only lack of time (or laziness) on
my side is why Cogito didn't move to this yet.

> By the way, with introduction of branches and remotes in config file,
> you can say:
>  [branch "localbranch"]
> 	remote = someremote
>  [remote "someremote"]
> 	fetch = remotebranch:localbranch
> 	push  = remotebranch:localbranch
> 
> and that would be equivalent to example branches file from the beginning
> of this email.

According to the documentation, this is not really useful since this
just tells what should git fetch default to when on branch
"localbranch". But "localbranch" is still just a branch representing a
state in a remote repository, so you should never be _on_ it in a sane
setup, but instead on a different branch which tracks it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
