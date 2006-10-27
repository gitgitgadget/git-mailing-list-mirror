X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Creating new repos
Date: Fri, 27 Oct 2006 14:39:18 +0200
Message-ID: <20061027123918.GB20017@pasky.or.cz>
References: <200610271229.k9RCTARu016773@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 12:40:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200610271229.k9RCTARu016773@laptop13.inf.utfsm.cl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30326>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdQzi-0003z4-LD for gcvg-git@gmane.org; Fri, 27 Oct
 2006 14:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750864AbWJ0MjV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 08:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWJ0MjU
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 08:39:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49620 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1750800AbWJ0MjU (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 08:39:20 -0400
Received: (qmail 2220 invoked by uid 2001); 27 Oct 2006 14:39:18 +0200
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Oct 27, 2006 at 02:29:10PM CEST, I got a letter
where "Horst H. von Brand" <vonbrand@inf.utfsm.cl> said that...
> I'm trying to set up git repos for remote access here. I set up git-daemon
> and got it working (some older repositories do work fine), but now:
> 
>   $ mkdir /var/scm/user/SomeRepo.git
>   $ cd /var/scm/user/SomeRepo.git
>   $ git --bare init-db
>   $ touch git-daemon-export-ok
> 
> All OK, but then, from a remote machine:
> 
>   $ git clone git://git-server/user/SomeRepo.git
>   fatal: no matching remote head
>   fetch-pack from 'git://git-server/user/Test.git' failed.
> 
> The empty repo created by init-db should be cloneable, so as to get the ball
> rolling easily.

Well there's really nothing to clone, so it's tough. :-) What would such
a clone be supposed to do? It has no branches to record as belonging to
origin, and note that Git's git-clone is long-term broken in the sense
that it won't pick new branches as they appear in the remote
repository. So a clone of an empty repository would be useless anyway.

> You can't push into such an empty repository either.

This is supposed to work. What error do you get?

> Any suggestion of how to set up a server into which users can create their
> own repos /without/ giving out full shell accounts?

Sure:

	http://repo.or.cz/w/repo.git

But it may be quite an overkill for you. ;-)

If you want them to be able to do it over ssh, you would need to provide
a trusted tool which would manage the repository setup, that means not
only doing init-db, but also managing the export-ok files, description
file, you'd likely want to enable the post-update hook (but probably not
any other hook or let the user edit it since at that point you've given
him full shell access), etc. And the tool would have to be carefully
reviewed since it's security-critical.

> Also, the behaviour of git-daemon is different when using git or ssh+git,
> you need to give the full path for the later but not the former (given
> --base-path=/var/scm):
> 
>   git://git-server/user/Test.git
>   ssh+git://git-server/var/scm/user/Test.git
> 
> Is this intentional?

git+ssh has nothing to do with git-daemon, it's executing other git
commands remotely.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
