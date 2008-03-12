From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] builtin-status: submodule summary support
Date: Wed, 12 Mar 2008 08:33:39 +0100
Message-ID: <47D78753.2040902@viscovery.net>
References: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZLTr-00029v-BT
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYCLHdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 03:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYCLHdo
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:33:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21010 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbYCLHdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 03:33:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZLSK-0007Kb-10; Wed, 12 Mar 2008 08:32:56 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 933E66D9; Wed, 12 Mar 2008 08:33:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205288512-20435-1-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76934>

Ping Yin schrieb:
> +static void wt_status_print_submodule_summary(struct wt_status *s)
> +{
> +	struct child_process sm_summary;
> +	const char *argv[] = {
> +		"submodule",
> +		"summary",
> +		"--cached",
> +		"--for-status",
> +		"--summary-limit",
> +		summary_limit,

Where is summary_limit? Did you split this patch series incorrectly?

> +		s->amend ? "HEAD^" : "HEAD",

Any chance that we avoid "HEAD^" here? Perhaps we have the SHA1 around
somewhere? I fear that our MSYS bash mangles it into "HEAD". I shall test it.

BTW, you don't mention the prerequisites of this series. I assume it
builds on top of your "[PATCH v5 0/5] git-submodule summary" series.

> +	sm_summary.no_stderr = 1;

Why this? If the submodule summary has errors we certainly want to see them.

> @@ -321,6 +349,9 @@ void wt_status_print(struct wt_status *s)
>  	}
>  
>  	wt_status_print_changed(s);
> +	// must flush s->fp since following call will write to s->fp in a child process
> +	fflush(s->fp);
> +	wt_status_print_submodule_summary(s);

Hmm. Aren't you unconditionally spawning "git submodule summary" for each
git-status/git-commit?

-- Hannes
