From: Luke Diamand <luke@diamand.org>
Subject: git p4: any way to avoid rebasing all the time?
Date: Wed, 11 Apr 2012 18:27:59 +0200
Message-ID: <CAE5ih7_Fh0XA-XNNvtHnXhYwUvwmmg-Z+y-Mb5Wvra3Y83eFsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:28:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI0Ou-0006ap-Tf
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 18:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760654Ab2DKQ2D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 12:28:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:46540 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760651Ab2DKQ2B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 12:28:01 -0400
Received: by wejx9 with SMTP id x9so671163wej.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 09:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=TipH0DiOJhe3HXaLHIfxYv/CENDR/h4jRdQWXfhzhJI=;
        b=EACmIoOeeV6IZYDHv8Vqz9f3JR3/+f63ZeNZXTrQjLbMlDOUbhoE5M6sGN1dbMTI1v
         tY5Vbd6dtERySdTyBvMex7erGnNO42sg+IuY6RMk/V2FOs/9pyobKKu8wqTPrrU50E8l
         BV5J9K6BtH04TV4kt6ywBryNZo67ptyM4IygYEBpBpqirFwEtiW/SkgZvB7OY4gp0HTJ
         8mdBbhz4CSFXPerF2nHdOhWe7UCxOOWolAyz4yPF6wG/Q+KMKqpWJ2K6p3QYRl1/DOJR
         ioZkfqZfLXy0v3PNsWRjM+h4jEIniLBlZj7JKzDI3U/c3l+vIP/DkqzmeWsHwsxy8Dyd
         DrHA==
Received: by 10.216.137.30 with SMTP id x30mr8621523wei.34.1334161679662; Wed,
 11 Apr 2012 09:27:59 -0700 (PDT)
Received: by 10.216.204.27 with HTTP; Wed, 11 Apr 2012 09:27:59 -0700 (PDT)
X-Gm-Message-State: ALoCoQm6XsimEpNM+oQu0cWDb2JffJflHY9ku8RF61TIACx3Sa9mhEHflFBmX++ifPXTwXsDCo6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195205>

Is there a way to get "git p4" to not rebase all the time?

Right now, git commits get discarded and replaced with new ones with
the same contents and extra git-p4 metadata embedded in the comment.

If we put this git-p4 metadata into a git note then we would not need
to rewrite the commits, and so could perhaps avoid rebasing quite so
much.

However, if "git p4" won't rewrite commits, then it can't reorder them
to match the ordering seen from p4.

So you could end up with git users seeing OLDHEAD,G,P and p4 users
seeing OLDHEAD,P,G, as there's a race to see who submits against
OLDHEAD first, which p4 always wins.

Would this matter (assuming the git and p4 commits are all reasonably
independent) or is there a way to avoid it?

Perhaps hook into the pre-receive hook? If the newest p4 changelist is
not the same as the HEAD of the branch being pushed to, then reject
the push, just as would happen if the branch could not be
fast-forwarded in a normal git repo? (Even with this there is still a
small window of opportunity).

At that point, the "git p4 rebase" command would still be used, but
would normally be a no-op.

Or would that result in something far too complicated to have any
chance of working?

Thanks,
Luke
