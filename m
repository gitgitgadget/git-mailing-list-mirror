From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH v3] Allow the user to change the temporary file name for
 mergetool
Date: Wed, 20 Aug 2014 09:22:47 +0200
Message-ID: <53F44CC7.4040809@atlas-elektronik.com>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com> <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 09:23:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK0Ee-0004Ns-FB
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 09:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbaHTHXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 03:23:03 -0400
Received: from mail96.atlas.de ([194.156.172.86]:16068 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbaHTHXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 03:23:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 97AC610938;
	Wed, 20 Aug 2014 09:22:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9b6FeGh1WVi9; Wed, 20 Aug 2014 09:22:49 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed, 20 Aug 2014 09:22:48 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 337F92716A;
	Wed, 20 Aug 2014 09:22:48 +0200 (CEST)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Wed, 20 Aug
 2014 09:22:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255555>

Am 19.08.2014 um 19:15 schrieb Robin Rosenberg:
> Using the original filename suffix for the temporary input files to
> the merge tool confuses IDEs like Eclipse. This patch introduces
> a configurtion option, mergetool.tmpsuffix, which get appended to
> the temporary file name. That way the user can choose to use a
> suffix like ".tmp", which does not cause confusion.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/config.txt        |  5 +++++
>  Documentation/git-mergetool.txt |  7 +++++++
>  git-mergetool.sh                | 10 ++++++----
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..0e15800 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1778,6 +1778,11 @@ notes.displayRef::
>  	several times.  A warning will be issued for refs that do not
>  	exist, but a glob that does not match any refs is silently
>  	ignored.
> +
> +mergetool.tmpsuffix::
> +	A string to append the names of the temporary files mergetool
> +	creates in the worktree as input to a custom merge tool. The
> +	primary use is to avoid confusion in IDEs during merge.
>  +
>  This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
>  environment variable, which must be a colon separated list of refs or
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index e846c2e..80a0526 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -89,6 +89,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
>  causes `git mergetool` to automatically remove the backup as files
>  are successfully merged.
>  
> +`git mergetool` may also create other temporary files for the
> +different versions involved in the merge. By default these files have
> +the same filename suffix as the file being merged. This may confuse
> +other tools in use during a long merge operation. The user can set
> +`mergetool.tmpsuffix` to be used as an extra suffix, which will be
> +appened to the temporary filename to lessen that problem.

Still:

s/appened/appended/

> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9a046b7..d7cc76c 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -214,6 +214,8 @@ checkout_staged_file () {
>  }
>  
>  merge_file () {
> +	tmpsuffix=$(git config mergetool.tmpsuffix || true)
> +
>  	MERGED="$1"
>  
>  	f=$(git ls-files -u -- "$MERGED")
> @@ -229,10 +231,10 @@ merge_file () {
>  	fi
>  
>  	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
> -	BACKUP="./$MERGED.BACKUP.$ext"
> -	LOCAL="./$MERGED.LOCAL.$ext"
> -	REMOTE="./$MERGED.REMOTE.$ext"
> -	BASE="./$MERGED.BASE.$ext"
> +	BACKUP="./$MERGED.BACKUP.$ext$tmpsuffix"
> +	LOCAL="./$MERGED.LOCAL.$ext$tmpsuffix"
> +	REMOTE="./$MERGED.REMOTE.$ext$tmpsuffix"
> +	BASE="./$MERGED.BASE.$ext$tmpsuffix"
>  
>  	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
>  	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
> 

Stefan
-- 
----------------------------------------------------------------
/dev/random says: It's Ensign Flintstone, Jim... He's Fred!
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
