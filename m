X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with
 an empty base
Date: Thu, 14 Dec 2006 00:48:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207101707.GA19139@spearce.org> 
 <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 23:48:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34262>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudpm-0003Y8-9L for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751762AbWLMXsI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWLMXsI
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:48:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54287 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751663AbWLMXsF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:48:05 -0500
Received: (qmail invoked by alias); 13 Dec 2006 23:48:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 14 Dec 2006 00:48:04 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Catalin Marinas wrote:

> On 13/12/06, Junio C Hamano <junkio@cox.net> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Unify the handling for cases C (add/add) and D (modify/modify).
> > >
> > >       On Tue, 12 Dec 2006, Junio C Hamano wrote:
> > >
> > >       > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >       >
> > >       > > How about this: if there is an add/add conflict, we treat it
> > >       > > as if there _was_ an empty file, and we let the shiny new
> > >       > > xdl_merge() find the _true_ conflicts, _instead of_ removing
> > >       > > the file from the index, adding both files with different
> > >       > > "~blabla" markers appended to their file names to the working
> > >       > > directory.
> 
> What is this new xdl_merge()? Is it a better replacement for diff3? In 
> this situation diff3 would actually show two confict parts, each of them 
> being the full file, with an empty ancestor.

xdl_merge(), as Git uses it, tries harder to find the true conflicts. So, 
if the files actually differ in only one line, just this line will be 
shown as conflict.

There is a flag passed to xdl_merge(), which tells it how hard it should 
try to make sense of the conflict. We use the "zealous" option, which is 
most accurate, but also slowest (although I have no numbers).

> > This fixes the behaviour in "both branches add the path
> > differently" case.  Previously merge-recursive did not create
> > the working tree file, but now it does just like merge-resolve.
> > 
> > Although I would feel very happy about this change, Catalin
> > might want to be informed about potential interaction this
> > change might have with his commit 8d41555 in StGIT.
> 
> I don't think it affects StGIT. Previously, "git-read-tree -m" left a
> file in the tree in this conflict situation. When I switched to
> git-merge-recursive (to handle renames better), I noticed that the
> file was no longer there and my merge algorithm failed. It now checks
> whether the file is missing and it generates one.

Great!

Ciao,
Dscho
