From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 11:44:59 -0500
Message-ID: <1296233099.12855.14.camel@drew-northup.unet.maine.edu>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 17:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PirRm-0005x8-23
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 17:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205Ab1A1QpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 11:45:11 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:50973 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab1A1QpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 11:45:10 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p0SGj3MF013061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Jan 2011 11:45:03 -0500
In-Reply-To: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p0SGj3MF013061
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1296837903.93432@Ijyk2OkkA0sb9YXWvd32EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165626>


On Fri, 2011-01-28 at 18:17 +0200, Felipe Contreras wrote:
> So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
> it's better to do something useful.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/merge.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 42fff38..f23d669 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -983,9 +983,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  	if (!allow_fast_forward && fast_forward_only)
>  		die("You cannot combine --no-ff with --ff-only.");
>  
> -	if (!argc)
> -		usage_with_options(builtin_merge_usage,
> -			builtin_merge_options);
> +	if (!argc) {
> +		/* argv[argc] should be NULL, so we can hijack it */
> +		argv[0] = "@{u}";
> +		argc = 1;
> +	}
>  
>  	/*
>  	 * This could be traditional "merge <msg> HEAD <commit>..."  and

Honestly, I'd prefer that this NOT be merged in. When I mess up the
command line I am typing I don't want some sort of hidden magic to kick
in--I want it to tell me that I did something stupid by printing out the
help message. This is standard to a large number of commands that by
default expect a certain number of operands and I don't see any good
reason why git merge should be any different.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
