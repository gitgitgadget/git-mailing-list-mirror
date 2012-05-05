From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Sat, 5 May 2012 18:38:02 +0200
Message-ID: <CAMP44s1dhAjKt3mxVmg2+0qp-QTyjYb1knhxf+m177Cg2ZBC1Q@mail.gmail.com>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120505155423.GA14684@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 18:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQhzo-0003w5-Ch
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 18:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756982Ab2EEQiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 12:38:06 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57565 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab2EEQiE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 12:38:04 -0400
Received: by eekc41 with SMTP id c41so1081773eek.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Dm1qOLwBW9kKg9wAK4oRKUFrg9arG1wmiUbpSUtOuB8=;
        b=JzhuTFlfS79VdbZVyz3c6tp5vBsTWGt/9WFfkdy53knsl5B6dkUfkem3/PJV91PUax
         E+WuQUeumRm7x3E0I20QxdoUyu3sS1frPzgj7eiaGyIL17p3Cm2YLDeCjwRU7uXJlZbi
         y0M/0tU0Q6LWgDymnUxUzQIBaN5QErI/sOEw59cxls0UjuOOLAfl/EFRYacdmqlo2NwM
         6npaCuaoftTc+VMsD/G8qgkIv9FGOeA79O1nZnXgr9lh71qKJEeFSdOznVqR2DSMRcwt
         nbM8fy7UQ03UkK48kFSToGftLqtx6tEApC7wh3gwvHh4L/92SBhvH31lQ47bILSqZR9P
         wL8A==
Received: by 10.213.107.193 with SMTP id c1mr1803364ebp.120.1336235882827;
 Sat, 05 May 2012 09:38:02 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 09:38:02 -0700 (PDT)
In-Reply-To: <20120505155423.GA14684@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197122>

On Sat, May 5, 2012 at 5:54 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Felipe Contreras wrote:
>
>> Since v3:
>>
>> =C2=A0* Rename to _GIT_complete to follow bash completion "guideline=
s"
>> =C2=A0* Get rid of foo_wrap name
>
> Thanks. =C2=A0G=C3=A1bor, does the "all caps _GIT_ prefix for public =
API
> functions" convention look like one we should adopt? =C2=A0If I under=
stand
> correctly, previously contrib/completion/git-completion.bash used
> leading double underscores for everything except completion functions=
,
> so this is a change.
>
> Following a convention similar to the bash-completion project's
> proposed future convention doesn't really help compatibility. =C2=A0I=
f we
> want to be able to include this function in that project without
> change some day, we'd have to call it _BC_git_complete. :)

No, that's for bash-completion's functions, this is a git bash
completion function.

And in any case, if they want something different they can change it
themselves, and they could tell us.

But wasn't you the one that suggested we follow the bash-completion's
guidelines, or that was only when the guidelines happened to match
your preference?

There are basically four arguments that have been brought forward.

1) Namespace

You said there were two namespaces:

> _git_*  (completion functions)
>__git_* (everything else, including public interfaces like __git_ps1)

But that's not actually true, we have these:

  __gitfoo (__gitdir, __gitcomp_1, __gitcomp, __gitcomp_nl)
  __git_foo
  _git_foo
  _git, _gitk

And what is used for what is not exactly clear.

Currently the only function meant to be public is __git_ps1, but
there's other __git_foo functions that are not meant to be public, so
clearly there's no namespace for public functions. Everything is
ad-hoc.

It could be assumed that anything that doesn't start with a _ is
reserved for the user. Of course, there's no such guideline anywhere,
so this would be a self-imposed limitation.

2) Guideline

You brought this argument forward, but it turns out the
bash-completion guys have no actual guideline; they are still trying
to decide what would be the naming for public functions.

If there's anything close to a guideline for bash-completion
functions, it would be a _BC_ prefix. Our script thus would be using
_GIT_ for its public functions. This would mean __git_ps1 should be
renamed to _GIT_ps1.

But now it seems you want to separate from this guideline.

3) Conflicts

Another problem is that a user might already have a function named
like that, which means 'git_complete' has higher chances of collision.
But I wrote checks that would ensure this doesn't happen, still,
nobody was interested in those checks.

It seems people are not interested in *real* conflicts, but rather
theoretical namespace collisions.

4) Convenience

git_complete is nicer than _GIT_complete.


It seems to me the push-back away from 'git_complete' is mostly due to
imaginary reasons, and now apparently specious reasons as well. So I
guess there's no point in discussing; no amount of evidence is going
to convince anybody to anything.

Cheers.

--=20
=46elipe Contreras
