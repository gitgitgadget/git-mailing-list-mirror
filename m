From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git rm --recursive
Date: Mon, 23 Nov 2015 21:12:42 -0500
Message-ID: <CAPig+cRF+VumPsbZR0mrGyY7Zbiz+yqRK-29iXUxjneNy4efqw@mail.gmail.com>
References: <20151118150637.GA49061@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Hans Ginzel <hans@matfyz.cz>
X-From: git-owner@vger.kernel.org Tue Nov 24 03:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a136C-0000jw-6O
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 03:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbbKXCMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 21:12:45 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34894 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbKXCMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 21:12:43 -0500
Received: by vkha189 with SMTP id a189so2255591vkh.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 18:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=imhqQt2hIRaMZw4fm0hJf2V26HLsm0ybNfhAsa9NK08=;
        b=U9gjOhToSlJHk+U6aesuwz5dTC6AVV7RJtQi8VWUEuJbJsMysle16PAy6gXK2TRk8R
         gQcu3V4dqJr8haUgbF8JNiwwl8wmq6c8tBuryD3bZC300BqRSzfnHC/kVx5bPFlzOR+e
         cEoJqhqg/J7PfbGAHKK3KvYsQZVu1WDboZB5a+LZgXZqCqZHXLlCq2Pn5/cZZ+dPTzys
         dJxJ+oREY0/BwV6VTHTiktVNGvWsmAZcXnmfVHs91HFUEYebTMQy5MKX7qICC8PcSRk6
         bgb7qwC6Qj6TfFosxjrwj5l/cHo0aj/Yrkh07uhk0yPTB15VUEAZnLTov+SIypbEsUX8
         n2cQ==
X-Received: by 10.31.13.205 with SMTP id 196mr23058066vkn.37.1448331162479;
 Mon, 23 Nov 2015 18:12:42 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 23 Nov 2015 18:12:42 -0800 (PST)
In-Reply-To: <20151118150637.GA49061@artax.karlin.mff.cuni.cz>
X-Google-Sender-Auth: Wa34v18KsoUyOBMlKDg_Sy9Y6ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281607>

On Wed, Nov 18, 2015 at 10:06 AM, Hans Ginzel <hans@matfyz.cz> wrote:
> I have added the --recursive alias for the -r option to the rm command.

When sending a patch, separate the patch itself from the above
commentary with a scissor line (--- 8< ---) so that git-am can extract
the patch automatically. Alternately, appease git-am by placing the
commentary below the "---" line just above the diffstat.

> From 83f197151c04164b0dfd4d127e72439aebaf8b71 Mon Sep 17 00:00:00 2001
> From: Hans Ginzel <hans@matfyz.cz>
> Date: Wed, 18 Nov 2015 15:44:56 +0100

All three above lines should be dropped. "From SHA1" is meaningful
only in your repository, thus not helpful in the patch. "From:" is the
same as the email address from which you sent the patch, so git-am can
just pick it up from the email envelope. On this project, the
important date is when the maintainer applies the patch, so the above
"Date:" is not interesting.

> Subject: [PATCH] builtin: rm: add --recursive to be consistent with GNU rm

The body of the commit message (following the subject) would be a good
place to explain why --recursive is desirable. Consistency with GNU
'rm' may be reasonable, but you may need to be more persuasive to
convince people that the project should support yet another alias for
an existing option and that whatever future maintenance that involves
(documentation and code) is really worthwhile, especially since nobody
has expressed interest in such an alias as yet.

Also, if you're aiming for consistency with GNU 'rm' (or even BSD
'rm'), wouldn't you want to support -R, as well?

Similarly, git-rm's -f option behaves differently than -f of Unix 'rm'
in that even with -f, git-rm still expects the named path to exist,
whereas Unix 'rm' does not. Is that difference also worth addressing,
or is that an argument against trying to make git-rm consistent with
GNU 'rm'?

Your Signed-off-by: is missing. See Documentation/SubmittingPatches.

More below...

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> @@ -47,6 +47,7 @@ OPTIONS
> -r::
> +--recursive::
>         Allow recursive removal when a leading directory name is
>         given.
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> @@ -269,7 +269,7 @@ static struct option builtin_rm_options[] = {
> -       OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive
> removal")),
> +       OPT_BOOL('r', "recursive",      &recursive,  N_("allow recursive
> removal")),
> diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> @@ -207,12 +207,25 @@ test_expect_success 'Recursive with -r but dirty' '
>         test -f frotz/nitfol
> '
>
> +test_expect_success 'Recursive with --recursive but dirty' '
> +       echo qfwfq >>frotz/nitfol &&
> +       test_must_fail git rm --recursive frotz &&
> +       test -d frotz &&
> +       test -f frotz/nitfol
> +'

This copy/pasted test isn't doing what you think it's doing. It would
pass even if you had totally botched the implementation of
--recursive. That's because it actively expects "git rm --recursive"
to fail, so it would "succeed" for any failure, for instance, due to a
botched implementation.

What you probably want to do instead is create a test which verifies
that "git rm" alone fails when attempting to remove a directory, and
that "git rm --recursive" succeeds.

> test_expect_success 'Recursive with -r -f' '
>         git rm -f -r frotz &&
>         ! test -f frotz/nitfol &&
>         ! test -d frotz
> '
>
> +test_expect_success 'Recursive with --recursive -f' '
> +       git rm -f --recursive frotz &&
> +       ! test -f frotz/nitfol &&
> +       ! test -d frotz
> +'

This copy/pasted test is in even worse shape. It doesn't pass at all,
even with a perfectly operational --recursive implementation. (I'm
guessing that you didn't run the tests after adding this.) This is
because the preceding test, from which this was copied, destroys state
prepared by the earlier "Recursive test setup" test upon which this
new test depends. Without that state, the test can not pass.

Anyhow, if you follow the advice above and just craft a new test which
ensures that "git rm" fails on a directory and "git rm --recursive"
succeeds, then that should be sufficient to verify that --recursive
works as an alias for -r, and you can drop these two (bogus)
copy/pasted tests.

> test_expect_success 'Remove nonexistent file returns nonzero exit status' '
>         test_must_fail git rm nonexistent
> '
> --
> 1.9.1
