From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: stop printing raw diff of first bad commit
Date: Thu, 28 May 2015 14:32:27 -0700
Message-ID: <xmqqegm0fkwk.fsf@gitster.dls.corp.google.com>
References: <1432829773-4754-1-git-send-email-tbsaunde@tbsaunde.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Thu May 28 23:32:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy5Pn-00077Y-7z
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbbE1Vcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:32:32 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36002 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbbE1Vca (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:32:30 -0400
Received: by iepj10 with SMTP id j10so48654987iep.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cpPT1P8kZZNxIuK08rcLm6o0eXExCzJLT3Tzwa4F8Ls=;
        b=RzpI0GZiwGpGF7UhKN26zFL1VEkhf7wFK9+JC2FuOZ0QXv7OPuCiL0OQQKSpXANFd7
         7y1IqCBarkWRxHkIePMTv+QHFJtcZH9CNKGqQmFVxSZZgopxaZJyL+dbdKGq+eMNGsyV
         q9H8sOcLSVpIRPY0Neieak98TxJsA1HIqg1t8aget3mSnO/bjhqQHsI6dtyA8sjkWvdo
         UwTGogOEjaGi0k+awQ6skA1tnwMrFe9Erd67LotOmIYQn6N9RgygV5ef42Pf7KFbos/0
         JOq8HWH8SpQNRHE3i7VpnnU6jD3PJWS3BF7sMJiadOTvR4uqeCxI67fuEXCEHuylWPWd
         6pog==
X-Received: by 10.107.40.144 with SMTP id o138mr6253192ioo.66.1432848750165;
        Thu, 28 May 2015 14:32:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id j3sm3017823igx.21.2015.05.28.14.32.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 14:32:28 -0700 (PDT)
In-Reply-To: <1432829773-4754-1-git-send-email-tbsaunde@tbsaunde.org> (Trevor
	Saunders's message of "Thu, 28 May 2015 12:16:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270203>

Trevor Saunders <tbsaunde@tbsaunde.org> writes:

> Signed-off-by: Trevor Saunders <tbsaunde@tbsaunde.org>
> ---
> The test change only kind of tests the change in behavior and doesn't seem all
> that useful.  However I'm not sure if its preferable to not even try and test
> that something isn't output.

As the only objective of this patch is to stop showing that raw
format diff output, I think it is sensible to make sure that the
output no longer happens.

I have a feeling that this patch has some backstory?  It may be
necessary to summarize it in the log message to explain why this is
a good thing to do.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 06b4868..eb820b2 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -591,7 +591,8 @@ test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
>  			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
>  			>../defaulted.log
>  	) &&
> -	grep "$HASH3 is the first bad commit" defaulted.log
> +	grep "$HASH3 is the first bad commit" defaulted.log &&
> +	test 0 -eq $(grep -c '^:' defaulted.log)
>  '

Your single quotes around the pattern are not doing what you think
they are doing.

Why not write this line like this instead?

	! grep "^:" default.log

Thanks.
