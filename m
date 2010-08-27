From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 10:00:16 +0200
Message-ID: <4C777090.2000107@drmicha.warpmail.net>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 10:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ootrh-0003ZK-Uy
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 10:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab0H0IAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 04:00:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40465 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab0H0IAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 04:00:16 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 572A0342;
	Fri, 27 Aug 2010 04:00:16 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 27 Aug 2010 04:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ALWYJ2Q9NpCE+PI8aV85UJ+4zo0=; b=hd6sbDEfSr248H/5T4+aE0Vj0t7/wT9F+84XvHVkGSd/TgLuHb7p65to+uVdBgEKLkCldnlwkd98A5G7WOsRG0tSWYhq/uTZDnVzKoVuTu5y2H6HZ20qKzQ5ljITxxfjW43brSJpk7Oy14eL3Bo6zBA5iq+/bLtjZIhGWuCRGsI=
X-Sasl-enc: zGKudGidOAjoTGGntMiCLEe9CNATJ8dxPdRcxLs7p5h7 1282896016
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D27F15E2316;
	Fri, 27 Aug 2010 04:00:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154588>

Dan Loewenherz venit, vidit, dixit 27.08.2010 06:57:
> Hi all,
> 
> I may be mistaking a design decision as a bug, but I wanted to throw
> this out to the list to make sure. I think that re-enacting it will be
> the best way to explain it.
> 
> $ mkdir test
> $ cd test
> $ git init
> $ cat > readme
> This is a test file.
> ^D
> $ git commit -am "first commit"
> [master (root-commit) fae0d05] first commit
>  1 files changed, 1 insertions(+), 0 deletions(-)

? You have not added any file, so git won't commit anything (not even
with -a). The above can't be a complete transcription. I assume you've
added readme with the content above.

> 
> For personal reasons, I now want readme to be uppercase.
> 
> $ mv readme README

Here's where using "git mv" would have been the easier choice, followed
by commit.

> $ cat > README
> This is the revised README.

Renaming and changing the content completely in one step will always
trip up git's rename detection. You should rename, commit, change,
commit, unless the change affects a small portion of the file only.

> $ git status -sb
> ## master
>  M readme

Again, this can't be a complete transcript. The above would lead to

 D readme
?? README

> $ git add README
> $ git status -sb
> ## master
>  M readme
> 
> At this point, I'm thinking that git is confused. Even though I've

Are you possibly using a case-challenged file system? Is this maybe on a
Mac with HFS or Win with NTFS?

Michael
