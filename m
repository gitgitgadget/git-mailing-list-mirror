From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 21:30:47 +0200
Message-ID: <53A88067.5010908@web.de>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo9mg1$bma$1@ger.gmane.org> <lo9ogu$4in$1@ger.gmane.org> <lo9rcn$8tu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 21:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz9xT-0000ax-NV
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 21:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbaFWTaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 15:30:55 -0400
Received: from mout.web.de ([212.227.15.4]:59694 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754520AbaFWTax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 15:30:53 -0400
Received: from [192.168.178.41] ([84.132.189.37]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LlF9O-1WRTtV0af8-00b6dP; Mon, 23 Jun 2014 21:30:51
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <lo9rcn$8tu$1@ger.gmane.org>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:fo5YYe2sMnES5YD7hCdodbpAmgUbjy+6fa9+ZkKJDdWg52fJMZo
 2yRAwUJe5aj6bN42t8SBVZelKVsAznCGFd7w8SxasVpqZWHpAvrlExtnt8ijxpOYsLtApbX
 zDy/v8cp6Z2hFBLC62hJ6MAgo5rp7K9NGvgR1Jh4/WDwZQCkrWpIftR9E29h+tUIzz+KEMO
 6fVJEMYlbdXvfGMjYVx9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252367>

Am 23.06.2014 20:24, schrieb Stephen Kelly:
> Stephen Kelly wrote:
> 
>> I see that gitk is showing the output of git diff --submodule, similar to
>> git submodule summary.

Right, and for your use case --submodule would have to learn a
different value in addition to 'log' and 'short'. And the default
is already configurable via the 'diff.submodule' config option.

>> Assuming that is not going to be changed, maybe I can hack
>> parseblobdiffline locally. I have not really tried to read of write tcl
>> code before though, so I'd still prefer a 'proper' solution somehow.

I'd prefer a proper solution too, which is exactly why I tried
to understand your use case first before speculating about how
it could be solved.

> I dug deeper and came up with this patch which suits my needs:
> 
> diff --git a/submodule.c b/submodule.c
> index b80ecac..0dacd61 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -297,7 +297,7 @@ static int prepare_submodule_summary(struct rev_info 
> *rev, const char *path,
>         init_revisions(rev, NULL);
>         setup_revisions(0, NULL, rev, NULL);
>         rev->left_right = 1;
> -       rev->first_parent_only = 1;
> +  rev->max_parents = 1;
>         left->object.flags |= SYMMETRIC_LEFT;
>         add_pending_object(rev, &left->object, path);
>         add_pending_object(rev, &right->object, path);
> 
> 
> The 'merge pull request' merges are only noise to me.

Yup, I think that's the core of the change necessary to help
your workflow.
