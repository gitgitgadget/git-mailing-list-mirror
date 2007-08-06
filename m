From: Eran Tromer <git2eran@tromer.org>
Subject: Re: question about git-submodule
Date: Mon, 06 Aug 2007 13:23:19 -0400
Message-ID: <46B75907.1070007@tromer.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home> <46B3B3D2.6030000@tromer.org> <20070805145922.GC999MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, VMiklos <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 06 19:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II6lp-000071-G4
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 19:53:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759598AbXHFRxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 13:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759590AbXHFRxa
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 13:53:30 -0400
Received: from forum2.org ([198.65.45.153]:4984 "EHLO forum2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758380AbXHFRx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 13:53:29 -0400
X-Greylist: delayed 1749 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Aug 2007 13:53:29 EDT
X-F2-Envelope-From: git2eran@tromer.org
X-F2-Envelope-To: git@vger.kernel.org
Received: from moby.tromer.org (c-66-30-26-80.hsd1.ma.comcast.net [66.30.26.80])
	(authenticated bits=0)
	by forum2.org (8.13.6.20060614/8.13.6) with ESMTP id l76HNYjb049923;
	Mon, 6 Aug 2007 17:23:35 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <20070805145922.GC999MdfPADPa@greensroom.kotnet.org>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55162>

On 2007-08-05 10:59, Sven Verdoolaege wrote:
>> BTW, is there any easy way to create a submodule directly inside the
>> supermodule's working tree, instead of cloning it as in the above example?
> 
> Do you want to use the submodule porcelain or just the plumbing?
> If you simply want to add a submodule locally, "git add" will do that for
> you just fine.  It's only when you want to make it easier for people who
> clone your superproject to get updates of the submodules that you
> should set up the information required by "git submodule" in .gitmodules
> (see end of module_add in git-submodule.sh).

If you just do "git add sub" (where sub is an existing repo subdir) then
any subsequent "git submodule update" predictably complains:
  No submodule mapping found in .gitmodules for path 'sub'

And if you wire up .gitmodules manually, then "git submodule update"
chokes on the "git-fetch" in modules_update().

So I suggest extending "git submodule add" to handle existing
subdirectories by simply using them as-is instead of creating a new
clone. And "git submodule update" shouldn't try fetching when the commit
is already present locally.

Speaking of which, currently "git submodule" clones/fetches *all*
branches on the remote repository, which seems quite excessive given
that the supermodule's content references just one submodule commit. By
default, "git submodule add" should fetch only the needed head, and "git
submodule update" should fetch only the commit sha1 (if needed).

  Eran
