From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 18:47:00 -0600
Message-ID: <51419b2c0710071747w14d0c265x2de42fca50552394@mail.gmail.com>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
	 <20071007213817.GJ31659@planck.djpig.de>
	 <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
	 <Pine.LNX.4.64.0710080018270.4174@racer.site>
	 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
	 <Pine.LNX.4.64.0710080028301.4174@racer.site>
	 <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
	 <Pine.LNX.4.64.0710080129480.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 02:47:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IegmJ-00073B-BK
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 02:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbXJHArF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 20:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbXJHArE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 20:47:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:52787 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbXJHArB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 20:47:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1476648wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RRVXHtVXLkhOcdAA+pBI7MNe+qpcSts7+lHw+WKKXT8=;
        b=OhXt5Q6VN7aw+Zo5yUfoeSbxl5l6k4IQMNoDYkeuYKVe4TybgZx9CduXyyjGxcHGE+vk+nYZVzCX2W0rZwRlnLxWr7HopXj9N+0lDo1+5/XXFXo6gNrPEz7RYa3a44xtbiJ3o63jZ4BvZrSWnnMeBlUrerOwH7lA+1aUWZYqP8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ug9j0GyfawEfDmEDi5QpxTb3caS0okXi2ye/I7bX39N6SY+QNuAX8RlZ5wnjlWAyUeYav09D3E1iR5i1py5HM4QbWPbuBz4QLY+Nk87NQ2cDDol1hKoOWn1rIUBrv4J/aLzcMsWuK0K5SbmLY4sJiCU3TmuCY2Gbl9Qlqtge8ZU=
Received: by 10.114.37.1 with SMTP id k1mr1403739wak.1191804420711;
        Sun, 07 Oct 2007 17:47:00 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 17:47:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710080129480.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60270>

On 10/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> It should be as easy as git filter-branch and git clone.

Yes, a git filter-branch, git clone, AND git gc in the clone avoids
all those funny ref editing commands.  However, cloning a 5.6GB repo
(the size of one of the real repos I'm dealing with) will likely take
a long time (and may push me past the limits of disk space), so using
other steps to avoid the need to clone actually seems nicer.

> > Oh, and git-filter-branch could really use some explanatory note about
> > how to actually complete rewriting the history.
>
> It does what it should do.  It is _your_ task to look at refs/original/*
> if everything went alright.  Then you just delete the checked refs.
>
> What made your case so cumbersome was that you wanted the big objects out
> _now_, instead of having them in for a grace period.  BTW this grace
> period is in place to help _you_, not the program.  (In case you fscked up
> and need those objects back.)

Sure, I think that's a sane default.  And I think it's fine that it
should be my task to look at the refs to check that everything worked
okay and delete them.  But it's nearly impossible to figure out how to
do that!  _That_ is my complaint.  I got multiple misleading or
incomplete answers (both on this list and in #git) before getting some
working solutions, so this task is obviously far from trivial.  I
really think that adding instructions about how to check and delete
the relevant refs would be a very useful addition to the
documentation.

Thanks everyone for the help!

Elijah
