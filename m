From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sun, 9 Nov 2014 09:34:34 -0800
Message-ID: <CAO2U3QiNYCWF_otPnR43gHNA22otR62aC2g8b0CnxVz3rjp7kQ@mail.gmail.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
 <20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 18:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnWOD-0003AH-2w
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 18:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaKIRe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 12:34:56 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:44139 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaKIRe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 12:34:56 -0500
Received: by mail-oi0-f53.google.com with SMTP id a141so4339494oig.26
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uOZHbRUCxWD4LyYdXjTo9oEGfSNm7C58KaKWZUo+1DU=;
        b=chXOnOtTGCqw2v+QkxSkeDNcyAoiAHl67N4vZqoZmM1Onr/X1wvUxweCdVv8s87bmR
         /bvoZkWCOcm7PGjLaODOXZR6j2kYzfc6Kfq0Byf9wfwyxyI1ga4VZPa26qQDFfbtpuwS
         vXr35qcwN9v4kC23KVMzzH3LGmL6VRZQldpC1aSEjqJJl69TbXS1bqfgZt0boWLYtmcn
         9MZqtmO2g7XAbUEqK5puoxbWi6ZK+iDPFOP1JF/0i7gyw2rhA/BzpoHcAwU2Ld3stAOq
         zsh6OL9JYGIVHLI/ZpovohIeXjS8S7ZQN4QoddQBQpRg/vn6xZdz4LlFqbAl/g7AI47U
         JKCA==
X-Received: by 10.202.198.82 with SMTP id w79mr20929060oif.45.1415554495177;
 Sun, 09 Nov 2014 09:34:55 -0800 (PST)
Received: by 10.202.18.132 with HTTP; Sun, 9 Nov 2014 09:34:34 -0800 (PST)
In-Reply-To: <20141109015918.GA24736@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Works for me, thanks =)

I'm curious now, is there an automated build of git running on a mac
anywhere? There's a mac mini running jenkins in my office and it's
possible I could convince someone to let me set up a git build that'll
e-mail me if there's a test failure.

On Sat, Nov 8, 2014 at 5:59 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 08, 2014 at 08:43:54PM -0500, Jeff King wrote:
>
>> Unfortunately I don't have an OS X install handy to test on.
>
> I lied; it turns out I still had access to an old VM. The problem did
> turn out to be rather silly. Here's a patch.
>
> -- >8 --
> Two tests recently added to t1410 create branches "a" and
> "a/b" to test d/f conflicts on reflogs. Earlier, unrelated
> tests in that script create the path "A/B" in the working
> tree.  There's no conflict on a case-sensitive filesystem,
> but on a case-insensitive one, "git log" will complain that
> "a/b" is both a revision and a working tree path.
>
> We could fix this by using a "--" to disambiguate, but we
> are probably better off using names that are less confusing
> to make it more clear that they are unrelated to the working
> tree files.  This patch turns "a/b" into "one/two".
>
> Reported-by: Michael Blume <blume.mike@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The line-diff is hard to read, but if anyone was looking for a chance to
> test-drive contrib/diff-highlight, it does a good job of making the
> change easy to see.
>
>  t/t1410-reflog.sh | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 976c1d4..8cf4461 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -254,36 +254,36 @@ test_expect_success 'checkout should not delete log for packed ref' '
>  '
>
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
> -       test_when_finished "git branch -d a || git branch -d a/b" &&
> +       test_when_finished "git branch -d one || git branch -d one/two" &&
>
> -       git branch a/b master &&
> -       echo "a/b@{0} branch: Created from master" >expect &&
> -       git log -g --format="%gd %gs" a/b >actual &&
> +       git branch one/two master &&
> +       echo "one/two@{0} branch: Created from master" >expect &&
> +       git log -g --format="%gd %gs" one/two >actual &&
>         test_cmp expect actual &&
> -       git branch -d a/b &&
> +       git branch -d one/two &&
>
> -       # now logs/refs/heads/a is a stale directory, but
> -       # we should move it out of the way to create "a" reflog
> -       git branch a master &&
> -       echo "a@{0} branch: Created from master" >expect &&
> -       git log -g --format="%gd %gs" a >actual &&
> +       # now logs/refs/heads/one is a stale directory, but
> +       # we should move it out of the way to create "one" reflog
> +       git branch one master &&
> +       echo "one@{0} branch: Created from master" >expect &&
> +       git log -g --format="%gd %gs" one >actual &&
>         test_cmp expect actual
>  '
>
>  test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
> -       test_when_finished "git branch -d a || git branch -d a/b" &&
> +       test_when_finished "git branch -d one || git branch -d one/two" &&
>
> -       git branch a/b master &&
> -       echo "a/b@{0} branch: Created from master" >expect &&
> -       git log -g --format="%gd %gs" a/b >actual &&
> +       git branch one/two master &&
> +       echo "one/two@{0} branch: Created from master" >expect &&
> +       git log -g --format="%gd %gs" one/two >actual &&
>         test_cmp expect actual &&
> -       git branch -d a/b &&
> +       git branch -d one/two &&
>
> -       # same as before, but we only create a reflog for "a" if
> +       # same as before, but we only create a reflog for "one" if
>         # it already exists, which it does not
> -       git -c core.logallrefupdates=false branch a master &&
> +       git -c core.logallrefupdates=false branch one master &&
>         : >expect &&
> -       git log -g --format="%gd %gs" a >actual &&
> +       git log -g --format="%gd %gs" one >actual &&
>         test_cmp expect actual
>  '
>
> --
> 2.1.2.596.g7379948
>
