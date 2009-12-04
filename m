From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git reset --hard in .git causes a checkout in that directory
Date: Fri, 04 Dec 2009 09:25:36 -0800
Message-ID: <7vljhislbj.fsf@alter.siamese.dyndns.org>
References: <4B17A166.60306@gmail.com>
 <20091204111158.GE27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten Lankhorst <m.b.lankhorst@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbul-0008GK-9O
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbZLDRZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbZLDRZn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:25:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbZLDRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:25:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24AAAA471D;
	Fri,  4 Dec 2009 12:25:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QBileoKWHPdt/eZmFkSv6zxxBPw=; b=rEpQuf
	uuHUNC/u7BjOYUUnXuhU+D7gdBYFXT7JVGAii2cJr/lqbTCSjnIBFpecVUhRQ1e6
	Q3NROtJZkRi0F0xEQuhcQopM3i4pIuT1/WNDxPioDU1WBF1ks5Knvh2V88atpL6u
	hlWhpIpITMMvO1HH4KmyPeG0hm+mEiCi0OvQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u/S81zhdJetoJ0/lV2HsSRPPkLExq0jO
	m2D6bI1gwCSgxD9CjnFnKwKBPX2Y9kUnviHXOurJwKOsTyQoAgi8m+ggIsi/lyCh
	hwDY5Y1DkgLa6ejtZMTCHR4AwAvfNRrStC140r3ywKhvi/PRgKvCu1uMfDgaWsww
	DYn6bWGQt0w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9950A471B;
	Fri,  4 Dec 2009 12:25:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B359A4719; Fri,  4 Dec 2009
 12:25:38 -0500 (EST)
In-Reply-To: <20091204111158.GE27495@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 4 Dec 2009 06\:11\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D693A3E-E0FA-11DE-8291-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134551>

Jeff King <peff@peff.net> writes:

> Junio, I think the following should go to maint (I didn't bother
> splitting the --merge and --hard code; --merge is in v1.6.2. I assumed
> we don't care about maint releases that far back).

Thanks.  The test already checks that the change won't break soft reset,
which is good, but it does not seem to check/specify what should happen in
the mixed reset in this case (I think it should be allowed).  Could you
add one while at it?

> diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
> index 42bf518..3ddf0ac 100755
> --- a/t/t7103-reset-bare.sh
> +++ b/t/t7103-reset-bare.sh
> @@ -11,6 +11,16 @@ test_expect_success 'setup non-bare' '
>  	git commit -a -m two
>  '
>  
> +test_expect_success 'hard reset requires a worktree' '
> +	(cd .git &&
> +	 test_must_fail git reset --hard)
> +'
> +
> +test_expect_success 'merge reset requires a worktree' '
> +	(cd .git &&
> +	 test_must_fail git reset --merge)
> +'
> +
>  test_expect_success 'setup bare' '
>  	git clone --bare . bare.git &&
>  	cd bare.git
> @@ -20,6 +30,10 @@ test_expect_success 'hard reset is not allowed' '
>  	test_must_fail  git reset --hard HEAD^
>  '
>  
> +test_expect_success 'merge reset is not allowed' '
> +	test_must_fail git reset --merge HEAD^
> +'
> +
>  test_expect_success 'soft reset is allowed' '
>  	git reset --soft HEAD^ &&
>  	test "`git show --pretty=format:%s | head -n 1`" = "one"
> -- 
> 1.6.6.rc1.18.ga777f.dirty
