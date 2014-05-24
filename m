From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: commit: support commit.verbose and --no-verbose
Date: Sat, 24 May 2014 00:52:19 -0700
Message-ID: <20140524075219.GA17093@hudson.localdomain>
References: <20140523212222.GA10412@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 09:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo6ks-00039t-LS
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 09:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbaEXHwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 03:52:25 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57305 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaEXHwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 03:52:24 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so5104884pab.24
        for <git@vger.kernel.org>; Sat, 24 May 2014 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EVvZVIKTgrgCnF5W8K1MN+AfSdp7LD4ChU2mzU4ZFjc=;
        b=rqu7StjJINCgczMMWAjpWfTpfaKxPQ0FBhMuFHTbfZmq4UpGDz8D/ZQgMHfNedNeqT
         ZZ17mD0167EZK0dqOyZy/14tMEde1HEgt2zYiGHuO6UTQ+boCln/R1TuK6SEptyX1fta
         BZy+ZlpKCnDFu6buiKPbKLGkQicwbKjR3xBhhNAimdFQgdp/2qiuSN287npu2DLofIkY
         9wdeoZLstjWX/e0O8THfv80CI2UPBQAwibdxoueDhotEbZijWxrLxrps+XjWoIsWsTYJ
         /OONNglhNUvmX5ISmR0adCXuBtopknUQ4eiDydCnLuxfRF3mM2/CyXpazI5JuiehAj0G
         EchA==
X-Received: by 10.68.134.169 with SMTP id pl9mr12078266pbb.133.1400917944069;
        Sat, 24 May 2014 00:52:24 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id oa3sm8054399pbb.15.2014.05.24.00.52.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 May 2014 00:52:22 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 24 May 2014 00:52:19 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140523212222.GA10412@sirius.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250057>


On Fri, May 23, 2014 at 04:22:22PM -0500, Caleb Thompson wrote:
> This patch allows people to set `commit.verbose` to implicitly send `--verbose`
...
>  
> +cat >check-for-no-diff <<EOF
> +#!$SHELL_PATH
> +exec grep -v '^diff --git' "\$1"
> +EOF
> +chmod +x check-for-no-diff
> +

For new tests, commands like this should be placed inside a
test_expect_success structure.  However, I can see why you did it this
way since the code just above it does it this way.
Perhaps others will have some recommendations.

Also, <<\-EOF is used instead of <<EOF to remove the tabs.

test_expect_success 'commit verbose setup' '
	cat >check-for-no-diff <<\-EOF &&
	#!SHELL_PATH
	exec grep -v '^diff --git' "\$1"
	EOF
	chmod +x check-for-no-diff
'

>  
> +test_expect_success 'commit shows verbose diff with set commit.verbose' '
> +	echo morecontent >file &&
> +	git add file &&
> +	git config commit.verbose true &&
> +	check_message message
> +'

'test_config' should be used to set config variables since it
also takes care of un-setting them when the test is complete.

test_expect_success 'commit shows verbose diff with set commit.verbose' '
	echo morecontent >file &&
	git add file &&
	test_config commit.verbose true &&
	check_message message
'

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
