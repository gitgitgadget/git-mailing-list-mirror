From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1020: cleanup subdirectory tests a little
Date: Mon, 18 May 2015 11:29:06 -0700
Message-ID: <xmqqwq05buz1.fsf@gitster.dls.corp.google.com>
References: <1431972817-18178-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes.Schindelin@gmx.de, Jens.Lehmann@web.de,
	git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 18 20:29:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPmz-0003wi-8z
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 20:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbbERS3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 14:29:11 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37876 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbbERS3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 14:29:08 -0400
Received: by igbsb11 with SMTP id sb11so55178682igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=LuElgk2V9RGcLsH6CUO0Z2JJsw6ek/SrkoQi7OsaRmk=;
        b=d/NhqCS73cPD9+D7BTuLfpapZH5aC+bQe/UN1YRWIoXObJVFDQs4IDbiG0LLthMzY4
         cmn+uIsjAD02gLwl5pCGNAABy5mPTnPVm5g6oP/E1WSz4QLg5aTzCO2MdLx2LGkjkMs3
         MZjz6hvbiGrOpXrBx5LVytcHffDfCm1vJXrRwm7iASlqldnjd58g/KL3FqnuowYSrF9Q
         nykn1GrQqKSAb0xGmFjHxQnDGuYdMGXotUAtCxsjqAzWNduBGWTb853nbtjr8YUffOYC
         rl7s2EolKVojyn9gHW5hDkkwgb0ykXDX3UOUFEzcrCon9m7G30hgE19X+9y7Fez3LluP
         57nQ==
X-Received: by 10.107.47.216 with SMTP id v85mr18243009iov.86.1431973747979;
        Mon, 18 May 2015 11:29:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2120:a5f3:f7b6:7da9])
        by mx.google.com with ESMTPSA id d186sm6631714ioe.42.2015.05.18.11.29.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 11:29:07 -0700 (PDT)
In-Reply-To: <1431972817-18178-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 18 May 2015 11:13:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269294>

Stefan Beller <sbeller@google.com> writes:

> When looking through existing tests to point out good style I came across
> t1020, which has a test commented out and the comment wasn't helping me
> either of what the test should accomplish in the future. The code of the
> test is the same as the test before except setting GIT_DIR=. explicitly,
> so it did not ring a bell for me as well.

I think this one should be clear, especially if you did notice the
one that sets GIT_DIR=. explicitly.  It is saying that "git show -s
HEAD" inside the bare repository should be intelligent enough to
realize that it is inside bare repository (hence HEAD cannot be a
file in the working tree); the user's asking for "HEAD" therefore
must mean "the tip commit", and never "(by default the tip commit)
filtered to the pathspec HEAD".

If it does not still work, shouldn't it be marked as
test_expect_failure instead of being commented out?

The first and last hunk to use when-finished looks like a good
change, but is unrelated.

>
> This removes the test, which may have been confusing readers since 2010.
>
> Additionally moves the "rm -fr foo.git" of the next test (where it is
> unrelated) to the previous test, where it makes sense as a cleanup.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t1020-subdirectory.sh | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
> index 2edb4f2..4470ede 100755
> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -163,6 +163,7 @@ test_expect_success 'no file/rev ambiguity check inside .git' '
>  '
>  
>  test_expect_success 'no file/rev ambiguity check inside a bare repo' '
> +	test_when_finished "rm -fr foo.git" &&
>  	git clone -s --bare .git foo.git &&
>  	(
>  		cd foo.git &&
> @@ -170,17 +171,7 @@ test_expect_success 'no file/rev ambiguity check inside a bare repo' '
>  	)
>  '
>  
> -# This still does not work as it should...
> -: test_expect_success 'no file/rev ambiguity check inside a bare repo' '
> -	git clone -s --bare .git foo.git &&
> -	(
> -		cd foo.git &&
> -		git show -s HEAD
> -	)
> -'
> -
>  test_expect_success SYMLINKS 'detection should not be fooled by a symlink' '
> -	rm -fr foo.git &&
>  	git clone -s .git another &&
>  	ln -s another yetanother &&
>  	(
