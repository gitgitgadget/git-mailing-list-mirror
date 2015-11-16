From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Mon, 16 Nov 2015 08:36:31 +0000
Message-ID: <5649958F.2010407@diamand.org>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sunshine@sunshineco.com, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 09:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyFHB-0001hv-O6
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 09:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbbKPIgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 03:36:33 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33260 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbbKPIgc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 03:36:32 -0500
Received: by wmec201 with SMTP id c201so163875770wme.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 00:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UPwjKDzTIEkfMKKJUpMtu7YTQrRvNVwTpP/QNqyZXQ4=;
        b=Pslx2kGDhC7Z1c5qG/am2xIn37wohYEoFzSt9cLgMKgyZr95YveHp8ZNiBkF47cbt4
         A1S+SZdFoQc9b+RU5VBhXzWpDOOoUk+QzP8HzO9YuXQFLeWePNiH4spqyVaEaNzlm8tT
         ZAjPrCaxsDTdGj+0tZAW9/WmxDfrIPFNcyXKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UPwjKDzTIEkfMKKJUpMtu7YTQrRvNVwTpP/QNqyZXQ4=;
        b=dmS0XqoM0yVuTVb+YqGr9ht1yD2yR4qyaA/d04GFbrnUXc+HCC+xuVlywqKBqe1e1M
         GrsPP3wwm2vqqyx3c29dDAr3Dx8mTWk2t3FbFDaDGsRDD3EVDD6jbFKDg/UOKE0SsFz8
         wolH4T7dCrxAoXCMDuhsrZxnfhCHTJ/Efa9OU2wy0nDcwTchsoEJpmlB2l7XHH0kINHP
         9EhT+ECOxviGODldgDpHSbM37czP+ia1PWwvTHAf+EM7yP7o/vCy4MYbi91BuC0/nG0P
         AxwgvFFurU+PZ3njh9pypklmwVu/Ywpi0fcz2OOXRq8/C3URYsarus2+NWJVFFSDGXpk
         0JBw==
X-Gm-Message-State: ALoCoQns0T/UMgzqxhOiccrAdk9tN758joXLxGclJFpk2CAwWn/I5g959i47SDLxICOv7yjMTdVT
X-Received: by 10.194.20.35 with SMTP id k3mr742243wje.19.1447662991091;
        Mon, 16 Nov 2015 00:36:31 -0800 (PST)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id i18sm17374154wmf.6.2015.11.16.00.36.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 00:36:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281330>

On 15/11/15 13:08, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> In rare cases kill/cleanup operations in tests fail. Retry these
> operations with a timeout to make the test less flaky.

Should there be a sleep in that retry_until_success loop so that it 
doesn't spin sending signals to p4d?

Do we need to worry about the time offset being updated (e.g. NTP) while 
this is running?

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   t/lib-git-p4.sh | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 7548225..8d6b48f 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -6,6 +6,10 @@
>   # a subdirectory called "$git"
>   TEST_NO_CREATE_REPO=NoThanks
>
> +# Some operations require multiple attempts to be successful. Define
> +# here the maximal retry timeout in seconds.
> +RETRY_TIMEOUT=60
> +
>   . ./test-lib.sh
>
>   if ! test_have_prereq PYTHON
> @@ -121,22 +125,33 @@ p4_add_user() {
>   	EOF
>   }
>
> +retry_until_success() {
> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
> +    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
> +    do :

  sleep here?

> +    done
> +}
> +
> +retry_until_fail() {
> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
> +    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
> +    do :

  sleep here?

> +    done
> +}
> +
>   kill_p4d() {
>   	pid=$(cat "$pidfile")
> -	# it had better exist for the first kill
> -	kill $pid &&
> -	for i in 1 2 3 4 5 ; do
> -		kill $pid >/dev/null 2>&1 || break
> -		sleep 1
> -	done &&
> +	retry_until_fail kill $pid
> +	retry_until_fail kill -9 $pid
>   	# complain if it would not die
>   	test_must_fail kill $pid >/dev/null 2>&1 &&
>   	rm -rf "$db" "$cli" "$pidfile"
>   }
>
>   cleanup_git() {
> -	rm -rf "$git" &&
> -	mkdir "$git"
> +	retry_until_success rm -r "$git"
> +	test_must_fail test -d "$git" &&
> +	retry_until_success mkdir "$git"
>   }
>
>   marshal_dump() {
>
