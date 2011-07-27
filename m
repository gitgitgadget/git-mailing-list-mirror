From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/18] revert: Propogate errors upwards from
 do_pick_commit
Date: Wed, 27 Jul 2011 06:39:08 +0200
Message-ID: <20110727043908.GD18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 06:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlvu1-0007G0-6d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 06:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909Ab1G0EjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 00:39:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64270 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab1G0EjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 00:39:19 -0400
Received: by ewy4 with SMTP id 4so1026832ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+EA9XzonbrjkK3m/IHLg9DEMco/V7CJoWNQ6i6a+jJI=;
        b=X++ghm5EGPQD37o0pDNjUJUQ0NEsshMrR3uXhNVJQgf8Sg1kr/UYPOfQLoSZ/EV9Co
         BLg73gtNSXM6PsbaphjRKNHGRzLpxJkKaGg8LLmxzWDOVqJPeBlosouxL2/umQSRry+5
         sYaEfzAbuvjeyvzuMV6lb+nnItddSKiABpVHo=
Received: by 10.213.106.14 with SMTP id v14mr2866038ebo.8.1311741558237;
        Tue, 26 Jul 2011 21:39:18 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id n41sm817285eeh.23.2011.07.26.21.39.15
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 21:39:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177926>

Ramkumar Ramachandra wrote:

> Currently, revert_or_cherry_pick can fail in two ways.  If it
> encounters a conflict, it returns a positive number indicating the
> intended exit status for the git wrapper to pass on; for all other
> errors, it calls die().  The latter behavior is inconsiderate towards
> callers, as it denies them the opportunity to recover from errors and
> do other things.

Patch 5 is good.  I still find patch 6 unconvincing, since it makes
the behavior inconsistent (there are still many ways for
revert_or_cherry_pick to exit() or die()), does not help with anything
that comes later, and it is more of a burden than most of the rest of
the patches to review (since one has to look at context not contained
in the diff to see if it is safe to continue running after an error
that previously would exit).  In the long term, I really do want this
change, though.  If you'd like, I can rebase to put it at the end of
the series (which shouldn't be hard).
