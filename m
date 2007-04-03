From: "Chris Lee" <clee@kde.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 3 Apr 2007 15:49:59 -0700
Message-ID: <db69205d0704031549g7273da53g817f885705735db2@mail.gmail.com>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	 <7vzm5pur7g.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 00:50:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYrpL-0000o2-Ik
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 00:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992464AbXDCWuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 18:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992466AbXDCWuE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 18:50:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:22236 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992464AbXDCWuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 18:50:01 -0400
Received: by wr-out-0506.google.com with SMTP id 76so4794wra
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 15:50:00 -0700 (PDT)
Received: by 10.114.161.11 with SMTP id j11mr2467979wae.1175640600059;
        Tue, 03 Apr 2007 15:50:00 -0700 (PDT)
Received: by 10.114.66.10 with HTTP; Tue, 3 Apr 2007 15:49:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704031357470.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 2e723a5deb717a66
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43687>

On 4/3/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 3 Apr 2007, Junio C Hamano wrote:
> > So maybe we should retitle this thread from "git-index-pack
> > really does suck.." to "I used git-index-pack in a stupid way"?

Well, I never claimed to be a genius. :)

> See my separate timing numbers, although I bet that Chris can give even
> better ones..
>
> Chris, try applying my patch, and then inside the KDE repo you have, do
>
>         git index-pack --paranoid --stdin --fix-thin new.pack < ~/git/.git/objects/pack/pack-*.pack
>
> (ie index the objects of the *git* repository, not the KDE one). That
> should approximate doing a fair-sized "git pull" - getting new objects. Do
> it with and without --paranoid, and time it.

% time git-index-pack --paranoid --stdin --fix-thin paranoid.pack <
/usr/local/src/git/.git/objects/pack/*pack
pack	bf8ba7897da9c84d1981ecdc92c0b1979506a4b9
git-index-pack --paranoid --stdin --fix-thin paranoid.pack <   5.28s
user 0.24s system 98% cpu 5.592 total

% time git-index-pack --stdin --fix-thin trusting.pack <
/usr/local/src/git/.git/objects/pack/*pack
pack	bf8ba7897da9c84d1981ecdc92c0b1979506a4b9
git-index-pack --stdin --fix-thin trusting.pack <   5.07s user 0.12s
system 99% cpu 5.202 total

So, in my case, at least... not really much of a difference, which is puzzling.

> I bet that what I see as a 7% slowdown will be much bigger for you, just
> because the negative lookups will be all that much more expensive when you
> have tons of objects.

I applied exactly the patch you sent, and it applied perfectly cleanly
- no failures.

I also mailed out the DVD with the repo on it to hpa today, so
hopefully by tomorrow he'll get it. (He's not even two cities over,
and I suspect I could have just driven it to his place, but that might
have been a little awkward since I've never met him.)

Anyway, so, hopefully once he gets it he can put it up somewhere that
you guys can grab it. For reference, the KDE repo is pretty big, but a
"real" conversion of the repo would be bigger; the one that I've been
playing with only has the KDE svn trunk, and only the first 409k
revisions - there are, as of right now, over 650k revisions in KDE's
svn repo. So, realistically speaking, a fully-converted KDE git repo
would probably take up at least 6GB, packed, if not more. Subproject
support would probably be *really* helpful to mitigate that.

-clee
