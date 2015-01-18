From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] .clang-format: introduce the use of clang-format
Date: Sun, 18 Jan 2015 12:31:18 +0100
Message-ID: <54BB9986.2040706@web.de>
References: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 12:32:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCo5S-0007t9-C6
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 12:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbARLcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 06:32:01 -0500
Received: from mout.web.de ([212.227.17.12]:57587 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbbARLcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 06:32:00 -0500
Received: from [192.168.178.27] ([79.250.181.50]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LtnvF-1XnCZw1Ihx-0119CT; Sun, 18 Jan 2015 12:31:53
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421530221-39306-1-git-send-email-artagnon@gmail.com>
X-Provags-ID: V03:K0:RxObtooUPeyJrMM1sVE9EQQZn9Z7xdA4OMpAfBXbRSPlBxrZqKm
 CID9sYG4vLKK5SQG68w2R70r0elefxl0cdtkSVJhumgvt/3L/64qqRMsxVXTJ8dfDZGhfzO
 je/5niIdjI1DpR32Lhss9DDyWjqkdnZv9GPsQ4m/CytTE5OqrduYxgiGu8efeA/uceai4cL
 YQ1rjSV4OP2kIg5RLyz6g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262596>

Am 17.01.2015 um 22:30 schrieb Ramkumar Ramachandra:
> Instead of manually eyeballing style in reviews, just ask all
> contributors to run their patches through [git-]clang-format.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>   The idea is to introduce the community to this new toy I found called
>   clang-format. Whether or not it's actually going to be used doesn't
>   bother me too much.
>
>   I'm not 100% sure of the style, but I'll leave you to tweak that
>   using http://clang.llvm.org/docs/ClangFormatStyleOptions.html
>
>   The current code isn't terribly conformant, but I suppose that'll
>   change with time.
>
>   .clang-format | 7 +++++++
>   1 file changed, 7 insertions(+)
>   create mode 100644 .clang-format
>
> diff --git a/.clang-format b/.clang-format
> new file mode 100644
> index 0000000..63a53e0
> --- /dev/null
> +++ b/.clang-format
> @@ -0,0 +1,7 @@
> +BasedOnStyle: LLVM
> +IndentWidth: 8
> +UseTab: Always
> +BreakBeforeBraces: Linux
> +AllowShortBlocksOnASingleLine: false
> +AllowShortIfStatementsOnASingleLine: false
> +IndentCaseLabels: false
> \ No newline at end of file

Why no newline on the last line?

These one would be needed as well to match our style, I think:

	AllowShortFunctionsOnASingleLine: None
	ContinuationIndentWidth: 8

And probably this one:

	Cpp11BracedListStyle: false

However, even then struct declarations that are combined with variable 
declaration and initialization get mangled:

	struct a {
		int n;
		const char *s;
	} arr[] = {
		{ 1, "one" },
		{ 2, "two" }
	};

becomes:

	struct a
	{
		int n;
		const char *s;
	} arr[] = { { 1, "one" }, { 2, "two" } };

It gets formatted better if arr is declared separately.

And this one helps get rid of the added line break between struct a and 
the following brace:

	BreakBeforeBraces: Stroustrup
