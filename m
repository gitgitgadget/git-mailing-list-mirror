From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 18:32:58 -0400
Message-ID: <20160324223257.GE8830@LykOS>
References: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
 <20160324215104.GC8830@LykOS>
 <20160324221457.GB17805@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 23:33:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajDoV-0004jF-FY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 23:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbcCXWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 18:33:07 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34872 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcCXWdF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 18:33:05 -0400
Received: by mail-qg0-f41.google.com with SMTP id y89so50087917qge.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0zGZJ9lRD9HmnurqFz5Pj/Otqapd7tgBAnDdg0JiWCE=;
        b=f+C/77DLsurhdtZw+3xiuqcb34ck3kefbO0DOcFbZHakbkiplouGHI7AkPxrUzfNKb
         VGiPEukCcFd50eQVQ82/mLIOj+xTbhUtJbccuwBtz+7/5yzqO+fp/2/IbtDaYtoRuRrr
         kYfJ/UOJVZe3/jNKBxRujJqwRp+5kyxBhOTmkKONtYM4Og2FqF8Qv2l0MM/4Y8TCiwKP
         WD+qzoHTG4ruJ+GqX/yeIPhs+r593ZZ6Uk7W4xeRj6jozu/ZlBG1rqgg/YeVkgRzB5Ca
         AI4EvAdmGbTqDzgNCzuW1s0T9QQqPaTpENjHQGIJwTzZtTxcPKgJCfrIitAa4lq3Gmaq
         xylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0zGZJ9lRD9HmnurqFz5Pj/Otqapd7tgBAnDdg0JiWCE=;
        b=am86gW59qfsgkOcPMRj5kdaOLC7ah7GtLtGTu/n4HRuhDdJHilYo21EPxuq4s27bO8
         46PA56FnEC6Ra5NCs5Z+krYoicCXbTJjn2qcD3E1keDLy4s/RXBRkn4r6ietXgAf4xek
         1+utQOz9tFFdaBvR1cRZa7IekVXtGOeZ97YOrEyCq/D/V6sdu6tSCSqlM377sS/AFu0H
         WTc/7xuBEWrYKHfnIAPR9tKuW+RaJcvkrb4bLaBD1dkzkLyXJXVw8VsW/p2272bzkmId
         5Ii5ZnCfpkg0qwkshsLUeBJVy2jJQNefGnxCBUxZBqaODIEoz5SbwVfI8Oxq13RhvHt4
         ZO/Q==
X-Gm-Message-State: AD7BkJLbDf4Y3Rwvt9u99HTn2rAvykeC+w0o+020ENrg+14GAdWeBH/iHAdCthVacfe2feDW
X-Received: by 10.140.20.197 with SMTP id 63mr13637366qgj.18.1458858783665;
        Thu, 24 Mar 2016 15:33:03 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id a91sm4148260qga.29.2016.03.24.15.33.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 15:33:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160324221457.GB17805@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289816>

> > This is my first stab at this, in the dumbest/simplest way imaginable. I
> > don't like that there is no code reuse (the run_gpg_verify function is
> > repeated here and in the plumbing command). I would appreciate pointers
> > on what would be the best way to avoid this.
> 
> It looks to me like you could factor the repeated code into a common
> verify_tag(), but maybe I am missing something.

I see, yes. This looks like the way forward.
> 
> > I also spent quite some time figuring out what you meant with
> > 
> > > Do note the trickery with SIGPIPE in verify-tag, though. We probably
> > > need to do the same here (in fact, I wonder if that should be pushed
> > > down into the code that calls gpg).
> > I don't see any explicit SIGPIPE trickery here. Any pointers?
> 
> There is a call to ignore SIGPIPE in builtin/verify-tag.c, line 100.
> Do we need to do be doing the same thing here?
> 
> There's some discussion in the thread starting at:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/53878/focus=53904
> 
> The claim there is that we get SIGPIPE and die early if we feed gpg a
> tag which isn't signed. We _should_ be catching that case already via
> parse_signature(), though I wonder if it can be fooled (e.g., something
> that looks like a signature, but when gpg parses it, it turns out to be
> bogus). So we should probably continue ignoring SIGPIPE to be on the
> safe side.
> 
> But I notice that we already handle SIGPIPE explicitly in sign_buffer()
> for similar reasons.  What I was wondering earlier was whether we should
> teach other functions that call gpg (like verify_signed_buffer()) to
> ignore SIGPIPE, too, so that we can return a reasonable error value
> rather than just killing the whole program.
> 

Now I get it  I think this should be easy to achieve by moving
verify_tag() to tag.c, along with the static run_gpg_verify functions. I
could move the SIGPIPE call inside the verify-tag command and patch up
everything accordingly. Does this sound ok?

Thanks,
-Santiago.
