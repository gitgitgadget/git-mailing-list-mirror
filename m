From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding .gitmodules
Date: Wed, 20 Jun 2012 19:52:19 +0200
Message-ID: <4FE20DD3.6040607@web.de>
References: <cover.1340202515.git.brad.king@kitware.com> <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:53:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShP5s-0005qO-2N
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab2FTRxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:53:24 -0400
Received: from mout.web.de ([212.227.17.11]:58311 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab2FTRxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:53:24 -0400
Received: from [192.168.178.48] ([91.3.162.199]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LzbDC-1RlusQ3AzS-014wiq; Wed, 20 Jun 2012 19:52:21
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com>
X-Provags-ID: V02:K0:8Psnbz5ug4IOxINzCfjyod7GnZUhYct3WqpLoX6nsFO
 IGat6Jzzs0418it2WgjXh7hGl0UA8yGMccL61vY8TK4YLnCVSS
 kFHoEja6+X1ii9oAP739kgQJYn4O8eisiEMXEKfyL4UnNHh7KL
 pQuorbQVSi/WjXxtq+0nfFUQYCuo/eORBoscK2gv31NdVklOLm
 HHdHdPEeJpwvSSloMos2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200308>

Am 20.06.2012 16:43, schrieb Brad King:
> Temporarily disable 'core.safecrlf' to add '.gitmodules' so that
> 'git add' does not reject the LF newlines we write to the file
> even if both 'core.autocrlf' and 'core.safecrlf' are enabled.
> This fixes known breakage tested in t7400-submodule-basic.

Hmm, I have no objections against the intention of the patch. But
as I understand it this message will reoccur when the user e.g.
edits the .gitmodules file later with any editor who just writes
lfs and adds it.

I don't know terribly much about crlf support but maybe flagging
the .gitmodules file in .gitattributes would be a better solution
here? Opinions?

> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  git-submodule.sh           |    2 +-
>  t/t7400-submodule-basic.sh |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5c61ae2..ed9a54a 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -303,7 +303,7 @@ Use -f if you really want to add it." >&2
>  
>  	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
>  	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
> -	git add --force .gitmodules ||
> +	git -c core.safecrlf=false add --force .gitmodules ||
>  	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
>  }
>  
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 5eaeb04..9a4da9b 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -99,7 +99,7 @@ test_expect_success 'submodule add' '
>  	test_cmp empty untracked
>  '
>  
> -test_expect_failure 'submodule add with core.autocrlf and core.safecrlf' '
> +test_expect_success 'submodule add with core.autocrlf and core.safecrlf' '
>  	(
>  		cd addtest-crlf &&
>  		git config core.autocrlf true &&
> 
