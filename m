From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Tracking vendor release with Git
Date: Tue, 11 Jun 2013 20:27:32 +0200
Message-ID: <51B76C14.3060907@kdbg.org>
References: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTIC-0005LI-IN
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab3FKS1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:27:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59075 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab3FKS1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:27:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 64BF2A7EDA;
	Tue, 11 Jun 2013 20:27:33 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7342130AE20;
	Tue, 11 Jun 2013 20:27:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227486>

Am 11.06.2013 19:06, schrieb Yann Droneaud:
> Hi,
> 
> I'm trying to setup a workflow to track vendor releases (upstream).
> Each new release are provided as an archive of source code, data,
> documentation, etc.
> 
> For each vendor releases, fixes need to be applied before making them
> available to users (downstream).
> 
> Seems to be a rather common use case, applied by most Linux distribution
> for decades.
> 
> In my case, on top of each releases, a common set of patches will be applied,
> the biggest, the most intrusive one, being converting CRLF to LF using dos2unix,
> the others being small portability fixes. In this case, fixes are not going to
> be applied by upstream.
> 
> I'm trying to "design" (copy ;) a workflow with following properties,
> in order of importance:
> 
> 1- I wish to keep a branch with each new vendor release as a commit.
>    This branch's history is only about vendor releases,
>    so it's easy to read the "changelog" of the vendor releases
>    with command such as git log <vendor-release-branch>
> 
> 2- I'd like to ease the process of applying our patches on top
>    of each new vendor release, eg. reduces the likeliness of conflicts.
> 
> 3- I wish to keep a branch with each new fixed vendor release as a commit.
>    Just like the upstream <vendor-release-branch>, only one commit
>    per release, so it's easy to read the "changelog" of the vendor releases
>    with command such as git log <patched-release-branch>

I suggest you aim for the following history (time flows from left to right):

  U---V-----W          <-- upstream branch
   \   \     \
    C---D-----E        <-- CRLF conversion branch
     \   \     \
      K---L--M--N--O   <-- downstream branch

U, V, W are the upstream releases.

C is the initial CRLF->LF conversion. D merges the second upstream
release into the CRLF branch, E the third upstream release. These merges
very likely create tons of conflicts. But that does not matter, because
you know that the only change in "our" side is CRLF conversion. The
commits on this branch can easily be automated. That's the primary
motivation for this scheme.

K is your first small bugfix and also your first downstream release.

After merging L, the second, CRLF-converted, upstream release, you make
your second small change, M, which is also your second downstream release.

Rinse and repeat with N and O for the third release.

-- Hannes
