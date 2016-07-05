Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5226220706
	for <e@80x24.org>; Tue,  5 Jul 2016 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbcGESJZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 14:09:25 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:46815 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcGESJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 14:09:24 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u65I9IeG014517;
	Tue, 5 Jul 2016 21:09:19 +0300
Date:	Tue, 5 Jul 2016 21:09:18 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	kpaxton@paxdesigns.com
Cc:	git@vger.kernel.org
Subject: Re: Dependencies required for offline installation
Message-Id: <20160705210918.6dc556b42037386aeea55d42@domain007.com>
In-Reply-To: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
References: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, 5 Jul 2016 07:45:12 -0400
Kevin Paxton <kpaxton@paxdesigns.com> wrote:

> I’m looking to install git on a separate network that is running
> Redhat 5.5. I need to know what is the list of packages that I need to
> download to be able to install git-all? I plan on using git-svn to
> migrate an existing svn repo over to git as well. Svn version we have
> installed is 1.9.3.
> 
> Does the tarball contain all dependencies already?

No, it does not.  It depends on a few of external libraries (and
software packages) -- check it out yourself at [1].

It should be noted though that this list is not fixed.
IIUC the only hard dependency is zlib and all the other stuff is
optional.  SSH transport is implemented by calling an OpenSSH (or
compatible) client program, so this is a soft dependency.

Note that in your case you will need to have Perl 5.8+ because it's
used by the git-svn implementation, and that will use the Perl bindings
for Subversion (which, in turn, depend on both Perl and libsvn).
You'll need to have that stuff available and installed as well.

> Should I go that route?
> Or should I try and find all the rpm's required?

It's hard to tell.

RH 5.5 appears to be really really old so it's unlikely you'll find
official RPMs for recent Git versions.  You might try to look them up
in unofficial 3rd-party repos maintained by those who need to support
outdated systems.

This might get further complicated by the fact you appear to have
non-standard Subversion package (too fresh for RH 5.5 IMO).

Failing that, I'd have a VM running RH 5.5 and tried to build a set of
RPMs against the software packages you have deployed on the target
system.  The RPM specs can be grabbed from any up-to-date Redhatoid
system and backported.

1. https://github.com/git/git/blob/master/INSTALL
