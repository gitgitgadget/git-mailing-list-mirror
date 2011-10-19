From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] t1300: put git invocations inside test function
Date: Wed, 19 Oct 2011 08:41:25 +0200
Message-ID: <4E9E7115.60303@viscovery.net>
References: <20111012182742.GA14543@sigill.intra.peff.net> <20111012182920.GA18948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:41:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPqM-0004P0-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1JSGle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:41:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54597 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751470Ab1JSGld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:41:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RGPq9-0008Pp-Jx; Wed, 19 Oct 2011 08:41:25 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 58BE41660F;
	Wed, 19 Oct 2011 08:41:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111012182920.GA18948@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183922>

Am 10/12/2011 20:29, schrieb Jeff King:
> @@ -750,13 +759,6 @@ test_expect_success NOT_MINGW 'get --path copes with unset $HOME' '
>  	test_cmp expect result
>  '
>  
> -rm .git/config
> -
> -git config quote.leading " test"
> -git config quote.ending "test "
> -git config quote.semicolon "test;test"
> -git config quote.hash "test#test"
> -
>  cat > expect << EOF
>  [quote]
>  	leading = " test"
> @@ -764,8 +766,14 @@ cat > expect << EOF
>  	semicolon = "test;test"
>  	hash = "test#test"
>  EOF
> -
> -test_expect_success 'quoting' 'cmp .git/config expect'
> +test_expect_success 'quoting' '
> +	rm .git/config &&
> +	git config quote.leading " test" &&
> +	git config quote.ending "test " &&
> +	git config quote.semicolon "test;test" &&
> +	git config quote.hash "test#test" &&
> +	test_cmp expect .git/config
> +'

This innocently looking hunk fails on Windows, because the preceding tests
are skipped, and .git/config does not exist. I was tempted to just change
this to 'rm -f'. But there are a few other instances of 'rm .git/config'
in this file that were *not* moved inside the test function.

How would you like this solved?

- Move this one out again
- Add -f to just this one
- Add -f everywhere
- a combination of the above?

-- Hannes
