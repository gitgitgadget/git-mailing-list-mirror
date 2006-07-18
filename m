From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 12:20:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607181216290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060706055729.GA12512@admingilde.org>  <87fyh1ncm0.fsf@mid.deneb.enyo.de>
  <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com> 
 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de> 
 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org> 
 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com> 
 <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
 <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: no To-header on input <""@pop.gmx.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 18 12:20:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2mh3-0002n1-VL
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 12:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWGRKUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 06:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGRKUm
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 06:20:42 -0400
Received: from mail.gmx.de ([213.165.64.21]:9863 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932163AbWGRKUm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jul 2006 06:20:42 -0400
Received: (qmail invoked by alias); 18 Jul 2006 10:20:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 18 Jul 2006 12:20:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23993>

Hi,

On Tue, 18 Jul 2006, Yakov Lerner wrote:

> How about making this parameter (do-use-mmap  vs  not-use-mmap)
> a *runtime*  parameter  ? (Env. var. $GIT_MMAP or $GIT_USE_MMAP ?).
> What do you think ? I see two benefits:
> (1) much easier to benchmark two methods against each other

You will benchmark it only once, right? No need to have this in git for 
one-time use.

> (2) will always work on cygwin (automatic fallback to working
>    method at runtime; say depending on filesystem)

I think it is too complicated to depend on the filesystem, and too system 
specific (but hey, those who submit a patch are more right than 
others...).

But an automatic fallback is not feasible: you would try to mmap(), and it 
would throw an "Access violation", which is MS speak for "Segmentation 
fault".

Besides, if you would be able to detect a failed mmap(), it would be too 
late: the rename() or unlink() would already have taken place.

Ciao,
Dscho
