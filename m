From: r.ductor@gmail.com
Subject: On the behavior of checkout <branch> with uncommitted local changes
Date: Thu, 19 Sep 2013 02:23:11 -0700 (PDT)
Message-ID: <8904036.vOg3y5OkbU@ipht-ia-004976>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 19 11:23:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMaSE-0001SN-1U
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 11:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab3ISJXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 05:23:14 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:42869 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab3ISJXN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 05:23:13 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq15so7635861wib.12
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=B1UN6oyQWWKPTgKliU3UaQsBcuEY226aL/ZEYQXSNb0=;
        b=Ykg8UBaQAqXOmettw9FUPPw5/SgcGaKv/E8yDKJNmpTpvpV0HEk0WBuY9+8cMSvQ6e
         duLgEvJ3cgwVlj1ar5u/ey1+2U1Pvn50llRUzXG0rveHJeEgVnbYQD3wXc8ISfO1scwZ
         XPd4gwPPPmK6Zan3qBXN/RIp0K6q9wSvGXI4SRnXEbNEb0iIRW5au8+SEZ1vRUgPhEoI
         I/xmf5QV3NS0oev1wBMrqLn2OKFQsWPJ38QnRw11zgGlfpqJqnKfjpynUH4Ow8xYgfQG
         Ts0yOVc99cBbeuQBt07iyX5/y2iwFDmAHW9HhwUUaFGX0+aWLhbH8Wna9pZxIlWZXS9u
         h7wQ==
X-Received: by 10.180.212.41 with SMTP id nh9mr10818594wic.9.1379582592102;
        Thu, 19 Sep 2013 02:23:12 -0700 (PDT)
Received: from ipht-ia-004976.localnet (ipht-ia-004976.extra.cea.fr. [132.166.22.90])
        by mx.google.com with ESMTPSA id ey4sm8215066wic.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 02:23:11 -0700 (PDT)
User-Agent: KMail/4.10.5 (Linux/3.10-2-amd64; KDE/4.10.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235008>

Dear all

I'm not a power git user but I profit of git every day and I like to fully understand what I do.

The man section for git checkout is too vague for my taste. In particular it is not clearly (unambiguously) stated what happens to index and worktree whenever local uncommitted changes are around. I've already rised a similar problem in this mail list [1], but I understand that a man page must be concise.

On the other hand, I couldn't find any complete information on this behavior: tutorials and books seem to avoid the problem, user posts seems confused ... 

To grasp some more information,  I've spent some hours in trials (sorry I'm unable to grasp information browsing the code repository). That resulted in the algorithm below presented.

Could anybody authoritative on that subject confirm/correct/discharge my statement? That could be of help for me and may others.

Nonetheless to say having this kind of pseudocodes available somewhere (e.g. for stash [2] and other tools modifing index and working tree) would make my git experience  (and that of many more people) happier.

Thanks to all developers for their efforts.

Regards
ric


Notations: let us fix a file and denote
C0  = its version in the initial commit
I0   = its version in the initial index
W0 = its version in the working tree
C1 = its version in the target commit
W1= its version in working tree after checkout completed
I1  = its version in index after checkout completed


git checkout Branch

if C0=W0=I0,          then: W1=I1=C1;
if C1=I0,                 then: W1=W0 and I1=C1=I0;
if C1=C0,                then: W1=W0 and I1=I0;
otherwise: abort


Note: in particular, if W0=I0 !=C0 then (in general) abort

Note: in particular, if C0=I0 and C1=W0 then abort  (...actually why that? no information is lost)


REFS
[1]http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/782914/focus=164647
[2]http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=717088
