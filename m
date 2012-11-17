From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC/PATCH 3/5] completion: trivial test improvement
Date: Sat, 17 Nov 2012 11:59:24 +0100
Message-ID: <20121117105924.GD12052@goldbirke>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
 <1353116298-11798-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Gustavsson <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 11:59:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZg7n-0000OT-JO
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 11:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab2KQK7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 05:59:34 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:58842 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2KQK7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 05:59:33 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MDl1u-1TVnRj13gE-00HEYI; Sat, 17 Nov 2012 11:59:25 +0100
Content-Disposition: inline
In-Reply-To: <1353116298-11798-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:hTXsp7O6JR18gq7MwiWa5PC7AU8fZw9brsGO/8e1Wam
 3mjalgYmuOjoexRJt36ZxNeQnwwjyPYttd67RlqJlcf95GswQD
 uZw4raUYFLahRpcEygN1+YooqeyQ7M+eg2MLjbSERtnOX/rzSX
 1Ldf6iF4OTWbSV+cPFP06XNaotM+ILMyEgbFTXoxsX9lu/kr3N
 5nfbhHYUz0lUS+SYZ1l4pvIQa7jXRFn7KSGA3ubo0gFSmk1CiT
 /3C/NURa1ZPX+E78yWloDz85o9HMULqz88imJt0JwDJjwpnsXl
 cuKlCQuQsanhVkzfvCGyXNkzwnado4oUlmxWHUb1D+Izgr6zyC
 O5U2pZ1dox51d+Std3V8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209938>

On Sat, Nov 17, 2012 at 02:38:16AM +0100, Felipe Contreras wrote:
> Instead of passing a dummy "", let's check if the last character is a
> space, and then move the _cword accordingly.
> 
> Apparently we were passing "" all the way to compgen, which fortunately
> expanded it to nothing.

Glad you noticed it, too.
I posted an alternative fix (without any new conditions in the code
path) a while ago:

  http://article.gmane.org/gmane.comp.version-control.git/206525

Will repost it as part of my series shortly.

> Lets do the right thing though.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t9902-completion.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index cbd0fb6..0b5e1f5 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -51,6 +51,7 @@ run_completion ()
>  	local _cword
>  	_words=( $1 )
>  	(( _cword = ${#_words[@]} - 1 ))
> +	test "${1: -1}" == ' ' && (( _cword += 1 ))
>  	__git_wrap__git_main && print_comp
>  }
>  
> @@ -156,7 +157,7 @@ test_expect_success '__gitcomp - suffix' '
>  '
>  
>  test_expect_success 'basic' '
> -	run_completion "git \"\"" &&
> +	run_completion "git " &&
>  	# built-in
>  	grep -q "^add \$" out &&
>  	# script
> -- 
> 1.8.0
> 
