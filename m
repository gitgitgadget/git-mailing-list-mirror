From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] t1400: add some more tests of "update-ref --stdin"'s
 verify command
Date: Wed, 10 Dec 2014 16:10:54 -0800
Message-ID: <20141211001054.GA14446@google.com>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
 <1418255272-5875-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brad King <brad.king@kitware.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyrLR-0004jW-B0
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 01:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbaLKAK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 19:10:57 -0500
Received: from mail-pd0-f201.google.com ([209.85.192.201]:45516 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073AbaLKAK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 19:10:56 -0500
Received: by mail-pd0-f201.google.com with SMTP id ft15so617838pdb.4
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bkirbBVYZjpUWZnAlsDN7J6xSZF/KdWUXS86/u4DXEA=;
        b=iLtYvlxGPt8MK+Ml058v1kV7KQ8LTcyHRlMHu/BZHON4C8tSFYe/7IbDAe9m4o/ang
         X+cuDnopdTHR6i51y2Juiie6iScv6QjnUZuZdtOT88oODBAj71WyeUKbgCjMmKjxE7Dp
         EDbQrlsQKkM3QSd7fHyrIqEQGHVLcv0cBbFGBdyouJyD+ua0JsrtiOHUi/OLZSPqJt2O
         Wuh1V+Cq+MXIEXYDgk5fVEXfGxUtgd95QBGAFlAE7Sk1uNC67yQNfCgGyuXxYMxLwQfR
         GbdZ7AbxEqgkzSEH3cie2rJZI2aK15Esfw77Re+BdRuryMIu84vBIqAFjaYJ0WkO2VQv
         4jxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bkirbBVYZjpUWZnAlsDN7J6xSZF/KdWUXS86/u4DXEA=;
        b=c2zmDsybPQiKlrOh7XmTBTesuyVWZQnlY2tOtZMBtusCo8SmzUbkBZbc/pHRDt1IP3
         sG/e46ifEZd6xTP4cXZ74C+ak+QnH371VzEAlolnD248BrJo6arM4E7/3MaYWbbx0KCy
         WBskld3BKFuTTGyTXBIy7MsxOKatqlV61mqbjeCA7WP+4BOTwHVc2UnRFGSUv2b1ftgF
         9B5zxjz+8SvzSOsEWQoCIWoBCo5rHm9Pz/6ocY7cEodUg+WMlr0gY0yHBgZH89zGfA0J
         45vfvRfGHNqM1iA9AMReBg7a/a4dyqwH/cQwDMSpG+Wsh5oSH487VeAYs7bOfX8tkdTH
         L3bw==
X-Gm-Message-State: ALoCoQmughuNcvM/X9sVV8z10sSkdN1nxOPWCnff4vBqkOARy7uTd67M/Aj6LbvmufcedqPBxg60
X-Received: by 10.67.23.33 with SMTP id hx1mr6104424pad.45.1418256655604;
        Wed, 10 Dec 2014 16:10:55 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id u7si1187171qcf.2.2014.12.10.16.10.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 16:10:55 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id oUkV7cQ3.1; Wed, 10 Dec 2014 16:10:55 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 626FA140BD8; Wed, 10 Dec 2014 16:10:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418255272-5875-2-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261264>

On Thu, Dec 11, 2014 at 12:47:51AM +0100, Michael Haggerty wrote:
> Two of the tests fail because
> 
>     verify refs/heads/foo
> 
> with no argument (not even zeros) actually *deletes* refs/heads/foo.
> This problem will be fixed in the next commit.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Reviewed-By: Stefan Beller <sbeller@google.com>

> The two failing tests have to restore the $m reference when they're
> done because otherwise the bug deletes it, causing subsequent tests
> to fail.
> 
>  t/t1400-update-ref.sh | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 7b4707b..6a3cdd1 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -619,6 +619,52 @@ test_expect_success 'stdin update/create/verify combination works' '
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> +test_expect_success 'stdin verify succeeds for correct value' '
> +	git rev-parse $m >expect &&
> +	echo "verify $m $m" >stdin &&
> +	git update-ref --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'stdin verify succeeds for missing reference' '
> +	echo "verify refs/heads/missing $Z" >stdin &&
> +	git update-ref --stdin <stdin &&
> +	test_must_fail git rev-parse --verify -q refs/heads/missing
> +'
> +
> +test_expect_success 'stdin verify treats no value as missing' '
> +	echo "verify refs/heads/missing" >stdin &&
> +	git update-ref --stdin <stdin &&
> +	test_must_fail git rev-parse --verify -q refs/heads/missing
> +'
> +
> +test_expect_success 'stdin verify fails for wrong value' '
> +	git rev-parse $m >expect &&
> +	echo "verify $m $m~1" >stdin &&
> +	test_must_fail git update-ref --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'stdin verify fails for mistaken null value' '
> +	git rev-parse $m >expect &&
> +	echo "verify $m $Z" >stdin &&
> +	test_must_fail git update-ref --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'stdin verify fails for mistaken empty value' '
> +	M=$(git rev-parse $m) &&
> +	test_when_finished "git update-ref $m $M" &&
> +	git rev-parse $m >expect &&
> +	echo "verify $m" >stdin &&
> +	test_must_fail git update-ref --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'stdin update refs works with identity updates' '
>  	cat >stdin <<-EOF &&
>  	update $a $m $m
> @@ -938,6 +984,52 @@ test_expect_success 'stdin -z update/create/verify combination works' '
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> +test_expect_success 'stdin -z verify succeeds for correct value' '
> +	git rev-parse $m >expect &&
> +	printf $F "verify $m" "$m" >stdin &&
> +	git update-ref -z --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'stdin -z verify succeeds for missing reference' '
> +	printf $F "verify refs/heads/missing" "$Z" >stdin &&
> +	git update-ref -z --stdin <stdin &&
> +	test_must_fail git rev-parse --verify -q refs/heads/missing
> +'
> +
> +test_expect_success 'stdin -z verify treats no value as missing' '
> +	printf $F "verify refs/heads/missing" "" >stdin &&
> +	git update-ref -z --stdin <stdin &&
> +	test_must_fail git rev-parse --verify -q refs/heads/missing
> +'
> +
> +test_expect_success 'stdin -z verify fails for wrong value' '
> +	git rev-parse $m >expect &&
> +	printf $F "verify $m" "$m~1" >stdin &&
> +	test_must_fail git update-ref -z --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'stdin -z verify fails for mistaken null value' '
> +	git rev-parse $m >expect &&
> +	printf $F "verify $m" "$Z" >stdin &&
> +	test_must_fail git update-ref -z --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_failure 'stdin -z verify fails for mistaken empty value' '
> +	M=$(git rev-parse $m) &&
> +	test_when_finished "git update-ref $m $M" &&
> +	git rev-parse $m >expect &&
> +	printf $F "verify $m" "" >stdin &&
> +	test_must_fail git update-ref -z --stdin <stdin &&
> +	git rev-parse $m >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'stdin -z update refs works with identity updates' '
>  	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$Z" "" >stdin &&
>  	git update-ref -z --stdin <stdin &&
> -- 
> 2.1.3
> 
