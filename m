From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 17:03:25 +0100
Message-ID: <20141113160325.GA24351@paksenarrion.iveqy.com>
References: <20141113111444.GA15503@aepfle.de>
 <20141113154457.GA31624@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 16:57:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xowlg-00017e-3V
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 16:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251AbaKMP5D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 10:57:03 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38500 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbaKMP5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 10:57:00 -0500
Received: by mail-lb0-f174.google.com with SMTP id w7so2672170lbi.33
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 07:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gtWLD+0/eh8FAWtLrcisgx8Ho62hzUQcTIUHaFQPpDM=;
        b=PwwyD3aq1FmqK4AN4eIoTLpE8HaRqowa/woi83btPrJsGDBcJdmEikLTGk7BqGWVfh
         u/fjPWonng2hxM2uULC19SqcQKZOPd9MoDOcbkYSpxSwlCO5Y0sK0aNWKa9vlb9hHy1M
         uCspVY8qnlCth8eFT6ouJH14hRabJI1IqtZMXp+vrBWnJVa1qeN4WTpfd5Cbumr8HiAO
         7YN/uOgo4jyTVSoTN07deVsQ2IX90vWRrB31Hu1oiMAYysLXmptbTocQemkitpGDOkVk
         7jsg75BlrptaLoOWmAniGJaAq9be3MWnYdYn/Gb3kCJYe+JAS4NEcp64mk8ankZZBWpi
         bYCg==
X-Received: by 10.152.22.194 with SMTP id g2mr3196544laf.33.1415894219477;
        Thu, 13 Nov 2014 07:56:59 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id ed8sm4075333lbb.41.2014.11.13.07.56.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 07:56:58 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Xowrl-00074k-97; Thu, 13 Nov 2014 17:03:25 +0100
Content-Disposition: inline
In-Reply-To: <20141113154457.GA31624@aepfle.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for sharing your notes! A few comments:

On Thu, Nov 13, 2014 at 04:44:57PM +0100, Olaf Hering wrote:
> First clone the remote repository as usual. Then create a local branc=
h for
> each remote branch that is supposed to be worked on:
> # git clone git://host/repo.git repo-master
> # cd repo-master
> # git checkout -b branchA origin/branchA
> # git checkout -b branchB origin/branchB
> # cd -
>
> Now clone each work branch into its own directory. The work dir refer=
ences the
> master repo. All changes come from and go into this repo, instead of =
the
> remote repo.
> # git clone -l -b branchA repo-master repo-branchA
> # git clone -l -b branchB repo-master repo-branchB
>
> To make changs in a work dir, commit as usual. The changes will be pu=
shed from
> the work copy into the local master repo. Its required to have some o=
ther
> branch than branchA active in repo-master, or push from work copy to
> repo-master will fail.

That's one of the reason it's not recommended to push into a non-bare
repository. You should clone your repo-master with the --bare option to
avoid having a work dir there.

> To publish the outstanding changes its required to do this from the m=
aster
> repo. First checkout the work branch, then pull the local changes and=
 finally
> push them to the remote repo.
> # cd repo-master
> # git checkout branchA
> # git pull
> # git push origin branchA
> # cd -

It's not. You could just add your remote repository as a remote to each
of your clones of your master repo and push directly from them. It
would be much simplier and it would allow you to directly fetch changes
from your remote into your branches as well.

(however, I'm not sure but I think, that this will slowly increase the
difference between your repositories when you develop. So that they
won't change any new data since to local clone was made).

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
