From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Question about git-cherry and the rev list it's using
Date: Thu, 12 May 2011 08:47:11 +0200
Message-ID: <4DCB826F.5020406@drmicha.warpmail.net>
References: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 08:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKPg9-0005Va-13
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 08:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab1ELGrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 02:47:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48451 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752700Ab1ELGrO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 02:47:14 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 72294203CB;
	Thu, 12 May 2011 02:47:13 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 12 May 2011 02:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=c3Zn9gWwZg5Hbsx5tFfdylkZS+0=; b=VHG4uh72AXlR845ki9FGOthmWU/YPKJNqjr9o9/VkvvA82jGrQm9bkrHY+JaFrq1zOIZK1G0HA2F2V4PoZkzEY5N6LEJas6qq6KAqYCZy5ROqxphxWEiYIzSmmrd1qv7lyRAxqIN2VjEqN0mhtcj5nFxGLCoIxdwms1iK02nxSU=
X-Sasl-enc: k1UbAlaOxVyZXiCNnNSDKuPFarN1sPCci0iwTyybmcvy 1305182833
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EFC794443D0;
	Thu, 12 May 2011 02:47:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173443>

Francis Moreau venit, vidit, dixit 11.05.2011 18:11:
> Hello,
> 
> I'm using "git cherry old master base" to see if all commits between
> master and base have been applied in my 'old' branch.
> 
> So I expect that git cherry is using a list of commits given by : "git
> rev-list --no-merges base..master".

Not really.

For each commit in "--no-merges old..master ^base" (i.e. "--no-merges
master ^old ^base"), "git cherry" checks whether there is a patch
equivalent commit in "--no-merges master..old", and outputs it with + or -.

> But it looks like it's not the case:
> 
>   $ git rev-list --no-merges --oneline base..master | wc -l
>   22
> 
>   $ git cherry old master base | wc -l
>   12
> 
> Could anybody help me on this because I don't understand the results I have ?

"--no-merges ^old ^base" should rev-list --count to 12.

But you may be better off with something like

git rev-list --count --cherry master...old ^base

(untested)

Michael
