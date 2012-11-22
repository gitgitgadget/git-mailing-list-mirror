From: Patrik Gornicz <patrik-git@mail.pgornicz.com>
Subject: Re: git-fetch does not work from .git subdirectory
Date: Wed, 21 Nov 2012 19:55:15 -0500
Message-ID: <50AD77F3.3080702@mail.pgornicz.com>
References: <50AC0316.7090002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbcfk-0002gl-7b
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab2KVTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:42:37 -0500
Received: from li287-246.members.linode.com ([66.228.37.246]:58930 "EHLO
	mail.pgornicz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755492Ab2KVTmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:42:32 -0500
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Nov 2012 14:42:32 EST
Received: from [192.168.1.110] (CPEc0c1c09f18e2-CM0026f321196d.cpe.net.cable.rogers.com [99.236.108.68])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pgornicz.com (Postfix) with ESMTPSA id 01C3149D8D;
	Wed, 21 Nov 2012 19:55:20 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121030 Thunderbird/16.0.1
In-Reply-To: <50AC0316.7090002@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210200>

Just a hunch but your remote's location uses a relative path 
'../linux-2.6.git', perhaps git is messing up what the path is relative 
to.

I assume this repo is beside the linux.cq-test repo? ie. perhaps 
they're located at /home/user/git/linux.cq-test and 
/home/user/git/linux-2.6.git.

Then, for example, from linux.cq-test it looks for 
/home/user/git/linux-2.6.git but from linux.cq-test/.git it looks for 
/home/user/git/linux.cq-test/linux-2.6.git, which is wrong.

Note sure what the fix will be though as it'll likely break existing 
repositories that use relative paths either way. Can you try an 
absolute path to see if that fixes thing?

Patrik

On Tue Nov 20 17:24:22 2012, Timur Tabi wrote:
> I was under the impression that git commands which affect repository (as
> opposed to the local file system) work from any subdirectory inside the
> repository.  For example:
>
> [b04825@efes linux.cq-test]$ git log -1
> commit f35d179fde24be5e1675b1df9f7a49b8d95561b2
> Author: Timur Tabi <timur@freescale.com>
> Date:   Wed Oct 31 15:56:20 2012 +0200
> ...
> [b04825@efes linux.cq-test]$ cd .git
> [b04825@efes .git]$ git log -1
> commit f35d179fde24be5e1675b1df9f7a49b8d95561b2
> Author: Timur Tabi <timur@freescale.com>
> Date:   Wed Oct 31 15:56:20 2012 +0200
> ...
>
> It appears, however, that git-fetch does not work this way:
>
> [b04825@efes linux.cq-test]$ git fetch upstream master
>  From ../linux-2.6
>   * branch            master     -> FETCH_HEAD
> [b04825@efes linux.cq-test]$ cd .git
> [b04825@efes .git]$ git fetch upstream master
> fatal: '../linux-2.6.git' does not appear to be a git repository
> fatal: The remote end hung up unexpectedly
>
> This makes it complicated because git hooks run from the .git directory on
> normal repositories, but they run from the top-level directory on bare
> repositories.  Apparently, you need to be in the top-level directory for
> git-fetch to run in any kind of repository.
>
