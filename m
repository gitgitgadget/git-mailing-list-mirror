From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Thu, 11 Jun 2015 15:40:07 +0200
Organization: gmx
Message-ID: <dabb4e8e3a864b26c002e9ef966bdf85@www.dscho.org>
References: <1433986244-76038-1-git-send-email-rappazzo@gmail.com>
 <1433986244-76038-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitset@pobox.com, git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 15:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z32iU-0002CG-I8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 15:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbbFKNkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 09:40:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:50131 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbbFKNkN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 09:40:13 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MZTP3-1Yk7kb1uxh-00LDuC; Thu, 11 Jun 2015 15:40:08
 +0200
In-Reply-To: <1433986244-76038-2-git-send-email-rappazzo@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:EkmuHgTWiX/vPDZc47vNZYJENgQeC0hyDtg+PLa0FAwaxaTepe+
 Rm6f61Lp+O3GpLJrez+sqn7GHuZFI5mIk5KekTAlpL6bFTeCjsaA/miH2yXtOh1jM8tiG1T
 K8mQJtFngSlWJ1CKwcB2FeaP0mI6gI85npcuxi5Yq/cEDyt2g4kraYIIQh9nC2brSplXlAK
 mbeIpTVou3C2TXgo3qxbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TNkjYIQDGm8=:uPKGjDWAn0tiljKD//eTJJ
 quLnACWjOJ5Xf0s/4lNQGOSfsq/KAKyScITo6AvnP2qArV2cQInDL5y3D/+fiD0JTWPWA1TaD
 ClxyiTXrjf6kIphKFxyariGFZRys3XiBLrvZOWZxCRjoCWHB9pxkMctHfh+uszAMgMT9dbI+l
 YDxQDZs075p7ZTs8qA9/lVuya9KlgI2QTsOBhPIW8Am2vD6g2M5jIzU6NautFWYGu0bys0rZ5
 9u9J3nfVLNtIjz6mwd8//nF51epx3aKwPcWjs8HZmbiEz7e1DNlxVvqPWniId6Vj8GF7fDyqo
 Dz4/theBhGOWIFw2V26+rLDrFHlWV2z71Kp8YaG6Cia7RA76uipds+VCPdIROPPp0PecDDeac
 MCsN2W+OL5u8qYn/ySjV6uV59MI3mRT6q6RvaXx2otjQCl6+bkVsNsoRl39gS38aRMAoCp5Ch
 209KzMuN4FiAubaguqZ4Hd9VKpi32VTdbIE8Wm75juBmRdP3P0wQoLgGVnOuULHiaM/Z00DTg
 21pM4wJJE7zc9ePhR4GRJg7Qiv21sB6eWxEmFpwrt5gXfDVj468/4kdUkoIUYX8pHohVpoJmA
 63uxjcqZSi46CxcYFH1pZiiufaYWMBY5XJiV1/CYmC2gKNunzTBh+yA3BH1NGaQuTqE5xqpwu
 ZsC58eYf1qtSJBT82bMKenO7C+LMOGzNLFEcBxHNTgudxXEuG53vGPmAc3RWAf35vUik=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271406>

Hi Michael,

On 2015-06-11 03:30, Michael Rappazzo wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index dc3133f..6d14315 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -740,10 +740,19 @@ collapse_todo_ids() {
>  # "pick sha1 fixup!/squash! msg" appears in it so that the latter
>  # comes immediately after the former, and change "pick" to
>  # "fixup"/"squash".
> +#
> +# Note that if the config has specified a custom instruction format
> +# each log message will be re-retrieved in order to normalize the 
> +# autosquash arrangement
>  rearrange_squash () {
>  	# extract fixup!/squash! lines and resolve any referenced sha1's
> -	while read -r pick sha1 message
> +	while read -r pick sha1 todo_message
>  	do
> +		message=${todo_message}

Why not just leave the `read -r pick sha1 message` as-is and simply write

		# For "autosquash":
		test -z "$format" ||
		message="$(git log -n 1 --format="%s" $sha1)"

here?

> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 41370ab..1ef96eb 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -250,4 +250,37 @@ test_expect_success 'squash! fixup!' '
>  	test_auto_fixup_fixup squash fixup
>  '
>  
> +test_expect_success 'autosquash with custom inst format matching on sha1' '
> +	git reset --hard base &&
> +	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
> +	echo 1 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "squash! $(git rev-parse --short HEAD^)" &&
> +	git tag final-shasquash-instFmt &&
> +	test_tick &&
> +	git rebase --autosquash -i HEAD^^^ &&

We usually write HEAD~3 instead of HEAD^^^...

> +	git log --oneline >actual &&
> +	test_line_count = 3 actual &&
> +	git diff --exit-code final-shasquash-instFmt &&
> +	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> +	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> +'
> +
> +test_expect_success 'autosquash with custom inst format matching on comment' '
> +	git reset --hard base &&
> +	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
> +	echo 1 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "squash! $(git log -n 1 --format=%s HEAD^)" &&
> +	git tag final-comment-squash-instFmt &&
> +	test_tick &&
> +	git rebase --autosquash -i HEAD^^^ &&
> +	git log --oneline >actual &&
> +	test_line_count = 3 actual &&
> +	git diff --exit-code final-comment-squash-instFmt &&
> +	test 1 = "$(git cat-file blob HEAD^:file1)" &&
> +	test 1 = $(git cat-file commit HEAD^ | grep squash | wc -l)
> +'

That is copied almost verbatim, except for the commit message. The code would be easier to maintain if it did not repeat so much code e.g. by refactoring out a function that takes the commit message as a parameter.

Ciao,
Johannes
