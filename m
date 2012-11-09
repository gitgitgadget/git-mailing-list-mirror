From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v3 2/3] git-submodule foreach: export .gitmodules
	settings as variables
Date: Fri, 9 Nov 2012 17:45:22 +0100
Message-ID: <20121109164516.GB922@book.hvoigt.net>
References: <20121029222759.GI20513@sigill.intra.peff.net> <cover.1352431674.git.wking@tremily.us> <2121ce36cf4eb02385255cbd5b0bbd1dcc803113.1352431675.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:46:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWria-0002II-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 17:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737Ab2KIQpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 11:45:47 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:41360 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729Ab2KIQp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 11:45:27 -0500
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1TWrhr-0000aO-SK; Fri, 09 Nov 2012 17:45:24 +0100
Content-Disposition: inline
In-Reply-To: <2121ce36cf4eb02385255cbd5b0bbd1dcc803113.1352431675.git.wking@tremily.us>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209231>

Hi,

On Thu, Nov 08, 2012 at 10:35:13PM -0500, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
> 
> This makes it easy to access per-submodule variables.  For example,
> 
>   git submodule foreach 'git checkout $(git config --file $toplevel/.gitmodules submodule.$name.branch) && git pull'
> 
> can now be reduced to
> 
>   git submodule foreach 'git checkout $submodule_branch && git pull'

What other use cases are there? Would the need for this maybe go away
once you had floating submodules following branches?

The whole thing looks like its adding some complex code which is not so
easy to read. I would like to make sure its worth it.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index bc33112..e4d26f9 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -434,8 +434,24 @@ cmd_foreach()
>  				clear_local_git_env
>  				# we make $path available to scripts ...
>  				path=$sm_path
> +
> +				# make all submodule variables available to scripts
> +				eval $(
> +					git config -f .gitmodules --get-regexp "^submodule\.${name}\..*" |

For completeness you should make the variables possible to override by
repository from the local repository configuration like all other
submodule options that are read directly from .gitmodules.

Cheers Heiko
