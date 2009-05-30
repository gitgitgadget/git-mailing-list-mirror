From: Shinya Kuribayashi <skuribay@pobox.com>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather
 than specific scripts
Date: Sat, 30 May 2009 09:36:27 +0900
Message-ID: <4A207F8B.9060805@pobox.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>	
 <20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>	
 <49FEE41F.4010006@ruby.dti.ne.jp>
 <b0943d9e0905290522l377c8f35h7f442b183cb7c7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 02:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MACnK-0003Kq-KS
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 02:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbZE3AvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 20:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbZE3AvP
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 20:51:15 -0400
Received: from b-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.35]:64244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753086AbZE3AvO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 20:51:14 -0400
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 20:51:14 EDT
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A6D52715C;
	Fri, 29 May 2009 20:36:40 -0400 (EDT)
Received: from [192.168.1.5] (unknown [61.112.77.19]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F2B62715A; Fri, 29 May
 2009 20:36:34 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <b0943d9e0905290522l377c8f35h7f442b183cb7c7d2@mail.gmail.com>
X-Pobox-Relay-ID: F0FE5F5A-4CB1-11DE-85F4-AACF009E36F1-47602734!b-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120328>

Catalin Marinas wrote:
> That's probably a better option. I changed the patch to this (only
> showing the relevant parts):
> 
> --- a/stgit/commands/common.py
> +++ b/stgit/commands/common.py
> @@ -97,6 +97,15 @@ def git_commit(name, repository, branch_name = None):
>      except libgit.RepositoryException:
>          raise CmdException('%s: Unknown patch or revision name' % name)
> 
> +def color_diff_flags():
> +    """Return the git flags for coloured diff output if the configuration and
> +    stdout allows."""
> +    stdout_is_tty = (sys.stdout.isatty() and 'true') or 'false'
> +    if config.get_colorbool('color.diff', stdout_is_tty) == 'true':
> +        return ['--color']
> +    else:
> +        return []
> +
>  def check_local_changes():
>      if git.local_changes():
>          raise CmdException('local changes in the tree. Use "refresh" or'
> 
> --- a/stgit/config.py
> +++ b/stgit/config.py
> @@ -109,16 +110,18 @@ class GitConfig:
>              if m:
>                  result.append(m.group(1))
>          return result
> +
> +    def get_colorbool(self, name, stdout_is_tty):
> +        """Invoke 'git config --get-colorbool' and return the result."""
> +        return Run('git', 'config', '--get-colorbool', name,
> +                   stdout_is_tty).output_one_line()
> 
>  config=GitConfig()

Proposed branch now works for me only with color.ui=auto.

Thanks!
--
Shinya Kuribayashi
