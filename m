From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: Support exclude prefix, ^<rev>
Date: Wed, 22 Apr 2015 15:03:27 +0200
Message-ID: <20150422150327.Horde.JQeFwEt1H0b2m6uCwo2Grw1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Trygve Aaberge <trygveaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 15:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkuJa-0006VR-TF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 15:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbbDVNDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 09:03:38 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:56178 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751055AbbDVNDh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 09:03:37 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YkuJU-0008JH-8O; Wed, 22 Apr 2015 15:03:36 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YkuJL-0005A1-9P; Wed, 22 Apr 2015 15:03:27 +0200
Received: from x590d28c7.dyn.telefonica.de (x590d28c7.dyn.telefonica.de
 [89.13.40.199]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 22 Apr 2015 15:03:27 +0200
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1429707816.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267589>

Hi,

Quoting Trygve Aaberge <trygveaa@gmail.com>:

> When using the exclude pattern, ^<rev>, the completion did not work.
> This enables completion after ^ in the same way that completion after ..
> is done.

Interesting, thinking back I can't recall I've ever needed multiple  
exclude patterns on the command line, and a single exclude is well  
served by the rev1..rev2 notion.
Of course that doesn't mean that nobody might need it, and since it's  
easy to implement, I'm for it.

> Signed-off-by: Trygve Aaberge <trygveaa@gmail.com>
> ---
> contrib/completion/git-completion.bash | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash  
> b/contrib/completion/git-completion.bash
> index 8cfee95..3036dac 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -496,6 +496,10 @@ __git_complete_revlist_file ()
> 		cur_="${cur_#*..}"
> 		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
> 		;;
> +	^*)
> +		cur_="${cur_#^}"
> +		__gitcomp_nl "$(__git_refs)" "^" "$cur_"
> +		;;

This is good, but considering the other cases I suggest making this  
the very first case.  That way we would not complete e.g. refs after  
'^rev..<TAB>', which would lead to a "bad revision" error when the  
command is executed, or tracked paths after '^rev:<TAB>', which I  
think doesn't make sense, though doesn't lead to error.

> 	*)
> 		__gitcomp_nl "$(__git_refs)"
> 		;;
> --
> 2.2.2
