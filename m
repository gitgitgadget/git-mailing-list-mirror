From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] t4203: fix checks for email address remapping
Date: Sat, 13 Jul 2013 08:29:32 +0200
Message-ID: <51E0F3CC.3040304@googlemail.com>
References: <1373675709-40486-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 08:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxtKp-0004kU-4P
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 08:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab3GMG3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 02:29:30 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:59605 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab3GMG33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 02:29:29 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so6795085eae.26
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=tI/HxIPFl72UtQeE5BlBjoTWqhZixzziR3f19H5mqac=;
        b=P8dKuWbyCpqkVykUObMerQmXE4u2UUjtSOY+0y6OLNc7Ii1vvKFhbaF/n2FKsCMYSY
         0/mVemMpMrS0IQTS6+EIz8O9ujOnbXmS2JxejconQrKAkRrI1yawtuQhd8OiXfkdFmGk
         RZtObbm95FIvi2WYAn3IjIKvdqKrPeAWLDdhtMcJJ6qYXQ/IKv6dSHqIJQotdqc2QR3h
         xpwwHWj6PqpCpuHhyE1d+sCAEgO5x7N1gh6caRxvHL/3cDZcy1ZQNvF8SZYMq/MikjWF
         t+h+mA3hdMQzE8Y6Z8QwKhdZQ1XOxxClklNrr+8UQSv30bkLSCyGP7ZwAeoJOWCNH/RQ
         oqww==
X-Received: by 10.15.52.5 with SMTP id o5mr50906386eew.58.1373696968350;
        Fri, 12 Jul 2013 23:29:28 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n45sm84634277eew.1.2013.07.12.23.29.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 23:29:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1373675709-40486-1-git-send-email-sunshine@sunshineco.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230276>

On 07/13/2013 02:35 AM, Eric Sunshine wrote:
> Two tests in t4203-mailmap.sh set up the mapping <bugs@company.xx> =>
> <bugs@company.xy> in an apparent attempt to check that email address
> remapping works as expected (in addition to name remapping which is also
> tested).  To test the remapping, git-shortlog is invoked but the
> invocation lacks the -e option instructing it to show email addresses,
> hence the tests do not actually prove that address remapping succeeded.
> Fix this by instructing git-shortlog to output email addresses as well.
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> 
> The very last git-shortlog "complex" test in the script does use -e and
> checks that email address remapping actually works, so it's not clear
> that this patch is needed. The <bugs@company.xx> => <bugs@company.xy>
> remapping done by the two tests touched by this patch, however, is
> misleading to the reader since it seems to imply that these two tests
> want to check address remapping as well. Perhaps a better change would
> be to remove the address remapping from these two tests.
> 
> 
>  t/t4203-mailmap.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 842b754..3cf64de 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -102,10 +102,10 @@ test_expect_success 'mailmap.file non-existent' '
>  '
>  
>  cat >expect <<\EOF
> -Internal Guy (1):
> +Internal Guy <bugs@company.xy> (1):
>        second
>  
> -Repo Guy (1):
> +Repo Guy <author@example.com> (1):
>        initial
>  
>  EOF
> @@ -114,15 +114,15 @@ test_expect_success 'name entry after email entry' '
>  	mkdir -p internal_mailmap &&
>  	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
>  	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
> -	git shortlog HEAD >actual &&
> +	git shortlog -e HEAD >actual &&
>  	test_cmp expect actual
>  '
>  
>  cat >expect <<\EOF
> -Internal Guy (1):
> +Internal Guy <bugs@company.xy> (1):
>        second
>  
> -Repo Guy (1):
> +Repo Guy <author@example.com> (1):
>        initial
>  
>  EOF
> @@ -131,7 +131,7 @@ test_expect_success 'name entry after email entry, case-insensitive' '
>  	mkdir -p internal_mailmap &&
>  	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
>  	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&+

So here it is capitalized email address (BUGS@), but at the expect file
it's still lower cased. I think this is a bug.
Junio was trying to fix it in 543f99173c2d2f648d8f846e24875150f7de03d3
(origin/jc/mailmap-case-insensitivity)
So I think we need another yet test case there:
commited:
    Internal Guy <BUGS@Company.xx>
    Internal Guy <bugs@company.xy>

Having just one entry in the mailmap
    Internal Guy <BUGS@Company.xx> <bugs@Company.xy>

should still work with the "shortlog -e"

> -	git shortlog HEAD >actual &&
> +	git shortlog -e HEAD >actual &&
>  	test_cmp expect actual
>  '
>  
> 
