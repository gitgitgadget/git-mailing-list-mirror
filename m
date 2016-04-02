From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 6/7] t5520: reduce commom lines of code
Date: Sat, 2 Apr 2016 20:50:06 +0200
Message-ID: <5700145E.4060308@kdbg.org>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
 <1459619912-5445-7-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 20:50:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amQcq-0005qp-1r
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbcDBSuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:50:11 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:47451 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbcDBSuK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:50:10 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3qcnPC0N4wz5tlL;
	Sat,  2 Apr 2016 20:50:06 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6CFA65220;
	Sat,  2 Apr 2016 20:50:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <1459619912-5445-7-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290604>

Am 02.04.2016 um 19:58 schrieb Mehul Jain:
> These two tests are almost similar and thus can be folded in a for-loop.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>   t/t5520-pull.sh | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index fb9f845..e12af96 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -298,15 +298,13 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
>   	test_pull_autostash_fail --rebase --no-autostash
>   '
>
> -test_expect_success 'pull --autostash (without --rebase) should error out' '
> -	test_must_fail git pull --autostash . copy 2>err &&
> -	test_i18ngrep "only valid with --rebase" err
> -'
> -
> -test_expect_success 'pull --no-autostash (without --rebase) should error out' '
> -	test_must_fail git pull --no-autostash . copy 2>err &&
> -	test_i18ngrep "only valid with --rebase" err
> -'
> +for i in --autostash --no-autostash
> +do
> +	test_expect_success "pull $i (without --rebase) is illegal" '
> +		test_must_fail git pull $i . copy 2>err &&
> +		test_i18ngrep "only valid with --rebase" err
> +	'
> +done

Hm. If the implementation of test_expect_success uses the variable, too, 
its value is lost when the test snippet runs. Fortunately, it does not.

You can make this code a bit more robust by using double-quotes around 
the test code so that $i is expanded before test_expect_success is 
evaluated.

You could also change the variable name, but to be sufficiently safe, 
you would have to use an unsightly long name. 'opt' would be just as bad 
as 'i'.

>
>   test_expect_success 'pull.rebase' '
>   	git reset --hard before-rebase &&
>

-- Hannes
