From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 14:11:22 -0600
Message-ID: <20120112201122.GE6038@burratino>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
 <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
 <20120112194710.GA28148@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 21:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlQzn-0002Xk-UA
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 21:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab2ALULd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 15:11:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50262 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2ALUL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 15:11:28 -0500
Received: by iabz25 with SMTP id z25so3187569iab.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9i5sn7hbF5EFuKPsRy4e3OtnK9YuILzfgF0cUZBkM5M=;
        b=YIzpMpB0z4uGg0MUOPhfQ/wsvPxwe6cmokiskED1KZ9eEMRpphcOwZ5d4DfgUxrhNA
         hbZn2+fYDLE2uQDetPECjMUrpIKgjmQ7Ie/E6yZcAQ9K0SIMgxTpuAgP6bkIMJqX9m6X
         c11YLW6dJVH7IZrf+13k3Uo1UfPPeHuHtl0zY=
Received: by 10.43.45.137 with SMTP id uk9mr4870112icb.52.1326399087831;
        Thu, 12 Jan 2012 12:11:27 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g34sm20572267ibk.10.2012.01.12.12.11.26
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 12:11:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120112194710.GA28148@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188479>

Jeff King wrote:

> I am tempted to suggest
[...]
>              That would make all of these work as most people would
> expect:
>
>   git cherry-pick A B C
>   git cherry-pick A..B
>   git cherry-pick A..B B..C
>
> but would be a regression for:
>
>   git cherry-pick B ^A
>
> versus the current code. I suspect that the latter form is not all that
> commonly used, though, and certainly I would accept it as a casualty of
> making the "A B C" form work. My only hesitation is that it is in fact a
> regression.

I find myself using such complicated expressions as

	list-revs-to-skip |
	xargs git cherry-pick --cherry-pick --right-only HEAD...topic --not

so yeah, that would be a pretty serious loss in functionality.

However, moving to something like the far future semantics that Junio
hinted at, for cherry-pick/revert and other --no-walk style commands
only, would not be a regression for me.  The multi-pick feature is
still young, and I _suspect_ changing the meaning of A..B B..C for it
would not inconvenience anybody.

I would even welcome a change in the meaning of B ^A: the most
intuitive thing for it to do would be to cherry-pick the single commit B
when and only when it is not an ancestor of A.

Jonathan
