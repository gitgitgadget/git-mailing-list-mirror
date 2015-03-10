From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] t7510: do not fail when gpg warns about insecure memory
Date: Tue, 10 Mar 2015 10:10:13 +0100
Message-ID: <54FEB4F5.4060602@drmicha.warpmail.net>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com> <20150308220424.GD4245@vauxhall.crustytoothpaste.net> <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com> <20150309012214.GE4245@vauxhall.crustytoothpaste.net> <E72F95BF-BE00-433E-9D05-0DDF1CACCCC1@gmail.com> <54FD6C22.4020808@drmicha.warpmail.net> <b822f2716d8bdfcb6576ad0dc502af5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 10:10:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVGBB-0008I4-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 10:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbbCJJKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 05:10:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44039 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbbCJJKP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 05:10:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CC73920F4A
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 05:10:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 10 Mar 2015 05:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=OzH0kexy8YCYariztwd63N
	2PLzQ=; b=L1iPxJLzFVf5KgBhBBn8qjLPsG4ZZjvJfQcoVuby4MQFGcJhSFWM8w
	7CztldVY+KFxoblVP7+M8BkznnD90qGQjSQhlmjTiN3OFlohmugc5fIujj5G7BBc
	kChXKm9mmcj4Vx6amaatOb3eKVcNlYLw7uOqx8jkKQMxwYjENrQ4c=
X-Sasl-enc: rz5xfoiJMF/FqEKAv35s2mPAsDStfXBQsJxojybEejQw 1425978615
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7398DC002A4;
	Tue, 10 Mar 2015 05:10:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <b822f2716d8bdfcb6576ad0dc502af5@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265220>

Kyle J. McKay venit, vidit, dixit 09.03.2015 21:03:
> Depending on how gpg was built, it may issue the following
> message to stderr when run:
> 
>   Warning: using insecure memory!
> 
> When the test is collecting gpg output it is therefore not
> enough to just match on a "gpg: " prefix it must also match
> on a "Warning: " prefix wherever it needs to match lines
> that have been produced by gpg.
> 
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
> 
> How about this patch instead.  It just treats "Warning:" lines as gpg  
> output

(They are, but gpg fails tp prefix them.)

> and the test still passes when "Warning: using insecure memory"  
> shows up.
> 
> -Kyle

Perfect, thanks!

>  t/t7510-signed-commit.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 474dab38..3cef18cf 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -86,8 +86,8 @@ test_expect_success GPG 'show signed commit with signature' '
>  	git show -s --show-signature initial >show &&
>  	git verify-commit -v initial >verify.1 2>verify.2 &&
>  	git cat-file commit initial >cat &&
> -	grep -v "gpg: " show >show.commit &&
> -	grep "gpg: " show >show.gpg &&
> +	grep -v -e "gpg: " -e "Warning: " show >show.commit &&
> +	grep -e "gpg: " -e "Warning: " show >show.gpg &&
>  	grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
>  	test_cmp show.commit commit &&
>  	test_cmp show.gpg verify.2 &&
> ---
> 
