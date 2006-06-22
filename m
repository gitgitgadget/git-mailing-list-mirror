From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually
 used.
Date: Thu, 22 Jun 2006 10:49:01 +0300
Message-ID: <20060622104901.f3543f07.tihirvon@gmail.com>
References: <0J1800MC1NKJD2C0@mxout2.netvision.net.il>
	<7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: iler.ml@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 09:49:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtJw7-0002Z3-Kn
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 09:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbWFVHtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 03:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWFVHtG
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 03:49:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:19276 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932828AbWFVHtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 03:49:05 -0400
Received: by nf-out-0910.google.com with SMTP id o60so234481nfa
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 00:49:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=L0r9SZXmXTXMBtRfkHmiP6Pv02EbhGrMlmPi6Y4085fgs5s/TBrLKb76S2713vg93SCupbMrVBvofEmFjTulJ6WOR/TfAHcnK/Kq69kwE2pOKcWVkDeyJZ9f8IQ18dHWTn3rPRUOAJB64qUOAycW/wgR1hYokIy2+5WSyVeUwDA=
Received: by 10.49.92.10 with SMTP id u10mr1331820nfl;
        Thu, 22 Jun 2006 00:49:03 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id l21sm1180245nfc.2006.06.22.00.49.03;
        Thu, 22 Jun 2006 00:49:03 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtb9veqv.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22307>

Junio C Hamano <junkio@cox.net> wrote:

> Yakov Lerner <iler.ml@gmail.com> writes:
> 
> > Before this patch, -DDEFAULT_GIT_TEMPLATE_DIR was passed on compilation
> > command line to all and every %c compiled. In fact the macro
> > is used by only one .c file, and unused by all other .c files.
> > Remove -DDEFAULT_GIT_TEMPLATE_DIR where unused. Follow the examlpe of 
> > exec_cmd.o. Pass -DDEFAULT_GIT_TEMPLATE_DIR only where actually used. 
> 
> Thanks.
> 
> By the way, I really started hating that we have $(GIT_VERSION)
> in $(TRACK_CFLAGS).  Since the version string is tied to the
> HEAD commit object name, having it in $(TRACK_CFLAGS) means that
> every time I switch branches, make a new commit on top of the
> current branch, or checkout-compile-and-then-make-local-change
> sequence would force pretty much everything to be rebuilt.

I think this already makes sure git is compiled if version changes:

# These can record GIT_VERSION
git$X git.spec \
        $(patsubst %.sh,%,$(SCRIPT_SH)) \
        $(patsubst %.perl,%,$(SCRIPT_PERL)) \
        $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
        : GIT-VERSION-FILE

$ git grep GIT_VERSION *.sh *.perl
git-send-email.perl:	my $gitversion = '@@GIT_VERSION@@';
git-send-email.perl:	if ($gitversion =~ m/..GIT_VERSION../) {

Only git-send-email and git needs to depend on GIT_VERSION.

> For that matter, I do not think tracking prefix_SQ makes much
> sense since what matters are bindir, gitexecdir and template_dir
> which are already covered, and prefix is merely a convenience to
> set these three (four, counting GIT_PYTHON_DIR; we probably
> should add it to TRACK_CFLAGS).

Yes, only ALL_CFLAGS, bindir, gitexecdir, template_dir and
GIT_PYTHON_DIR should be in TRACK_CFLAGS.

-- 
http://onion.dynserv.net/~timo/
