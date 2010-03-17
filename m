From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 17 Mar 2010 08:09:32 +0100
Message-ID: <4BA0802C.3020603@viscovery.net>
References: <1268777101-22122-1-git-send-email-lars@pixar.com> <1268777101-22122-3-git-send-email-lars@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 08:09:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrnNu-0001hF-DI
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 08:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142Ab0CQHJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 03:09:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:20858 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753067Ab0CQHJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 03:09:35 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NrnNk-0004Cq-Ud; Wed, 17 Mar 2010 08:09:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id ACC641660F;
	Wed, 17 Mar 2010 08:09:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1268777101-22122-3-git-send-email-lars@pixar.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142370>

Lars R. Damerow schrieb:
> @@ -422,6 +429,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  			}
>  			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
>  		}
> +		if (one_filesystem) {
> +			if (stat("..", &buf))
> +				die_errno("failed to stat '%s/..'", getcwd(err_cwd, sizeof(err_cwd)-1));

When stat of .. fails, then it is not unlikely that getcwd fails, too.
Then you would report the errno produced by getcwd.

But can't you avoid this getcwd()? The die() call in the context below
uses cwd.

> +			if (buf.st_dev != current_device)
> +				die("Not a git repository (or any parent up to %s/..)\n"
> +					"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.",
> +					getcwd(err_cwd, sizeof(err_cwd)-1));
> +		}
>  		if (chdir(".."))
>  			die_errno("Cannot change to '%s/..'", cwd);
>  	}

-- Hannes
