From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Fri, 22 Jan 2010 08:29:26 +0100
Message-ID: <4B5953D6.7020303@viscovery.net>
References: <718290.769818367-sendEmail@darysmbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Rydh <dary@math.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 08:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYDxa-0001YJ-8F
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 08:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab0AVH3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 02:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048Ab0AVH3c
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 02:29:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5014 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab0AVH3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 02:29:32 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NYDxP-00056Z-G9; Fri, 22 Jan 2010 08:29:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 289C91660F;
	Fri, 22 Jan 2010 08:29:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <718290.769818367-sendEmail@darysmbp>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137744>

David Rydh schrieb:
> diff --git a/builtin-mv.c b/builtin-mv.c
> index 8247186..1c1f8be 100644
> --- a/builtin-mv.c
> +++ b/builtin-mv.c
> @@ -27,7 +27,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
>  		if (length > 0 && is_dir_sep(result[i][length - 1]))
>  			result[i] = xmemdupz(result[i], length - 1);
>  		if (base_name)
> -			result[i] = basename((char *)result[i]);
> +			result[i] = xstrdup(basename((char *)result[i]));
>  	}
>  	return get_pathspec(prefix, result);
>  }

We are already leaking memory of magnitude O(argc*length of file names),
and IMO, this new leak of the same magnitude doesn't hurt.

If you want to avoid it, you can set NO_LIBGEN_H in Makefile.

The other changes in this patch should really be a separate patch. They do
not fix an immediate problem, right?

-- Hannes
