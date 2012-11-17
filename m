From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 4/5] completion: get rid of compgen
Date: Sat, 17 Nov 2012 12:00:31 +0100
Message-ID: <20121117110031.GE12052@goldbirke>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
 <1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 12:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZg8x-0001aE-66
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 12:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab2KQLAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 06:00:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:64289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2KQLAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 06:00:45 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0M2CDg-1TH2p13RQa-00s9F7; Sat, 17 Nov 2012 12:00:32 +0100
Content-Disposition: inline
In-Reply-To: <1353116298-11798-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:4G56oYlGyXqzRDRj1Ezlk4Deh1mEOLVpRHHaoUr9MQv
 YWVSQlZlcP1pt7X1XtvN1KMLUm5GSV45z6v8Dpn2FTpcpQrHCF
 cn+8/lCrkcPfz765ngYyoNrFl8sBcs1kinVwpiVfuLRnD0HoVT
 e7OQLjoK9kEtXRyitiqqLekoG14XW73G9naJrpQAtW+LCTz1C7
 k15az3TbSRmZx7L3gWJesi9STzM/mmWXTjYTkLcPX/3vv473aT
 az4ho2a/mI7MG7HBRzutI6XRpqPYI9lZIVQw24ExTD3hurKxZX
 EQ0AwhnmhLXG7Il2LxLoT3nxeZBvdFd4ZEH8KsTUClUHsl0Bxm
 GFpgfaLRwtd1NImY2iqg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209939>

On Sat, Nov 17, 2012 at 02:38:17AM +0100, Felipe Contreras wrote:
> The functionality we use is very simple, plus, this fixes a known
> breakage 'complete tree filename with metacharacters'.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 975ae13..ad3e1fe 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -227,7 +227,11 @@ fi
>  
>  __gitcompadd ()
>  {
> -	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
> +	for x in $1; do
> +		if [[ "$x" = "$3"* ]]; then
> +			COMPREPLY+=("$2$x$4")
> +		fi
> +	done

The whole point of creating __gitcomp_nl() back then was to fill
COMPREPLY without iterating through all words in the wordlist, making
completion faster for large number of words, e.g. a lot of refs, or
later a lot of symbols for 'git grep' in a larger project.

The loop here kills that optimization.

>  }
>  
>  # Generates completion reply with compgen, appending a space to possible
> -- 
> 1.8.0
