From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Correct test-parse-options to handle negative ints
Date: Fri, 19 Jun 2015 11:28:47 -0700
Message-ID: <xmqqoakb8sdc.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434705059-2793-2-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 20:28:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6126-0002bO-LA
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 20:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbbFSS2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 14:28:51 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34571 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbbFSS2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 14:28:49 -0400
Received: by igboe5 with SMTP id oe5so22362580igb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+V8+qEjOy8B7rWtAedK+d4cBwz+NPLW/OaI3VJLGPZU=;
        b=xBeT3NSunHp4wvM/fnES9cjtsCWne+l0eSjYBCSfvNw3s3BBJnMu4y/79kp1tVfbEA
         UhM8FFgUMDTMnW26TyOSYXP/hbdiT7lKn5Fj/I8HSLKjiShKuzGnsb4pp5fXuLeyJIVH
         yYo0PBpiOLYtVp9izkA4JmKK6/AEqRSf1bn/zsUTmHdOnl4BSSS11kQGgrWK36VLcHDl
         xeuK+o1RW8kP1DTD02i8XD4uCqQQqCwIOgrJWU6H4gM2SbjDQDMPPtXikGnapgTmNyG1
         iwuQgT+WC1rAwNTMYTNoyQzvy3iIGeD3KrxhhOTaKiHO3cpga5igeNxTo1LasfeTBAKr
         VUdw==
X-Received: by 10.42.96.193 with SMTP id k1mr20266065icn.80.1434738529117;
        Fri, 19 Jun 2015 11:28:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id h138sm7519986ioe.2.2015.06.19.11.28.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 11:28:48 -0700 (PDT)
In-Reply-To: <1434705059-2793-2-git-send-email-charles@hashpling.org> (Charles
	Bailey's message of "Fri, 19 Jun 2015 10:10:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272179>

Charles Bailey <charles@hashpling.org> writes:

> From: Charles Bailey <cbailey32@bloomberg.net>
>
> Fix the printf specification to treat 'integer' as the signed type that
> it is and add a test that checks that we parse negative option
> arguments.
>
> Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
> ---

Makes sense.  Will queue.

>  t/t0040-parse-options.sh | 2 ++
>  test-parse-options.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index b044785..ecb7417 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -151,6 +151,8 @@ test_expect_success 'short options' '
>  	test_must_be_empty output.err
>  '
>  
> +test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
> +
>  cat > expect << EOF
>  boolean: 2
>  integer: 1729
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 5dabce6..7c492cf 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -82,7 +82,7 @@ int main(int argc, char **argv)
>  	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
>  
>  	printf("boolean: %d\n", boolean);
> -	printf("integer: %u\n", integer);
> +	printf("integer: %d\n", integer);
>  	printf("timestamp: %lu\n", timestamp);
>  	printf("string: %s\n", string ? string : "(not set)");
>  	printf("abbrev: %d\n", abbrev);
