From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 21:06:38 -0500
Message-ID: <1229220398.3360.66.camel@mattlaptop2.local>
References: <1229203014.31181.7.camel@mattlaptop2.local>
	 <m3prjvg2st.fsf@localhost.localdomain>
	 <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
	 <200812132351.37420.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 03:19:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBgZk-0004gx-19
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 03:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYLNCRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 21:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYLNCRx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 21:17:53 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:56826 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752139AbYLNCRw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 21:17:52 -0500
Received: from [129.2.130.102] (129-2-130-102.wireless.umd.edu [129.2.130.102])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 974BE13EC0;
	Sat, 13 Dec 2008 18:17:51 -0800 (PST)
In-Reply-To: <200812132351.37420.jnareb@gmail.com>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103042>

On Sat, 2008-12-13 at 23:51 +0100, Jakub Narebski wrote:
> "no_hide" (currently "include_forks") allows us to _not_ passing this
> parameter in other places than project_in_list(); undef is falsy.

Right.  That's why I made the current parameter $for_strict_export (so
only project_in_list passes it) rather than the negation.

> By the way, doesn't git_project_index and perhaps git_opml also need
> this parameter passed to git_get_projects_list?

Yes, now that you mention it, I suppose they should show forks, though
not hidden repositories.  Then git_get_projects_list can be called in
three different modes: include everything (project_in_list), include
forks but not hidden (git_get_project_index and git_opml), or include
neither forks nor hidden (git_project_list).  Should we have two
separate parameters to git_get_projects_list or a single three-valued
one?

That raises another point.  I was going to change git_get_projects_list
so that forks of a hidden project that are not themselves hidden appear
on the parent project's page but not in the main project list.  This
way, users who know about the parent project can navigate to the fork,
but the fork does not give away the existence of the parent project by
appearing in the main list.  Then I guess git_project_index and git_opml
should omit forks of hidden projects, meaning that some fork-checking
still has to take place with "include forks" on but "include hidden"
off.  This will make git_get_projects_list somewhat more complex but not
unmanageably so, and I do think it's the behavior we want.

I will send an updated patch.

-- 
Matt
