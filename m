From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 2/2] difftool: add support for --trust-exit-code
Date: Tue, 28 Oct 2014 02:34:09 -0700
Message-ID: <20141028093407.GA20944@gmail.com>
References: <544CAC30.7000607@kdbg.org>
 <1414372542-3485-1-git-send-email-davvid@gmail.com>
 <1414372542-3485-2-git-send-email-davvid@gmail.com>
 <xmqq38a9tkqt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Adri Farr <14farresa@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 10:34:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xj3A6-0001p7-1i
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 10:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbaJ1Jdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 05:33:53 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39261 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbaJ1Jdu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 05:33:50 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so332539pad.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2014 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+FC9VXdw2xjjqJ/A0/WpBec8zdVEFloIr2GjNbqXdOM=;
        b=LSOxWOXMc+FRsCZyLpCfTkEfZm9lWTm45fKkqMcsg3/vKHuxfk362xJyBZRrEUkQIC
         LPuEn3X4DJZZZBe0hmff9aibeaFYO7TtMN7MkVZPnNtmxAfQeJkK9pCLMDdbAOsjXOGx
         fSqFQnB6gsBrVxQwvYbrgaVO9J7nXyIcpTMHu9W7HmbHH4d/hiLupv/bgnz8vpSHVVNz
         Lo67fIrIaQQq0a3KHMj6v1FkP9FPo5JUn89/JjV7qiZrIV0+/7Wsl+g1R7nYdpVCmdRv
         X9fHSZoIDsJbwa5HHMbaT640knPUuuaiZRjKGIdx52Ow66Kdopx1Hw6zSpErNBeXCAlk
         zZJw==
X-Received: by 10.66.138.47 with SMTP id qn15mr2162470pab.82.1414488830019;
        Tue, 28 Oct 2014 02:33:50 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id dl1sm1144237pbc.16.2014.10.28.02.33.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 Oct 2014 02:33:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq38a9tkqt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 11:45:14AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > +write_script .git/fail-right-file <<\EOF
> > +echo "$2"
> > +exit 1
> > +EOF
> 
> This should be inside the next one, no?
> 
> > +test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
> > +	>for-diff &&
> > +	git add for-diff &&
> > +	echo file>expect &&
> > +	test_must_fail git difftool -y --trust-exit-code \
> > +		--extcmd .git/fail-right-file branch >actual &&
> > +	test_cmp expect actual &&
> > +	git reset -- for-diff &&
> > +	rm -f for-diff .git/fail-right-file
> > +'
> 
> In other words, this squashed in.


Yes, please.  And drop patch 1/2, of course.
Thanks for the clarification.


> 
>  t/t7800-difftool.sh | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 4b2f611..69bde7a 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -104,20 +104,19 @@ test_expect_success PERL 'difftool ignores exit code with --no-trust-exit-code'
>  	git difftool -y --no-trust-exit-code -t error branch
>  '
>  
> -write_script .git/fail-right-file <<\EOF
> -echo "$2"
> -exit 1
> -EOF
> -
>  test_expect_success PERL 'difftool stops on error with --trust-exit-code' '
> +	test_when_finished "rm -f for-diff .git/fail-right-file" &&
> +	test_when_finished "git reset -- for-diff" &&
> +	write_script .git/fail-right-file <<-\EOF &&
> +	echo "$2"
> +	exit 1
> +	EOF
>  	>for-diff &&
>  	git add for-diff &&
> -	echo file>expect &&
> +	echo file >expect &&
>  	test_must_fail git difftool -y --trust-exit-code \
>  		--extcmd .git/fail-right-file branch >actual &&
> -	test_cmp expect actual &&
> -	git reset -- for-diff &&
> -	rm -f for-diff .git/fail-right-file
> +	test_cmp expect actual
>  '
>  
>  test_expect_success PERL 'difftool honors --gui' '

-- 
David
