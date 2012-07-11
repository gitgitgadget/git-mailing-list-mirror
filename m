From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] submodules: don't stumble over symbolic links when cloning
 recursively
Date: Wed, 11 Jul 2012 22:39:39 +0200
Message-ID: <4FFDE48B.7060802@kdbg.org>
References: <4FFDC1EE.8080106@web.de> <4FFDCFA4.9060602@kdbg.org> <4FFDDCAD.5080001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bob Halley <halley@play-bow.org>,
	Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:40:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp3hm-0003d0-M1
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab2GKUjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 16:39:43 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:43500 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753562Ab2GKUjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 16:39:43 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5307613004D;
	Wed, 11 Jul 2012 22:39:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E3E2919F449;
	Wed, 11 Jul 2012 22:39:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <4FFDDCAD.5080001@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201327>

Am 11.07.2012 22:06, schrieb Jens Lehmann:
> Am 11.07.2012 21:10, schrieb Johannes Sixt:
>> Am 11.07.2012 20:11, schrieb Jens Lehmann:
>>> Since 69c305178 (submodules: refactor computation of relative gitdir path)
>>> cloning a submodule recursively fails for recursive submodules when a
>>> symbolic link is part of the path to the work tree of the superproject.
>>>
>>> This happens when module_clone() tries to find the relative paths between
>>> work tree and git dir. When a symbolic link in current $PWD points to a
>>> directory in a different level determining the number of "../" needed to
>>> traverse to the superprojects work tree leads to a wrong result.
>>>
>>> As there is no portable way to say "pwd -P" use cd_to_toplevel to remove
>>> the link from the pwd, which fixes this problem.
>> ...
>>> -	a=$(cd "$gitdir" && pwd)/
>>> -	b=$(cd "$sm_path" && pwd)/
>>> +	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
>>> +	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
>>
>> But if you cd out, how can it be correct not to cd in again if $gitdir
>> and/or $sm_path are relative?
> 
> I'm not sure what you mean by "cd out", but the two "cd_to_toplevel"
> make sure that when $gitdir or $sm_path are relative the symbolic link
> gets removed from the output of pwd. So it's rather "cd into the path
> where the symlink is resolved".

At this point we can be in a subdirectory of the worktree. With
cd_to_toplevel we move up in the directory hierarchy ("cd out"). Then a
relative $gitdir or $sm_path now points to the wrong directory. No?

-- Hannes
