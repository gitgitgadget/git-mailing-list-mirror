From: Olaf Hering <olaf@aepfle.de>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 11:14:27 +0100
Message-ID: <20141114101427.GA1548@aepfle.de>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
 <20141113160325.GA24351@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 11:14:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpDtm-0008Ts-8f
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 11:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbaKNKOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 05:14:33 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:41036 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbaKNKOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 05:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1415960067; l=1697;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=xzbjldAHAab1gZZk0vUy8OxdkOY=;
	b=F7+pHfYbVMVKM2Flny2Cd5FxegB3LvuG6qNIrNGYPGw+bIrgzXDcCN/BaIeMF8qexhM
	nzQfTaNm+TX3GfgTQqsrb9f86/bHgQD40qVOxLbtO+IjHAUprjlEfsvfJPPgt4IVLMsDE
	R0WNmNinrNzLtVTgaJTG4rm/RVBKbaXZ0MY=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIZST8ulOSUJqstS8YMAWN1YEmXTnspMxV9Qxw==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1088:9901:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 35.11 AUTH)
	with ESMTPSA id Y0528bqAEAERz0J
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Fri, 14 Nov 2014 11:14:27 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 45A8A50172; Fri, 14 Nov 2014 11:14:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141113160325.GA24351@paksenarrion.iveqy.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, Fredrik Gustafsson wrote:

> Thanks for sharing your notes! A few comments:
> 
> On Thu, Nov 13, 2014 at 04:44:57PM +0100, Olaf Hering wrote:
> > First clone the remote repository as usual. Then create a local branch for
> > each remote branch that is supposed to be worked on:
> > # git clone git://host/repo.git repo-master
> > # cd repo-master
> > # git checkout -b branchA origin/branchA
> > # git checkout -b branchB origin/branchB
> > # cd -
> >
> > Now clone each work branch into its own directory. The work dir references the
> > master repo. All changes come from and go into this repo, instead of the
> > remote repo.
> > # git clone -l -b branchA repo-master repo-branchA
> > # git clone -l -b branchB repo-master repo-branchB
> >
> > To make changs in a work dir, commit as usual. The changes will be pushed from
> > the work copy into the local master repo. Its required to have some other
> > branch than branchA active in repo-master, or push from work copy to
> > repo-master will fail.
> 
> That's one of the reason it's not recommended to push into a non-bare
> repository. You should clone your repo-master with the --bare option to
> avoid having a work dir there.

So my repo-master is now "bare". I pushed from repo-branchA into
repo-master and see my commits in both repos. But pushing from
repo-master to the remote fails because repo-master does not have
outstanding remote commits. However, git fetch doesnt do anything:

Fetching origin
From host:/remote/dir
* branch            HEAD       -> FETCH_HEAD


Obviously I miss something. The man page of git clone or fetch does not
mention how "bare" is supposed to be handled.

Olaf
