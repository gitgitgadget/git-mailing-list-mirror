From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather
 than specific scripts
Date: Mon, 04 May 2009 21:48:31 +0900
Message-ID: <49FEE41F.4010006@ruby.dti.ne.jp>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 04 14:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0xjq-000266-Pq
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 14:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954AbZEDM50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 08:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZEDM5Z
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 08:57:25 -0400
Received: from smtp14.dti.ne.jp ([202.216.231.189]:61335 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbZEDM5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 08:57:25 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2009 08:57:24 EDT
Received: from shinya-kuribayashis-macbook.local (PPPax2584.tokyo-ip.dti.ne.jp [210.170.234.84]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id n44CmWuu023782;Mon, 4 May 2009 21:48:32 +0900 (JST)
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
In-Reply-To: <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118229>

Hi,

Catalin Marinas wrote:
> This patch adds the mechanism to check if the output is tty for the
> diff and show commands and passes the --color option to git if the
> color.diff config option is set auto or true. The patch also changes the
> default pager to 'less -FRSX' from the diffcol.sh script.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Cool.

> diff --git a/stgit/commands/common.py b/stgit/commands/common.py
> index 6bb3685..e46412e 100644
> --- a/stgit/commands/common.py
> +++ b/stgit/commands/common.py
> @@ -83,6 +83,14 @@ def git_commit(name, repository, branch_name = None):
>      except libgit.RepositoryException:
>          raise CmdException('%s: Unknown patch or revision name' % name)
>  
> +def color_diff_flags():
> +    """Return the git flags for coloured diff output if the configuration and
> +    stdout allows."""
> +    if sys.stdout.isatty() and config.get('color.diff') in ['true', 'auto']:
> +        return ['--color']
> +    else:
> +        return []
> +
>  def check_local_changes():
>      if git.local_changes():
>          raise CmdException('local changes in the tree. Use "refresh" or'

Junio introduces `color.ui=auto' as one of base settings in his recent
Japanese article for Git newbies:

http://gitster.livejournal.com/2009/04/24/

Is color.ui worth supporting in color_diff_flags()?, or simply having 
additional color.diff would be better?

> diff --git a/stgit/config.py b/stgit/config.py
> index efce097..4f16978 100644
> --- a/stgit/config.py
> +++ b/stgit/config.py
> @@ -37,7 +37,8 @@ class GitConfig:
>          'stgit.autoimerge':	'no',
>          'stgit.keepoptimized':	'no',
>          'stgit.extensions':	'.ancestor .current .patched',
> -        'stgit.shortnr':	 '5'
> +        'stgit.shortnr': '5',
> +        'stgit.pager':  'less -FRSX'
>          }
>  
>      __cache={}

Wrong indentation? :-)


Shinya
