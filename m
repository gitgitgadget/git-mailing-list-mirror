From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 4/4] t1006: add tests for git cat-file --allow-unknown-type
Date: Mon, 4 May 2015 21:33:16 -0400
Message-ID: <CAPig+cTOVFem74yr4HPqDRU3-4s_B58jQsx14ntp5FsB0WR6SA@mail.gmail.com>
References: <55463094.9040204@gmail.com>
	<1430663402-26717-1-git-send-email-karthik.188@gmail.com>
	<1430663402-26717-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 03:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpRjl-0004ig-Tp
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 03:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbbEEBdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 21:33:24 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36606 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbbEEBdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 21:33:18 -0400
Received: by igblo3 with SMTP id lo3so99531556igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ypp+EWtkKHBsYiCteWdTHgkR9lg+CCTUvOsnb4pnyhU=;
        b=a/ZJtApyZax6MCPWTdxrgNVZVz3B3ux5vrgPQB5KbIEWM9QeftXL2RTmZXmyCq3Oyd
         UeCk1cN6JxTK5u8PUyfAv/BoAKtgjigxjbFpzTdhzZXlxV7AV5FHqFMF1rZqu91cO53y
         Dqr/kjE9ty/zT5HZWzmlLQWnIhSQohp0XHdTcC4ptBxlaZEPj8jc6LBFiEiskX+pP87W
         YMCBQdz1rMV0sVKauw72YyxdAsKd2TEOt4Lt7MuqXCo1KWf4VLroShUPhGSHzuJhWhbn
         oseJaxjXXKXLGg1foHGfyw+BVoGcCMUB6AZDW47nt2R0on1VJt4xH2NUD+XFNuDlzVUj
         npsQ==
X-Received: by 10.50.66.230 with SMTP id i6mr629988igt.22.1430789597018; Mon,
 04 May 2015 18:33:17 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 18:33:16 -0700 (PDT)
In-Reply-To: <1430663402-26717-4-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: RkrSi4hwt3kipu1qU0paQmZeBQk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268378>

On Sun, May 3, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  t/t1006-cat-file.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ab36b1e..de8eaf1 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -47,6 +47,18 @@ $content"
>         test_cmp expect actual
>      '
>
> +    test_expect_success "Type of $type is correct using --allow-unknown-type" '
> +       echo $type >expect &&
> +    git cat-file -t --allow-unknown-type $sha1 >actual &&

Indentation is still botched in this test and the next one (as
mentioned previously [1]).

[1]: http://article.gmane.org/gmane.comp.version-control.git/268005

> +       test_cmp expect actual
> +    '
> +
> +    test_expect_success "Size of $type is correct using --allow-unknown-type" '
> +       echo $size >expect &&
> +    git cat-file -s --allow-unknown-type $sha1 >actual &&
> +       test_cmp expect actual
> +    '
> +
>      test -z "$content" ||
>      test_expect_success "Content of $type is correct" '
>         maybe_remove_timestamp "$content" $no_ts >expect &&
> @@ -296,4 +308,37 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>         }
>  '
>
> +bogus_type="bogus"
> +bogus_content="bogus"
> +bogus_size=$(strlen "$bogus_content")
> +bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
> +
> +test_expect_success "Type of broken object is correct" '
> +       echo $bogus_type >expect &&
> +       git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "Size of broken object is correct" '
> +       echo $bogus_size >expect &&
> +       git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
> +bogus_content="bogus"
> +bogus_size=$(strlen "$bogus_content")
> +bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
> +
> +test_expect_success "Type of broken object is correct when type is large" '
> +       echo $bogus_type >expect &&
> +       git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success "Size of large broken object is correct when type is large" '
> +       echo $bogus_size >expect &&
> +       git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.0.rc1.250.gfbd73bd
