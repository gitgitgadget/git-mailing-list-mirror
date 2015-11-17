From: Jonathan Lebon <jonathan.lebon@gmail.com>
Subject: Re: [PATCH 3/4] diff-highlight: match up lines before highlighting
Date: Tue, 17 Nov 2015 00:18:28 -0500
Message-ID: <CAM0PgJ4erahEZsL75c4mytF158xxeE6itG8KOMMi4n-zBTHcww@mail.gmail.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-4-git-send-email-jonathan.lebon@gmail.com>
 <20151103214416.GC22484@sigill.intra.peff.net> <20151103220314.GE22484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 06:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyYg3-0004hc-UI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 06:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbbKQFTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 00:19:21 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34527 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbbKQFS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 00:18:58 -0500
Received: by ykfs79 with SMTP id s79so275492678ykf.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 21:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kXptcOa2yCBzr7mxd6+Bum+oxxPG/3jjojZGYvXLDas=;
        b=lhxO1/w/e7/kiYXS0FsxGEgjrBeD7z0hS0c+u7YO1XT3Kz83NHia4QQfCkBkDJjn7C
         zCUCTwZAicH1GHAoR05KNtTI7IuVkL3FR0Ou7FyGQHO9zAdIPQhU7rm3uTu9frcUfLCH
         RD3xXuW4ROGtW2YdM2Iv7EmZJTOvJ4/QSPp69T8jVz9dmMCAUCIZlOq+EMdY07tpkk3j
         y8jBlsPUAnC5+Z/2u6k9YgWOdDHGHoBRskg9K9zl4d/k7ME+Kcujv3wCA1LD5dkd0kAQ
         y47X6+bmio1MQ+yD7qtF3Yd+K/y4kjMHjaBJvFCbjDJ2N0BWtXgNymcsSNyQqYeRigTI
         iJBg==
X-Received: by 10.129.85.84 with SMTP id j81mr40725480ywb.194.1447737537940;
 Mon, 16 Nov 2015 21:18:57 -0800 (PST)
Received: by 10.37.32.10 with HTTP; Mon, 16 Nov 2015 21:18:28 -0800 (PST)
In-Reply-To: <20151103220314.GE22484@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281382>

On Tue, Nov 3, 2015 at 5:03 PM, Jeff King <peff@peff.net> wrote:
> Your is _much_ slower. I get:
>
>   real    0m25.538s
>   user    0m25.420s
>   sys     0m0.120s
>
> for the old versus:
>
>   real    2m3.580s
>   user    2m3.548s
>   sys     0m0.156s

Thanks for investigating and trying it out. I got the same results
here as well.

> for your series. In an interactive setting, the latency may not be that
> noticeable, but if you are digging far into history (e.g., "git log -p",
> then using "/" in less to search for a commit or some test), I suspect
> it would be very noticeable.

Agreed.

> I was thinking there was some low-hanging fruit in memoizing the
> calculations, but even the prefix/suffix computation is pairwise. I'm
> not really sure how to make this much faster.

I gave memoization a try to see if it could improve the situation. I also
lowered maxhunksize to 10. Doing `git log -p` on git.git went from 2m31
to 2m11. So I think it would require a whole other approach overall.

> As for the output itself, the diff between the two looks promising. The
> first several cases I looked at ar strict improvements. Some of them are
> kind of weird, especially in English text.

Yes, I'm very happy with the improvements and run with these patches all
the time for now.

> In the other thread I mentioned earlier, the solution I cooked up was
> dropping highlighting entirely for hunks over a certain percentage of
> highlighting. I wonder if we could do something similar here (e.g.,
> don't match lines where more than 50% of the line would be highlighted).

I looked over but haven't tested the patches in the other thread yet. But
overall, the LCS definitely looks promising. I'm hoping to find some time
to have a more serious go at it and maybe pick it up where you left off.

>
> -Peff

Thanks again for reviewing these patches and apologies for the delayed
reply.

Jonathan
