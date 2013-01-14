From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Announcing git-reparent
Date: Mon, 14 Jan 2013 15:28:23 -0500
Message-ID: <CAHREChigPiRpwcM5QPEG8UJVro_fTN_a76AZaqowTWbwtw_M-g@mail.gmail.com>
References: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
 <20130114071608.GL3125@elie.Belkin> <CAA01Csoh24ppo37fzptzZKvFrzGQyhz-0eDTQsP8tZiTRQ2YwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqeW-00039B-G6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 21:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758698Ab3ANU2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 15:28:44 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:64819 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab3ANU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 15:28:43 -0500
Received: by mail-pb0-f53.google.com with SMTP id jt11so2356637pbb.40
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 12:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+EavN53YXeiEePzobchhwKZVBmix+pyfpmKbA1Rso2g=;
        b=Fzgep7fv9hznUq3s0a0vrEXQAXOzIjo6FeDsGUsPNsSbaAjXi5EbGbK/UGeGTBqmXH
         MK8rRejGlniDj5P+L5BSo8YsW0ZNe2C9Aw1zJLIYJYDROi8RPKmSXu5tOHLOkKov6Naq
         DBBb77ZWfeI+1z3S2ly0ExZ7PZRkc7Es7FYJgsTd45AjCWAxdL1Z1ikrWgX8bAuI3grz
         Hav4ZZmDT+BpTzDzeOaGCZoVrWrCA6vIulYVDJRlG5kUSPV7jgbJAyHzC3tATPFMrSkT
         CJerzmW30QKF7A+fS7oTcrCbVTvUWWyatGO1m9IG0LkGAz+EmBFKjNWWq+8NJn//Rr4n
         oiPQ==
Received: by 10.68.217.98 with SMTP id ox2mr4873037pbc.96.1358195323184; Mon,
 14 Jan 2013 12:28:43 -0800 (PST)
Received: by 10.68.222.132 with HTTP; Mon, 14 Jan 2013 12:28:23 -0800 (PST)
In-Reply-To: <CAA01Csoh24ppo37fzptzZKvFrzGQyhz-0eDTQsP8tZiTRQ2YwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213529>

On Mon, Jan 14, 2013 at 3:03 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Just wondering, is the result different than something like
>
> git checkout commit_to_reparent
> cp -r * ../snapshot/
> git reset --hard new_parent
> rm -r *
> cp -r ../snapshot/* .
> git add -A
>
> (assumes 1 parent, does not cope with .dot files, and has probably
> other small problems)

The result is similar, but your script would also lose the commit
message and author.  I think the following would do exactly as my
script does (untested):

git checkout commit_to_reparent
git branch tmp
git reset --soft new_parent
git commit -C tmp
git branch -D tmp

I actually contemplated using the above method in my script, rather
than git-commit-tree and git-reset.  In the end, I decided to stick
with my original approach because it does not create any intermediate
state; either an early command fails and nothing changes, or the git
reset works and everything is done.  Using the above might be cleaner
for the --edit flag since it allows the git-commit cleanup of the
commit message, but this would require much more careful error
handling, and might make the reflog uglier.

I'd be interested to hear a git expert's opinion on the choice.
