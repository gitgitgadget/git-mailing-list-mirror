From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Tue, 3 Apr 2012 16:26:50 -0500
Message-ID: <20120403212650.GD19858@burratino>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
 <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
 <20120403210815.GB19858@burratino>
 <20120403211219.GC19858@burratino>
 <4F7B69FE.9010600@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFBFw-00049v-QW
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab2DCV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:27:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40844 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552Ab2DCV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:27:05 -0400
Received: by iagz16 with SMTP id z16so192280iag.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MfLC/QQPjNQ2zvfDF97jyNIzZDebr+03SKnI9/9YGKA=;
        b=Dvz2xB6zk8X3Wiqa/XL640TRZNciCz5g4fYRov4m2Sc/GPouTkzNTgwo10TjRvHgfQ
         ZRmEWEBY8j0RKoQTy6XeDeWFaFSSuUFSf+cu/UdIT7F+VDqSLZyjXF969RowWu2DpdBk
         fnR+xY/TWlUiTkXACS2BgJY9UyAqgmgQaM6R1fJDjUIQoBaQpw+kEfQ2CVXTneFKctTD
         AWoDfe3AI/yj7nrEPYi4is1ZAlnunbY/6OFhdsOd1hWlNolvJdvFgQQu8tFFCUk9lmAR
         h2HuhYAIQNlE0BQjjbp0/nGv5IK9ap/N2ubAdgfPU6tM6+xlEX5S0xI3qGf8Bd1SNyJu
         jkBQ==
Received: by 10.50.156.170 with SMTP id wf10mr10483944igb.7.1333488425393;
        Tue, 03 Apr 2012 14:27:05 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id re5sm2642345igb.0.2012.04.03.14.27.04
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 14:27:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7B69FE.9010600@sohovfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194650>

Andrew Wong wrote:

> But what I meant was, regardless of who's calling "cherry-pick", if
> "cherry-pick" runs into an error and needs to stop, it needs to save a
> state so that it can do a "--continue". And this behavior should stay
> the same regardless of who the caller is. And that means its callers
> (e.g. "rebase -i") should know about this and do a cleanup when
> "cherry-pick" failed.

The current CHERRY_PICK_HELP codepath removes CHERRY_PICK_HEAD to let
its caller take care of the appropriate "commit -c" magic for
historical reasons.  I'd be happy to see "rebase -i" stop relying on
that.

Unfortunately, outside scripts from before CHERRY_PICK_HEAD existed
are also allowed to use CHERRY_PICK_HELP, so the incomplete
implementation that leaves behind a CHERRY_PICK_HEAD when the commit
being cherry-picked resolves into nothingness is still a bug.
