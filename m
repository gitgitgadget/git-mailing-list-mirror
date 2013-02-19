From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] t7502: demonstrate breakage with a commit message
 with trailing newlines
Date: Mon, 18 Feb 2013 21:39:20 -0800
Message-ID: <20130219053919.GE19757@elie.Belkin>
References: <1361247427-438-1-git-send-email-drafnel@gmail.com>
 <1361247427-438-2-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 06:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7fvk-0002MM-2u
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 06:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab3BSFj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 00:39:26 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:59266 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab3BSFjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 00:39:25 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so2048161pbc.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 21:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6eTW5F2SNxNOT4nBW6tC1tdYuTcw7XUuMmnt9BQ1cA4=;
        b=r4WBWQzZG161ocXpu6WFaJz/2iWD8H14uuduHbzvB//F2tZqEbfGgAxx0efcKtklBy
         UOOQ/Z3zbVtuOiz1LB/adVH3a8Kxn3iPqUDMQ9HPOA6GvHZpF/UvUL1NV0IgfFG7ngxk
         7xo8ZKfroO/ZcrY+fWd7HeurK1TZywP/WyX8C6n0pSYNnu/p+x9VTOoVLC4GkjLC2EQK
         F8GE2uykMUEIG/11iTaO0Qv1fFoqf2nDt7EXVilIpldO/Dqh+WFDqKcuiFtCQyz22PYA
         Mzzub3MbOfLbHNLP7Vp0UteW7CXWOtwdp8Zsie9iJaVNvRWC5ioic7+Dy28Qm7kTrWZV
         HBMA==
X-Received: by 10.68.252.70 with SMTP id zq6mr36999299pbc.136.1361252365364;
        Mon, 18 Feb 2013 21:39:25 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id km10sm16803269pbc.9.2013.02.18.21.39.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 21:39:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1361247427-438-2-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216563>

Brandon Casey wrote:

> This test attempts to verify that a commit message supplied to 'git
> commit' via the -m switch was used in full as the commit message for a
> commit when --cleanup=verbatim was used.
[...]
> The test was able to complete successfully since internally, git appends
> two newlines to each string supplied via the -m switch.
[...]
> Mark this test as failing, since it is not handled correctly by git.
> As described above, git appends two extra newlines to every string
> supplied via -m.

Good catch.  This is an old one, triggered by a combination of

 v1.5.4-rc0~78^2~23 builtin-commit: resurrect behavior for multiple -m
                    options, 2007-11-11

and

 v1.5.4-rc2~3^2 Allow selection of different cleanup modes for commit
                messages, 2007-12-22

The patch makes sense and makes the test easier to read, so
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(Patch left unsnipped for reference.)

> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  t/t7502-commit.sh | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
> index 9040f8a..39e55f8 100755
> --- a/t/t7502-commit.sh
> +++ b/t/t7502-commit.sh
> @@ -177,10 +177,18 @@ test_expect_success 'verbose respects diff config' '
>  	git config --unset color.diff
>  '
>  
> +mesg_with_comment_and_newlines='
> +# text
> +
> +'
> +
> +test_expect_success 'prepare file with comment line and trailing newlines'  '
> +	printf "%s" "$mesg_with_comment_and_newlines" >expect
> +'
> +
>  test_expect_success 'cleanup commit messages (verbatim option,-t)' '
>  
>  	echo >>negative &&
> -	{ echo;echo "# text";echo; } >expect &&
>  	git commit --cleanup=verbatim --no-status -t expect -a &&
>  	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
>  	test_cmp expect actual
> @@ -196,10 +204,10 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
>  
>  '
>  
> -test_expect_success 'cleanup commit messages (verbatim option,-m)' '
> +test_expect_failure 'cleanup commit messages (verbatim option,-m)' '
>  
>  	echo >>negative &&
> -	git commit --cleanup=verbatim -m "$(cat expect)" -a &&
> +	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
>  	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
>  	test_cmp expect actual
>  
> -- 
