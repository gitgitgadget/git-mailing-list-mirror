From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bug?  git format-patch -M -D then git am fails
Date: Wed, 14 Nov 2012 14:28:00 +0100
Message-ID: <50A39C60.7000005@drmicha.warpmail.net>
References: <1352846721.17444.24.camel@joe-AO722> <7vsj8dcdv6.fsf@alter.siamese.dyndns.org> <1352847962.17444.27.camel@joe-AO722> <7vfw4dccm7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, git <git@vger.kernel.org>,
	David Miller <davem@davemloft.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:28:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYd0t-0003H8-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829Ab2KNN2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:28:04 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39066 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752262Ab2KNN2D (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 08:28:03 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 336A120B25;
	Wed, 14 Nov 2012 08:28:02 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 14 Nov 2012 08:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=e/iLiX+FULvmLuVmq7HnE1
	tHt8M=; b=H1/dno1gzvGXMMt0u+Punapz8S5IqtQ+JCu5Ky3DAtNSxA2l03dNge
	Kk/zYSiPg1uiVvwZzXpuOfcc4paMKXNp5GZhfr4eHnnjvnYrY+e3Iw7XDPyi+jL2
	gegiaF0fq0JghdtA91xr6btaX6gpYnyOKBK5qdC1vOqxPiOD24BQg=
X-Sasl-enc: /j40vDq5ovC+95smFf+ddYsrsUCgZIRLYrTVubiGFZfT 1352899681
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7F18B8E0125;
	Wed, 14 Nov 2012 08:28:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <7vfw4dccm7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209716>

Junio C Hamano venit, vidit, dixit 14.11.2012 00:22:
> Joe Perches <joe@perches.com> writes:
> 
>> I don't believe that reversibility
>> is a really useful aspect of deletion patches
>> when there are known git repositories involved.
> 
> You can read "reversibility" as "safety" if you want.  We would want
> to make sure we know what we are deleting before deleting a path.
> 
> The history that the receiver of such a patch has may have further
> changes that are relevant that the sender of the deletion patch did
> not know about, and removing the path in such a case would make the
> result inconsistent.  If the sender did his work on top of the newer
> version with the change in the path, the sender's patch may still
> have deleted the path but would have had changes to other paths to
> compensate for the loss of that change.
> 

Just in case someone wants to hack on this: To be safe, "git am" would
need to read the blob's sha1 from something like

diff --git a/Makefile b/Makefile
deleted file mode 100644
index 1b6d84d..0000000

and check that the file to be deleted matches.

Michael
