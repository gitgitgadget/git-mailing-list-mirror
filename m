From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Symmetric of rebase / more intelligent cherry-pick
Date: Tue, 11 Oct 2011 17:23:03 -0500
Message-ID: <20111011222138.GA3768@elie.hsd1.il.comcast.net>
References: <20111011155444.GB14417@capsaicin.mamane.lu>
 <7v8vorfhhu.fsf@alter.siamese.dyndns.org>
 <7vty7fdxql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lionel Elie Mamane <lionel@mamane.lu>,
	Christian Couder <chriscool@tuxfamily.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 00:24:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDkkp-00079M-3H
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297Ab1JKWXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 18:23:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45197 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1JKWXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:23:13 -0400
Received: by ggnv2 with SMTP id v2so64858ggn.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bcE29Wk6em/CL1Bc5UZU0cxViqbJitv6cRGP7q8RmZ4=;
        b=LjVYyfR9VRzYzPvF8Fbu6vrLasT3mVzCKCkIv/pqxIrciGtVZhotLHseCNX6YeeNSg
         ZYUWlXne2JtGCrF7NKtHklie3jtMflZQeMbTshvebWPYAZ3yuZrcqEDlWRlNTw6O5XxH
         /LBfL+El+/ahfFFKS5TYK+/RuCcxhCuD148es=
Received: by 10.236.177.66 with SMTP id c42mr33055938yhm.14.1318371792472;
        Tue, 11 Oct 2011 15:23:12 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p54sm63249yhh.1.2011.10.11.15.23.10
        (version=SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:23:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vty7fdxql.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183332>

Junio C Hamano wrote:

> We actually have half of that filtering in "--cherry-pick" that was
> introduced in d7a17ca (git-log --cherry-pick A...B, 2007-04-09).
>
> Perhaps the recent cherry-pick that allows multiple commits to be picked
> should use that option (i.e. a "log --cherry-pick --right-only ..@{u}"
> equivalent) when coming up with which commits to apply?

No UI ideas from me, but I have a script like this sitting in $HOME/bin:

 base=$1 topic=$2

 git rev-list $base..HEAD |
 git diff-tree -s --pretty=raw --stdin |
 sed -ne 's/(cherry picked from commit \([0-9a-f]*\))/\1/p' |
 xargs git cherry-pick -x -s \
   --cherry-pick --right-only --no-merges HEAD...$topic \
   --not $base
