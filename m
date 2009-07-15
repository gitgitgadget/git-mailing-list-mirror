From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: Dividing up a large merge.
Date: Tue, 14 Jul 2009 20:16:54 -0400
Message-ID: <3e8340490907141716j77df346es1f894d6a7f6cb0aa@mail.gmail.com>
References: <20090714233246.GA25390@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: davidb@quicinc.com
X-From: git-owner@vger.kernel.org Wed Jul 15 02:17:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQsBi-0004XK-1P
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 02:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbZGOARU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 20:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZGOART
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 20:17:19 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:38790 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbZGOARP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 20:17:15 -0400
Received: by ewy26 with SMTP id 26so3693558ewy.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tVhjbMd9hocggc0iiuLIOSeN4P0g0EurQyV7MeEHORU=;
        b=cj2f7csbefdcrj7yRE1mYQquPDXgX+H/97TizVJetKnfTM2QfZGBrK4bJh95GqPj4o
         79Ools8WV8qs84FtOY0vmlV1eOIOVCtB2WirN+I/8THj8wX25Aa6emi19cYhX040ltR5
         gy++TYeLqgfEG/nHg0qClikPibcBCdrFJ99YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cAmQy7RU5IA/POHtBxVO+z0Z2yoepwDX+S5Cgf8KbpEnoVO6te6yQp0ZiJTi5gJqj0
         CsEYCKWMH4DuGkc8kMkzhTkezcsoWRJByeY+mvtgohtdh6GIaCt5i32hiZIbguORBYJt
         dIlXCk0LyAqqQhd/hMq82APUvJZvE+SWYhY3Q=
Received: by 10.216.8.77 with SMTP id 55mr1903784weq.220.1247617034147; Tue, 
	14 Jul 2009 17:17:14 -0700 (PDT)
In-Reply-To: <20090714233246.GA25390@huya.quicinc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123277>

On Tue, Jul 14, 2009 at 7:32 PM, <davidb@quicinc.com> wrote:
> I'm trying to figure out a better way of dividing up the effort
> involved in a merge amongst a group of people. =A0Right now, I
> basically describe the merge to each of them, and ask them to
> merge their part, and then 'git checkout HEAD' the other parts.
> They tell me about the commits, along with the files that they've
> merged correctly. =A0When everybody is done, I make a real merge
> commit, and pull in all of their files. =A0It's a lot for me to
> track, and confusing for each person.

What do you mean by describing a merge? git is designed to have all
the information needed for a merge inherent in the repository history.

> I'd like to create a branch we can all push to that we gradually
> work to become the result of a resolved merge. =A0Not only does git
> not want to help me do the merge, but seems to actively be
> fighting against me doing this.
>
> What I thought of was something like telling people to do:
>
> =A0$ git merge v2.6.30
> =A0resolve some files
> =A0$ git checkout HEAD ...rest of files...
> =A0$ git commit; git push
>
> but that 'rest of files' is fairly large and complicated. =A0I can
> think of two ideas:
>
> =A0- Something that basically does a partial 'git reset --hard
> =A0 =A0HEAD' to put many of the files back.
>
> =A0- The ability to specify subpaths on the 'git merge' to do the
> =A0 =A0merge work but limited to a directory or set of files.
>
> Obviously, either case will require someone to still track the
> overall effort and make sure the final state of the tree really
> represents the total merge.
>
> Is there anything that can parse the output of 'git merge-tree'?
> Even just splitting this up and then applying parts of it would
> be helpful. =A0Would it be useful to write something that can apply
> the results output of 'git merge-tree'?

I'm having a hard time understanding the situation here - why can't you=
 just:
$ git checkout -b mergebranch v2.6.30
$ git merge developer1/topic
# Fix conflicts
$ git merge developer2/topic
# Fix conflicts
# etc

Why are there so many conflicts to make this an issue?

If the commits are isolated to small changes, rebasing the developer
topic branches instead of merging may help, by allowing you to take
conflicts one commit at a time. For example, if your problems are
primarily conflicts between developer branches and upstream:

$ git checkout -b mergebranch-dev1 developer1/topic
$ git rebase v2.6.30
# Fix conflicts on a commit-by-commit basis
$ git checkout -b mergebranch-dev2 developer2/topic
$ git rebase v2.6.30
# Fix conflicts on a commit-by-commit basis
$ git checkout -b mergebranch
$ git merge mergebranch-dev1
# Fix any remaining conflicts

If your problems are because of conflicts between developer branches
and each other:
$ git checkout -b mergebranch-dev1 developer1/topic
$ git rebase v2.6.30
# Fix conflicts on a commit-by-commit basis
$ git checkout -b mergebranch-dev2 developer2/topic
$ git rebase mergebranch-dev1
# Fix conflicts on a commit-by-commit basis

These rebasing approaches will change the commit IDs, so your
developers will need to rebase any further work upon these new commit
IDs, but if things are as bad as you say, a commit-by-commit merge
that rebase allows you may be much simpler.
