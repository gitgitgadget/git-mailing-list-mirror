From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 4 Apr 2013 13:13:10 -0600
Message-ID: <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
	<1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
	<87y5cyqhya.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Jed Brown <jed@59a2.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpbV-0003t8-KA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764579Ab3DDTNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:13:13 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:48092 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764493Ab3DDTNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:13:12 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so3069231lbi.28
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JKp1SBWMWgzzH7lOPbZmtPrUIv2cQVvdJxLgsdsgAFo=;
        b=Fa38CkPGO7lSvw/g+QtJvF4/Itrh41CxZ2UewpDa9afvyriCde5OvYtNpwVvqA6LBq
         LpyKuSdR9SElVidBV1Zqde2KwWrnS3E2/62nqS4iCHYOvwHsljYgoe59yD9Vb1neadWp
         8if2IH7QpwLdwSXgZLKtaOKGQ8kxsXVpqWsFCbh4CFiWGnu08N1vKjC9H7P0sQsQ8XYs
         BQ5khtRHa9g7VB9V5EMKg1LFnexI3FJKoYNJxI3oy6rcbomM220uYLh7mHrB84yM8tBC
         /JUxoIkLWcJm97VbgAprxWqjruWYe4LkwQbGutsXS3wlxqZFZnOtPX+hReNO6mUs9Cp1
         BTAw==
X-Received: by 10.112.156.42 with SMTP id wb10mr4284575lbb.32.1365102790481;
 Thu, 04 Apr 2013 12:13:10 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 12:13:10 -0700 (PDT)
In-Reply-To: <87y5cyqhya.fsf@59A2.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220073>

On Thu, Apr 4, 2013 at 12:17 PM, Jed Brown <jed@59a2.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> Ideally we shouldn't do this, as it's not recommended in mercurial
>> documentation, but there's no other way to push multiple bookmarks (on
>> the same branch), which would be the behavior most similar to git.
>
> The problem is that you're interacting with a Mercurial upstream, not a
> Git upstream.  When you're in their playground, you have to play by
> their rules.  Creating new heads is disruptive and not likely to be
> appreciated.

If that's the case, they should disable in the server, just like some
people disable non-fast-forward pushes in git.

The problem is Mercurial, purely and simple, without forcing the push,
how do you expect this to work?

% git clone hg::whatever
% git checkout -b feature-a master
# do stuff
% git push -u origin feature-a

If somebody made a single commit to master (default), you can't push
any more, you have to merge master to feature-a, and if you push
further changes to feature-a and somebody is blocked by that, they
need to merge feature-a to master. It's a completely nonsensical
workflow, and there's nothing _we_ can do about it.

However, it's easy to work around; simply create a 'bookmarks' branch
were people can push unlimited amounts of heads, problem solved. The
people working with traditional permanent branches won't be blocked by
other people pushing bookmarks in a git-like workflow.

Why punish the sane people?

However we can have a configuration to turn this on and off, I would
all it remote-hg.stop-me-from-doing-what-i-just-told-you-to-do. I
don't see the hurry though, specially if (according to you), remote-hg
can't even clone.

Cheers.

-- 
Felipe Contreras
