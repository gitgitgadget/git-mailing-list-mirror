From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] Added tests for reset -
Date: Tue, 10 Mar 2015 14:29:00 -0400
Message-ID: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
References: <1425984728-27996-1-git-send-email-sudshekhar02@gmail.com>
	<1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 19:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVOtw-0004cq-07
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 19:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbbCJS3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 14:29:04 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:34526 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbCJS3A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 14:29:00 -0400
Received: by yhaf73 with SMTP id f73so1818114yha.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AdZ4/gNAGEn2ssv52RA3wKHiTiSzMqsOwc3J7L6Zi5Y=;
        b=sTyhtbAAY7FoqT1WgE6WpvCpvA8iVtEG05UzzghRsTfn+nzm+14l/V+6HYs7D+jytG
         /6S4+4qQLpE51qe95b+gMVydjFs2YoEVDUmyZNJ4/H/L4V2IKl/2JI1JwTw8ijx1OTRr
         FhQl2SsS1Z8Z8GaYtnBmAAxjPPrxBSaA4fTyYw4lOENw01Wp75KIdjSWyXKAdbO8lqyP
         kLbmCY0MFelxJk2nixITuDUhKFYi+zAb93Ya+8DzKyfNZBDx82TPSkG++mL/ZeOTV3mx
         FXeO1ytE8vNZU6GxgGXARJUZpQgMwuyapphE1IWkE0N4Aqppfx6uejt+G8NSnPoyY3Wc
         1HbA==
X-Received: by 10.170.194.7 with SMTP id l7mr3700041yke.91.1426012140074; Tue,
 10 Mar 2015 11:29:00 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 11:29:00 -0700 (PDT)
In-Reply-To: <1425984728-27996-2-git-send-email-sudshekhar02@gmail.com>
X-Google-Sender-Auth: J6highZXh9D_6RAHNgR9Z2QQk-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265253>

On Tue, Mar 10, 2015 at 6:52 AM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> Added tests for reset -

Mention the area of the project you are changing, followed by a colon,
followed by a short summary of the change. Drop capitalization. Write
in imperative mood.

    t7102: add 'reset -' tests

> Added the following test cases:

Imperative mood: "Add test cases:"

>     1) Confirm error message when git reset is used with no previous branch
>     2) Confirm git reset - works like git reset @{-1}
>     3) Confirm "-" is always treated as a commit unless the -- file option
>     is specified
>     4) Confirm "git reset -" works normally even when a file named @{-1} is
>     present
>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..0faf241 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,143 @@ test_expect_success 'reset --mixed sets up work tree' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'reset - in the presence of file named - with previous branch' '
> +       echo "Unstaged changes after reset:" >expect &&
> +       echo "M -" >>expect &&
> +       echo "M 1" >>expect &&

Mentioned by Matthieu: Use "cat <<-\EOF".

> +       git init no_previous &&
> +       (
> +               cd no_previous &&
> +               >./- &&

Unnecessarily complex ">./-" when ">-" will suffice.

> +               >1 &&
> +               git add 1 - &&
> +               git commit -m "add base files" &&
> +               git checkout -b new_branch &&
> +               echo "random" >./- &&
> +               echo "wow" >1 &&
> +               git add 1 - &&
> +               git reset - >../output

Since you will be comparing this output with "expected" output, it is
customary to name this file "actual".

> +       ) &&
> +       rm -rf no_previous &&

Mentioned by Matthieu: Use test_when_finished(). You want this cleanup
action invoked even if any part of the test fails, so register it as
early as possible for it to be effective; either just before or after
git-init.

> +       test_cmp output expect

When test_cmp() detects a difference in the expected and actual
output, it dumps the difference (in 'diff' format) as debugging
output. It's easier to read 'diff' output, and matches our
expectations more closely, if 'expect' is mentioned before 'actual',
so:

    test_cmp expect actual

> +'
> +test_expect_success 'reset - in the presence of file named - with -- file option' '
> +       echo "Unstaged changes after reset:" >expect &&
> +       echo "M -" >>expect &&
> +       git init no_previous &&
> +       (
> +               cd no_previous &&
> +               >./- &&
> +               >1 &&
> +               git add 1 - &&
> +               git commit -m "add base files" &&
> +               git checkout -b new_branch &&
> +               echo "random" >./- &&
> +               echo "wow" >1 &&
> +               git add 1 - &&
> +               git reset -- - >../output
> +       ) &&
> +       rm -rf no_previous

Broken &&-chain.

> +       test_cmp output expect
> +'
> +test_expect_success 'reset - in the presence of file named - with both pre and post -- option' '
> +       echo "Unstaged changes after reset:" >expect &&
> +       echo "M -" >>expect &&
> +       git init no_previous &&
> +       (
> +               cd no_previous &&
> +               >./- &&
> +               >1 &&
> +               git add 1 - &&
> +               git commit -m "add base files" &&
> +               git checkout -b new_branch &&
> +               echo "random" >./- &&
> +               echo "wow" >1 &&
> +               git add 1 - &&
> +               git reset - -- - >../output
> +       ) &&
> +       rm -rf no_previous

Broken &&-chain.

> +       test_cmp output expect
> +'
> +
> +test_expect_success 'reset - works same as reset @{-1}' '
> +       git init no_previous &&
> +       (
> +               cd no_previous &&
> +               echo "random" >random &&
> +               git add random &&
> +               git commit -m "base commit" &&
> +               git checkout -b temp &&
> +               echo new-file >new-file &&
> +               git add new-file &&
> +               git commit -m "added new-file" &&
> +               git reset - &&
> +               git status --porcelain >../first &&
> +               git add new-file &&
> +               git commit -m "added new-file" &&
> +               git reset @{-1} &&
> +               git status --porcelain >../second
> +       ) &&

In other tests, you performed "rm -rf no_previous &&" cleanup at this
point, but it's missing here.

> +       test_cmp first second
> +'
> +
> +test_expect_success 'reset - with file named @{-1}' '
> +       echo "Unstaged changes after reset:" >expect &&
> +       echo "M @{-1}" >>expect &&
> +       git init no_previous &&
> +       (
> +               cd no_previous &&
> +               echo "random" >./@{-1} &&
> +               git add ./@{-1} &&
> +               git commit -m "base commit" &&
> +               git checkout -b new_branch &&
> +               echo "additional stuff" >>./@{-1} &&
> +               git add ./@{-1} &&
> +               git reset - >../output
> +       ) &&
> +       rm -rf no_previous &&
> +       test_cmp output expect
> +'
> +
>  test_done
> --
> 2.3.1.279.gd534259
