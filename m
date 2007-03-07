From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 22:50:57 -0500
Message-ID: <45EE36A1.30001@gmail.com>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com> <7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com> <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 04:51:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOnB6-0007Om-7n
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 04:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbXCGDu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 22:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbXCGDu5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 22:50:57 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:24740 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161253AbXCGDu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 22:50:56 -0500
Received: by wx-out-0506.google.com with SMTP id h31so31853wxd
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 19:50:55 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DE3xniarHSljVhMPTYekMdWrWerLOaK9XYDpz/QzcavPSNa4zV29TYyaIdFDN5ZwuhVAMq2IjGFjVWZJeRqI+9VbM75QfK4ic87OP4Kgn9RlMR8fEKs746OlqACOpiJCAWVQwD3W/KGm+8fwiyaBZ0WpBx56o1PZe5k1dHQIEhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TSpn8z2CcFaYbikJunh+FbZL8MStCJR6GRq6MsvNZzNZxnAwSFkPlo+vD6oK9g8ujRn2v2P9voKLrj2STiENbWxX0XuZUqe6mXnDkDwH33ohz4HMhR5PtQiMdiAZAtIW/WSN3sElpVueFq6XLWUaLYKpRqx18ZA3u5hGJcft4ss=
Received: by 10.70.39.2 with SMTP id m2mr13094725wxm.1173239455742;
        Tue, 06 Mar 2007 19:50:55 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id i36sm218976wxd.2007.03.06.19.50.54;
        Tue, 06 Mar 2007 19:50:55 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41648>

Johannes Schindelin wrote:
> Have you tried "make test"? In particular, t5510-fetch.sh?
>
> If it passes, git-bundle works at least for one particular case, and I'd 
> suspect then that the inbuilt GIT_EXEC_PATH bites you. To avoid that 
> particular peculiarity, just "export GIT_EXEC_PATH=/path/to/next/", and 
> try again.
>
> Hiw,
> Dscho
Yes, setting GIT_EXEC_PATH fixed the problem, thanks.

I just tried git-bundle in a repository where I just committed 1 file, 
the previous commit is several weeks old.

git-bundle create test.bdl HEAD --since=1.day.ago  ==>> pack with 1531 
objects
git-bundle create test.bdl HEAD ^HEAD~1            ==>> pack with 3 objects

But, both should only have 3 objects. So, I think the boundary marking 
with date limiting still has a problem. Apparently, every blob 
supporting the included commits are included in the pack, even if those 
blobs are also part of the pack's prerequisites.

Mark
