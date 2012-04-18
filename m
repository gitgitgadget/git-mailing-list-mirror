From: Semen Vadishev <semen.vadishev@tmatesoft.com>
Subject: Re: Delete gitlink entry but keep .gitmodules file unmodified
Date: Wed, 18 Apr 2012 18:34:30 +0400
Message-ID: <4F8ED0F6.5070106@tmatesoft.com>
References: <4F8EBF5D.5070301@tmatesoft.com> <4F8EC4E2.6070507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 16:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKVxx-0002cU-Au
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 16:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab2DROeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 10:34:36 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:43860 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782Ab2DROef (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 10:34:35 -0400
Received: by lbom4 with SMTP id m4so2261631lbo.19
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 07:34:34 -0700 (PDT)
Received: by 10.112.48.202 with SMTP id o10mr1199506lbn.25.1334759673904;
        Wed, 18 Apr 2012 07:34:33 -0700 (PDT)
Received: from vs.local ([217.148.215.10])
        by mx.google.com with ESMTPS id uc6sm33317071lbb.3.2012.04.18.07.34.32
        (version=SSLv3 cipher=OTHER);
        Wed, 18 Apr 2012 07:34:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8EC4E2.6070507@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195872>

> Yes, unfortunately current git isn't able to do that (even though work
> is ongoing to make future versions handle that just fine). Right now
> the populated submodule "ext" won't be removed when you switch to a
> branch where it doesn't exist. If the new branch has a tree there,
> you'll almost certainly get an error when trying to switch to it as
> that would overwrite files left over from the submodule (end even if
> it doesn't, you'll might get lots of untracked files in the tree
> after the checkout).
We assume such modifications are rare enough, so this downside is fairly 
minor in our case.

And what about these obsolete [submodule "foo"] sections left in 
.gitmodules and .git/config files? Do they bring any problems? Maybe for 
some older git versions?

Thank you,

Semen Vadishev,
TMate Software,
http://subgit.com/ - git+svn on the server side!


On 4/18/12 17:42, Jens Lehmann wrote:
> Am 18.04.2012 15:19, schrieb Semen Vadishev:
>> Suppose one has a properly initialized submodule in a tree like this:
>>
>> $ git ls-tree HEAD
>> 100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1    .gitmodules
>> 160000 commit ec633ea81e3cf64c3735ef4acd5ff9a490ed54eb    ext
>> 100644 blob 597d6924118c00054efd526d9e48f68198f7da12    file.txt
>>
>> $ git show HEAD:.gitmodules
>> [submodule "ext"]
>>          path = ext
>>          url = $URL
>>
>> Then one pulls a modification that replaces 'ext' gitlink by some blob or tree entry, but keeps '.gitmodules' the same:
>>
>> $ git ls-tree HEAD
>> 100644 blob d208248ba4ab1d1791dc27f451dcaedb87dc19e1    .gitmodules
>> 040000 tree 82e3a754b6a0fcb238b03c0e47d05219fbf9cf89    ext
>> 100644 blob 597d6924118c00054efd526d9e48f68198f7da12    file.txt
>>
>> Are there any possible downsides of such modification we should be aware of?
> Yes, unfortunately current git isn't able to do that (even though work
> is ongoing to make future versions handle that just fine). Right now
> the populated submodule "ext" won't be removed when you switch to a
> branch where it doesn't exist. If the new branch has a tree there,
> you'll almost certainly get an error when trying to switch to it as
> that would overwrite files left over from the submodule (end even if
> it doesn't, you'll might get lots of untracked files in the tree
> after the checkout).
>
> As a workaround you could use a symbolic link (assuming you FS supports
> that) and switch that around between two different directories:
>
> 100644 .gitmodules
> 100644 ext ->  ext_sub
> 160000 ext_sub
>
> 100644 .gitmodules
> 100644 ext ->  ext_tree
> 160000 ext_tree
>
> If you then add ext_sub and ext_tree to the .gitignore of each side it
> isn't present in, everything should work just fine (and when git learns
> to handle that case, you can get rid of that workaround for future
> commits).
