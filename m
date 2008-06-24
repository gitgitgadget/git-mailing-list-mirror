From: "Alf Clement" <alf.clement@gmail.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 20:22:32 +0200
Message-ID: <556d90580806241122i5e38ebf0ma7c60a7d3a6f5225@mail.gmail.com>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Christian Holtje" <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDAz-0004eN-QM
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbYFXSWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYFXSWi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:22:38 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:16069 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYFXSWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:22:36 -0400
Received: by yx-out-2324.google.com with SMTP id 31so560154yxl.1
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hubD/3AvkK3gLeESYQqEIO2EuV7+C71QRTqQPLnbcas=;
        b=arkb5WSxClzYLrNuwH64JOrn0fJRYXsaloh1GwtLkyFQGjRvRlk8oBu/kIphYTfBHO
         61czyI1jEY622XTUTAKOwZ0frCFw/JQzPIPHffM2xzhLpY+FB/A0LP23kZ1ecAeTEUmX
         Ygj/5rVXNHWrAGrR1cI5DS7zujHirtW488ivM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Bf/NrfCpIGcACFUEE5FMdPjNJ34K/Jdcb7jU9WnNOyG+AhJZ36uX4OGtq66pcn/FLS
         gxHVCUvJhns3ZRpbhuWg9tBe25zQ63bJBgXRr1zC5PSpCMZh/vJRmtHnILoJoaoPIYjA
         TCoYHH7VnbUYpXjLUvmfCtXJc95DQd0wiLGQA=
Received: by 10.142.148.10 with SMTP id v10mr6024403wfd.317.1214331752641;
        Tue, 24 Jun 2008 11:22:32 -0700 (PDT)
Received: by 10.150.121.1 with HTTP; Tue, 24 Jun 2008 11:22:32 -0700 (PDT)
In-Reply-To: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86100>

Hi Christian,

thanks for the patch. I use git under Windows and also run often into
these problems,
because I have to (but don't like to) use come compilers under Windows.
I usually comment the two bad_lines() in the pre-commit-hook out by hand:
"trailing whitespace" and "indent SP followed by TAB", because i.e.
Visual Studio writes some files out, which trigger these checks.

Can't we get rid of these checks?

CU,
Alf

On 6/24/08, Christian Holtje <docwhat@gmail.com> wrote:
> When commit files that use DOS style CRLF end-of-lines, the pre-commit
> hook would raise an error.  When combined with the fact that the hooks
> get activated by default on windows, it makes life difficult for
> people working with DOS files.
>
> This patch causes the pre-commit hook to deal with crlf files
> correctly.
>
> Signed-off-by: Christian H√∂ltje <docwhat@gmail.com>
> ---
>   t/t7503-template-hook--pre-commit.sh |   75 +++++++++++++++++++++++++
> +++++++++
>   templates/hooks--pre-commit          |   10 ++++-
>   2 files changed, 83 insertions(+), 2 deletions(-)
>   create mode 100755 t/t7503-template-hook--pre-commit.sh
>
> diff --git a/t/t7503-template-hook--pre-commit.sh b/t/t7503-template-
> hook--pre-commit.sh
> new file mode 100755
> index 0000000..8f0c3c9
> --- /dev/null
> +++ b/t/t7503-template-hook--pre-commit.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Christian H√∂ltje
> +#
> +
> +test_description='t7503 templates-hooks--pre-commit
> +
> +This test verifies that the pre-commit hook shipped with
> +git by default works correctly.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'verify that autocrlf is unset' '
> +   if git config core.autocrlf
> +   then
> +     false
> +   else
> +     test $? -eq 1
> +   fi
> +'
> +
> +test_expect_success 'lf without hook' '
> +
> +	echo "foo" > lf.txt &&
> +	git add lf.txt &&
> +	git commit -m "lf without hook" lf.txt
> +
> +'
> +
> +test_expect_success 'crlf without hook' '
> +
> +	echo "foo\r" > crlf.txt &&
> +	git add crlf.txt &&
> +	git commit -m "crlf without hook" crlf.txt
> +
> +'
> +
> +# Set up the pre-commit hook.
> +HOOKDIR="$(git rev-parse --git-dir)/hooks"
> +mkdir -p "${HOOKDIR}"
> +cp -r "${HOOKDIR}-disabled/pre-commit" "${HOOKDIR}/pre-commit"
> +chmod +x "${HOOKDIR}/pre-commit"
> +
> +test_expect_success 'lf with hook' '
> +
> +	echo "bar" >> lf.txt &&
> +	git add lf.txt &&
> +	git commit -m "lf with hook" lf.txt
> +
> +'
> +test_expect_success 'crlf with hook' '
> +
> +	echo "bar\r" >> crlf.txt &&
> +	git add crlf.txt &&
> +	git commit -m "crlf with hook" crlf.txt
> +
> +'
> +
> +test_expect_success 'lf with hook white-space failure' '
> +
> +	echo "bar " >> lf.txt &&
> +	git add lf.txt &&
> +	! git commit -m "lf with hook" lf.txt
> +
> +'
> +test_expect_success 'crlf with hook white-space failure' '
> +
> +	echo "bar \r" >> crlf.txt &&
> +	git add crlf.txt &&
> +	! git commit -m "crlf with hook" crlf.txt
> +
> +'
> +
> +test_done
> diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
> index b25dce6..335ca09 100644
> --- a/templates/hooks--pre-commit
> +++ b/templates/hooks--pre-commit
> @@ -55,8 +55,14 @@ perl -e '
>   	if (s/^\+//) {
>   	    $lineno++;
>   	    chomp;
> -	    if (/\s$/) {
> -		bad_line("trailing whitespace", $_);
> +	    if (/\r$/) {
> +		if (/\s\r$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}
> +	    } else {
> +		if (/\s$/) {
> +		    bad_line("trailing whitespace", $_);
> +		}
>   	    }
>   	    if (/^\s* \t/) {
>   		bad_line("indent SP followed by a TAB", $_);
> --
> 1.5.5.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
