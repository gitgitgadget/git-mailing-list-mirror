From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] t3404: rebase -i: demonstrate short SHA-1
 collision
Date: Sat, 24 Aug 2013 23:16:49 -0700
Message-ID: <20130825061649.GS2882@elie.Belkin>
References: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
 <1377303042-50868-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 08:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTdC-0002bd-0T
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 08:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756028Ab3HYGQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 02:16:54 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38489 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab3HYGQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 02:16:53 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so2206328pdj.7
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=REbIeV7bRUVNIH2LXasOFzgk4b4Bt0Lt8KJRszkYlfU=;
        b=odGuM8of+CywDLdotsIou+x3bI4zHKwOLDVYlOZsRDXiu+PiXXbiatUAfBKUSieuiz
         CBwcm1SeGIdsZUUx56qWVg/LGQR80M3RzwI2HlcBWu5+0jue0VLQ4cEgDm1CbSm+FoBQ
         qxdVVrNodrz7mbQ0ZnNjSnDMANENEhqHIj70z6w4y3JV9gr8uV3vmb31N6+cGrAHENc8
         t5dcKkelFX2I3QJmGMewm6sUiTMvSpIlDbeTxAgERmSA5011w7jUHiPHIycBs1fFtvuu
         fI5I6klBZ/VKXyCzYCl7r2Wi9bsY5ixIv0anv+Bi6OfxZWFex6QIdGcCDEuw/iCqFOPE
         T4+g==
X-Received: by 10.66.248.198 with SMTP id yo6mr244469pac.143.1377411413550;
        Sat, 24 Aug 2013 23:16:53 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id py4sm10047750pbb.33.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 23:16:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377303042-50868-3-git-send-email-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232929>

Eric Sunshine wrote:

> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1037,4 +1037,28 @@ test_expect_success 'rebase -i with --strategy and -X' '
>  	test $(cat file1) = Z
>  '
>  
> +test_expect_success 'short SHA-1 setup' '
> +	test_when_finished "git checkout master" &&
> +	git checkout --orphan collide &&
> +	git rm -rf . &&
> +	(
> +	unset test_tick &&
> +	test_commit collide1 collide &&
> +	test_commit --notick collide2 collide &&
> +	test_commit --notick collide3 collide
> +	)

Style: would be clearer indented:

	(
		unset test_tick &&
		test_commit ...
	)

> +test_expect_failure 'short SHA-1 collide' '
> +	test_when_finished "reset_rebase && git checkout master" &&
> +	git checkout collide &&
> +	(
> +	unset test_tick &&

Likewise.

Thanks,
Jonathan
