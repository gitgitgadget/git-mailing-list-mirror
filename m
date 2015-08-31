From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Mon, 31 Aug 2015 09:58:49 -0700
Message-ID: <xmqqzj17wg1i.fsf@gitster.mtv.corp.google.com>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 18:59:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWSQ5-0006ts-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 18:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471AbbHaQ6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 12:58:51 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36101 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbHaQ6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 12:58:51 -0400
Received: by pabpg12 with SMTP id pg12so12412850pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Cey0nrWYEX/ADL+39x7veM5KH3Clt73ApyM5J3ovSOM=;
        b=v+x7Om/gomQuP1Q9BjOUdSvgp7ALHjUcwr8W4lezhSqDy0koL4q01fy8FO1J76p3La
         shIW5Lk6U1cFugVp0BMnoUmy36TZNQDvYNZZl0rT9h14haQvdyecLNzFFRvG0S0UZovW
         05JNEfHWuyiUiiRGsB7AHxImbPDEaEvCm1wD3vLEzaQzSo3NcogGB6ToW0xOg/ZLuY1w
         /18GwtgKv+7ZJM3oQxMUcBjO3w8TSHeP/pumNuG88V1jJ8qnVkG6g4W0psmsRlPCBozI
         BHFk31lJNXW7WSuyf59wU/YhYH+h9wvjdIV52jxPZ2U7utSZ7GHLxTD8tRhUcmgBYkv2
         Ct2g==
X-Received: by 10.66.55.66 with SMTP id q2mr38929343pap.94.1441040330655;
        Mon, 31 Aug 2015 09:58:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id xo14sm15306191pac.24.2015.08.31.09.58.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 09:58:49 -0700 (PDT)
In-Reply-To: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
 ("Erik
	=?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sun, 30 Aug 2015 11:18:09
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276891>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> While we are here, remove some boilerplate by using test_commit.
>
> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
> ---

Many of the constructs we see here shows clearly that this is an
ancient part of the codebase ;-), as we would be using the one
parameter form of "git init" and more test_* helpers if we were
writing this script in today's Git codebase.  It may have been
better if you didn't do "while we are here" and corrected only the
&&-chain in patch 1/2 and then updated the style of the tests to
take advantage of the newer facilities recent test-lib has in a
separate patch 2/2, but this will do at least for now.

Will queue.

Thanks.


>  t/t7300-clean.sh | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 27557d6..86ceb38 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -432,9 +432,7 @@ test_expect_success 'nested git work tree' '
>  	(
>  		cd foo &&
>  		git init &&
> -		>hello.world
> -		git add . &&
> -		git commit -a -m nested
> +		test_commit nested hello.world
>  	) &&
>  	(
>  		cd bar &&
> @@ -443,9 +441,7 @@ test_expect_success 'nested git work tree' '
>  	(
>  		cd baz/boo &&
>  		git init &&
> -		>deeper.world
> -		git add . &&
> -		git commit -a -m deeply.nested
> +		test_commit deeply.nested deeper.world
>  	) &&
>  	git clean -f -d &&
>  	test -f foo/.git/index &&
> @@ -601,9 +597,7 @@ test_expect_success 'force removal of nested git =
work tree' '
>  	(
>  		cd foo &&
>  		git init &&
> -		>hello.world
> -		git add . &&
> -		git commit -a -m nested
> +		test_commit nested hello.world
>  	) &&
>  	(
>  		cd bar &&
> @@ -612,9 +606,7 @@ test_expect_success 'force removal of nested git =
work tree' '
>  	(
>  		cd baz/boo &&
>  		git init &&
> -		>deeper.world
> -		git add . &&
> -		git commit -a -m deeply.nested
> +		test_commit deeply.nested deeper.world
>  	) &&
>  	git clean -f -f -d &&
>  	! test -d foo &&
