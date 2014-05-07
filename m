From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Tue, 6 May 2014 18:16:30 -0700
Message-ID: <CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com> <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
 <xmqqa9aug4my.fsf@gitster.dls.corp.google.com> <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
 <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 03:17:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhqU0-0004Mk-7g
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 03:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbaEGBRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 21:17:12 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:58134 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaEGBRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 21:17:11 -0400
Received: by mail-qg0-f53.google.com with SMTP id f51so317835qge.26
        for <git@vger.kernel.org>; Tue, 06 May 2014 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dRoLu3oD/FK35t5lJaEnfY/ZteMQBitioWFMVsw8Z6k=;
        b=JsfRZgVmVU7mItdCxzhCZ7YaWSayg2z0EuK9tgHAayIBzVIzoOuE55DweGGhxlTmTl
         rRREWDY+A2gmx5rNLjfa1xwHMsofWyUYNNVV1vtIQSEEQRK/VkF7BJ8huIuR+B0TypWK
         tBbtjaZRlP7sKp2fcXG4fTGAM4HvSr/WHgrNR/fEDX3QRniLU7QL9XG99mxs1se01yRN
         yO0Ed6JNtUqBvr8fUgcmJhOb8UR6+66r+075egio1P9qk7cdccOxuGr/PQCQejftvkNj
         FvR6smueqxH9U6g7o+nbcLJI0nHlvOUlSfivyd5R0VFwqQz8pspwLdRGoYzPGUjWVsV/
         qYXQ==
X-Received: by 10.224.67.195 with SMTP id s3mr60985574qai.96.1399425430236;
 Tue, 06 May 2014 18:17:10 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Tue, 6 May 2014 18:16:30 -0700 (PDT)
In-Reply-To: <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248276>

On Tue, May 6, 2014 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nathan Collins <nathan.collins@gmail.com> writes:
>
>> But 'git apply' could be much more helpful than 'patch' even, since
>> the presence or absence of the 'a/' and 'b/' prefixes in the patch,
>> and the 'diff.noprefix' setting, give Git enough info to be very
>> helpful to the user.
>
> The prefix would be unreliable as the generator may be using the
> mnemonicprefix option to use i/ and w/ prefixes.  Worse yet, the
> configuration variables are for people who generated the diff you
> are feeding "git apply", and there is nothing that tells "apply"
> that the patch is generated with _your_ setting.

More concretely, what I had in mind was that if 'diff.noprefix=true'
is set in the user's config, and the patch is in '-p0' format, then
Git could suggest to the user that the 'diff.noprefix' setting *might*
be causing them to generate '-p0' patches. If the user had in fact not
generated the patch themselves, then they could safely ignore the
suggestion.

But this may just be an overcomplicated solution to my and others'
misuse of the 'diff.noprefix' option; see below.

> So that is not workable.
>
> However, Before issuing this error message
>
>>   git -c diff.noprefix=true diff HEAD~ | git apply --reverse
>>   error: Data/Function/Decorator/Memoizer/Unsafe.hs: No such file or directory
>
> we _could_ check that there is Data/ directory in the target tree
> the patch is being applied and suggest to:

To clarify, the actual path was

  src/Data/Function/Decorator/Memoizer/Unsafe.hs

The path in the error message,

  Data/Function/Decorator/Memoizer/Unsafe.hs

was the '-p1' version of that path. This is extra confusing if the
user is unfamiliar with the '-p' option for patch and unaware that
'git apply' is assuming '-p1'.

>  * "use -p0", if noprefix, which I agree with Jonathan is an insane
>    thing to use by default, is common enough; or
>
>  * "use different setting for -p$n", if noprefix is not common.
>
> in the error message.  Extra computation necessary to do so would
> happen only in the error codepath, and we wouldn't mind spending
> some cycles if they help the end user.

I'm starting to think there are really two separate issues here:

1. 'git apply' doesn't give a very helpful error message when the
patch does not apply due to not being in '-p1' format.

2. the 'diff.noprefix=true' option is used for two unrelated things in
practice. One of them is related to diffing -- namely, making Git
generate '-p0' patches -- and the other is unrelated to diffing --
namely, users want file names that can be easily copied with
double-click.

For (1), I think the solution is check if the patch makes sense as
'-p0', in the error case, and tell the user about this in the error
message as you suggested above.  In fact, in case the '-p1' path
doesn't exist, Git could just try all possible '-p$n' values, and
report the first that yields valid paths, if any. Mentioning to the
user that they have 'diff.noprefix=true' set in case '-p0' is
discovered might be helpful, but a better solution to (2) might
eliminate this problem in practice.

For (2), the solution may be to add a separate
'diff.add-clickable-paths' option (probably there is a better name?
'diff.add-copyable-paths'? ...), which makes Git insert clickable
paths in the comments in the diff output. This handles the
clickable-paths use case which lead me and others to abuse
'diff.noprefix=true'. Examples where people suggest using
'diff.noprefix=true' to make it easier to double-click copy paths
include [1 - 5]. Examples where people suggest using 'noprefix' to
generate '-p0' patches include [6 - 10].

Concretely, if 'diff.add-clickable-paths' is set, then instead of e.g.

  diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
b/src/Data/Function/Decorator/Memoizer
  index 3ef17da..a0586d3 100644
  --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
  +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs

we get e.g.

  # src/Data/Function/Decorator/Memoizer/Unsafe.hs
  diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
b/src/Data/Function/Decorator/Memoizer
  index 3ef17da..a0586d3 100644
  --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
  +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs

as the diff header.

In any case, warning the user in the 'diff.noprefix' docs that the
point of the option is to create '-p0' patches, and that setting this
permanently will cause bad interactions with other Git commands (like
'git apply') seems like a great idea -- you suggested this in your
first email, but I hadn't really understood why my use of
'diff.noprefix' was "insane" yet. This probably won't help people that
blindly use 'noprefix' in the "insane" way based on a suggestion they
found with Google, but it can't hurt. If there were a
'diff.add-clickable-paths' option, then the 'diff.noprefix' docs could
also mention this, and suggest the user use that instead if their use
case is the "easy copy" use case.

Thank you both for pointing out that my usage of 'diff.noprefix=true'
is insane. Sorry if my suggestion for the 'diff.add-clickable-paths'
option is also insane; making the 'git apply' error message better --
keeping in mind that users who use 'noprefix' to create clickable
paths may not even know what "'-p$n' patch" is -- is probably
sufficient in practice.

Cheers,

-nathan

References for copy and paste:

[1] http://stackoverflow.com/a/20370519/470844: answer to SO question
about why there are 'a/' and 'b/' prefixes. Last comment says that
'--no-prefix' makes copy and paste easier.

[2] https://coderwall.com/p/oaekvg: points out that 'noprefix' makes
copy and paste easier.

[3] http://git.661346.n2.nabble.com/PATCH-git-jump-ignore-custom-prefix-in-diff-mode-tp7567162p7567308.html:
post to Git mailing list with user mentioning they use 'noprefix' to
make copy and paste easier.

[4] http://hugogiraudel.com/2014/03/17/git-tips-and-tricks-part-2/:
blog post suggesting you can set 'noprefix' to make it easier to copy
and paste file names.

[5] http://www.databasesandlife.com/why-subversion-is-better-than-git/:
page arguing that SVN is better than Git (hahaha) because in SVN you
can copy file names from diff output with double click, but in Git
there is an annoying leading 'a/' or 'b/'. A Git defender replies
suggesting that 'noprefix' can be used to make copy/paste work.

References for creating '-p0' patches:

[6] http://tamsler.blogspot.com/2009/02/patching-with-git-diff.html

[7] http://stackoverflow.com/questions/4610744/can-i-get-a-patch-compatible-output-from-git-diff

[8] http://lists.drupal.org/pipermail/development/2011-April/038006.html

[9] http://www.lullabot.com/blog/article/git-best-practices-upgrading-patch-process

[10]
http://scribu.net/wordpress/contributing-to-wordpress-using-github.html:
SVN uses '-p0' patches, so they suggest using 'noprefix' to generate
SVN compatible patches from Git.
