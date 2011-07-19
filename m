From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Make filter-branch work with many branches
Date: Tue, 19 Jul 2011 20:06:02 +0200
Message-ID: <4E25C78A.1090600@kdbg.org>
References: <E186982C-71AE-4C08-B857-A67BDCD21E3D@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 20:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjEgQ-0007Bo-Su
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab1GSSGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:06:09 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:51584 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751072Ab1GSSGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:06:08 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5718ECDF85;
	Tue, 19 Jul 2011 20:06:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 144E019F3B9;
	Tue, 19 Jul 2011 20:06:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <E186982C-71AE-4C08-B857-A67BDCD21E3D@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177487>

Am 19.07.2011 18:29, schrieb Dave Zarzycki:
> -rev_args=$(git rev-parse --revs-only "$@")
> -
>  case "$filter_subdir" in
>  "")
>  	eval set -- "$(git rev-parse --sq --no-revs "$@")"

This line in the hunk context changes what "$@" will produce. Therefore,
the "$@" that you removed above will not produce the same thing...

> @@ -286,8 +284,8 @@ case "$filter_subdir" in
>  	;;
>  esac
>  
> -git rev-list --reverse --topo-order --default HEAD \
> -	--parents --simplify-merges $rev_args "$@" > ../revs ||
> +git rev-parse --revs-only "$@" | git rev-list --stdin --reverse --topo-order \
> +	--default HEAD --parents --simplify-merges "$@" > ../revs ||

... that you insert here. How can the result ever have worked for you?

Perhaps store the list of revs in a temporary file?

-- Hannes
