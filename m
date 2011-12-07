From: Johan Herland <johan@herland.net>
Subject: Re: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Wed, 7 Dec 2011 17:01:22 +0100
Message-ID: <CALKQrgcQ5jv+oDXxDoTGUhmP-Dg344-oSotb+q-4a3fnEBY1Zw@mail.gmail.com>
References: <4EDF74EC.6090504@fechner.net>
	<CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com>
	<4EDF87A6.4000703@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 17:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJwC-0000cg-9y
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 17:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab1LGQBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 11:01:31 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:59171 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545Ab1LGQB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 11:01:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RYJvx-000MKj-Gd
	for git@vger.kernel.org; Wed, 07 Dec 2011 17:01:25 +0100
Received: by faar15 with SMTP id r15so186137faa.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 08:01:23 -0800 (PST)
Received: by 10.50.237.5 with SMTP id uy5mr19874791igc.50.1323273682731; Wed,
 07 Dec 2011 08:01:22 -0800 (PST)
Received: by 10.42.229.193 with HTTP; Wed, 7 Dec 2011 08:01:22 -0800 (PST)
In-Reply-To: <4EDF87A6.4000703@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186469>

On Wed, Dec 7, 2011 at 16:35, Matthias Fechner <idefix@fechner.net> wro=
te:
> Am 07.12.11 15:42, schrieb Ramkumar Ramachandra:
>>
>> Assuming that you actually want to rewrite the history, the situatio=
n
>> calls for a git-reset(1). =C2=A0Just "git reset --hard HEAD~1" on ea=
ch of
>> your branches (Caution: first understand what it does!) and you'll
>
>
> that will not work, because in the master branch I already have aroun=
d 15
> commits after the bogus commit and I want to keep these commits.
>
> And in some other branches there are tons of commits (over 100) after=
 the
> bogus commit with the merge and I only want to remove that bogus comm=
it but
> keep all other commits after the bogus commit (all commits are not re=
lated
> to the bogus one, they are all in different files).
>
> It is even fine if I could remove the bogus commit from all branches.

Use "git revert $commit" to undo the effects of the given $commit.
This must be applied to all affected branches (either by reverting in
the master branch and remerging master to the other branches, or by
using "git revert" in each individual branch).

Note that the "git revert" command will NOT remove the original bogus
commit. Instead, it will create a new commit that undoes the changes
introduced by the bogus commit. If the same lines/files have been
touched by other commits in the meantime, you might get conflicts that
you'll have to resolve, just like a regular merge.

If you'd rather want the bogus commit to disappear entirely (i.e.
rewrite the history so that it looks like the bogus comit never
happened in the first place), then things get more complicated. You
will need to recreate the history of your master branch, skipping the
bogus commit, and then recreate all the other branches in a similar
manner. The "git rebase" tool will be helpful here, but I recommend
that you understand and get used to how it works before applying it to
this problem. Note that rewriting history is only a good idea when you
haven't shared the history with anyone else. If other people are
already using any of the branches with the bogus commit, then
rewriting the history is a BIG NO-NO. In that case, "git revert" is
the only sane approach.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
