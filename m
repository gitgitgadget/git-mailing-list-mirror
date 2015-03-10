From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Added tests for git reset -
Date: Tue, 10 Mar 2015 03:49:06 -0400
Message-ID: <CAPig+cRgA5ZMM8d+ep8cyoZpK8FubzDBNVACgGWyWdRgF+nq7w@mail.gmail.com>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com>
	<1425934010-8780-2-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:49:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVEuf-0001W3-4E
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 08:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbCJHtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 03:49:08 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:46172 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbCJHtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 03:49:07 -0400
Received: by yhoc41 with SMTP id c41so21953616yho.13
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n0MPUrdffXLmzaCqor4uKVE0V0yjMeVNFBUfO2FdWVs=;
        b=qKUaEHQBOT5c3Z2whBHrfON6uAVcOPBThL62tjVXe1/eTVOi3wKvCWlgOdHSvbp5LJ
         b3ESKSASe0VG0oJUZyic9Bnsw3KlIV9dHyjZ8QaZNKUaBvCTB2ij0i7xLssMhzlFs+XZ
         OzwlG+7o9vBEqkFHlxCiQMMJMsiMGnsrpc0m3Pb/p+/xtZLCQFxmRmqtrR99HEqaAyZ1
         CCrE1u3IANGZDaAAkYPEUgn4qwHVo02BGXzP6fDQzbFRu3WsnzYkkx0DDKYIgCRrwLdw
         bk1V//EWbNvjSpJElxa80hsrvPWdF8HQQmE+MMykyQTzdWanVxvyGNX2uRqLgtOQS2dF
         se0w==
X-Received: by 10.170.41.16 with SMTP id 16mr32687663ykj.85.1425973746812;
 Tue, 10 Mar 2015 00:49:06 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 00:49:06 -0700 (PDT)
In-Reply-To: <1425934010-8780-2-git-send-email-dyoucme@gmail.com>
X-Google-Sender-Auth: RtTuKJso6JI72JGUD_B74l34LlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265216>

On Mon, Mar 9, 2015 at 4:46 PM, Sundararajan R <dyoucme@gmail.com> wrote:
> As you had suggested @Junio, I have added the required tests.
> Please let me know if there is something is I should add.
>
> Signed-off-by: Sundararajan R <dyoucme@gmail.com>
> Thanks-to: Junio C Hamano
> ---
> I have added 6 tests to check for the following cases:
> git reset - with no @{-1}
> git reset - with no @{-1} and file named -
> git reset - with @{-1} and file named @{-1}
> git reset - with @{-1} and file named -
> git reset - with @{-1} and file named @{-1} and -
> git reset - with @{-1} and no file named - or @{-1}
> The 1st test with no previous branch results in the error
> The 2nd,3rd,4th and 5th result in the ambiguous argument error
> The 6th test has - working like @{-1}

See my review of patch 1 regarding where to place commentary, how to
construct a good commit message, and how to formulate the trailers
(Helped-by:, Signed-off-by:).

> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..a670938 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,111 @@ test_expect_success 'reset --mixed sets up work tree' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'reset - with no @{-1}' '
> +       git init new --quiet &&

Why --quiet?

> +       cd new &&

As Torsten mentioned already, wrap a subshell (via '(' and ')') around
the 'cd' and commands which should be invoked within the subdirectory.
Doing so ensures that tests following this one aren't incorrectly run
within the working directory set by this test.

> +       test_must_fail git reset - >actual &&
> +       touch expect &&

Unless the timestamp of 'expect' is significant, don't use "touch" to
create the file. Instead, just say ">expect &&" on a line by itself.

> +       test_cmp expect actual

What is the intention here? Rather than git-reset's stderr, you've
captured stdout, which doesn't seem particularly interesting.

> +'
> +
> +rm -rf new

This is ineffective since the test just above left you inside the
'new' subdirectory, and there is no 'new' subdirectory within that one
to clean up.

> +cat >expect <<EOF
> +fatal: ambiguous argument '-': both revision and filename
> +Use ./- for file named -
> +Use '--' to separate paths from revisions, like this:
> +'git <command> [<revision>...] -- [<file>...]'
> +EOF

Reproducing the error message verbatim is fragile. Any minor change to
the text will cause the test to fail. Generally speaking, it is
sufficient just to use test_must_fail to ensure that the command fails
as expected. If you feel particularly strongly about checking that the
correct error condition occurred, then just check the error output
using test_i18ngrep() for a significant phrase, such as "ambiguous
argument".

> +test_expect_success 'reset - with no @{-1} and file named -' '
> +       git init new --quiet &&
> +       cd new &&
> +       echo "Hello" > - &&

Drop the space after the redirection operator.

> +       git add -

Broken &&-chain.

> +       test_must_fail git reset - 2>actual &&
> +       test_cmp ../expect actual
> +'
> +
> +cd ..

This is problematic. If the preceding test fails in git-init, before
the "cd new", then this "cd .." will change to the wrong place. Use of
a subshell, as explained above, avoids such problems.

> +rm -rf new
> +
> +cat >expect <<EOF
> +fatal: ambiguous argument '@{-1}': both revision and filename
> +Use '--' to separate paths from revisions, like this:
> +'git <command> [<revision>...] -- [<file>...]'
> +EOF

Rather than doing cleanup ("rm") and preparation ("cat >expect") at
the top-level, place them within the test which requires them, thus
making each test self-contained.

I'll stop reviewing here since the above comments also apply to the
rest of the tests.

> +test_expect_success 'reset - with @{-1} and file named @{-1}' '
> +       git init new --quiet &&
> +       cd new &&
> +       echo "Hello" >@{-1} &&
> +       git add @{-1} &&
> +       git commit -m "first_commit" &&
> +       git checkout -b new_branch &&
> +       touch @{-1} &&
> +       git add @{-1} &&
> +       test_must_fail git reset - 2>actual &&
> +       test_cmp ../expect actual
> +'
> +
> +cd ..
> +rm -rf new
> +
> +cat >expect <<EOF
> +fatal: ambiguous argument '-': both revision and filename
> +Use ./- for file named -
> +Use '--' to separate paths from revisions, like this:
> +'git <command> [<revision>...] -- [<file>...]'
> +EOF
> +
> +test_expect_success 'reset - with @{-1} and file named - ' '
> +       git init new --quiet &&
> +       cd new &&
> +       echo "Hello" > - &&
> +       git add - &&
> +       git commit -m "first_commit" &&
> +       git checkout -b new_branch &&
> +       touch - &&
> +       git add - &&
> +       test_must_fail git reset - 2>actual &&
> +       test_cmp ../expect actual
> +'
> +
> +cd ..
> +rm -rf new
> +
> +test_expect_success 'reset - with @{-1} and file named @{-1} and - ' '
> +       git init new --quiet &&
> +       cd new &&
> +       echo "Hello" > - &&
> +       git add - &&
> +       git commit -m "first_commit" &&
> +       git checkout -b new_branch
> +       echo "Hello" >@{-1} &&
> +       git add @{-1} &&
> +       test_must_fail git reset - 2>actual &&
> +       test_cmp ../expect actual
> +'
> +
> +cd ..
> +rm -rf new
> +
> +test_expect_success 'reset - with @{-1} and no file named - or @{-1} ' '
> +       git init new --quiet &&
> +       cd new &&
> +       echo "Hello" >new_file &&
> +       git add new_file &&
> +       git commit -m "first_commit" &&
> +       git checkout -b new_branch &&
> +       echo "Hey" >new_file &&
> +       git add new_file &&
> +       git reset - &&
> +       git status -uno >file1 &&
> +       git add new_file &&
> +       git reset @{-1} &&
> +       git status -uno >file2 &&
> +       test_cmp file1 file2
> +'
> +
>  test_done
> --
> 2.1.0
