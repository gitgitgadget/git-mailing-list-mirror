From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t7400: fix bogus test failure with symlinked trash
Date: Sat, 30 Jul 2011 12:41:26 +0200
Message-ID: <4E33DFD6.9050709@web.de>
References: <20110730003609.GA6089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 30 12:41:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn6zP-0001bk-7E
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 12:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1G3Klb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 06:41:31 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:51847 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1G3Kla (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 06:41:30 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 42474194771F0;
	Sat, 30 Jul 2011 12:41:29 +0200 (CEST)
Received: from [91.48.110.67] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qn6z3-0002Ss-00; Sat, 30 Jul 2011 12:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110730003609.GA6089@sigill.intra.peff.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+L541DIL7+FEWZIFYpPMqN8zoeoXXrlxxNn3HD
	EpBIGh3fjxg3xFRZ2cmyMsyiWh96/Aa3Q8CR40ZrI+HamV3x+F
	yHpzvuU5Q4i5w1tkXksg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178188>

Am 30.07.2011 02:36, schrieb Jeff King:
> This feels a little funny, because we are probably using the same
> "convert relative to absolute" code to generate our expected value, as
> well as in the test itself. So any bug in that code is likely to be
> masked. But this test isn't really about checking the absolute path
> code, but rather making sure that it is invoked properly.

While the patch itself is good (apart from using backticks, I think
a "$()" should be used there), I share your concerns about loosing
an opportunity to test git functionality against the real world.

What about doing the following instead?

submodurl=$(cd "$TRASH_DIRECTORY"; pwd -P)

(That pattern is already used in t/t0000-basic.sh)

But that is just nitpicking ...

>  t/t7400-submodule-basic.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5afe6cc..12200ca 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -48,7 +48,7 @@ test_expect_success 'setup - repository to add submodules to' '
>  
>  # The 'submodule add' tests need some repository to add as a submodule.
>  # The trash directory is a good one as any.
> -submodurl=$TRASH_DIRECTORY
> +submodurl=`git rev-parse --show-toplevel`
>  
>  listbranches() {
>  	git for-each-ref --format='%(refname)' 'refs/heads/*'
