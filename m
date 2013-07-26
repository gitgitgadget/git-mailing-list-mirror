From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Fri, 26 Jul 2013 16:08:57 -0700
Message-ID: <20130726230857.GK14690@google.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net>
 <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net>
 <20130726224359.GA3928@sigill.intra.peff.net>
 <20130726230527.GA12968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 01:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2r8Q-0001Bo-HY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 01:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760147Ab3GZXJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 19:09:07 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43780 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339Ab3GZXJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 19:09:01 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so3777516pad.22
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HMINtYtTQPocoSwgqRoQs6wu3/UQ5eHNl265J13EK+s=;
        b=wjQwmYjslTojMBaa0rIoMshkBjv2HkF1Ko85FuXsxIca36Ntjr5Gyz016mizM4oSRT
         Fcl9zCG9RHmPJnQrlCUfTxBQEpIMaaII5TeOaqcfSipDsKKjD0qTags1wGkvzi0fMsoQ
         gpeTg5OuNITLjN/U+s3INM5A6F4uWCeIxYhUQe4jBaGlu+aPY10e1NXGXe917F6lqFWz
         0002KDnVNn5z/Vatj87/lsDawW/Qe2h0GIox8S2Yn0z6j8HLEktF3EYYA8b3sTtRZusx
         DbW0IZVcq8gKENf5DcxS4QPrgTw54MZc3xNX0Y2/QBnTd3qsVj4dnLb/ZFLx/IJQ3iJe
         5Cfw==
X-Received: by 10.66.253.4 with SMTP id zw4mr42607474pac.119.1374880141068;
        Fri, 26 Jul 2013 16:09:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y6sm62334119pbl.23.2013.07.26.16.08.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 16:08:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130726230527.GA12968@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231215>

Jeff King wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -63,8 +63,14 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>  "If you wish to commit it anyway, use:\n"
>  "\n"
>  "    git commit --allow-empty\n"
> +"\n");
> +static const char empty_cherry_pick_advice_skip_single[] =
> +N_("Otherwise, please use 'git reset'\n");
> +static const char empty_cherry_pick_advice_skip_multi[] =
> +N_("If you wish to skip this commit, use:\n"
>  "\n"
> -"Otherwise, please use 'git reset'\n");
> +"    git reset && git cherry-pick --continue\n"
> +"\n");

Hmm, wouldn't it be more consistent to either say

	If you wish to commit it anyway, use

		git commit --allow-empty && git cherry-pick --continue

	If you wish to skip this commit, use

		git reset && git cherry-pick --continue

Or

	If you wish to commit it anyway, use

		git commit --allow-empty
	
	If you wish to skip this commit, use

		git reset

	Then "git cherry-pick --continue" will resume cherry-picking
	the remaining commits.

?
