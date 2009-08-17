From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Tue, 18 Aug 2009 01:16:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>  <200908142223.07994.jnareb@gmail.com>  <7veird4yyi.fsf@alter.siamese.dyndns.org>  <200908160137.30384.jnareb@gmail.com>  <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>  <7vtz06xxao.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>  <7vws52uvxq.fsf@alter.siamese.dyndns.org>  <alpine.DEB.1.00.0908172347220.8306@pacific.mpi-cbg.de>
 <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-3446089-1250550999=:8306"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 18 01:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBQl-0001ur-0K
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbZHQXPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbZHQXPu
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:15:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:52560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbZHQXPu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 19:15:50 -0400
Received: (qmail invoked by alias); 17 Aug 2009 23:15:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 18 Aug 2009 01:15:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196C1xsPbl6Q57llkIhOnLW89x06KmAlSG6/GDEd7
	IX0uuwf/trgX7j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126317>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-3446089-1250550999=:8306
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, skillzero@gmail.com wrote:

> On Mon, Aug 17, 2009 at 3:02 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> 
> > And here comes the problem: if something is treated untracked because 
> > it was outside of the sparse checkout, then I want it to be treated as 
> > untracked _even if_ I happened to broaden the checkout by editing 
> > .git/info/sparse.  The file did not just magically become subject to 
> > overwriting just because I edited .git/info/sparse (which could be a 
> > simple mistake).
> 
> Maybe I'm misunderstanding what you're saying, but why would you want a 
> file that's become part of the checkout by editing .git/info/sparse to 
> still be treated as untracked?
> 
> If I have a file on that's excluded via .git/info/sparse then I edit 
> .git/info/sparse to include it and switch to a branch that doesn't have 
> that file, I'd expect that file to be deleted from the working copy if 
> the content matches what's in the repository. If it's modified then I'd 
> expect the branch switch to fail (like it would without a sparse 
> checkout).

First things first: with sparse checkout, you should not check out 
_anything_ outside of the focus of the sparse checkout.

So I contend that you would only end up with a sparse'd-out file 
that was formerly tracked if you did something wrong.  That should not 
happen.

Even if: all the more reason to have a flag that indicated that this file 
is not sparsed'd-out -- contradicting .git/info/sparse.

The thing is: we need a way to determine quickly and without any 
ambiguity whether a file is tracked, assumed unchanged, or sparse'd-out 
(which Nguyễn calls no-checkout).

And if we change .git/info/sparse, that state _must not_ change.  We did 
not touch the file by editing .git/info/sparse, so the state must be 
unchanged.

Whether "git checkout" should realize that a checked out file (which has 
no changes, mind you!) needs to be deleted and marked no-checkout is a 
different question.

Ciao,
Dscho


--8323328-3446089-1250550999=:8306--
