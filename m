From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Sun, 31 Dec 2006 16:43:13 +0100
Message-ID: <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <Pine.LNX.4.63.0612301955340.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 16:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H12qZ-0002qS-Hi
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 16:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933151AbWLaPnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 10:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWLaPnP
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 10:43:15 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:3225 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933151AbWLaPnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 10:43:14 -0500
Received: by py-out-1112.google.com with SMTP id a29so2939755pyi
        for <git@vger.kernel.org>; Sun, 31 Dec 2006 07:43:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=isbC71jgmkoyuZKSVI8VvJchxhocGCPU1W2qKIBFXB1b/4F6FHGfkkXzwSeZL3IPar0y7h55ZMkHbQfzwimcBmvHu4deRITU7JMl49rJDWywg7sHAEtRmGkZ3UaxBGChiOF/3mUlU3At4KTApP6O3BisJHyKb5KtIUUYdEprj0I=
Received: by 10.35.10.17 with SMTP id n17mr14712561pyi.1167579794024;
        Sun, 31 Dec 2006 07:43:14 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 31 Dec 2006 07:43:13 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35702>

On 12/31/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> Further, if you rely on parsing being super-fast, why not just parse
> _only_ the header information that you actually need? The header still
> consists of
>
>         - exactly one "tree",
>         - an arbitrary amount of "parent" lines,
>         - exactly one "author", and
>         - exactly one "committer" line
>
> After that may come optional headers,

If you intorduce the concept of an 'optional header part' you
logically and naturally _may_ also introduce the concept of disabling
the display of _that_ optional header, or better, to keep back
compatibility (I just remaind that's more then one year and an half
that git-rev-list works in that way!) you may accept the concept of an
option to show the additional optional header part. That's just what
I'm asking, no more no less.

>but by that time you should
> _already_ have stopped parsing! And the order is fixed already
> (parse_commit_buffer() relies on it).
>
> After all, you have an initial parsing for the purpose of organizing the
> commits, and you can have _another_ for the purpose of displaying the
> message (you can remember the offset where the first parsing stopped to
> accelerate the second). The latter parsing should be done individually,
> when displaying the commit.
>

The problem with your proposed algorithm is that you don't have _one_
commit but a sequence of commits to parse, so when you have parsed
until the committer line you must need to know where the next commit
starts, IOW you have to find the next '\0', that's what I was trying
to expose in my previous e-mail postscriptum.


Thanks
Marco
