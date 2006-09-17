From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Sun, 17 Sep 2006 15:18:29 +0200
Organization: At home
Message-ID: <eejhtr$paa$1@sea.gmane.org>
References: <20060916210832.GV17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 15:18:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOwXU-0005Ho-1C
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 15:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWIQNSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 09:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWIQNSN
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 09:18:13 -0400
Received: from main.gmane.org ([80.91.229.2]:53708 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932427AbWIQNSM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 09:18:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOwX0-0005Al-0h
	for git@vger.kernel.org; Sun, 17 Sep 2006 15:17:58 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 15:17:58 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 15:17:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27191>

Martin Waitz wrote:

> Now three types of path based URLs are supported:
>       gitweb.cgi/project.git
>       gitweb.cgi/project.git/branch
>       gitweb.cgi/project.git/branch/filename
> 
> The first one (show project summary) was already supported for a long time
> now.  The other two are new: they show the shortlog of a branch or
> the plain file contents of some file contained in the repository.

> +     if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
> +             # we got "project.git/branch/filename"
> +             $action    ||= "blob_plain";
> +             $hash_base ||= $1;
> +             $file_name ||= $2;
> +     } elsif ($path_info =~ m,^$project/([^/]+)$,) {
> +             # we got "project.git/branch"
> +             $action ||= "shortlog";
> +             $hash   ||= $1;
> +     }

I'm sorry, but I realized that I didn't think and check this patch through.

First, this patch spews a bunch of warnings: when PATH_INFO is empty, when
we undefine $project etc. The patches by me and by matled try to address
and remove those warnings, but I'm sure we missed some.

Second, the whole concept of third type of path (path_info) based URL is
flawed: branches can also be hierarchical (for example Junio uses
<initals>/<topic> topic branches, although they are not published).
Therefore it is much harder to distinguish where branchname ends and
filename begins. The patch assumes that branches are flat. So for example
for branch with the name like "gitweb/xmms2" the types 2 and 3 wouldn't
work; and type 1 worked before this patch.

Therefore I rescind my Ack.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
