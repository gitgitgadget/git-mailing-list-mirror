From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Benchmarks regarding git's gc
Date: Tue, 8 Nov 2011 10:40:15 -0600
Message-ID: <CA+sFfMdax6UYsi2ojGWQT_TdPSMPGMGRZA3jz+VaENmbs4buzQ@mail.gmail.com>
References: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoil-0007HA-0P
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376Ab1KHQkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 11:40:18 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42546 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab1KHQkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 11:40:17 -0500
Received: by eye27 with SMTP id 27so535171eye.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gg+rnjT+nEzJurT5IPzfDEnZuVCsc22alfjLs5RFRnM=;
        b=Ugz+Mh9fE8zuBkuh4CP6lgf5i3b5b+QZ9WuoNi88YTqVEPBaPGwxMh4CioCOf5LvBe
         wzlfriY4OVZydvzIJuUOzDwAinS0FlxhyjGVm+cCA0en1Nvkk/uX0lZzUAwymZeetwRl
         ZdVH0VrQJFHwyN7sh51sVHwDE0AGcuENq1+xo=
Received: by 10.182.41.69 with SMTP id d5mr10194871obl.47.1320770415296; Tue,
 08 Nov 2011 08:40:15 -0800 (PST)
Received: by 10.182.188.104 with HTTP; Tue, 8 Nov 2011 08:40:15 -0800 (PST)
In-Reply-To: <CAMP44s3E-YCMQQzJAU2wjjD-adpNy6bGb-=iUQ=p=bFTWxm+Ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185095>

On Tue, Nov 8, 2011 at 5:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Has anybody seen these?
> http://draketo.de/proj/hg-vs-git-server/test-results.html#results
>
> Seems like a potential area of improvement.

I think this is a case of designing the problem space so that your
intended winner wins and your intended loser loses.

'git gc' is designed so that it can be run out-of-band.  It doesn't
make a lot of sense to design your application so that the end-user
has to wait for git-gc to run, and I don't think anyone ever would.
But that is similar to how mercurial works, and that is why the author
of that page measured git's performance that way.

Off the top of my head, it seems to me that running 'git gc --auto' in
a cron job with SCHED_BATCH scheduling and some simple locking may
satisfy his requirement of keeping the repository size bounded and
ensuring that the pack operation does not affect the operation of the
web app.

-Brandon
