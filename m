From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Tue, 17 Jul 2007 18:36:15 +0200
Message-ID: <e5bfff550707170936kcd0c001nb4c4a90baacf4275@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <200707170849.35842.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAq2A-0002k6-PE
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763372AbXGQQgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761761AbXGQQgS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:36:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:18625 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760740AbXGQQgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:36:17 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1206919nze
        for <git@vger.kernel.org>; Tue, 17 Jul 2007 09:36:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HbzvKXRDFhQcUGge1G3P715ZGLuvbHumQi5KePgxhJSlFeIiNQucNrybgmjbBGifmBkcjybh3sLLuaQHw8KMdl/rOe0uR6/+tcLJNdSTGNyf/haIovqnIpzosfYHE0k8L1nXw1T3g6p2Q0hC4ApupQWQuLDZhRiAnY6Zv4FYNvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AULz6hxuhvH87tgq+/W0IeCrqo3IFXZLGyN0HOj0agSC+ZB8a4+nedN6eLbBg3iKfdopqBxdL+Vlj74779DNgrHU3ulKgjXLPNXirSgSmqQUmZ4MEplR75pTwOrbR4ctcs5H57pGzZ89FJjD9n+wYkvnrZg0Aq1oNMrgwMOYNCs=
Received: by 10.114.174.2 with SMTP id w2mr564155wae.1184690175439;
        Tue, 17 Jul 2007 09:36:15 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Tue, 17 Jul 2007 09:36:15 -0700 (PDT)
In-Reply-To: <200707170849.35842.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52772>

On 7/17/07, Andy Parkins <andyparkins@gmail.com> wrote:
>
> Does this really give a speedup?
>
> I'd be surprised, as long as the parse is being done during the output from
> git using the QProcess::readyRead() signal once and only once, then git is
> the bottle neck.  Parsing the stream is almost trivial in comparison to the
> work that git is doing.
>

Well, it's not exactly from readyRead() but you are right, the bottle
neck it's git.

A bare:
time git log --parents --boundary --pretty=raw -z --log-size
--topo-order HEAD > /dev/null

gives on linux and git repositories
git 960ms
linux 6920ms

Instead qgit gives, with the same command:

WITHOUT --log-size patch
git  1170ms  (+21%)
linux 7942ms (+15%)


WITH --log-size patch
git 1125ms (+17%)
linux 7820ms (+13%)

I don't know why overhead on Linux is less, probably on small repos
the GUI part of qgit that you can consider more or less a constant
time weights more regarding parsing.


Marco
