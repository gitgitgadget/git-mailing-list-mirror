From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: diff-index does not consider a removed submodule to be staged
 with --ignore-submodules
Date: Sun, 21 Sep 2014 23:36:10 +0200
Message-ID: <541F44CA.7080403@web.de>
References: <541DA95A.2030407@thequod.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Daniel Hahler <genml+git-2014@thequod.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 23:36:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVoo8-0006k5-BW
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 23:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbaIUVgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 17:36:24 -0400
Received: from mout.web.de ([212.227.15.14]:53555 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbaIUVgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 17:36:24 -0400
Received: from [192.168.178.41] ([79.211.118.222]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Lu1Be-1YTrgT0f5C-011Tpw; Sun, 21 Sep 2014 23:36:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <541DA95A.2030407@thequod.de>
X-Provags-ID: V03:K0:vksHR1nJ7OXudHPY867OkHUrCIWLc4aJSypFINkD0WHjnx5Swxl
 fnLBfqR4e9Ydm65j7nayOmEs3CkRzDNqMti9gQKcYBKMY86ZvZxbJ/3Gnal09/N3jbBrBmA
 jZjwkRnoYm8MtTrhZJXz2KwaxiROm8+Hg5U0s1AVjK+TJGZXoFvWWoK4HBc7lUQwMX0LEiB
 iPK6FPj93xvewAQ0l1VCQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257358>

Am 20.09.2014 um 18:20 schrieb Daniel Hahler:
> After staging the removal of a submodule, diff-index does not consider this when "--ignore-submodules" is being used:
>
>      # In a repository with submodule "sm":
>      % git rm --cached sm
>      % git diff-index --cached --quiet --ignore-submodules HEAD
>      % echo $?
>      0
>      % git status
>      On branch master
>      Changes to be committed:
>        (use "git reset HEAD <file>..." to unstage)
>
>          deleted:    sm
>
> "git status --ignore-submodules" behaves the same.
>
>>From the man page of "--ignore-submodules" it looks like the option is meant to prevent scanning of submodules itself, but in this case the main repository is affected.

Sorry, but I don't know what man page you are talking about here ...

> This command is used by zsh's vcs_info module (in Functions/VCS_Info/Backends/VCS_INFO_get_data_git):
>
>      if (( querystaged )) ; then
>          if ${vcs_comm[cmd]} rev-parse --quiet --verify HEAD &> /dev/null ; then
>              ${vcs_comm[cmd]} diff-index --cached --quiet --ignore-submodules HEAD 2> /dev/null
>              (( $? && $? != 128 )) && gitstaged=1
>
> Is this a bug/oversight in Git or by design?
> Is there a better way to detect if there are any staged changes?

It might be that --ignore-submodules=dirty is what you want. It will
report changes in the committed submodule SHA-1, added and removed
submodules but won't care about any modifications inside the submodule.
