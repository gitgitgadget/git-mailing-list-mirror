From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'sparse' clone idea
Date: Wed, 14 Jun 2006 11:20:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606141110001.15673@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e6oh2g$ngh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 14 11:21:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqRZ4-0001JT-OY
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 11:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWFNJUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 05:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWFNJUv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 05:20:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34267 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932115AbWFNJUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 05:20:50 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A76492366;
	Wed, 14 Jun 2006 11:20:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9B789237B;
	Wed, 14 Jun 2006 11:20:49 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7D52320A8;
	Wed, 14 Jun 2006 11:20:49 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6oh2g$ngh$1@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21835>

Hi,

On Wed, 14 Jun 2006, Jakub Narebski wrote:

> I wonder if 'sparse clone' idea described below would avoid the most
> difficult part of 'shallow clone' idea, namely the [sometimes] need to
> un-cauterize history. See: (<7vac8lidwi.fsf@assigned-by-dhcp.cox.net>).

I do not think that is the hardest problem. The hardest thing is to tell 
the server in an efficient manner which objects we have.

Example:

A - B - C - D
    ^ cutoff
        ^ current HEAD

Suppose B is your fake root, C is your HEAD, you want to fetch D. Now, 
make it a difficult example: both A and D contain a certain blob Z, but 
neither B nor C do. You have to tell the server _in an efficient manner_ 
to send Z also.

And by efficient manner I mean: you may not bring the server down just 
because 5 people with shallow clones decide to fetch from it.

> 'sparse clone' begins like 'shallow clone': full history is copied down to
> specified point of history (cut-off or cauterization point for shallow
> clone), but instead of cauterizing the history from that point downwards,
> the history is simplified using grafts.
> 
> In the sparse part we need:
>  * all commits pointed by tags (if we clone/copy tags) 
>    and other refs (if we clone/copy those tags)
>  * merge bases for all commits in full, and in the sparse part,
>    _including_ merge bases themselves

Hmmm. You cannot know _all_ merge bases beforehand, because you do not 
decide where other people fork off.

>  * all roots

Why?

> Commits in sparse part would be connected like in original history, only
> skipping "uniteresting" commits.

Interesting idea, though I do not think it solves the most pressing 
problems we have with shallow clones.

Ciao,
Dscho

P.S.: I think the problems of a lazy clone are much easier to solve...
