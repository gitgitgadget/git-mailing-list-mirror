From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Tue, 18 May 2010 18:05:16 +0200
Message-ID: <4BF2BABC.2010405@drmicha.warpmail.net>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Tue May 18 18:05:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEPIk-0002lg-9G
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 18:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab0ERQFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 12:05:44 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48375 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752Ab0ERQFn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 12:05:43 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A47DAF39F7;
	Tue, 18 May 2010 12:05:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 18 May 2010 12:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JtEEzKe+XKeHE4xoy+QmuDg06Bc=; b=pByG0O64A6Y8zSf6LheMbwNJLz1M6V05Nu92mnVOIPUuI9m6coZ9FcKwGZq9PcsZfA7ig92XI0n2iMHC9M551i4lLlfZoySK9GogS7DCXU/PkRJFFKUSFdwbWF+ujw7sxJhoeuNKZw+vuObblLOjck3MBs7hStjZxJ6E6SsjLCs=
X-Sasl-enc: Vs1KnyGSJborZQ3T+m7O627mEbjFwKB2x9caa0UQGs9N 1274198723
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D08C94C1A8;
	Tue, 18 May 2010 12:05:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147285>

Yann Droneaud venit, vidit, dixit 18.05.2010 16:41:
> Since I don't have en_US.utf8, some tests failed:
> 
>   * UTF-8 locale not available, test skipped
>   * skip 10: ISO-8859-1 should match UTF-8 in svn
>   * skip 11: eucJP should match UTF-8 in svn
>   * skip 12: ISO-2022-JP should match UTF-8 in svn
> 
> On my system locale -a reports:
> 
>    en_US
>    en_US.ISO-8859-1
>    en_US.UTF-8
> 

locale -a|grep en_US
en_US
en_US.iso88591
en_US.iso885915
en_US.utf8

This is on Fedora 13, which is not exactly exotic. What is your system?

> According to Wikipedia utf8 is not a correct name
> for the UTF-8 encoding:
> http://en.wikipedia.org/wiki/UTF-8#Official_name_and_incorrect_variants
> 
> And compare_svn_head_with() is explicitly using en_US.UTF-8
> locale.
> 
> Signed-off-by: Yann Droneaud <yann@droneaud.fr>
> ---
>  t/t9129-git-svn-i18n-commitencoding.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
> index b9224bd..ec6ed4f 100755
> --- a/t/t9129-git-svn-i18n-commitencoding.sh
> +++ b/t/t9129-git-svn-i18n-commitencoding.sh
> @@ -69,7 +69,7 @@ do
>  	'
>  done
>  
> -if locale -a |grep -q en_US.utf8; then
> +if locale -a |grep -q en_US.UTF-8; then
>  	test_set_prereq UTF8
>  else
>  	say "UTF-8 locale not available, test skipped"

Funny thing is the test succeeds for me, even when run within
LANG=en_US.iso88591.
So I'd suggest to use

-if locale -a |grep -q en_US.utf8; then
+if locale -a |egrep -q 'en_US.utf8|en_US.UTF-8'; then

and embrace for more variants to appear down the road...

Michael
