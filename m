From: Nahor <nahor.j+gmane@gmail.com>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 12:16:22 -0700
Message-ID: <5086ED06.5020406@gmail.com>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 21:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQk1R-0006Z9-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 21:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab2JWTUD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 15:20:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:45279 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144Ab2JWTUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 15:20:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQk1D-0006RK-TZ
	for git@vger.kernel.org; Tue, 23 Oct 2012 21:20:03 +0200
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 21:20:03 +0200
Received: from nahor.j+gmane by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 21:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208240>

On 2012-10-22 09:34, W. Trevor King wrote:
> From: "W. Trevor King" <wking@tremily.us>
>
> This removes a configuration step if you're trying to setup =C3=86var=
's
>
>    $ git submodule foreach 'git checkout $(git config --file $topleve=
l/.gitmodules submodule.$name.branch) && git pull'
>
> workflow from
>
>    commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
>    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>    Date:   Fri May 21 16:10:10 2010 +0000
>
>      git-submodule foreach: Add $toplevel variable
>
> If you're not using that workflow, I see no harm in recording the
> branch used to determine the original submodule commit.

IMHO, the problem is that this works only for a very specific workflow.=
=20
Normal git usage can very easily break this feature.

=46or instance, the module may later be updated to a commit in branch B=
=20
instead of branch A. Unless you remember to also update .gitmodule, you=
=20
have then inconsistent information.

A similar issue arises if branch A is deleted from the module later (fo=
r=20
instance because it has been merged in the master branch and is not=20
useful anymore). Then .gitmodule points to a non-existant branch.
Same thing if a branch is renamed.

Last issue, the branch that exists in your local repository may not=20
exist in someone else's repository, either because the branch is purely=
=20
local, or because it has a different name on the remote repo.


I think a better place to store that kind of information is using=20
git-notes. That way, if the branch is renamed or deleted, you can easil=
y=20
update the old notes to use the new name instead.


	Nahor
