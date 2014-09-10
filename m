From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] git-notes.txt: Explain how to transfer notes between repos
Date: Thu, 11 Sep 2014 01:31:54 +0200
Message-ID: <CALKQrgfQ4-A=NgR_gSsaSXMjRzQZtXBdvrWbzTBGH3jyfC4bJg@mail.gmail.com>
References: <1410357414-691-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>
To: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 01:32:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRrMx-00045p-98
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 01:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbaIJXcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 19:32:06 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:64354 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbaIJXcF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2014 19:32:05 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XRrMo-000BJQ-23
	for git@vger.kernel.org; Thu, 11 Sep 2014 01:32:02 +0200
Received: by mail-pa0-f47.google.com with SMTP id ey11so10257001pad.6
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 16:31:54 -0700 (PDT)
X-Received: by 10.70.88.163 with SMTP id bh3mr7418053pdb.52.1410391914380;
 Wed, 10 Sep 2014 16:31:54 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Wed, 10 Sep 2014 16:31:54 -0700 (PDT)
In-Reply-To: <1410357414-691-1-git-send-email-sunny@sunbase.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256810>

On Wed, Sep 10, 2014 at 3:56 PM, =C3=98yvind A. Holm <sunny@sunbase.org=
> wrote:
> The documentation for git notes did not mention anywhere how to trans=
fer
> notes between repositories, create a section that explains this topic=
=2E

Thanks! Although there are some online resource containing similar
information (e.g. http://git-scm.com/blog/2010/08/25/notes.html), this
info has obviously been missing from the manual page for way too long.

Your text illustrates well how to work with simple notes sharing
scenarios, where there are typically only a single writer per notes
ref. However, if you have a situation where you and your peers are
contributing to the same notes refs, then you will need a more
sophisticated scheme.

In your current illustration, if you do some notes work on
refs/notes/foo, and your friend does the same, then, when you fetch
from your friend (with the +refs/notes/*:refs/notes/* refspec
configured), their notes work will silently overwrite your own notes
work (the '+' in the refspec causes a "forced update"). What you
typically would want instead, is to fetch your friend's notes refs
into a separate namespace (similar to how git stores remote branches
under refs/remotes/$remote/* instead of directly under refs/heads/*),
so that you can examine their changes before potentially merging them
with your own (using 'git notes merge').

This is a more complicated workflow than the one you sketch out below,
and although it's only really needed for notes ref with multiple
writers, I believe that is such a common use case that it merits at
least a mention in the manual page. I'm not sure if we would need to
sketch out the entire workflow, or whether it's sufficient to merely
mention that a more complicated workflow is needed in the multi-writer
case.


Have fun! :)

=2E..Johan

> Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
> ---
>  Documentation/git-notes.txt | 39 +++++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.tx=
t
> index 310f0a5..4237bec 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -264,6 +264,45 @@ prior to the merge, these will also be removed b=
y this notes merge
>  strategy.
>
>
> +TRANSFERRING NOTES ACROSS REPOSITORIES
> +--------------------------------------
> +
> +Notes are not transferred by default when using the standard
> +fetch/push commands, but has be done explicitly. To fetch all notes
> +from a particular remote, use
> +
> +------------
> +$ git fetch origin refs/notes/*:refs/notes/*
> +------------
> +
> +`git fetch` can be configured to automatically fetch notes from a
> +remote with this command:
> +
> +------------
> +$ git config --add remote.origin.fetch +refs/notes/*:refs/notes/*
> +------------
> +
> +To transfer notes to a remote repository:
> +
> +------------
> +$ git push origin refs/notes/*
> +------------
> +
> +If you don't want to fetch or push all notes stored under
> +`refs/notes/`, replace the asterisk with the specific type of notes
> +you want to transfer:
> +
> +------------
> +$ git fetch origin refs/notes/commits:refs/notes/commits
> +------------
> +
> +or
> +
> +------------
> +$ git push origin refs/notes/commits
> +------------
> +
> +
>  EXAMPLES
>  --------
>
> --
> 2.1.0.127.g0c72b98
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Johan Herland, <johan@herland.net>
www.herland.net
