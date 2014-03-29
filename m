From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] status: don't ignore submodules added to index
Date: Sun, 30 Mar 2014 00:16:23 +0100
Message-ID: <53375447.2050502@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374F82.3020800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 00:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU2UQ-0001AI-6h
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 00:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaC2XQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 19:16:34 -0400
Received: from mout.web.de ([212.227.17.12]:53710 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbaC2XQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 19:16:34 -0400
Received: from [192.168.178.41] ([84.132.177.211]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LbZlL-1Wvzr11jrf-00lBFq; Sun, 30 Mar 2014 00:16:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53374F82.3020800@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:X+f/E7QbxmcPFLLjRUL30SjQofE2AdiDcvn7DEWdMblNjcnzPhM
 TyaUs1ggIxT0my1NrE78m3NcFbtYxyBEzeLLzQcJrgrDSAWDyLJX4EdPEAKMl2YXjN1+j2M
 9xNNtuFkVKY5jOoIDuTNNSRkgQqLHLaHWROHwvhaYQmRhb048yB+39YAgGmGHdzTbdty2Rh
 0B/N4SJG0gWmUjGMF2QgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245448>

Am 29.03.2014 23:56, schrieb Ronald Weiss:
> Submodules explicitly added to index by user should be never hidden in
> status output.
> 
> This also fixes a bug in commit, where submodules with configured ignore
> setting (in .gitmodules or .git/config), added to index by user, are not
> displayed in the commit message as being commited, but they still are
> commited. Unless the changed submodules are the only changes in the index,
> in such case commit fails immediately with "no changes", which is even
> worse.

Thanks, but I think this patch falls a bit short (I assume you should see
test failures with this patch). I'm currently working on fixing that, will
post that as soon as I finished it.

> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
>  wt-status.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index a452407..108a048 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -486,10 +486,8 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>  	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
>  	setup_revisions(0, NULL, &rev, &opt);
>  
> -	if (s->ignore_submodule_arg) {
> -		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> -		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
> -	}
> +	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> +	DIFF_OPT_CLR(&rev.diffopt, IGNORE_SUBMODULES);
>  
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = wt_status_collect_updated_cb;
> 
