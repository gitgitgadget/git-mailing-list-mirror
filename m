From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Tue, 6 Jun 2006 01:21:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606060117180.25685@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 01:21:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOOB-0003Wv-Na
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWFEXVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFEXVh
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:21:37 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23445 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750805AbWFEXVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 19:21:36 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 9B2381DB2;
	Tue,  6 Jun 2006 01:21:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8F1121DE0;
	Tue,  6 Jun 2006 01:21:35 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 77AEB1DA0;
	Tue,  6 Jun 2006 01:21:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk67v2o85.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21351>

Hi,

On Mon, 5 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Mon, 5 Jun 2006, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > When calling git_setup_directory_gently, and GIT_DIR was set, it just
> >> > ignored the variable nongit_ok.
> >> 
> >> Hmph.  Is this really a breakage?  That is, gently() is meant
> >> for a case where you do not know if you even find a git
> >> repository and tell it not to complain because you are prepared
> >> for the case where you are not in a git repository.
> >
> > Yes, it is a breakage: in git-clone, line 212, we explicitely set GIT_DIR 
> > (to the not-yet-existing repository path), and call git-init-db. Now, with 
> > the alias thing we need to get the config if it exists, so we _got_ to 
> > call gently(). Boom.
> 
> Hmph.  Would it be a bug in clone that does not create GIT_DIR
> then?

I don't think so. The whole point in calling git-init-db is to create 
that. GIT_DIR is set so that the otherwise nice work-in-a-subdirectory 
does not kick in. Imagine for example:

	git-clone ./. victim

(taken straight out of t5400). If GIT_DIR was not set, git-init-db (which 
reads repositoryformat from the config if that exists, right?) would find 
.git/ in git/t/trash, and _not_ create git/t/trash/victim/.git/.

Ciao,
Dscho
