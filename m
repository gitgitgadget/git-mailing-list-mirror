From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [1.8.0] git checkout refs/heads/foo checks out branch foo
Date: Mon, 7 Feb 2011 06:01:51 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1102062234010.3788@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 12:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmOr5-0007Ua-8n
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 12:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab1BGLB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 06:01:58 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37223 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1BGLB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 06:01:57 -0500
Received: by qyk12 with SMTP id 12so3883818qyk.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:subject:message-id
         :user-agent:mime-version:content-type;
        bh=zpVhKlUTK+Ov+m7TPDupYDSgkvYLViP+neprBf8WLUU=;
        b=q6A0GWdAyE6oVyZgO1l3/h43+iSlHpOp9EcYazIcYWNIHaRFgr/C9uKiGK+Cjqi+wo
         DnNEegdW8yzF3fWrmdyyT8qHhFZS7mC96ODf7Jspoh5zry5SkA4KgqkZui1CclLtPu1a
         ta3fgOV+nzqmYRMyHn0TGdNJ3AAE5OuAfrahg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:subject:message-id:user-agent:mime-version
         :content-type;
        b=JwCNtvtzAd/6U9uac1d2xL/8cj8X7pTgIcnlpGKX1yNx9bgoA7htUatmnQCjTA5QMQ
         t+z+WZDzPADftOASn4NDRCO+oOjLwveWoWuQq7BCQAa9nNO8nKGCfCYHePf89Vh8Luyl
         z4IXRwjtCD3uIvmL/urPio18cRQ8kqO0+12F8=
Received: by 10.224.3.4 with SMTP id 4mr4429244qal.109.1297076516722;
        Mon, 07 Feb 2011 03:01:56 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm2756498qck.22.2011.02.07.03.01.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 03:01:55 -0800 (PST)
X-X-Sender: martin@debian
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166251>

Proposal:

'git checkout refs/heads/foo' (or 'git checkout heads/foo' for that
matter) does not check out the branch, but instead detaches HEAD at
foo. This is quite counter-intuitive (at least to me) and the same
functionality can be achieved by using e.g. foo~0. Change the behavior
so that the branch is actually checked out. This also applies to
e.g. 'git rebase master refs/heads/topic', which currently rebases a
detached HEAD. There are probably other examples as well that I'm not
aware of.


Risks:

Existing scripts may depend on the current behavior. It seems unlikely
that many users depend on it. Most likely, they use foo~0 or foo^0
instead.


Migration plan:

Make 'git checkout refs/head/foo' emit a warning in the next 1.7.x
explaining that its semantics will change in 1.8.0. Then change the
behavior in 1.8.0 and remove the warning.
