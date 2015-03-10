From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] Added tests for git reset -
Date: Tue, 10 Mar 2015 06:48:09 +0100
Message-ID: <54FE8599.7000403@web.de>
References: <1425934010-8780-1-git-send-email-dyoucme@gmail.com> <1425934010-8780-2-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Sundararajan R <dyoucme@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 06:48:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVD1p-0002Wv-FU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 06:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbbCJFsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 01:48:25 -0400
Received: from mout.web.de ([212.227.17.11]:61323 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbbCJFsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 01:48:24 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lz3BE-1XRCCb0wKm-0149N3; Tue, 10 Mar 2015 06:48:21
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1425934010-8780-2-git-send-email-dyoucme@gmail.com>
X-Provags-ID: V03:K0:4tZsiQirnxIL36GpJAO3cDT6pMOXTOn64yjY1okbRMOK4fdS+W+
 nX6dzJNouF/KkU1OHsUWTHj5BBPHZo6FIkaPFq1R05LLSxYnGNukxYE2fSdXJhfJwozAu4U
 K7tsCrUpi6nyWURulFIpI7paJMp51dEnRuaiIncWdt6k2MG8BePaW+c+iOPF7wkTAlP8H4Z
 EyOrNbHChOp7RKvvlu+uA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265209>

On 03/09/2015 09:46 PM, Sundararajan R wrote:
> As you had suggested @Junio, I have added the required tests.
> Please let me know if there is something is I should add.
>
> Signed-off-by: Sundararajan R <dyoucme@gmail.com>
> Thanks-to: Junio C Hamano
> ---
> I have added 6 tests to check for the following cases:
> git reset - with no @{-1}
> git reset - with no @{-1} and file named -
> git reset - with @{-1} and file named @{-1}
> git reset - with @{-1} and file named -
> git reset - with @{-1} and file named @{-1} and -
> git reset - with @{-1} and no file named - or @{-1}
> The 1st test with no previous branch results in the error
> The 2nd,3rd,4th and 5th result in the ambiguous argument error
> The 6th test has - working like @{-1}
>
>   t/t7102-reset.sh | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
>
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..a670938 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,111 @@ test_expect_success 'reset --mixed sets up work tree' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'reset - with no @{-1}' '
> +	git init new --quiet &&
> +	cd new &&
> +	test_must_fail git reset - >actual &&
> +	touch expect &&
> +	test_cmp expect actual
> +'
> +
> +rm -rf new
> +
> +cat >expect <<EOF
> +fatal: ambiguous argument '-': both revision and filename
> +Use ./- for file named -
> +Use '--' to separate paths from revisions, like this:
> +'git <command> [<revision>...] -- [<file>...]'
> +EOF
> +
> +test_expect_success 'reset - with no @{-1} and file named -' '
> +	git init new --quiet &&
> +	cd new &&
> +	echo "Hello" > - &&
> +	git add -
> +	test_must_fail git reset - 2>actual &&
> +	test_cmp ../expect actual
> +'
> +
> +cd ..
> +rm -rf new
> +
> +cat >expect <<EOF
> +fatal: ambiguous argument '@{-1}': both revision and filename
> +Use '--' to separate paths from revisions, like this:
> +'git <command> [<revision>...] -- [<file>...]'
> +EOF
> +
> +test_expect_success 'reset - with @{-1} and file named @{-1}' '
> +	git init new --quiet &&
> +	cd new &&
If the shell changes the directory, this should be done in a subshell

+	git init new --quiet &&
+	(
		cd new &&

                # All the stuff
             )

+'

+cd ..

And the the .. should  be removed
(Same problem further down)
