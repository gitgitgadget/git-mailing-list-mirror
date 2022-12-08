Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D25C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 11:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLHLv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 06:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLHLu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 06:50:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7234083248
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 03:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670500187; bh=iCtTkOSx8qcHaOalX61i+ywOr7N//yCXA4ghHJtjBrE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LzH68sv+L1c8yJm+KRxL8RcDzsfVB8wTBcJPieUkM6HBaYjq1g/Q8a/gZ1sTOoqPJ
         FWGUrB2WY+1i2QSmOpPaR5AdJL/DTWAO0qL5uB4u8Wnh9NaI+CnCTjw619caDjqECB
         duEaFnd6nmf0NMZXYcman8buhPPOYl6MR/DcgiMgRxyPixYEn6gcoYZ5jhCcDZ2YLL
         kgfgWK7ASmXM/WN8AYRK0keQ8tfFbSR7P5g2IvtBQvTD/qYH2pzjT2JA9AepqmIAa8
         mHJt2lNo+4uLL2ESlQ1xz3JOn+dhV7gecf27RQHKjZ1QoytlD8sq8W6rMpkOuN25Zw
         lkzHtSpU3elxg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.24.155.134] ([89.1.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1oW6Vv0dSa-00bcOd; Thu, 08
 Dec 2022 12:49:47 +0100
Date:   Thu, 8 Dec 2022 12:49:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] t1509: make "setup" test more robust
In-Reply-To: <617f98dcb40d417fbb48d9c1de8fa9ab650f5370.1668999621.git.gitgitgadget@gmail.com>
Message-ID: <7rs8633n-s68s-4542-o01o-033p86p51p77@tzk.qr>
References: <pull.1425.git.1668999621.gitgitgadget@gmail.com> <617f98dcb40d417fbb48d9c1de8fa9ab650f5370.1668999621.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GbKlye5c6vrsyh0YJWPo3Tkpe80TdZlaYxVuEf5erI4OfXtYwxI
 MFhtdUbGkhIWFcuKNXU2V+PuXh325XnfetEYI0bF8vLFaoc909U12gc82wXhg+X8QPVGj7T
 fcuVd+jf8ChC0/ysJQ2dto3OAoHfrf9sVD4/pLaIarswZkDraZXdTP9Ar/JxEQ8tkv9p/tj
 gApIlu65GpzvtEG1iZb4w==
UI-OutboundReport: notjunk:1;M01:P0:KRE+SCkN+kA=;Um+TRLlrJg5b90XXrPJyoWzVMKU
 TZHDZXISpzdlMIt2ehlDEJBRyzvdSARu8LeXOGhWGOk7D6FITCWHD7wIAWlAOqxeSwm91Fg/3
 am35DbZ+8uc/7qsG/Ihfw00Az5MJ24Xv2D5Qt1SZyUhwK2wWfp3RSeGv9YB6atM+66+Vy4cOu
 bZsHCj3rTsh3ESbfSA8sVSDyvkq+tdfAAwPndEwepyy0K5bo8F2WYi8f/lI1nTE98WuCDST10
 FgcL+keJ0bAoqF/ERhuQ9eNC9N0FSSmqWf7usBSKJaWQApQpQTjX/SVvRyQWm7jfuFQoFVbMe
 Dcwl0ZV8X4vs8f+MqcmLIy3jnC/jmdCdJu1aQj+EjZz5/iGoSBSEXtyxiMSvmmEgHTOpvcLEh
 Zr20EBhGubWbJHkowXo6YSxoQg6h/kqtB9EZEJhRHSsPtxlKgWNHdDKWEX/mM/xSS/8TDnWMM
 r7/2QzZsirxA1hR+IhOoWoetBIkZGw4kpcvW9bx2INltcGFCoGPUVSlQlivmHiPacou7geOCD
 Gvvwi4vqxdSGI/HXq76QpIs+ZA5XFMuQTv/cRahoxuBGoogyXwswNADgTFkn/aGbEXJVm+ELt
 MbcjLhXZgkD4G9j18vFam76zrgfPYzZlmi2qxeh0TBhKH7Tw6O3e9FH9tpikuRYGDcfZqy2cP
 xa4TBqhAnIjnH7RTVlS1FdIVOydVlpXP75hFc78IT3e6KFmlok1uD5nvRY+gc8v4qE+ovzRmh
 MOsLRq56BwgoveBCBu/kwrhLRi1ICgpnXgr+5lBulRKXZA33Ef5uDtE0VDNhEnPPnJ7CQyL4n
 G87J8uEMXr/TeC5ih1TUEEXt+LCGKuVTU6zjpxVt1aQ9Zxdi0byqN3yLpp0UwtUQNlLNUKdJg
 RbQT/YTUK4SjqugJJlu+6aaXFp6RLK8RRuvIhmVYWU+XgeROISrYxeaYTKx2pnBROJoJeW7kj
 ilJngA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 21 Nov 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> One of the t1509 setup tests is very particular about the output it
> expects from `git init`, and fails if the output differs even slightly
> which can happen easily if the script is run multiple times since it
> doesn't do a good job of cleaning up after itself (i.e. it leaves
> detritus in the root directory `/`). One bit of cruft in particular
> (`/HEAD`) makes the test fail since its presence causes `git init` to
> alter its output; rather than reporting "Initialized empty Git
> repository", it instead reports "Reinitialized existing Git repository"
> when `/HEAD` is present. Address this problem by making the test do a
> more careful job of crafting its intended initial state.

Good explanation, and the patch is obviously correct.

ACK,
Johannes

>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t1509-root-work-tree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1509-root-work-tree.sh b/t/t1509-root-work-tree.sh
> index eb57fe7e19f..d0417626280 100755
> --- a/t/t1509-root-work-tree.sh
> +++ b/t/t1509-root-work-tree.sh
> @@ -243,7 +243,7 @@ say "auto bare gitdir"
>  # DESTROYYYYY!!!!!
>  test_expect_success 'setup' '
>  	rm -rf /refs /objects /info /hooks &&
> -	rm -f /expected /ls.expected /me /result &&
> +	rm -f /HEAD /expected /ls.expected /me /result &&
>  	cd / &&
>  	echo "Initialized empty Git repository in /" > expected &&
>  	git init --bare > result &&
> --
> gitgitgadget
>
>
