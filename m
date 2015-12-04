From: demerphq <demerphq@gmail.com>
Subject: Re: best practices against long git rebase times?
Date: Fri, 4 Dec 2015 18:09:33 +0100
Message-ID: <CANgJU+Ums-zg1kDiW4mm_X_zxreb=wBVc1gpHUOFN=44x1TyRQ@mail.gmail.com>
References: <20151204150546.GA17210@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:10:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4trr-0004yn-6x
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 18:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415AbbLDRJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 12:09:37 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37678 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242AbbLDRJe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 12:09:34 -0500
Received: by wmww144 with SMTP id w144so73202966wmw.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=V9WKHHTHZ2MFnjLCCx9+zz7e1QtOZnnUfYrAbLmDQ+Y=;
        b=k33DskKRcNJeyQIK73tmoLn7W6E6rQhB30XZ2tDgGT1a+EWP6zoE2jIb4o05iaURMR
         5l2gmvtgmR4ONIF3xCtp4E9gPdp8iSdGAIDHxDyPTP32Gu+477raQTG267c0E0OUSE2a
         obj4zslDgRN2WwlCBam+wo1k5y+wVstQ7eZofH2EDI0QgKGT33abbBL7JClU7EYwfqvW
         dvpywICJa/kwSFCYFlrnaSnlQbUQwdq1kS3dvvmqCO2kkaTWqHMwsMYZJJ2Nm2kP2Vki
         LQ7dUOX3sjQkK4vaYMQcoSS/bp3I84FHQwwP4wMNNcMoWj490Nd3ExaBl0at3+YUPCik
         /fCg==
X-Received: by 10.28.183.198 with SMTP id h189mr6122761wmf.44.1449248973681;
 Fri, 04 Dec 2015 09:09:33 -0800 (PST)
Received: by 10.27.39.70 with HTTP; Fri, 4 Dec 2015 09:09:33 -0800 (PST)
In-Reply-To: <20151204150546.GA17210@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281988>

On 4 December 2015 at 16:05, Andreas Krey <a.krey@gmx.de> wrote:
> Hi all,
>
> our workflow is pretty rebase-free for diverse reasons yet.
>
> One obstacle now appearing is that rebases simply take
> very long - once you might want to do a rebase there are
> several hundred commits on the remote branch, and our tree
> isn't small either.
>
> This produces rebase times in the minute range.
> I suppose this is because rebase tries to see
> if there are new commits in the destination
> branch that are identical to one of the local
> commits, to be able to skip them. (I didn't
> try to verify this hypothesis.)
>
> What can we do to make this faster?

I bet you have a lot of refs; tags, or branches.

git rebase performance along with many operations seems to scale
proportionately to the number of tags.

At $work we create a tag every time we "roll out" a "server type".

This produces many tags a day.

Over time rebase, and many operations actually, start slowing down to
the point of painfulness.

The workaround we ended up using was to set up a cron job and related
infra that removed old tags.

Once we got rid of most of our old tags git became nice to use again.

Try making a clone, nuking all the refs in it, and then time rebase and friends.

Yves





-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
