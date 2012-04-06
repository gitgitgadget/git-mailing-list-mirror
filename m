From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Linear history *and* share a branch?
Date: Fri, 6 Apr 2012 12:04:21 +0200
Message-ID: <CACBZZX7+cp6CwsnWmc8P1i9SabiTOJZXO9w-3E_m1A83gZKA6w@mail.gmail.com>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
 <CACBZZX6za0+MXi4nPiV5ZuCKa91cPz0aye6FZG4gGAdqj0GqcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 12:04:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG62H-0006jA-V7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 12:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893Ab2DFKEo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 06:04:44 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38447 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab2DFKEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 06:04:42 -0400
Received: by eekc41 with SMTP id c41so654477eek.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/9FNGrWIqjGf149jswDtdzB6IqkLMRzYvtwU7s590eY=;
        b=c1KcHqwTudB/2QYpcR9+UJHUgsboaD0q8S/7OBdOPtAA39P2mhBEUtjl3rLJ+5pDM5
         Ip+y/XxWvHF1ZlqDGH4ofYovAqiddxeMxRIQS57ZSjK7hbPJjGdEgwpfCKrIL3p6uf01
         QgF83aMX/LutSoJPXZyGekgaZ+wkcZuhYxshf1VbPMNUlvKTS352ptVkh9UcGxyrLT+7
         w7Df54PpQJr54aVd/C1GnhwRQIdK6Xj31DUptM3AoIO6TjEmGZnpTEQ0vJheR14IZvoE
         EqJlETKC9xV1RyCOWNzQJHfrdaaxTLKaKc1nzECkvDThqidoOPXqBbI1d173ZE/dMcuB
         Qqzg==
Received: by 10.14.99.10 with SMTP id w10mr1223319eef.51.1333706681550; Fri,
 06 Apr 2012 03:04:41 -0700 (PDT)
Received: by 10.213.103.1 with HTTP; Fri, 6 Apr 2012 03:04:21 -0700 (PDT)
In-Reply-To: <CACBZZX6za0+MXi4nPiV5ZuCKa91cPz0aye6FZG4gGAdqj0GqcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194863>

On Thu, Apr 5, 2012 at 22:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Thu, Apr 5, 2012 at 22:48, Hilco Wijbenga <hilco.wijbenga@gmail.co=
m> wrote:
>> Should we simply do "git merge master" instead of "git rebase master=
"?
>> And then do something at the end when we are about to merge the shar=
ed
>> branch back into master to guarantee linear history? Your thoughts a=
nd
>> ideas would be greatly appreciated.
>
> Yes, that's the most sensible workflow to have. You create a topic
> branch, push/pull it back and forth, do merge commits and never rebas=
e
> it, then when you decide if it's finished you can either merge it int=
o
> the mainline (with non-linear history), or have someone rebase it and
> push it to the mainline.
>
> I use the latter workflow extensively in my work e.g. when peer
> programming. We'll both have the same branch set up as a tracking
> branch, make a bunch of WIP commits with crappy commit messages for a
> day or so, then at the end of the day interactively rebase the branch=
,
> and push it with linear history to the mainline.

To elaborate, this is how to do the workflow I'm talking about, with a
git set to push.default=3Dtracking.

The person setting up the topic branch does this, "origin" is our
shared upstream server. This creates a new topic and pushes it:

    git checkout -b team-whatever/some-topic
    git push origin -u team-whatever/some-topic

Everyone else does this:

    git fetch origin
    git checkout -t team-whatever/some-topic

Then everyone hacks, and does a "git pull --no-rebase && git push" to
push work. When you're pair programming and switching between
computers this'll often be:

    git commit -a -m"wip"
    git push

=46ollowed by, on the other box:

    git pull --no-rebase

Then when the topic is ready and you want to push it to the mainline
someone does:

    git fetch origin
    git rebase -i origin/master

and rewords/squashes/fixes up the various commits, followed by:

    # Now fixed up, push to the mainline
    git push origin team-whatever/some-topic:master
    # Nuke the now-redundant topic branch
    git push origin --delete team-whatever/some-topic
