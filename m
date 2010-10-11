From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Gitweb: Show git clone url on projects list
Date: Mon, 11 Oct 2010 14:27:07 -0700
Message-ID: <4CB3812B.8060209@eaglescrag.net>
References: <AANLkTi=5P1OiKprOifyu2xuFjVToL5kE9dXrEr3gSr+_@mail.gmail.com>	<AANLkTimGhR_64CDKuN0x4Lk6Ve8rr7BAOCL1uGUkQv6v@mail.gmail.com> <m3iq1efhlp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Manuel Doninger <manuel@doninger.net>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 23:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Ptt-0006lS-Sp
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110Ab0JKV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:27:12 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:39758 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab0JKV1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:27:11 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o9BLR7ZX028846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 11 Oct 2010 14:27:08 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <m3iq1efhlp.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 11 Oct 2010 14:27:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158791>

Sorry for the late response, was traveling on the 7th.  Comments inline.

> There were multiple attempts to add such link to core gitweb (i.e. the
> one present in git 1.7.3), but were not merged in due to runing
> aground the following problems:
> 
> 1. There might be more than one link for one git repository.  One can
>    provide git://, http:// and ssh:// URLs.  Which one to chose?
> 
>    This issue might be solved by either using first one on the list,
>    or filtering and showing link(s) to anonymous unauthenticated ones,
>    i.e. _git_ link (if git:// URL exists) and perhaps _http_ link (if
>    http:// URL exists).

If you are running a uniform enough site, http://git.kernel.org,
http://git.fedorahosted.org/git/, etc it's easy enough to deal with.
This only becomes an issue if/when you allow more generic trees to
exist, and aren't expecting a uniform git link.

> 2. More important issue is that besides @git_base_url_list the URL or
>    URLs for a repository can come from various other places: from
>    'cloneurl' text file and from `gitweb.url' configuration variable.
>    It it was taken into account (even to check that such configuration
>    does not exist) it would badly affect performance of generating
>    projects list page.
> 
>    The git.kernel.org gitweb doesn't have this problem because it uses
>    @git_base_url_list (I think unconditionally); also it supports
>    output caching, so eventual performance hit is migitated.

We actually don't, at least currently, use @git_base_url_list.  Right
now there's a configuration variable to set a uniform server / base url,
and then use project path to append to that.  git:// in this case is
hard coded, though with http being smart now there is no reason why that
should be that way (no one has asked for the change &/or submitted a
patch to me to alter that behavior).

The caching helps, though since I'm not actually using @git_base_url the
caching isn't of significant impact, since I only need to know the path
vs. poking in the repo directly.  (that said caching still buys me a lot
of performance overall).

Assuming you are using my caching version of gitweb setting $gitlinkurl
in your config file to be the base (before the path) of your link, it
should work.  Should get that even if caching is disabled, though YMMV I
don't do a lot of testing with the cache turned off, and I haven't
written a test case for that yet.

- John 'Warthog9' Hawley
