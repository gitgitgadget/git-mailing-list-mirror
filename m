From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git leaves repo in bad state in out-of-space situation
Date: Sun, 17 Apr 2011 17:38:20 +0400
Message-ID: <BANLkTim4=eKQ2wq73Lf5zrjOND-r1n0XCw@mail.gmail.com>
References: <BANLkTi=4EvRZK_bK=JrwiZgfaeHvNgj-dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luke Hutchison <luke.hutch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 15:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBSBT-0003bQ-Ka
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 15:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418Ab1DQNiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Apr 2011 09:38:23 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55948 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1DQNiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2011 09:38:21 -0400
Received: by qwk3 with SMTP id 3so2051268qwk.19
        for <git@vger.kernel.org>; Sun, 17 Apr 2011 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tiXx510iJCefp54AmAX2iNlqCrjPu8yhVs5oJgCQgZ0=;
        b=IdC4oddozHYE8TM3wevvYpVb9ie3zilCRRJhiCu1QfruVNQeV7Fy7wqkdrSJi2QZpg
         GUixrlrwHwoy+x5t6WTu6uuhTClYNbYN8Iz4k2FIgF7zHYQnN4exTfQemOmlH7+q2YRM
         MP+fN+LRRpHYD8+HJW1RvCQR57xQPlwJd82EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=erILwbq0dd9r7jn4v7Go4wxTi1RL1jXM4YypyeCb0+5QSozEb6jMZvcja3eRTYl44B
         pR7nftmt/jJ4PLBNtK9OTo5xshN/AvlSVGwilyBRjRfvdiOvLf2lMW1ZA9yvdza9qC3I
         P9kngt6hviL+BZjY/eQp9InJt6wkl3M0xHGQs=
Received: by 10.229.17.17 with SMTP id q17mr2735373qca.154.1303047500930; Sun,
 17 Apr 2011 06:38:20 -0700 (PDT)
Received: by 10.229.185.21 with HTTP; Sun, 17 Apr 2011 06:38:20 -0700 (PDT)
In-Reply-To: <BANLkTi=4EvRZK_bK=JrwiZgfaeHvNgj-dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171719>

Hi,

On Sun, Apr 17, 2011 at 10:40 AM, Luke Hutchison <luke.hutch@gmail.com>=
 wrote:
> I just did a git pull and ran out of disk space halfway through, whic=
h
> left me with a bunch of "Could not create file <filename>" errors. =A0=
I
> freed up space and tried to repeat the git pull. =A0Now my repo is
> b0rked:
>
> $ git pull
> Updating eedace8..a37dbb1
> error: Your local changes to the following files would be overwritten=
 by merge:
> =A0 =A0 =A0 =A0<list of some of the pulled files>
> Please, commit your changes or stash them before you can merge.
> error: The following untracked working tree files would be overwritte=
n by merge:
> =A0 =A0 =A0 =A0<a lot more of the pulled files>

The repository is not borked, it's just your working tree is in an
inconsistent state, but it is easy to fix:

git reset --hard HEAD

i.e. to discard all changes in your working tree. BTW, it is not only
useful in the above situation, but when in the process of merging you
discover that you've resolved some conflicts in the wrong way and want
to re-do all merge again.

> I wasn't sure how to fix this, and this was probably the wrong
> response, but I tried "git add . ; git commit -a -m test ; git push"

and that was a silly thing to do... In fact, committing everything
blindly is almost always a bad idea...

BTW, did you mean "git pull" above? Because if you did "git push"
then those bogus changes are at the server now.

> and got a bunch of merge conflicts due to zero-length binary files
> (PNGs etc.). =A0Repeating this again I get "up to date" but some of m=
y
> files have now been replaced in the repo with zero-length versions,
> which seems dangerous if I didn't notice it and just assumed that git
> had worked its magic and fixed the situation.

git does not do magic, it does exactly what you say. If you said in
the previous commit to change some files to have a zero length then
you should not be surprise that they are empty now.

It always helps to run "gitk --all" to see what you are doing.

> I know that gracefully handling out-of-diskspace situations is a pain=
,
> and it's hard to catch each corner case. =A0But it seems like git cou=
ld
> degrade a little more elegantly in this situation (e.g. files should
> not just be created with zero length if there is no disk space left).
> Thoughts?

Creating or not creating files with zero length would not make any
practical difference here (instead of having zero it would be appeared
removed). There are many situations when checkout (reading files to
the work tree may fail in the middle), for instance, the user could
press CTRL-C, which will leave the working in an inconsistent state.

So, the general solution is only one:

  git reset --hard HEAD


Dmitry
