From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 11:44:31 +0100
Message-ID: <4D3FFB0F.9070700@viscovery.net>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org, Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 11:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi2rh-0006S1-Ov
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 11:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1AZKog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 05:44:36 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10972 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751159Ab1AZKof (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 05:44:35 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Pi2rY-0006HD-9H; Wed, 26 Jan 2011 11:44:32 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0AB061660F;
	Wed, 26 Jan 2011 11:44:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <m239og12pe.fsf@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165516>

Please don't set Mail-Followup-To; it's disliked on this list.

Am 1/26/2011 9:36, schrieb Francis Moreau:
> I tried to reproduce something similar but with a far more simple repo:
> 
> 
> <v2.6.28> 1.f o
>               |
>           1.e o (merge)
>               | \
>           1.d o  o 2.c (merge)
>               |  | \
>           1.c o  o  o 3.a "Remove blacklist_iommu()"
>               |  | /
>               |  o 2.a
>               | /
>           1.b o
>               |
> <v2.6.27> 1.a o "Introduce blacklist_iommu()"
>               |
>               o Init
> 
> Basically this repo 3 branches: master, 2, 3. Master branch introduces
> the "blacklist_iommu()" function with commit 1.a, and branch "3" removes
> it at commit 3.a.
> ...
> So in this case there's no need to pass the '-m' flag and git-log(1), by
> default walks through all the commits:

To reproduce the real history, you have to modify your example in three ways:

1. 2.a must be forked off of Init, not 1.b; i.e., this commit does not
contain "blacklist_iommu".

2. Drop the side branch that removes the word. (Drop at least the commit.)

3. The merge 1.e (which resembles d847059) must be modified such that it
takes the contents of 2.c rather than 1.d.

IOW, "blacklist_iommu" is not removed explicitly by a commit, but rather
by a merge of one branch that has it and another one that doesn't have it.

Look closely at d847059: The commit message hints at a conflict in
intel_iommu.c, and Ingo resolved the conflict by taking the contents of
the file of one branch, namely the branch that does *not* contain
"blacklist_iommu", ignoring entirely what happend on the other branch
(that had added "blacklist_iommu" somewhere at or before v2.6.27).

-- Hannes
