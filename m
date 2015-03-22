From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 18:26:02 -0400
Message-ID: <CAPig+cQUtUiXx2v6OBsTiE6EoitmxuCk0ua4RoaocNW0rzjLoQ@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-4-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZoJu-0002HS-0t
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 23:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbbCVW0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 18:26:05 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34148 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbbCVW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 18:26:03 -0400
Received: by ykfc206 with SMTP id c206so64033699ykf.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gVyKWHsjgxIQMDcZzGNjOV/gtAYTGbS8R3MzF+VzLQc=;
        b=iQLVbXfCUu8Y0bIfXS+IieZfC7NJcTZ3K+s435zUC8d5s7EvDA1KKXviP2SVBCjnOj
         164bK1iq9jIQ1bWgMN69Lx/F+f7shSDhCkdl2hsf/ohg4IbWUUnCjdqBBC4zIg2Y4mie
         MNelIINba+e5uRvKkQY6MGYQ+uYnXXku9yIdoz6ayjsIq20XaSZL1xVJenlVfH1B6j9/
         dJ4TwrCmzZXNv0c5EINzjGEQIsK1erCyTlWCWYQ0uG/MGNuchzN+xRZem8eJTGjxI20B
         rZgefZaYKmHOMdIGNK1QN3bsC5Fp7d9Lf1oTPLckJ91GfApInDXpQU68nhwRlO7zUEL5
         IrMg==
X-Received: by 10.170.194.7 with SMTP id l7mr69064958yke.91.1427063162638;
 Sun, 22 Mar 2015 15:26:02 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 15:26:02 -0700 (PDT)
In-Reply-To: <1427048921-28677-4-git-send-email-koosha@posteo.de>
X-Google-Sender-Auth: q5y1NrpKI1Zpq_GtgXZSX9ltQK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266099>

On Sun, Mar 22, 2015 at 2:28 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> Subject: Add tests for git-log --merges=show|hide|only

Drop capitalization, mention area you're touching, followed by colon,
followed by short summary:

    t4202-log: add --merges= tests

More below.

> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
> ---
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..ab6f371 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>  * initial
>  EOF
>
> +cat > only_merges <<EOF
> +Merge tag 'reach'
> +Merge tags 'octopus-a' and 'octopus-b'
> +Merge branch 'tangle'
> +Merge branch 'side' (early part) into tangle
> +Merge branch 'master' (early part) into tangle
> +Merge branch 'side'
> +EOF

Current custom is to place this sort of setup code in its own test
rather than having it at top-level. So, the above and below 'cat's
should all go in a test named "setup --merges=" (or something better).
Prefixing EOF with '-' allows you to indent the here-doc content and
EOF so that it reads nicely inside a test. Also prefix EOF with '\' to
indicate that you do not expect interpolation within the here-doc.
Torsten already mentioned to drop the space following '>'. Finally,
within the setup test, chain them all together with &&. So:

    cat >only_merges <<-\EOF &&
    ...
    EOF

More below.

> +cat > only_commits <<EOF
> +seventh
> +octopus-b
> +octopus-a
> +reach
> +tangle-a
> +side-2
> +side-1
> +Second
> +sixth
> +fifth
> +fourth
> +third
> +second
> +initial
> +EOF
> +
> +cat > both_commits_merges <<EOF
> +Merge tag 'reach'
> +Merge tags 'octopus-a' and 'octopus-b'
> +seventh
> +octopus-b
> +octopus-a
> +reach
> +Merge branch 'tangle'
> +Merge branch 'side' (early part) into tangle
> +Merge branch 'master' (early part) into tangle
> +tangle-a
> +Merge branch 'side'
> +side-2
> +side-1
> +Second
> +sixth
> +fifth
> +fourth
> +third
> +second
> +initial
> +EOF

t4202 already does this sort of fragile hard-coding of "expected"
output, so this isn't a particularly strong objection, but it would be
more robust if you could create these "expected" lists dynamically by
issuing some git command other than the one you're testing. (That
could also be considered fodder for a follow-on patch if you don't
consider such a change worthwhile at this time.)

> +
> +test_expect_success 'log with config log.merges=show' '
> +       git config log.merges show &&
> +    git log --pretty=tformat:%s >actual &&

Torsten already mentioned botched indentation. Use (8-character wide)
tab for indentation everywhere.

> +       test_cmp both_commits_merges actual &&
> +    git config --unset log.merges

If the test_cmp fails (because the expected and actual output
differed), then the git-config --unset will never be invoked. To
ensure that the config setting is undone when the test finishes
(whether successful or not), use test_config().

The other option is to ensure that each test sets or clears log.merges
as appropriate at the start of the test, and then not bother about
resetting it. The shortcoming of this approach, however, is that any
tests added following these new tests won't necessarily know that
log.merges is set or that they may need to clear it. Consequently,
test_config() at the start of each of these tests is probably the
better approach.

More below.

> +'
> +
> +test_expect_success 'log with config log.merges=only' '
> +       git config log.merges only &&
> +    git log --pretty=tformat:%s >actual &&
> +       test_cmp only_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log with config log.merges=hide' '
> +       git config log.merges hide &&
> +    git log --pretty=tformat:%s >actual &&
> +       test_cmp only_commits actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log with config log.merges=show with git log --no-merges' '
> +       git config log.merges show &&
> +    git log --no-merges --pretty=tformat:%s >actual &&
> +       test_cmp only_commits actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log with config log.merges=hide with git log ---merges' '
> +       git config log.merges hide &&
> +    git log --merges --pretty=tformat:%s >actual &&
> +       test_cmp only_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=show' '

For these tests which expect log.merges to be unset, it would be more
robust, and the intent clearer, if you actually ensured that it was
unset. test_unconfig() at the start of the test would be the
appropriate way to unset the config. It would also make the tests more
self-contained, in case they are ever re-ordered.

More below.

> +    git log --merges=show --pretty=tformat:%s >actual &&
> +       test_cmp both_commits_merges actual
> +'
> +
> +test_expect_success 'log --merges=only' '
> +    git log --merges=only --pretty=tformat:%s >actual &&
> +       test_cmp only_merges actual
> +'
> +
> +test_expect_success 'log --merges=hide' '
> +    git log --merges=hide --pretty=tformat:%s >actual &&
> +       test_cmp only_commits actual
> +'
> +
> +test_expect_success 'log --merges=show with config log.merges=hide' '
> +       git config log.merges hide &&
> +    git log --merges=show --pretty=tformat:%s >actual &&
> +       test_cmp both_commits_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=show with config log.merges=only' '
> +       git config log.merges only &&
> +    git log --merges=show --pretty=tformat:%s >actual &&
> +       test_cmp both_commits_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=only with config log.merges=show' '
> +       git config log.merges show &&
> +    git log --merges=only --pretty=tformat:%s >actual &&
> +       test_cmp only_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=only with config log.merges=hide' '
> +       git config log.merges hide &&
> +    git log --merges=only --pretty=tformat:%s >actual &&
> +       test_cmp only_merges actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=hide with config log.merges=show' '
> +       git config log.merges show &&
> +    git log --merges=hide --pretty=tformat:%s >actual &&
> +       test_cmp only_commits actual &&
> +    git config --unset log.merges
> +'
> +
> +test_expect_success 'log --merges=hide with config log.merges=only' '
> +       git config log.merges only &&
> +    git log --merges=hide --pretty=tformat:%s >actual &&
> +       test_cmp only_commits actual &&
> +    git config --unset log.merges
> +'

There's an awful lot of repetition in the implementation these new
tests. Such repetition invites errors when composing the tests and
makes them difficult to review (since it's easy to be sloppy in the
review as well). The situation could be improved by introducing a
helper function which performs the tests, controlled by a few
parameters. For instance, the helper could accept three arguments: (1)
optional value of --merges=, (2) optional value of log.merges, (3)
name of "expected" file. It also suggests that you should normalize
the names of the "expected" files ("expect_show", "expect_only",
"expect_hide") so that the 3rd argument can be short and sweet. Let's
say that the helper is test_log_merges(), then you would invoke it as:

    test_log_merges "" "" show
    test_log_merges "" show show
    test_log_merges "" only only
    ...
    test_log_merges hide "" hide
    ...
    test_log_merges only hide only

for all combination of --merges= and log.merges.

> +
>  test_expect_success 'log --graph with merge' '
>         git log --graph --date-order --pretty=tformat:%s |
>                 sed "s/ *\$//" >actual &&
> --
> 2.3.3.263.g095251d.dirty
