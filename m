From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Tue, 16 Dec 2014 10:33:40 +0100
Message-ID: <548FFC74.7080307@drmicha.warpmail.net>
References: <20141216021900.50095.24877@random.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: Anastas Dancha <anapsix@random.io>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 10:33:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0oVo-0007Qh-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 10:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbaLPJdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 04:33:43 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49863 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbaLPJdm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2014 04:33:42 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D1E7B2048B
	for <git@vger.kernel.org>; Tue, 16 Dec 2014 04:33:41 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 16 Dec 2014 04:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=d0ahslSJJ3jO3TMHmTyZbb
	Eq9Og=; b=RIIGRT3JQhYMaqkwz5BNgX8XbOQMaoaI+UUC+lokzLQSt7vAG0A7Yh
	1+cupp22D9VkvhaOP7EN+nwp7HELPTutoQbCr2ZF09dzDR/hQxZSYm8s3w6THE0z
	xZNb1QNxictbSuY55uQ0tomXHUgm+YpY9zI+vsUjuBTnNNTEgE/6g=
X-Sasl-enc: z2vDCFvxvnR7cWIPeDjoj1FupKBrnEvBdCywKcrfFg5Q 1418722421
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 09B9AC0027E;
	Tue, 16 Dec 2014 04:33:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141216021900.50095.24877@random.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261441>

Anastas Dancha schrieb am 16.12.2014 um 03:30:
> From f80bdf3272e7bdf790ee67fb94196a8aa139331f Mon Sep 17 00:00:00 2001
> From: Anastas Dancha <anapsix@random.io>
> Date: Mon, 15 Dec 2014 16:30:50 -0500
> Subject: [PATCH] remote: allow adding remote w same name as alias
> 
> When ~/.gitconfig contains an alias (i.e. myremote)
> and you are adding a new remote using the same name
> for remote, Git will refuse to add the remote with
> the same name as one of the aliases, even though the
> remote with such name is not setup for current repo.
> 
> $ git remote add myremote git@host.com:team/repo.git
> fatal: remote myremote already exists.
> 
> The fatal error comes from strcmp(name, remote->url[0])
> condition, which compares a name of the new remote with
> existing urls of all the remotes, including the ones
> from ~/.gitconfig (or global variant).
> I'm not sure why that is necessary, unless Git is meant
> to prevent users from naming their remotes as their
> remote aliases..
> Imho, if someone want's to git remote add myremote
> myremote, they should, since git-remote always takes
> 2 arguments, first being the new remote's name and
> second being new remote's url (or alias, if set).

While that is true for "git remote", it is wrong for "git push" and the
like, which takes "remote name or remote URL" as a parameter. Therefore,
remote names and remote aliases need to be unique within the same namespace.

> Thanks to @mymuss for sanity check and debugging.
> 
> Signed-off-by: Anastas Dancha <anapsix@random.io>
> ---
>  builtin/remote.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
