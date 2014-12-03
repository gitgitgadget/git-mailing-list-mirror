From: Brodie Rao <brodie@sf.io>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Wed, 3 Dec 2014 13:21:03 -0800
Message-ID: <CADQoFhyxFNzazsEaE6Bk2W_KDhogBho8vgJXkDDPsYvC46ZX5Q@mail.gmail.com>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
	<xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
	<20141117213442.GD15880@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bryan Turner <bturner@atlassian.com>,
	Stefan Saasen <ssaasen@atlassian.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHMF-0003pv-G8
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbaLCVVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:21:07 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:45350 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaLCVVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:21:06 -0500
Received: by mail-oi0-f48.google.com with SMTP id u20so11276488oif.35
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sf.io; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RmO3wMH9TnBhVUeokYwq96+FVUrM2HZAP3QWusrg4kQ=;
        b=SmhjZk3tjpiTdW/zKNZWe/tP5g4hc0bBCixZ84AhRALKV7KyBkfvUozO16P01hSrcl
         K82eFBx0x1cYU7/8995yOETwAmqk934cLvMDKtOg7chk1hngt/3u8vXAY0OIJqYTR+3p
         xpCzk8zvNbPWG7roH81RK7VOmChPq4vxAXldc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RmO3wMH9TnBhVUeokYwq96+FVUrM2HZAP3QWusrg4kQ=;
        b=eOE20iSidQDPQ9J4aQi1vCWsWKaqrFiEMi4igYQgkFwM9TEv/WhKhLWGQN6POsXxWV
         ep07PuHlnARlSXZ0M9brYY6VD/aDcFiIuuNSu3ad1p2vFsmfTOj5ONEGHynujEXqXBNe
         DWgehSgXciThKDRHEFdgPPShC2b24XDTc+cdoDlWbS5cqtEWVfSfBo7bSFJhWHzV/DvK
         BMtToJQpJaEnUEFfErXdNhnO7GuT01SxnT7f/Ai1ucVRVxbomW33Xy1d6NRvwaBquAQB
         CUlfXsldGJ3K+09Z4Vp6i88h+H6XP/mBT2T23xwodSToZGswqRRSF8v7H3+ReEPDGmO4
         G3MA==
X-Gm-Message-State: ALoCoQkyopH0pZA+7id7NELa0+UfM90+0EcABoHhB4dGub1wMr+HtHFMnQJ2fGYJwu3l5LfQhuKS
X-Received: by 10.202.231.139 with SMTP id e133mr4489027oih.8.1417641664707;
        Wed, 03 Dec 2014 13:21:04 -0800 (PST)
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com. [209.85.214.172])
        by mx.google.com with ESMTPSA id e16sm11740791oic.16.2014.12.03.13.21.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 13:21:03 -0800 (PST)
Received: by mail-ob0-f172.google.com with SMTP id wn1so12170062obc.3
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 13:21:03 -0800 (PST)
X-Received: by 10.202.191.11 with SMTP id p11mr4369777oif.32.1417641663575;
 Wed, 03 Dec 2014 13:21:03 -0800 (PST)
Received: by 10.182.75.198 with HTTP; Wed, 3 Dec 2014 13:21:03 -0800 (PST)
In-Reply-To: <20141117213442.GD15880@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260693>

On Mon, Nov 17, 2014 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 14, 2014 at 03:01:05PM -0800, Junio C Hamano wrote:
>
>> >  23 files changed, 375 insertions(+), 7 deletions(-)
>> [...]
>>
>> I am not sure if this much of code churn is warranted to work around
>> issues that only happen on repositories on NFS servers that do not
>> keep open-but-deleted files available.  Is it an option to instead
>> have a copy of repository locally off NFS?
>
> I think it is also not sufficient. This patch seems to cover only
> objects. But we assume that we can atomically rename() new versions of
> files into place whenever we like without disrupting existing readers.
> This is the case for ref updates (and packed-refs), as well as the index
> file.  The destination end of the rename is an unlink() in disguise, and
> would be susceptible to the same problems.

I'm not aware of renaming over files happening anywhere in gc-related
code. Do you think that's something that would need to be addressed in
the rest of the code base before going forward with this garbage
directory approach? If so, do you have any suggestions on how to
tackle that problem?
