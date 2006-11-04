X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 18:52:23 +0100
Message-ID: <200611041852.23867.Josef.Weidendorfer@gmx.de>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <20061103162422.b0bf105e.seanlkml@sympatico.ca> <20061104050305.GA9003@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 4 Nov 2006 17:52:39 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061104050305.GA9003@spearce.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30931>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgPh2-0001mQ-CR for gcvg-git@gmane.org; Sat, 04 Nov
 2006 18:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965572AbWKDRw3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 12:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965573AbWKDRw3
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 12:52:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:50654 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S965572AbWKDRw3 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 12:52:29 -0500
Received: (qmail invoked by alias); 04 Nov 2006 17:52:26 -0000
Received: from p5496B6C7.dip0.t-ipconnect.de (EHLO noname) [84.150.182.199]
 by mail.gmx.net (mp020) with SMTP; 04 Nov 2006 18:52:26 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Saturday 04 November 2006 06:03, Shawn Pearce wrote:
> After reading your reply you are probably correct.  I can see there
> may be workflows that want every remote branch also created as a
> local branch.
> 
> I could certainly live with a command line option to clone, e.g.:
> 
> 	git clone --only vmdvt,vmtip user@host:/path...

Still missing here: What branch should be checked out after
cloning?

Perhaps it is better to extend git-checkout to allow to do the
correct thing when the user specifies a read-only branch from
refs/remotes. E.g. with refs/remotes/origin/vmdvt,

 	git checkout origin/vmdvt

should create a new local branch refs/heads/vmdvt which forks
from remotes/origin/vmdvt (and abort with
error if refs/heads/vmdvt already exists without being the local
development branch for remotes/origin/vmdvt), add to .git/config

[branch "vmdvt"]
	remote = origin
	merge = remotes/origin/vmdvt

and switch to this new created branch.

Given this addition to git-checkout, the implicit default
action after cloning with --use-separate-remote should be

	git checkout origin/master

where "master" can be changed on the git-clone command line
to another branch, e.g. "--checkout vmdvt".

IMHO, this addition to git-checkout would make it a lot
easier to work with --use-separate-remote, as there,
every branch other the master is read-only.

And if you have two remote repositories with a master branch
each, and you want to develop locally on both, this could
be accomplished with

	git checkout -b othermaster remotes/otherrepo/master

