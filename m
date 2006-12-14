X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with
 an empty base
Date: Thu, 14 Dec 2006 14:44:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141436170.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org> 
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net>  <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
  <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 13:44:59 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34334>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuqtM-0006AX-Ba for gcvg-git@gmane.org; Thu, 14 Dec
 2006 14:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932720AbWLNNox (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 08:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWLNNox
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 08:44:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:50993 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932720AbWLNNow
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 08:44:52 -0500
Received: (qmail invoked by alias); 14 Dec 2006 13:44:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 14 Dec 2006 14:44:51 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Catalin Marinas wrote:

> On 13/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > xdl_merge(), as Git uses it, tries harder to find the true conflicts. So,
> > if the files actually differ in only one line, just this line will be
> > shown as conflict.
> 
> I gave the latest GIT a try and it works OK with StGIT.

Great!

> What it the relation between git-merge-recursive and "git-read-tree
> -m" (if any)?

git-merge-recursive internally calls the equivalent of 'git-read-tree -m' 
(it does not fork() and exec(), but rather calls the C functions 
directly) and does nothing more if the 'git-write-tree' succeeds. At least 
that's the theory...

If the git-write-tree does not succeed, it is because there are unmerged 
entries, and only then, merge-recursive does the rename detection and the 
file level merges.

> One nice addition to git-merge-recursive (probably only useful to
> StGIT) would be more meaningful labeling of the conflict regions,
> passed via a command line similar to the "diff3 -L" option. StGIT
> generates "patched", "current" and "ancestor" labels with diff3.

This is possible. However, it is not _that_ horrible to see "HEAD" and 
some SHA1 which is obviously non-HEAD. Added to that, a quite common case 
are the intermediate merges which make merge-recursive so powerful, and 
they are rightly called "Temporary branch 1" and "... 2".

> Yet another nice feature would be the ancestor region (which diff3
> doesn't add either but it gets added by emacs'
> ediff-merge-files-with-ancestor function if you use the interactive
> merge with StGIT).

Feasible, yes. But the code was written without that idea, so it would 
involve changes in the xdmerge_t structure (add i0, chg0), recording that 
in xdl_append_merge(), and passing also the base to 
xdl_fill_merge_buffer().

Is this really that nice? I never needed it... Besides, it can get really 
crappy when the conflicting regions are too large.

Ciao,
Dscho
