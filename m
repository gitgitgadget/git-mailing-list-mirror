From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] blame: add blame.showEmail configuration
Date: Sun, 31 May 2015 11:13:23 -0700
Message-ID: <xmqqa8wkaa4c.fsf@gitster.dls.corp.google.com>
References: <xmqq617bcgva.fsf@gitster.dls.corp.google.com>
	<1433021926-17762-1-git-send-email-qneill@quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 20:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7jm-0006Gj-Jl
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 20:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451AbbEaSN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 14:13:26 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34979 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559AbbEaSNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 14:13:25 -0400
Received: by igbyr2 with SMTP id yr2so46813116igb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5LWVX5hyJVtRsdoLp1Qm4GGTpDyH+Cecf06g3xFht2g=;
        b=Wz/bfVVd9zdo2CvT8l6G6Nc47Qe6H6kZdh8aeYxt8JKOiqDQws3STsZ+uZL0enj34g
         agIG7BN9VtueGRlloOlWtNszXxDFPgyx0oIce1H1j+TqaCxN78QwidanGrN4/5aAC9xG
         DutXQAJnZPiAndDfKHFnIeVJnkKhAfGdUgOJ0P/La/0Oj++cBopJEoC+7+UPYMtPsusT
         S3dDi+qnW7N2AYUD4mAHnlP4GcFk+0GH3uicM/5VFp0S2mhUiwXOK3GEkT738WlXIoi/
         7fkaCLgG3l8j+ubaWjj1zxp3yOrOlLSOC9kCuXe3nTFhgjarbdM+5MQzsGxKimmfALyh
         w0SQ==
X-Received: by 10.107.35.203 with SMTP id j194mr22258653ioj.45.1433096004534;
        Sun, 31 May 2015 11:13:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id rr5sm6176464igb.7.2015.05.31.11.13.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 31 May 2015 11:13:24 -0700 (PDT)
In-Reply-To: <1433021926-17762-1-git-send-email-qneill@quicinc.com> (Quentin
	Neill's message of "Sat, 30 May 2015 16:38:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270340>

Quentin Neill <quentin.neill@gmail.com> writes:

> From: Quentin Neill <quentin.neill@gmail.com>
>
> Complement existing --show-email option with fallback
> configuration variable, with tests.
> ---

The patch itself looks very reasonable.  Thanks for getting back to
us ;-)

A few minor nits:

    - Your in-body "From:" is redundant and unnecessary, as your
      e-mail is coming from the same address.

    - You need "Signed-off-by: Quentin Neill <quentin.neill@gmail.com>"
      after your log message (separate it with a blank line before
      the sign-off, and place the sign-off before the three-dash
      lines).

> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 5cdf3f1..faf1660 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -19,4 +19,66 @@ test_expect_success 'blame --show-email' '
>  		"<E at test dot git>" 1
>  '
>  
> +test_expect_success 'setup showEmail tests' '
> +	echo "bin: test number 1" >one &&
> +	git add . &&
> +	GIT_AUTHOR_NAME=name1 GIT_AUTHOR_EMAIL=email1@test.git git commit -a -m First --date="2010-01-01 01:00:00"
> +'
> +
> +cat >expected_n <<\EOF &&
> +(name1 2010-01-01 01:00:00 +0000 1) bin: test number 1
> +EOF
> +
> +cat >expected_e <<\EOF &&
> +(<email1@test.git> 2010-01-01 01:00:00 +0000 1) bin: test number 1
> +EOF

These two commands outside test_expect_success are part of setup, so

	test_expect_success 'setup showEmail tests' '
        	echo "bin: test number 1" >one &&
                git add one &&
                GIT_AUTHOR_NAME=name1 \
                GIT_AUTHOR_EMAIL=email1@test.git \
                git commit -m First --date="2010-01-01 01:00:00" &&
		cat >expected_n <<-\EOF &&
                (name1 ...
                EOF
                cat >expected_e <<-\EOF
                (<email1@...
		EOF
	'

Also do not hesitate to break overlong lines with "\".

> +find_blame() {

style: "find_blame () {"

Other than that, the patch looks good.

Thanks.
