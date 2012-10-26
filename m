From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] t7407: Fix recursive submodule test
Date: Fri, 26 Oct 2012 21:29:47 +0200
Message-ID: <508AE4AB.4070209@web.de>
References: <CABURp0op2+QUvusUmAFUxT8s8c02bB9V3=ag9gTTSiiN4t96OA@mail.gmail.com> <1351278834-28867-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, phil.hord@gmail.com,
	Jeff King <peff@peff.net>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:30:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRpbZ-0005lP-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966160Ab2JZT3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:29:53 -0400
Received: from mout.web.de ([212.227.15.3]:62031 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966021Ab2JZT3w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:29:52 -0400
Received: from [192.168.178.41] ([79.193.90.117]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MKrPw-1TRpbH26jI-000hKZ; Fri, 26 Oct 2012 21:29:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1351278834-28867-1-git-send-email-hordp@cisco.com>
X-Provags-ID: V02:K0:FcRYAc3oxPQgiWYNB8lOOja0jbXdA+dV9Pef//y3uZ9
 6SXCyvKAQeVlcLQHClYK31d9IFEOfx+Sz65dZw3hpTWCctsQRR
 cRas88WnvP1ErHpRamSdi2KMjVnpFtYlSqMS6toX+QGQnRzGMR
 B7tw0kkaLLUn/iZhCWY2sbwAEJf6YOpwC34saqGfIeE8l4f1tZ
 3GqzOMFiRXtDdQhSU1kwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208483>

Am 26.10.2012 21:13, schrieb Phil Hord:
> A test in t7404-submodule-foreach purports to test that
> the --cached flag is properly noticed by --recursive calls
> to the foreach command as it descends into nested
> submodules.  However, the test really does not perform this
> test since the change it looks for is in a top-level
> submodule handled by the first invocation of the command.
> To properly test for the flag being passed to recursive
> invocations, the change must be buried deeper in the
> hierarchy.
> 
> Move the change one level deeper so it properly verifies
> the recursive machinery of the 'git submodule status'
> command.

Me thinks we should definitely do this.

> Signed-off-by: Phil Hord <hordp@cisco.com>
> ---
>  t/t7407-submodule-foreach.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 9b69fe2..107b4b7 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -226,14 +226,14 @@ test_expect_success 'test "status --recursive"' '
>  	test_cmp expect actual
>  '
>  
> -sed -e "/nested1 /s/.*/+$nested1sha1 nested1 (file2~1)/;/sub[1-3]/d" < expect > expect2
> +sed -e "/nested2 /s/.*/+$nested2sha1 nested1\/nested2 (file2~1)/;/sub[1-3]/d" < expect > expect2
>  mv -f expect2 expect
>  
>  test_expect_success 'ensure "status --cached --recursive" preserves the --cached flag' '
>  	(
>  		cd clone3 &&
>  		(
> -			cd nested1 &&
> +			cd nested1/nested2 &&
>  			test_commit file2
>  		) &&
>  		git submodule status --cached --recursive -- nested1 > ../actual
> 
